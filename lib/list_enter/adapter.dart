import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';

class EnterAdapter extends SourceFlowAdapter<EnterState> {
  EnterAdapter()
      : super(
          pool: <String, Component<Object>>{},
          reducer: buildReducer(),
          effect: buildEffect(),
        );
}
