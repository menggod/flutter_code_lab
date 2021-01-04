import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ThirdPage extends Page<ThirdState, Map<String, dynamic>> {
  ThirdPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ThirdState>(
                adapter: null,
                slots: <String, Dependent<ThirdState>>{
                }),
            middleware: <Middleware<ThirdState>>[
            ],);

}
