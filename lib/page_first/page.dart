import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FirstPage extends Page<FirstState, Map<String, dynamic>> {
  FirstPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FirstState>(
                adapter: null,
                slots: <String, Dependent<FirstState>>{
                }),
            middleware: <Middleware<FirstState>>[
            ],);

}
