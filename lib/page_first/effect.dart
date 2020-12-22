import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Effect<FirstState> buildEffect() {
  return combineEffects(<Object, Effect<FirstState>>{
    FirstAction.action: _onAction,
    FirstAction.toSecond: _onToSecond,
  });
}

void _onAction(Action action, Context<FirstState> ctx) {}

void _onToSecond(Action action, Context<FirstState> ctx) async {
  var result = await Navigator.of(ctx.context).pushNamed("second", arguments: {"firstValue": FirstState.fixedMsg});
  print(result);
  ctx.dispatch(FirstActionCreator.onUpdateMsg((result as Map)["secondValue"]));
}
