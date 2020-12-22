import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SecondAction { backFirst }

class SecondActionCreator {
  static Action onBackFirst() {
    return const Action(SecondAction.backFirst);
  }
}
