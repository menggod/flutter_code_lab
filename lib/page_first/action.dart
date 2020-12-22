import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FirstAction { action }

class FirstActionCreator {
  static Action onAction() {
    return const Action(FirstAction.action);
  }
}
