import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<EnterState> buildEffect() {
  return combineEffects(<Object, Effect<EnterState>>{
    EnterAction.action: _onAction,
  });
}

void _onAction(Action action, Context<EnterState> ctx) {
}
