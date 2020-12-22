import 'package:fish_redux/fish_redux.dart';

enum Test1Action { action, increase, updateCount }

class Test1ActionCreator {
  static Action onAction() {
    return const Action(Test1Action.action);
  }

  //去effect层去处理自增数据
  static Action onIncrease() {
    return Action(Test1Action.increase);
  }

  //去reducer层更新数据，传参可以放在Action类中的payload字段中，payload是dynamic类型，可传任何类型
  static Action onUpdateCount(int count) {
    return Action(Test1Action.updateCount, payload: count);
  }
}
