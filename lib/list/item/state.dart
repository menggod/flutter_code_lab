import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_code_test/list/item/item_detail_bean.dart';

class ItemState implements Cloneable<ItemState> {
  Datas itemDetail;

  ItemState({this.itemDetail});

  @override
  ItemState clone() {
    return ItemState()..itemDetail = itemDetail;
  }
}

ItemState initState(Map<String, dynamic> args) {
  return ItemState();
}
