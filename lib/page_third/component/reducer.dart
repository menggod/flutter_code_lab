import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SubThirdState> buildReducer() {
  return asReducer(
    <Object, Reducer<SubThirdState>>{
      SubThirdAction.action: _onAction,
    },
  );
}

SubThirdState _onAction(SubThirdState state, Action action) {
  final SubThirdState newState = state.clone();
  return newState;
}
