import 'package:fish_redux/fish_redux.dart';

class ThirdState implements Cloneable<ThirdState> {

  @override
  ThirdState clone() {
    return ThirdState();
  }
}

ThirdState initState(Map<String, dynamic> args) {
  return ThirdState();
}
