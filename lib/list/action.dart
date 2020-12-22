import 'package:fish_redux/fish_redux.dart';

enum ListAction { updateItem }

class ListActionCreator {
  static Action onUpdateItem(var list) {
    return Action(ListAction.updateItem, payload: list);
  }
}
