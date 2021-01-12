import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(Test1State state, Dispatch dispatch, ViewService viewService) {
  return _bodyWidget(state, dispatch);
}

Widget _bodyWidget(Test1State state, dispatch) {
  return Scaffold(
    appBar: AppBar(
      title: Text("test redux"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have pushed the button this many times:'),

          ///使用state中的变量，控住数据的变换
          Text(state.count.toString()),

        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        dispatch(Test1ActionCreator.onIncrease());
      },
    ),
  );
}
