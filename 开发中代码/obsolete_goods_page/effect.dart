import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mpa/actions/storage.dart';
import 'package:mpa/config/global.dart';
import 'package:mpa/models/obsolete_goods/obsolete_goods_model.dart';
import 'package:mpa/models/response_bean.dart';
import 'package:mpa/pages/obsolete_goods_list_page/view.dart';
import 'package:mpa/pages/obsolete_goods_page/view.dart';
import 'package:mpa/routes/mavigator.dart';
import 'package:mpa/service/api_service.dart';
import 'package:mpa/utils/date_util.dart';
import 'package:mpa/utils/extension.dart';
import 'package:mpa/utils/logger.dart';
import 'package:mpa/utils/sort_utils.dart';
import 'package:mpa/widget/error_page/action.dart';

import 'state.dart';

class ObsoleteGoodsEffect extends GetxController {
  final ObsoleteGoodsState state = ObsoleteGoodsState();

  @override
  void onReady() {
    pageInit();
    super.onReady();
  }

  @override
  void onClose() {
    setGuideStatus();
    super.onClose();
  }

  void onErrorRefresh() {
    state.isShowErrorPage = false;
    update();
    pageInit();
  }

  void pageInit() async {
    doRequestAction();
  }

  void doRequestAction() async {
    PageStateUtils.setGetXLoadingState(this, state, true);
    BaseResponse<ObsoleteGoodsPageModel> response =
        await ApiService.getObsoleteGoodsDetail(state.weedoutTaskId, state.yearMonth);

    if (!response.isSuccess() || response.isDataNull()) {
      PageStateUtils.setGetXLoadingState(this, state, false);
      state.isShowErrorPage = true;
      update();
      return;
    }
    PageStateUtils.setGetXLoadingState(this, state, false);
    state.pageModel = response.data;
    state.weedoutTaskId = response.data?.weedoutTaskId;
    var contentList = <ObsoleteGoodsModel>[];

    {
      //退货
      var list = state.pageModel!.weedoutReturnList;
      processContentListItem(list, contentList);
    }

    {
      //折扣
      var list = state.pageModel!.weedoutDiscountList;
      processContentListItem(list, contentList);
    }
    {
      //消化
      var list = state.pageModel!.weedoutDigestionList;
      processContentListItem(list, contentList);
    }
    {
      //其他
      var list = state.pageModel!.weedoutOtherList;
      processContentListItem(list, contentList);
    }
    {
      //已处理
      var list = state.pageModel!.weedoutProcessedList;
      processContentListItem(list, contentList);
    }

    state.list = contentList;
    state.obsoleteType = ObsoleteType.pending;
    if (state.scrollController?.hasClients ?? false) {
      state.scrollController.jumpTo(0);
    }
    update();

    var bool = await Storage.getBool(SpConstant.SHOW_OBSOLETE_TIPS);
    if (bool == null) {
      if ((state.getShowList()?.isNotEmpty ?? false) && (state.pageModel?.inDealTime ?? 0) == 1) {
        state.guideStatus = true;
        update();
      }
    }
  }

  //PROCESSED(0, "已处理商品"),
  //RETURN(1,  "退货"),
  //DISCOUNT(2, "折扣"),
  //DIGESTION(3, "自然消化"),
  void processContentListItem(List<ObsoleteGoodsBean>? remoteList, List<ObsoleteGoodsModel> contentList) {
    if (remoteList?.isNotEmpty ?? false) {
      var model = ObsoleteGoodsModel();
      model.list = remoteList;
      model.dealStatus = remoteList!.first.dealStatus;

      if (model.dealStatus == 1) {
        model.handlingMethodId = 0;
        model.handlingMethodValue = "已处理商品";
      } else {
        model.handlingMethodId = remoteList!.first.handlingMethodId;
        model.handlingMethodValue = remoteList!.first.handlingMethodValue;
      }

      contentList.add(model);
    }
  }

  void onTabClick(ObsoleteType type) {
    if (state.obsoleteType == type) {
      return;
    }
    if (state.scrollController?.hasClients ?? false) {
      state.scrollController.jumpTo(0);
    }
    state.obsoleteType = type;

    update();
  }

