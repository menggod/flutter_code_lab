import 'package:flutter/material.dart';
import 'package:flutter_code_test/global/cons.dart';
import 'package:get/get.dart';

import 'model/poem_item_bean.dart';
import 'state.dart';

class HomeListEffect extends GetxController {
  final HomeListState state = HomeListState();

  var list = Cons.routeList.keys.toList();
  List itemList = <PoemItem>[];

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < list.length; i++) {
      itemList
          .add(PoemItem(title: list[i], summary: Cons.routeIntroList[list[i]]));
    }
    state.data = itemList;
    debugPrint('menggod effect onInit:${itemList.length} ');
  }

}
