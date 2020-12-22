import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SecondState> buildReducer() {
  return asReducer(
    <Object, Reducer<SecondState>>{
      SecondAction.backFirst: _onBackFirst,
    },
  );
}

SecondState _onBackFirst(SecondState state, Action action) {
  final SecondState newState = state.clone();
  return newState;
}
