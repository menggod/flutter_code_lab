import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SubThirdAction { action }

class SubThirdActionCreator {
  static Action onAction() {
    return const Action(SubThirdAction.action);
  }
}
