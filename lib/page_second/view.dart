import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SecondState state, Dispatch dispatch, ViewService viewService) {
  return WillPopScope(
    child: _bodyWidget(state),
    onWillPop: (){
      dispatch(SecondActionCreator.onBackFirst());
      return Future.value(false);
    },
  );
}

Widget _bodyWidget(SecondState state) {
  return Scaffold(
    appBar: AppBar(
      title: Text("second page"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('下方数据是FirstPage页面传递过来的:'), Text(state.msg)],
      ),
    ),
  );
}
