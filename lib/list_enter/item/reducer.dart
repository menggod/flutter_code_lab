import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SubEnterState> buildReducer() {
  return asReducer(
    <Object, Reducer<SubEnterState>>{
      SubEnterAction.action: _onAction,
    },
  );
}

SubEnterState _onAction(SubEnterState state, Action action) {
  final SubEnterState newState = state.clone();
  return newState;
}
