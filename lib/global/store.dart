import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_code_test/global/reducer.dart';

import 'state.dart';


class GlobalStore {
  static Store<GlobalState> _store;

  static Store<GlobalState> get store => _store ?? createStore<GlobalState>(GlobalState(), buildReducer());
}
