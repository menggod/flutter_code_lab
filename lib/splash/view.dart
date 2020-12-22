import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/page/first_home_pager.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SplashState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      body: MyHomePage(
    title: "测试页面",
  ));
}
