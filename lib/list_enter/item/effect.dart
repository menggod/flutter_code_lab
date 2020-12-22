import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<SubEnterState> buildEffect() {
  return combineEffects(<Object, Effect<SubEnterState>>{
    SubEnterAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SubEnterState> ctx) {
}
