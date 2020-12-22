import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_code_test/list_enter/item/state.dart';

//TODO replace with your own action
enum EnterAction { action, initList }

class EnterActionCreator {
  static Action onAction() {
    return const Action(EnterAction.action);
  }

  static Action onInitList(List<SubEnterState> items) {
    return Action(EnterAction.initList, payload: items);
  }
}
