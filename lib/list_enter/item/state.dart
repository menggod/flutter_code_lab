import 'package:fish_redux/fish_redux.dart';

class SubEnterState implements Cloneable<SubEnterState> {
  int type;
  String title;
  String content;

  SubEnterState({this.type, this.title, this.content});

  @override
  SubEnterState clone() {
    return SubEnterState()
      ..content
      ..title
      ..type;
  }
}

SubEnterState initState(Map<String, dynamic> args) {
  return SubEnterState();
}
