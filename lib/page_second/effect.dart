import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Effect<SecondState> buildEffect() {
  return combineEffects(<Object, Effect<SecondState>>{
    SecondAction.backFirst: _onBackFirst,
  });
}

void _onBackFirst(Action action, Context<SecondState> ctx) {
  Navigator.pop(ctx.context, {"secondValue": SecondState.fixedMsg});
}
