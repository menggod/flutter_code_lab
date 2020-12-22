import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<Test1State> buildEffect() {
  return combineEffects(<Object, Effect<Test1State>>{
    Test1Action.action: _onAction,
    Test1Action.increase: _onIncrease,
  });
}

void _onAction(Action action, Context<Test1State> ctx) {}

//自增
void _onIncrease(Action action, Context<Test1State> ctx) {
  int count = ctx.state.count + 1;
  //处理自增
  ctx.dispatch(Test1ActionCreator.onUpdateCount(count));
}
