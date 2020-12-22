import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SubEnterComponent extends Component<SubEnterState> {
  SubEnterComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SubEnterState>(
                adapter: null,
                slots: <String, Dependent<SubEnterState>>{
                }),);

}
