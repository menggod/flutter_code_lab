import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

abstract class GlobalBaseState {
  Color get themeColor;

  set themeColor(Color color);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  GlobalState clone() {
    return GlobalState();
  }

  @override
  Color get themeColor {
    return Colors.pink;
  }

  @override
  set themeColor(Color color) {}
}

GlobalState initState(Map<String, dynamic> args) {
  return GlobalState();
}
