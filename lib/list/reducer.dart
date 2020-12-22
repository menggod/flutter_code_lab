import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ListState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListState>>{
      ListAction.updateItem: _onUpdateItem,
    },
  );
}

ListState _onUpdateItem(ListState state, Action action) {
  final ListState newState = state.clone();
  return newState..items = action.payload;
}