  void removeGoods(ObsoleteGoodsBean bean) async {
    state.list?.forEach((element) {
      if (element.handlingMethodId != 0) {
        var indexOf = element?.list?.indexOf(bean);
        if (indexOf != null && indexOf! >= 0) {
          element.list?.remove(bean);
        }
      }
    });
    var last = state.list?.last;
    if (last != null) {
      bean.dealStatus = 1;
      last.list?.insert(0, bean);
      state.list?.last = last;
    }

    state?.list?.forEach((element) {
      if (element.list != null) {
        SortUtils.insertSort(element!.list!, (ObsoleteGoodsBean a, ObsoleteGoodsBean b) {
          final int sortByKindNameCate1 = (a.kindCodeCate1!).compareTo(b.kindCodeCate1!);
          if (sortByKindNameCate1 == 0) {
            final int sortByStorage = -(a.storage!).compareTo(b.storage!);
            if (sortByStorage == 0) {
              final int sortByGoodsCode = (a.goodsCode!).compareTo(b.goodsCode!);
              return sortByGoodsCode;
            }
            return sortByStorage;
          }
          return sortByKindNameCate1;
        });
      }
    });
    update();

    var response = await ApiService.modifyObsoleteGoods(
      bean.goodsId,
      state.weedoutTaskId,
    );
    if (!response.isSuccess()) {
      var last = state.list?.last;
      if (last != null) {
        bean.dealStatus = 0;
        last.list?.remove(bean);
        state.list?.last = last;
      }
      state.list?.forEach((element) {
        if (element.handlingMethodId != 0) {
          if (element.handlingMethodId == bean.handlingMethodId) {
            element?.list?.insert(0, bean);
          }
        }
      });

      state?.list?.forEach((element) {
        if (element.list != null) {
          SortUtils.insertSort(element!.list!, (ObsoleteGoodsBean a, ObsoleteGoodsBean b) {
            final int sortByKindNameCate1 = (a.kindCodeCate1!).compareTo(b.kindCodeCate1!);
            if (sortByKindNameCate1 == 0) {
              final int sortByStorage = -(a.storage!).compareTo(b.storage!);
              if (sortByStorage == 0) {
                final int sortByGoodsCode = (a.goodsCode!).compareTo(b.goodsCode!);
                return sortByGoodsCode;
              }
              return sortByStorage;
            }
            return sortByKindNameCate1;
          });
        }
      });
      update();
    }
  }

  void queryByMonth(int dateInt) {
    state.yearMonth = dateInt;
    state.weedoutTaskId = null;
    state.pageModel = null;
    doRequestAction();
  }

  void setGuideStatus() {
    state.guideStatus = false;
    Storage.setBool(SpConstant.SHOW_OBSOLETE_TIPS, false);
    update();
  }

  void processScroll(ObsoleteGoodsModel model) {
    var indexOf = state.getShowList()?.indexOf(model);
    if (indexOf == 0) {
      if (state.scrollController?.hasClients ?? false) {
        state.scrollController.jumpTo(0);
      }
    }
    double needScroller = 0.0;
    if ((indexOf ?? 0) > 0) {
      needScroller += 10.px();
      for (int i = 0; i < indexOf!; i++) {
        needScroller += 105.px();
        needScroller += i * 3.px();
        needScroller += (98.px() * (state.getShowList()![i].list?.length ?? 0));
      }
    }

    var scrollController = state.scrollController;
    var position = scrollController.position;
    double viewportDimension = position.viewportDimension;
    double maxScrollExtent = position.maxScrollExtent;

    if (scrollController.offset == maxScrollExtent) {
      return;
    }

    if (needScroller - maxScrollExtent > 0) {
      if (state.scrollController?.hasClients ?? false) {
        state.scrollController.jumpTo(maxScrollExtent);
      }
    }
    if (state.scrollController?.hasClients ?? false) {
      state.scrollController.jumpTo(needScroller);
    }
  }

  void onBack(BuildContext context) {
    if (state.pageFrom == ObsoleteGoodsPage.FROM_NOTIFY) {
      Mavigator.toReplaceNewPage(context, ObsoleteGoodsListPagePage());
    } else {
      Mavigator.onBack(context);
    }
  }
}
