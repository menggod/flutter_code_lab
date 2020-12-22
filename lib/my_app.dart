import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;

import 'splash/page.dart';

Widget createApp() {
  final AbstractRoutes routes = PageRoutes(pages: <String, Page<Object, dynamic>>{"splash": SplashPage()});

  return MaterialApp(
    title: '测试',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: routes.buildPage('splash', null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(builder: (BuildContext context) {
        return routes.buildPage(settings.name, settings.arguments);
      });
    },
  );
}
