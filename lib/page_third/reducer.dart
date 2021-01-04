import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ThirdState> buildReducer() {
  return asReducer(
    <Object, Reducer<ThirdState>>{
      ThirdAction.action: _onAction,
    },
  );
}

ThirdState _onAction(ThirdState state, Action action) {
  final ThirdState newState = state.clone();
  return newState;
}
