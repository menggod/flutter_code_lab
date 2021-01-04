import 'package:fish_redux/fish_redux.dart';

class SubThirdState implements Cloneable<SubThirdState> {

  @override
  SubThirdState clone() {
    return SubThirdState();
  }
}

SubThirdState initState(Map<String, dynamic> args) {
  return SubThirdState();
}
