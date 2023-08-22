import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpa/actions/adapt.dart';
import 'package:mpa/models/obsolete_goods_activity_bean.dart';
import 'package:mpa/routes/mavigator.dart';
import 'package:mpa/utils/app_colors.dart';
import 'package:mpa/utils/extension.dart';
import 'package:mpa/utils/format.dart';
import 'package:mpa/utils/lego_utils.dart';
import 'package:mpa/utils/singleton.dart';
import 'package:mpa/widget/dash_line.dart';
import 'package:mpa/widget/empty_page/empty_view.dart';
import 'package:mpa/widget/getx_widget/error_page.dart';
import 'package:mpa/widget/getx_widget/loading_view.dart';
import 'package:mpa/widget/other_widget.dart';

import 'effect.dart';

class ObsoleteGoodsListPagePage extends StatefulWidget {
  @override
  State<ObsoleteGoodsListPagePage> createState() => _ObsoleteGoodsListPagePageState();
}

class _ObsoleteGoodsListPagePageState extends State<ObsoleteGoodsListPagePage> {
  final effect = Get.put(ObsoleteGoodsListPageEffect());
  final state = Get
      .find<ObsoleteGoodsListPageEffect>()
      .state;

  @override
  Widget build(BuildContext context) {
    var _appBarLayout = LegoUtils.getPageTitleHasArrow(
        onBack: () {
          Mavigator.onBack(context);
        },
        leftWidgetsList: [
          GetBuilder<ObsoleteGoodsListPageEffect>(builder: (effect) {
            return Text(
              "总部汰品",
              style: TextStyle(color: Colors.white, fontSize: Adapt.px(24), fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.left,
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
              "${DateTime
                  .now()
                  .year}.${DateTime
                  .now()
                  .month}.${DateTime
                  .now()
                  .day}(周${FormatUtils.getWeekDayZH(DateTime
                  .now()
                  .weekday)})",
              style: TextStyle(color: Colors.white, fontSize: Adapt.px(24), fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis, // 文字显示不全样式
              maxLines: 1, // 最大显示行数，默认为最大
            ),
          ),
        ]);

    Widget buildListItem(ObsoleteGoodsActivityBean item) {
      return Container(
        width: double.infinity,
        height: 220.px(),
        margin: EdgeInsets.only(bottom: 20.px()),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFEBF0F2),
              offset: Offset(0, 2.px()),
              blurRadius: 9.px(),
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
                child: Container(
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Opacity(
                        opacity: (item?.inDealTime == 1) ? 1 : 0,
                        child: Container(
                          width: 74.px(),
                          height: 32.px(),
                          decoration: BoxDecoration(
                            color: Color(0xFFF75C24),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.px()),
                              bottomRight: Radius.circular(12.px()),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "处理中",
                              style: LegoUtils.getw600TextStyle(16, color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.px(), right: 20.px(), top: 8.px()),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              "${item?.activityName ?? "-"}",
                              style: LegoUtils.getw600TextStyle(22),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12.px()),
                              padding: EdgeInsets.symmetric(horizontal: 6.px(), vertical: 2.px()),
                              decoration: BoxDecoration(
                                color: Color(0xFFFEF0F0),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Color(0xFFFFD1D1),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "${item?.activityTypeValue ?? "-"}",
                                  style: LegoUtils.getw400TextStyle(14, color: AppColors.c_ff4747_ff, height: 1.2),
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "SKU:${item?.activitySku ?? "-"}个",
                              style: LegoUtils.getw600TextStyle(22),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.px(), right: 20.px(), top: 6.px()),
                        child: Text(
                          "处理周期:${item?.dealStartDate ?? "-"} ~ ${item?.dealEndDate ?? "-"}",
                          style: LegoUtils.getw400TextStyle(16, color: AppColors.c_8c8681_ff),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40.px(), right: 20.px(), top: 10.px()),
                        child: AutoSizeText(
                          "${item?.taskDesc ?? ""}".fixAutoLines(),
                          style: LegoUtils.getw400TextStyle(15, color: AppColors.c_8c8681_ff, height: 1.6),
                          minFontSize: 2,
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
                )),
            VerticalLine(
              margin: EdgeInsets.only(top: 40.px(), bottom: 40.px()),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                effect.goDetailPage(item, context);
              },
              child: Container(
                width: 143.px(),
                height: 220.px(),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "查看详情",
                      style: LegoUtils.getw400TextStyle(20, color: AppColors.c_383735_ff),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.c_383735_ff,
                      size: Adapt.px(20),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return PageContainer(
      child: Scaffold(
        appBar: _appBarLayout,
        body: Container(
          color: AppColors.c_bg_gray,
          width: double.infinity,
          child: GetBuilder<ObsoleteGoodsListPageEffect>(builder: (effect) {
            return Stack(
              children: [
                (state.list?.length ?? -1) != 0
                    ? GetBuilder<ObsoleteGoodsListPageEffect>(builder: (effect) {
                  return Container(
                    padding: EdgeInsets.only(
                      left: 40.px(),
                      right: 40.px(),
                    ),
                    child: ListView.builder(
                      itemExtent: 220.px(),
                      padding: EdgeInsets.only(top: 20.px()),
                      itemCount: state.list?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return buildListItem(state.list![index]);
                      },
                    ),
                  );
                })
                    : Container(
                  child: EmptyView(
                    true,
                    title: "暂无汰品信息",
                  ),
                ),
                GetBuilder<ObsoleteGoodsListPageEffect>(builder: (effect) {
                  return GetLoadingView(
                    state.isShowLoading,
                  );
                }),
                GetBuilder<ObsoleteGoodsListPageEffect>(builder: (effect) {
                  return GetErrorPage(
                    state.isShowErrorPage,
                    state.baseResponse,
                    onTryClick: () {
                      effect.onErrorRefresh();
                    },
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<ObsoleteGoodsListPageEffect>();
    super.dispose();
  }

  // 0 其他汰品
  // 1 月度常规汰品
  // 2 季节性汰品

  processTagShow(ObsoleteGoodsActivityBean item) {
    switch (item?.activityType) {
      case 1:
    }
  }
}
