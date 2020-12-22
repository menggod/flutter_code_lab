import 'package:fish_redux/fish_redux.dart';

class Test1State implements Cloneable<Test1State> {

  @override
  Test1State clone() {
    return Test1State();
  }
}

Test1State initState(Map<String, dynamic> args) {
  return Test1State();
}
