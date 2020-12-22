import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_code_test/global_store/reducer.dart';
import 'package:flutter_code_test/global_store/state.dart';

class GlobalStore {
  static Store<GlobalState> _store;

  static Store<GlobalState> get store => _store ?? createStore<GlobalState>(GlobalState(), buildReducer());
}
