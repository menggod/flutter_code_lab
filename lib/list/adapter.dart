import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_code_test/list/item/component.dart';
import 'package:flutter_code_test/list/state.dart';

class ListItemAdapter extends SourceFlowAdapter<ListState> {
  static const String item_style = "project_tab_item";

  ListItemAdapter()
      : super(
          pool: <String, Component<Object>>{item_style: ItemComponent()},
        );
}
