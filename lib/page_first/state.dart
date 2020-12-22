import 'package:fish_redux/fish_redux.dart';

class FirstState implements Cloneable<FirstState> {

  @override
  FirstState clone() {
    return FirstState();
  }
}

FirstState initState(Map<String, dynamic> args) {
  return FirstState();
}
