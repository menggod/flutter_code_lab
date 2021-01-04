import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<ThirdState> buildEffect() {
  return combineEffects(<Object, Effect<ThirdState>>{
    ThirdAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ThirdState> ctx) {
}
