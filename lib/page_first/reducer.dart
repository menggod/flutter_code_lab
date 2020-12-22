import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FirstState> buildReducer() {
  return asReducer(
    <Object, Reducer<FirstState>>{
      FirstAction.action: _onAction,
    },
  );
}

FirstState _onAction(FirstState state, Action action) {
  final FirstState newState = state.clone();
  return newState;
}
