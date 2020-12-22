import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_code_test/list_enter/adapter.dart';
import 'package:flutter_code_test/list_enter/state.dart';
import 'package:flutter_code_test/list_enter/view.dart';

class EnterPage extends Page<EnterState, Map<String, dynamic>> {
  EnterPage()
      : super(
          initState: initState,
          view: buildView,
          dependencies: Dependencies<EnterState>(
              adapter: NoneConn<EnterState>() + EnterAdapter(),
              slots: <String, Dependent<EnterState>>{}),
          middleware: <Middleware<EnterState>>[],
        );
}
