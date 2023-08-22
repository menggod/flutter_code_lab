import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpa/models/obsolete_goods_activity_bean.dart';
import 'package:mpa/models/response_bean.dart';
import 'package:mpa/pages/obsolete_goods_page/view.dart';
import 'package:mpa/routes/mavigator.dart';
import 'package:mpa/service/api_service.dart';
import 'package:mpa/widget/error_page/action.dart';

import 'state.dart';

class ObsoleteGoodsListPageEffect extends GetxController {
  final ObsoleteGoodsListPageState state = ObsoleteGoodsListPageState();

  @override
  void onReady() {
    pageInit();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onErrorRefresh() {
    state.isShowErrorPage = false;
    update();
    pageInit();
  }

  void pageInit() async {
    PageStateUtils.setGetXLoadingState(this, state, true);

    BaseResponse<List<ObsoleteGoodsActivityBean>> response =
        await ApiService.getObsoleteGoodsList();

    if (!response.isSuccess() || response.isDataNull()) {
      PageStateUtils.setGetXLoadingState(this, state, false);
      state.isShowErrorPage = true;
      update();
      return;
    }
    state.list = response.data;
    PageStateUtils.setGetXLoadingState(this, state, false);
  }

  void goDetailPage(
      ObsoleteGoodsActivityBean item, BuildContext context) async {
    Mavigator.toNewPage(
        context,
        ObsoleteGoodsPage(
          weedoutTaskId: item.weedoutTaskId,
          pageFrom: ObsoleteGoodsPage.FROM_LIST,
        ));

    if (item.readStatus == 0) {
      ApiService.postReadNotify(item.weedoutTaskId).then((response) {
        if (response.isSuccess()) {
          item.readStatus = 1;
          update();
        }
      });
    }
  }
}
