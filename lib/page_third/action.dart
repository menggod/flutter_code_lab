import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ThirdAction { action }

class ThirdActionCreator {
  static Action onAction() {
    return const Action(ThirdAction.action);
  }
}
