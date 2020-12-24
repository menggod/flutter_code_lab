import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SplashState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      body: Container(
    child: SquareGridView(displayAxis: false),
  ));
}
