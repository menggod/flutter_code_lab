import 'package:flutter/material.dart';
import 'package:mpa/models/obsolete_goods/obsolete_goods_model.dart';
import 'package:mpa/widget/error_page/error_state.dart';

enum ObsoleteType {
  pending(0, 'pending'),
  already(1, 'already'),
  all(2, 'all');

  const ObsoleteType(this.number, this.value);

  final int number;
  final String value;

  static ObsoleteType getTypeByTitle(String title) =>
      ObsoleteType.values.firstWhere((activity) => activity.name == title);

  static ObsoleteType getType(int number) => ObsoleteType.values.firstWhere((activity) => activity.number == number);

  static String getValue(int number) => ObsoleteType.values.firstWhere((activity) => activity.number == number).value;
}

class ObsoleteGoodsState with PageState {
  int? weedoutTaskId;
  int? yearMonth;

  late int pageFrom;

  ObsoleteGoodsPageModel? pageModel;
  List<ObsoleteGoodsModel>? list;
  late ObsoleteType obsoleteType;
  late ScrollController scrollController;
  bool guideStatus = false;

  /// 1已处理 0未处理
  int getPendingCount() {
    var count = 0;
    if (list != null) {
      list
          ?.where((element) {
            return element.dealStatus == 0;
          })
          .toList()
          .forEach((element) {
            count += element.list?.length ?? 0;
          });
    }
    return count;
  }

  int getAlreadyCount() {
    var count = 0;
    if (list != null) {
      list
          ?.where((element) {
            return element.dealStatus == 1;
          })
          .toList()
          .forEach((element) {
            count += element.list?.length ?? 0;
          });
    }
    return count;
  }

  int getAllCount() {
    var count = 0;
    if (list != null) {
      list?.forEach((element) {
        count += element.list?.length ?? 0;
      });
    }
    return count;
  }

  double getShowMoney() {
    var money = 0.0;
    list?.where((element) => element.dealStatus == 0 && (element.list?.length ?? 0) > 0).toList()?.forEach((element) {
      element?.list?.forEach((bean) {
        money += bean.storageAmt ?? 0;
      });
    });
    return money;
  }

  List<ObsoleteGoodsModel>? getShowList() {
    return list?.where((element) {
      if (obsoleteType == ObsoleteType.pending) {
        return element.dealStatus == 0 && (element.list?.length ?? 0) > 0;
      } else if (obsoleteType == ObsoleteType.already) {
        return element.dealStatus == 1 && (element.list?.length ?? 0) > 0;
      } else {
        return (element.list?.length ?? 0) > 0;
      }
    }).toList();
  }

  ObsoleteGoodsState() {
    obsoleteType = ObsoleteType.pending;
    scrollController = ScrollController();
  }
}
