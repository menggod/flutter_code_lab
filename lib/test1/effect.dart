import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<Test1State> buildEffect() {
  return combineEffects(<Object, Effect<Test1State>>{
    Test1Action.action: _onAction,
  });
}

void _onAction(Action action, Context<Test1State> ctx) {
}
