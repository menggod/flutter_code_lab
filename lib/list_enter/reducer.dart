import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<EnterState> buildReducer() {
  return asReducer(
    <Object, Reducer<EnterState>>{
      EnterAction.action: _onAction,
    },
  );
}

EnterState _onAction(EnterState state, Action action) {
  final EnterState newState = state.clone();
  return newState;
}
