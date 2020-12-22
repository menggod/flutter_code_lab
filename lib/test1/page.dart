import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class Test1Page extends Page<Test1State, Map<String, dynamic>> {
  Test1Page()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<Test1State>(
                adapter: null,
                slots: <String, Dependent<Test1State>>{
                }),
            middleware: <Middleware<Test1State>>[
            ],);

}
