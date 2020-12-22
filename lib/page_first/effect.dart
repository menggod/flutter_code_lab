import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<FirstState> buildEffect() {
  return combineEffects(<Object, Effect<FirstState>>{
    FirstAction.action: _onAction,
  });
}

void _onAction(Action action, Context<FirstState> ctx) {
}
