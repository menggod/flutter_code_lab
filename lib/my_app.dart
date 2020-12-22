import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_code_test/list_enter/page.dart';
import 'package:flutter_code_test/test1/page.dart';

import 'splash/page.dart';

Widget createApp() {
  final AbstractRoutes routes = PageRoutes(pages: <String, Page<Object, dynamic>>{
    "splash": SplashPage(),
    "test1": Test1Page(),
    "enter": EnterPage(),
  });

  return MaterialApp(
    title: '测试',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: routes.buildPage('test1', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        //页面切换风格
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
