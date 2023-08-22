import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:mpa/actions/adapt.dart';
import 'package:mpa/models/obsolete_goods/obsolete_goods_model.dart';
import 'package:mpa/utils/app_colors.dart';
import 'package:mpa/utils/extension.dart';
import 'package:mpa/utils/format.dart';
import 'package:mpa/utils/lego_utils.dart';
import 'package:mpa/utils/path_utils.dart';
import 'package:mpa/utils/singleton.dart';
import 'package:mpa/utils/tips_utils.dart';
import 'package:mpa/widget/empty_page/empty_view.dart';
import 'package:mpa/widget/getx_widget/error_page.dart';
import 'package:mpa/widget/getx_widget/loading_view.dart';
import 'package:mpa/widget/other_widget.dart';
import 'package:readmore/readmore.dart';

import 'effect.dart';
import 'state.dart';

class ObsoleteGoodsPage extends StatefulWidget {
  static const int FROM_LIST = 0;
  static const int FROM_NOTIFY = 1;
  final int? weedoutTaskId;
  final int? yearMonth;
  final int pageFrom;

  ObsoleteGoodsPage({this.weedoutTaskId, this.yearMonth, required this.pageFrom});

  @override
  _ObsoleteGoodsPageState createState() => _ObsoleteGoodsPageState();
}

class _ObsoleteGoodsPageState extends State<ObsoleteGoodsPage> {
  final effect = Get.put(ObsoleteGoodsEffect());
  final state = Get.find<ObsoleteGoodsEffect>().state;

