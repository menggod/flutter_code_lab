import 'package:fish_redux/fish_redux.dart';

class SubThirdState extends MutableSource implements Cloneable<SubThirdState> {
  @override
  SubThirdState clone() {
    return SubThirdState();
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
}

SubThirdState initState(Map<String, dynamic> args) {
  return SubThirdState();
}
