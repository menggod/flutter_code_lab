import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/list_enter/adapter.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(EnterState state, Dispatch dispatch, ViewService viewService) {
  ListAdapter listAdapter = viewService.buildAdapter();
  return Scaffold(
    appBar: AppBar(
      title: Text("入口页面"),
      backgroundColor: state.themeColor,
    ),
    body: Container(
      child: ListView.builder(
        itemBuilder: listAdapter.itemBuilder,
        itemCount: listAdapter.itemCount,
      ),
    ),
  );
}
