import 'package:flutter/material.dart';

//     记录根路由，用以过滤overlay
//     ModalRoute rootRoute = ModalRoute.of(DoKitApp.appKey.currentContext);

class WidgetHelp with WidgetInspectorService {
  WidgetHelp._privateConstructor();

  static final WidgetHelp _instance = WidgetHelp._privateConstructor();

  factory WidgetHelp() {
    return _instance;
  }

  // String getDartFileName() {
  //   return this.getSelectedSummaryWidget();
  // }
}
