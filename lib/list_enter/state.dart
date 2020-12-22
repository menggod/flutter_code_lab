import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_code_test/global_store/state.dart';

class EnterState extends MutableSource implements GlobalBaseState, Cloneable<EnterState> {
  @override
  EnterState clone() {
    return EnterState();
  }

  @override
  Object getItemData(int index) {
    // TODO: implement getItemData
    throw UnimplementedError();
  }

  @override
  String getItemType(int index) {
    // TODO: implement getItemType
    throw UnimplementedError();
  }

  @override
  // TODO: implement itemCount
  int get itemCount => throw UnimplementedError();

  @override
  void setItemData(int index, Object data) {
    // TODO: implement setItemData
  }

  @override
  Color themeColor;

}

EnterState initState(Map<String, dynamic> args) {
  return EnterState();
}
