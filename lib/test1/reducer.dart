import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<Test1State> buildReducer() {
  return asReducer(
    <Object, Reducer<Test1State>>{
      Test1Action.action: _onAction,
      Test1Action.updateCount: _updateCount,
    },
  );
}

Test1State _onAction(Test1State state, Action action) {
  final Test1State newState = state.clone();
  return newState;
}

Test1State _updateCount(Test1State state, Action action) {
  final Test1State newState = state.clone();
  newState..count = action.payload;
  return newState;
}