  @override
  void initState() {
    state.weedoutTaskId = widget.weedoutTaskId;
    state.yearMonth = widget.yearMonth;
    state.pageFrom = widget.pageFrom;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    processDate() {
      if (state.pageModel == null || state.pageModel!.yearMonth == null) {
        return "";
      }
      var yearMonth = state.pageModel!.yearMonth;
      var date = yearMonth.toString();
      if (date.length == 6) {
        return "${date.substring(0, 4)}年${date.substring(4, 6)}月";
      }
    }

    var _appBarLayout = LegoUtils.getPageTitleHasArrow(
        onBack: () {
          effect.onBack(context);
        },
        leftWidgetsList: [
          GetBuilder<ObsoleteGoodsEffect>(builder: (effect) {
            return Container(
              constraints: BoxConstraints(maxWidth: Adapt.px(400), minWidth: Adapt.px(100)),
              child: Text(
                "${state?.pageModel?.activityName ?? "门店汰品"}",
                style: TextStyle(color: Colors.white, fontSize: Adapt.px(24), fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            );
          }),
        ],
        centerWidgetsList: [
          Container(
            padding: EdgeInsets.only(left: Adapt.px(20), right: Adapt.px(10)),
            constraints: BoxConstraints(maxWidth: 450),
            child: Text(
              "${VarSingleton.instance?.getStoreName() ?? ''}",
              style: TextStyle(color: Colors.white, fontSize: Adapt.px(24), fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis, // 文字显示不全样式
              maxLines: 1, // 最大显示行数，默认为最大
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Text(
              "${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}(周${FormatUtils.getWeekDayZH(DateTime.now().weekday)})",
              style: TextStyle(color: Colors.white, fontSize: Adapt.px(24), fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis, // 文字显示不全样式
              maxLines: 1, // 最大显示行数，默认为最大
            ),
          ),
        ],
        rightWidgetsList: []);

    return PageContainer(
      child: WillPopScope(
        onWillPop: () async {
          effect.onBack(context);
          return false;
        },
        child: Scaffold(
          appBar: _appBarLayout,
          body: Container(
            color: AppColors.c_bg_gray,
            width: double.infinity,
            child: Stack(
              children: [
                GetBuilder<ObsoleteGoodsEffect>(builder: (effect) {
                  return (state.pageModel != null && state.pageModel!.weedoutTaskId != null)
                      ? Flex(
                          direction: Axis.vertical,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 60.px(),
                              padding: EdgeInsets.symmetric(horizontal: 20.px()),
                              color: AppColors.white,
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        buildTabItem("待处理 (${state.getPendingCount()})", ObsoleteType.pending),
                                        buildTabItem("已处理 (${state.getAlreadyCount()})", ObsoleteType.already),
                                        buildTabItem("全部 (${state.getAllCount()})", ObsoleteType.all),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: state.obsoleteType == ObsoleteType.pending,
                                    child: Container(
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        children: [
                                          Text(
                                            "涉及库存金额:",
                                            style: LegoUtils.getw600TextStyle(18),
                                          ),
                                          Text(
                                            "${FormatUtils.formatDoubleFillZero(state.getShowMoney(), 1)}元",
                                            style: LegoUtils.getw600TextStyle(24, color: AppColors.c_f75c24_ff),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                              visible: (state.pageModel?.taskDesc ?? "").length > 0,
                              child: Container(
                                decoration: LegoUtils.getCornersBg(8),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 20.px(), vertical: 12.px()),
                                margin: EdgeInsets.only(top: 10.px(), left: 20.px(), right: 20.px()),
                                child: ReadMoreText(
                                    "活动须知: ${(state.pageModel?.taskDesc ?? "").replaceAll("\n", " ").fixAutoLines()}",
                                    style: LegoUtils.get18TextStyle(
                                      c: AppColors.c_f75c24_ff,
                                    ),
                                    trimLines: 1,
                                    colorClickableText: AppColors.c_adadad_ff,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '  展开',
                                    trimExpandedText: ' 折叠'),
                              ),
                            ),
                            Expanded(
                                child: Container(
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.only(top: 10.px(), left: 20.px(), right: 20.px()),
                              decoration: LegoUtils.getCornersBgCustom(topLeft: 8, topRight: 8),
                              child: (state.getShowList()?.length ?? 0) != 0
                                  ? Container(
                                      child: ListView.builder(
                                        controller: state.scrollController,
                                        itemBuilder: (BuildContext context, int index) {
                                          return getModelView(state.getShowList()![index], index);
                                        },
                                        itemCount: state.getShowList()?.length ?? 0,
                                      ),
                                    )
                                  : Container(
                                      child: EmptyView(
                                        true,
                                        title: processTabEmpty(),
                                      ),
                                    ),
                            ))
                          ],
                        )
                      : Container(
                          margin: EdgeInsets.all(20.px()),
                          height: double.infinity,
                          width: double.infinity,
                          decoration: LegoUtils.getCornersBg(6),
                          child: EmptyView(
                            state.pageModel != null,
                            title: "暂无数据",
                          ),
                        );
                }),
                GetBuilder<ObsoleteGoodsEffect>(builder: (effect) {
                  return Visibility(
                    visible: state.guideStatus,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        effect.setGuideStatus();
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        // color: AppColors.c_f75c24_a3,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: BounceInRight(
                                child: Container(
                                  margin: EdgeInsets.only(top: 300.px(), right: 70.px()),
                                  width: 420.px(),
                                  height: 60.px(),
                                  padding: EdgeInsets.symmetric(horizontal: 20.px()),
                                  decoration: LegoUtils.getCornersBgHaveShadow(
                                    4,
                                    spreadRadius: 6,
                                    shadowColor: AppColors.c_6d5f57_29,
                                  ),
                                  child: Flex(
                                    direction: Axis.horizontal,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "左滑列表可以将商品“标记为已处理”",
                                        style: LegoUtils.get20TextStyle(c: AppColors.c_f75c24_ff),
                                      ),
                                      Image(
                                        image: AssetImage("assets/images/ico_dialog_close.png"),
                                        width: 36.px(),
                                        height: 36.px(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                GetBuilder<ObsoleteGoodsEffect>(builder: (effect) {
                  return GetLoadingView(
                    state.isShowLoading,
                  );
                }),
                GetBuilder<ObsoleteGoodsEffect>(builder: (effect) {
                  return GetErrorPage(
                    state.isShowErrorPage,
                    state.baseResponse,
                    onTryClick: () {
                      effect.onErrorRefresh();
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String processTabEmpty() {
    if (state.obsoleteType == ObsoleteType.pending) {
      return "恭喜您，您已经完成了全部的汰品处理";
    } else if (state.obsoleteType == ObsoleteType.already) {
      return "您还没有处理完成的汰品信息，请及时处理";
    } else {
      return "暂无数据";
    }
  }

  Widget buildTabItem(String title, ObsoleteType type) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        effect.onTabClick(type);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4.px()),
        constraints: BoxConstraints(minWidth: 160.px()),
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "$title",
              style: state.obsoleteType == type
                  ? LegoUtils.getw600TextStyle(24, color: AppColors.c_383735_ff)
                  : LegoUtils.getw500TextStyle(22, color: AppColors.c_565656_ff),
            ),
            Opacity(
              opacity: state.obsoleteType == type ? 1 : 0,
              child: Container(
                  width: 40.px(),
                  height: 4.px(),
                  margin: EdgeInsets.only(top: 6.px()),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(4)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [AppColors.c_f75c24_ff, AppColors.c_facfca_ff]))),
            )
          ],
        ),
      ),
    );
  }

  Widget getModelView(ObsoleteGoodsModel model, int index) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  effect.processScroll(model);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 36.px()),
                  padding: EdgeInsets.only(left: 40.px()),
                  child: model.handlingMethodId == 0
                      ? Text(
                          "${model.handlingMethodValue}(${model.list?.length ?? 0})",
                          style: LegoUtils.getw500TextStyle(22),
                        )
                      : Text(
                          "处理方式:${model.handlingMethodValue}: (${model.list?.length ?? 0})",
                          style: LegoUtils.getw500TextStyle(22),
                        ),
                ),
              ),
              processModelTitle(model),
              buildChildList(model),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 40.px()),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.5.px(), color: AppColors.c_f1f1f1_ff)),
          ),
        )
      ],
    );
  }

  //PROCESSED(0, "已处理商品"),
  //RETURN(1,  "退货"),
  //DISCOUNT(2, "折扣"),
  //DIGESTION(3, "自然消化"),
  Container processModelTitle(ObsoleteGoodsModel model) {
    switch (model.handlingMethodId) {
      case 2:
      case 4:
        return Container(
          height: 45.px(),
          padding: EdgeInsets.only(left: 40.px(), right: 42.px()),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text(
                  "分类",
                  style: LegoUtils.getw400TextStyle(17, color: AppColors.c_746f6b_ff),
                ),
              ),
              buildTitleItem("箱规"),
              buildTitleItem("商品类别", width: 120),
              buildTitleItem("商品状态"),
              buildTitleItem("处理方式"),
              buildTitleItem("库存数"),
              buildTitleItem("库存金额(元)", width: 120, tips: true),
            ],
          ),
        );
        break;
      case 1:
      case 3:
        return Container(
          height: 45.px(),
          padding: EdgeInsets.only(left: 40.px(), right: 42.px()),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text(
                  "分类",
                  style: LegoUtils.getw400TextStyle(17, color: AppColors.c_746f6b_ff),
                ),
              ),
              buildTitleItem("箱规"),
              buildTitleItem("商品类别", width: 120),
              buildTitleItem("商品状态"),
              buildTitleItem("库存数"),
              buildTitleItem("库存金额(元)", width: 120, tips: true),
            ],
          ),
        );
        break;
      default:
        return Container(
          height: 45.px(),
          padding: EdgeInsets.only(left: 40.px(), right: 42.px()),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Text(
                  "分类",
                  style: LegoUtils.getw400TextStyle(17, color: AppColors.c_746f6b_ff),
                ),
              ),
              buildTitleItem("箱规"),
              buildTitleItem("商品类别", width: 120),
              buildTitleItem("商品状态"),
              buildTitleItem("处理方式"),
              buildTitleItem("处理状态"),
            ],
          ),
        );
    }
  }

  Widget buildTitleItem(String title, {double width = 100, Alignment alignment = Alignment.center, bool tips = false}) {
    if (tips) {
      return Tooltip(
        message: "以售价计算",
        preferBelow: false,
        padding: EdgeInsets.only(left: 8.px(), right: 8.px()),
        waitDuration: Duration(seconds: 1),
        showDuration: Duration(seconds: 3),
        textStyle: LegoUtils.get18TextStyle(c: AppColors.white),
        triggerMode: TooltipTriggerMode.tap,
        child: Flex(direction: Axis.horizontal, children: [
          Text(
            "$title",
            style: LegoUtils.getw400TextStyle(17, color: AppColors.c_746f6b_ff),
          ),
          Icon(
            Icons.info_outline,
            color: AppColors.c_74716e_ff,
            size: Adapt.px(20),
          )
        ]),
      );
    } else {
      return Container(
        width: Adapt.px(width),
        child: Align(
          alignment: alignment,
          child: Text(
            "$title",
            style: LegoUtils.getw400TextStyle(17, color: AppColors.c_746f6b_ff),
          ),
        ),
      );
    }
  }

  Container buildChildContentItem(dynamic content, bool dealStatus,
      {double width = 100, Alignment alignment = Alignment.center, bool needProcess = false, bool isMoney = false}) {
    return Container(
      width: Adapt.px(width),
      child: Align(
        alignment: alignment,
        child: AutoSizeText(
          needProcess
              ? (isMoney
                  ? "${FormatUtils.formatDoubleFillZero(content, 1)}"
                  : "${FormatUtils.formatDouble(content, 1)}")
              : "$content".fixAutoLines(),
          minFontSize: 2,
          style: LegoUtils.getw400TextStyle(19, color: dealStatus ? AppColors.c_746f6b_ff : AppColors.black),
        ),
      ),
    );
  }

  Container buildChildContent2LineItem(dynamic content, bool dealStatus,
      {double width = 100, Alignment alignment = Alignment.center, bool needProcess = false, bool isMoney = false}) {
    return Container(
      width: Adapt.px(width),
      child: Align(
        alignment: alignment,
        child: Tooltip(
          message: "$content",
          preferBelow: false,
          padding: EdgeInsets.only(left: 8.px(), right: 8.px()),
          waitDuration: Duration(seconds: 1),
          showDuration: Duration(seconds: 3),
          textStyle: LegoUtils.get18TextStyle(c: AppColors.white),
          triggerMode: TooltipTriggerMode.tap,
          child: Text(
            needProcess
                ? (isMoney
                    ? "${FormatUtils.formatDoubleFillZero(content, 1)}"
                    : "${FormatUtils.formatDouble(content, 1)}")
                : "$content".fixAutoLines(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: LegoUtils.getw400TextStyle(19, color: dealStatus ? AppColors.c_746f6b_ff : AppColors.black),
          ),
        ),
      ),
    );
  }

  Widget processGoodsStatusIco(
    String content,
    String icoUrl,
  ) {
    return Tooltip(
      message: "$content",
      preferBelow: false,
      padding: EdgeInsets.only(left: 8.px(), right: 8.px()),
      waitDuration: Duration(seconds: 1),
      showDuration: Duration(seconds: 3),
      textStyle: LegoUtils.get18TextStyle(c: AppColors.white),
      triggerMode: TooltipTriggerMode.tap,
      child: Image.asset(
        icoUrl,
        fit: BoxFit.scaleDown,
        width: Adapt.px(30),
        height: Adapt.px(30),
      ),
    );
  }

  Container buildChildGoodsStatusItem(dynamic content, bool dealStatus,
      {double width = 100, Alignment alignment = Alignment.center, bool needProcess = false, bool isMoney = false}) {
    if (content == "-") {
      return Container(
        width: Adapt.px(width),
        child: Align(
          alignment: alignment,
          child: Text(
            needProcess
                ? (isMoney
                    ? "${FormatUtils.formatDoubleFillZero(content, 1)}"
                    : "${FormatUtils.formatDouble(content, 1)}")
                : "$content".fixAutoLines(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: LegoUtils.getw400TextStyle(19, color: dealStatus ? AppColors.c_746f6b_ff : AppColors.black),
          ),
        ),
      );
    }
    var result = "$content";
    var splitList = result.split(",");
    var widgetList = <Widget>[];
    splitList.forEach((element) {
      switch (element) {
        case "限制配货":
          widgetList.add(processGoodsStatusIco(
              element,
              dealStatus
                  ? "assets/images/ico_reestricted_distribution_gray.png"
                  : "assets/images/ico_reestricted_distribution_black.png"));
          break;
        case "限制订货":
          widgetList.add(processGoodsStatusIco(
              element,
              dealStatus
                  ? "assets/images/ico_reestricted_order_gray.png"
                  : "assets/images/ico_reestricted_order_black.png"));
          break;
        case "限制销售":
          widgetList.add(processGoodsStatusIco(
              element,
              dealStatus
                  ? "assets/images/ico_reestricted_sell_gray.png"
                  : "assets/images/ico_reestricted_sell_black.png"));
          break;
        case "清场":
          widgetList.add(processGoodsStatusIco(
              element,
              dealStatus
                  ? "assets/images/ico_reestricted_clean_gray.png"
                  : "assets/images/ico_reestricted_clean_black.png"));
          break;
        case "限制向总部退货":
          widgetList.add(processGoodsStatusIco(
              element,
              dealStatus
                  ? "assets/images/ico_reestricted_headquarter_gray.png"
                  : "assets/images/ico_reestricted_headquarter_black.png"));
          break;
        case "限制向供应商退货":
          widgetList.add(processGoodsStatusIco(
              element,
              dealStatus
                  ? "assets/images/ico_reestricted_supplier_gray.png"
                  : "assets/images/ico_reestricted_supplier_black.png"));
          break;
      }
    });

    return Container(
      width: Adapt.px(width),
      child: Align(
          alignment: alignment,
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 1.px(),
            runSpacing: 1.px(),
            children: widgetList,
          )),
    );
  }

  showRequireTips(
    ObsoleteGoodsBean item,
  ) {
    if (item.handlingRequire != null && (item.handlingRequire?.length ?? 0) > 0) {
      return Tooltip(
        message: "${item?.handlingRequire ?? "-"}",
        preferBelow: false,
        padding: EdgeInsets.only(left: 8.px(), right: 8.px()),
        waitDuration: Duration(seconds: 1),
        showDuration: Duration(seconds: 3),
        textStyle: LegoUtils.get18TextStyle(c: AppColors.white),
        triggerMode: TooltipTriggerMode.tap,
        child: Container(
            constraints: BoxConstraints(minWidth: 0.px(), maxWidth: 200.px()),
            padding: EdgeInsets.only(
              left: Adapt.px(8),
              right: Adapt.px(8),
            ),
            height: Adapt.px(18),
            margin: EdgeInsets.only(left: 6.px()),
            decoration: LegoUtils.getCornersBg(4, borderColor: AppColors.c_f86a3e_1a, color: AppColors.c_fef3ef_ff),
            child: Text(
              "${item?.handlingRequire ?? "-"}".fixAutoLines(),
              style: LegoUtils.getTextStyle(fs: 12, c: AppColors.c_fe6043_ff, height: 1.3),
              overflow: TextOverflow.ellipsis,
            )),
      );
    } else {
      return Container();
    }
  }

  buildChildList(ObsoleteGoodsModel model) {
    var list;
    switch (model.handlingMethodId) {
      case 2:
      case 4:
        list = model.list?.map((e) {
          return Slidable(
              enabled: processSlidable(e),
              key: ValueKey("${(e?.goodsId ?? "0")}"),
              endActionPane: ActionPane(
                extentRatio: 0.18,
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      processRemoveGoods(e);
                    },
                    autoClose: true,
                    spacing: 1,
                    backgroundColor: AppColors.c_f75c24_ff,
                    foregroundColor: Colors.white,
                    label: '标记为已处理',
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(left: 40.px()),
                width: double.infinity,
                height: 98.px(),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  // border: Border(bottom: BorderSide(width: 1.px(), color: Color(0xffe5e5e5))),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Tips.showImgDialog(context, e.imgUrl).then((val) {
                          print(val);
                        });
                      },
                      child: Container(
                        decoration: LegoUtils.getCornersBg(6),
                        width: 80.px(),
                        height: 80.px(),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image(
                              image: (e.imgUrl == null
                                  ? AssetImage("assets/images/goods.png")
                                  : NetworkImage(Paths.getImg01(e.imgUrl))) as ImageProvider<Object>,
                              width: Adapt.px(80),
                              fit: BoxFit.scaleDown,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 12.px()),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.goodsName ?? '-',
                              style: TextStyle(
                                color: e.dealStatus == 1 ? AppColors.c_746f6b_ff : Color(0xFF383735),
                                fontSize: Adapt.px(19),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2.px()),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    e.goodsCode ?? '-',
                                    style: TextStyle(
                                        color: AppColors.c_746f6b_ff,
                                        fontSize: Adapt.px(19),
                                        fontWeight: FontWeight.w400,
                                        height: 1.2),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4.px()),
                                    child: Text(
                                      "${FormatUtils.formatDoubleFillZero(e?.standardPrice, 1)}元",
                                      style: TextStyle(
                                          color: AppColors.c_746f6b_ff,
                                          fontSize: Adapt.px(19),
                                          fontWeight: FontWeight.w400,
                                          height: 1.2),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  showRequireTips(e)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildChildContentItem(e.packageSize, e.dealStatus == 1, needProcess: true),
                    buildChildContent2LineItem("${e.kindCodeCate1}-${e.kindNameCate1}", e.dealStatus == 1, width: 120),
                    buildChildGoodsStatusItem(
                        ((e.goodsState?.length ?? 0) > 0) ? e.goodsState : "-", e.dealStatus == 1),
                    buildChildContent2LineItem(
                        ((e.handlingMethod?.length ?? 0) > 0) ? e.handlingMethod : "-", e.dealStatus == 1),
                    buildChildContentItem(e.storage, e.dealStatus == 1, needProcess: true),
                    buildChildContentItem(
                      e.storageAmt,
                      e.dealStatus == 1,
                      width: 120,
                      needProcess: true,
                      isMoney: true,
                    ),
                    buildChildContentItem("", e.dealStatus == 1, width: 40),
                  ],
                ),
              ));
        }).toList();
        break;
      case 1:
      case 3:
        list = model.list?.map((e) {
          return Slidable(
              enabled: processSlidable(e),
              key: ValueKey("${(e?.goodsId ?? "0")}"),
              endActionPane: ActionPane(
                extentRatio: 0.18,
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      processRemoveGoods(e);
                    },
                    autoClose: true,
                    spacing: 1,
                    backgroundColor: AppColors.c_f75c24_ff,
                    foregroundColor: Colors.white,
                    label: '标记为已处理',
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(left: 40.px()),
                width: double.infinity,
                height: 98.px(),
                decoration: BoxDecoration(
                    // border: Border(bottom: BorderSide(width: 1.px(), color: Color(0xffe5e5e5))),
                    ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Tips.showImgDialog(context, e.imgUrl).then((val) {
                          print(val);
                        });
                      },
                      child: Container(
                        decoration: LegoUtils.getCornersBg(6),
                        width: 80.px(),
                        height: 80.px(),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image(
                              image: (e.imgUrl == null
                                  ? AssetImage("assets/images/goods.png")
                                  : NetworkImage(Paths.getImg01(e.imgUrl))) as ImageProvider<Object>,
                              width: Adapt.px(80),
                              fit: BoxFit.scaleDown,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 12.px()),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.goodsName ?? '-',
                              style: TextStyle(
                                color: e.dealStatus == 1 ? AppColors.c_746f6b_ff : Color(0xFF383735),
                                fontSize: Adapt.px(19),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2.px()),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    e.goodsCode ?? '-',
                                    style: TextStyle(
                                        color: AppColors.c_746f6b_ff,
                                        fontSize: Adapt.px(19),
                                        fontWeight: FontWeight.w400,
                                        height: 1.2),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4.px()),
                                    child: Text(
                                      "${FormatUtils.formatDoubleFillZero(e?.standardPrice, 1)}元",
                                      style: TextStyle(
                                          color: AppColors.c_746f6b_ff,
                                          fontSize: Adapt.px(19),
                                          fontWeight: FontWeight.w400,
                                          height: 1.2),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  showRequireTips(e)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildChildContentItem(e.packageSize, e.dealStatus == 1, needProcess: true),
                    buildChildContent2LineItem("${e.kindCodeCate1}-${e.kindNameCate1}", e.dealStatus == 1, width: 120),
                    buildChildGoodsStatusItem(
                        ((e.goodsState?.length ?? 0) > 0) ? e.goodsState : "-", e.dealStatus == 1),
                    buildChildContentItem(e.storage, e.dealStatus == 1, needProcess: true),
                    buildChildContentItem(
                      e.storageAmt,
                      e.dealStatus == 1,
                      width: 120,
                      needProcess: true,
                      isMoney: true,
                    ),
                    buildChildContentItem("", e.dealStatus == 1, width: 40),
                  ],
                ),
              ));
        }).toList();
        break;
      default:
        list = model.list?.map((e) {
          return Slidable(
              enabled: processSlidable(e),
              key: ValueKey("${(e?.goodsId ?? "0")}"),
              endActionPane: ActionPane(
                extentRatio: 0.18,
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      processRemoveGoods(e);
                    },
                    autoClose: true,
                    spacing: 1,
                    backgroundColor: AppColors.c_f75c24_ff,
                    foregroundColor: Colors.white,
                    label: '标记为已处理',
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(left: 40.px()),
                width: double.infinity,
                height: 98.px(),
                decoration: BoxDecoration(
                    // border: Border(bottom: BorderSide(width: 1.px(), color: Color(0xffe5e5e5))),
                    ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Tips.showImgDialog(context, e.imgUrl).then((val) {
                          print(val);
                        });
                      },
                      child: Container(
                        decoration: LegoUtils.getCornersBg(6),
                        width: 80.px(),
                        height: 80.px(),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Image(
                              image: (e.imgUrl == null
                                  ? AssetImage("assets/images/goods.png")
                                  : NetworkImage(Paths.getImg01(e.imgUrl))) as ImageProvider<Object>,
                              width: Adapt.px(80),
                              fit: BoxFit.scaleDown,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 12.px()),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.goodsName ?? '-',
                              style: TextStyle(
                                color: e.dealStatus == 1 ? AppColors.c_746f6b_ff : Color(0xFF383735),
                                fontSize: Adapt.px(19),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2.px()),
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    e.goodsCode ?? '-',
                                    style: TextStyle(
                                        color: AppColors.c_746f6b_ff,
                                        fontSize: Adapt.px(19),
                                        fontWeight: FontWeight.w400,
                                        height: 1.2),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 4.px()),
                                    child: Text(
                                      "${FormatUtils.formatDoubleFillZero(e?.standardPrice, 1)}元",
                                      style: TextStyle(
                                          color: AppColors.c_746f6b_ff,
                                          fontSize: Adapt.px(19),
                                          fontWeight: FontWeight.w400,
                                          height: 1.2),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  showRequireTips(e)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildChildContentItem(e.packageSize, e.dealStatus == 1, needProcess: true),
                    buildChildContent2LineItem("${e.kindCodeCate1}-${e.kindNameCate1}", e.dealStatus == 1, width: 120),
                    buildChildGoodsStatusItem(
                        ((e.goodsState?.length ?? 0) > 0) ? e.goodsState : "-", e.dealStatus == 1),
                    buildChildContent2LineItem(
                        ((e.handlingMethod?.length ?? 0) > 0) ? e.handlingMethod : "-", e.dealStatus == 1),
                    buildChildContentItem(e.dealStatus == 1 ? "已处理" : "未处理", e.dealStatus == 1),
                    buildChildContentItem("", e.dealStatus == 1, width: 40),
                  ],
                ),
              ));
        }).toList();
    }

    var newList = <Widget>[];
    if (list != null) {
      newList.addAll(list);
    }

    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: newList,
      ),
    );
  }

  bool processSlidable(ObsoleteGoodsBean e) {
    if (state.pageModel != null && (state.pageModel?.inDealTime ?? 0) == 1) {
      return e.dealStatus == 0;
    }

    return false;
  }

  @override
  void dispose() {
    Get.delete<ObsoleteGoodsEffect>();
    super.dispose();
  }

  void processRemoveGoods(ObsoleteGoodsBean bean) {
    effect.removeGoods(bean);
  }
}
