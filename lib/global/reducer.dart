import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onChangeThemeColor,
    },
  );
}

GlobalState _onChangeThemeColor(GlobalState state, Action action) {
  final GlobalState newState = state.clone();
  return newState;
}
