import 'package:fish_redux/fish_redux.dart';

enum FirstAction { action, toSecond, updateMsg }

class FirstActionCreator {
  static Action onAction() {
    return const Action(FirstAction.action);
  }

  static Action onToSecond() {
    return Action(FirstAction.toSecond);
  }

  static Action onUpdateMsg(String msg) {
    return Action(FirstAction.updateMsg, payload: msg);
  }
}
