import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum Test1Action { action }

class Test1ActionCreator {
  static Action onAction() {
    return const Action(Test1Action.action);
  }
}
