import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SubEnterAction { action }

class SubEnterActionCreator {
  static Action onAction() {
    return const Action(SubEnterAction.action);
  }
}
