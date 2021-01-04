import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SubThirdComponent extends Component<SubThirdState> {
  SubThirdComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SubThirdState>(
                adapter: null,
                slots: <String, Dependent<SubThirdState>>{
                }),);

}
