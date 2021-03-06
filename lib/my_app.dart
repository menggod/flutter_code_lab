import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:flutter_code_test/global/cons.dart';
import 'package:flutter_code_test/list/page.dart';
import 'package:flutter_code_test/list_enter/page.dart';
import 'package:flutter_code_test/page/unknown_page.dart';
import 'package:flutter_code_test/page_first/page.dart';
import 'package:flutter_code_test/page_second/page.dart';
import 'package:flutter_code_test/test1/page.dart';

import 'draw/day02/home.dart';
import 'global/router_observer.dart';
import 'splash/page.dart';
import 'view/test_overlay.dart';

final MyRouteObserver _myRouteObserver = MyRouteObserver();

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

Widget createApp() {
  final AbstractRoutes routes = PageRoutes(pages: <String, Page<Object, dynamic>>{
    "splash": SplashPage(),
    "test1": Test1Page(),
    "enter": EnterPage(),
    "first": FirstPage(),
    "second": SecondPage(),
    "list": ListPage(),
  });

  return MaterialApp(
    key: Cons.rootKey,
    // routes: Cons.routeList,
    // navigatorObservers: [_myRouteObserver],
    onUnknownRoute: (RouteSettings setting) =>
        MaterialPageRoute(builder: (context) => UnknownPage()),
    title: '测试',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: routes.buildPage('splash', null),
    onGenerateRoute: _myGenerateRoute,
    // onGenerateRoute: (RouteSettings settings) {
    //   return MaterialPageRoute<Object>(builder: (BuildContext context) {
    //     //页面切换风格
    //
    //
    //
    //     return routes.buildPage(settings.name, settings.arguments);
    //   });
    // },
  );
}

Widget createSimple() {
  return MaterialApp(
    key: Cons.rootKey,
    // routes: Cons.routeList,
    navigatorObservers: [_myRouteObserver],
    onGenerateRoute: _myGenerateRoute,
    initialRoute: "/life_cycle_3",
    onUnknownRoute: (RouteSettings setting) =>
        MaterialPageRoute(builder: (context) => UnknownPage()),
    title: '测试',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  );
}

Route _myGenerateRoute(RouteSettings settings) {
  final String name = settings.name;
  final Function pageBuilder = Cons.routeList[name];
  if (pageBuilder != null) {
    if (settings.arguments != null) {
      // 如果透传了参数
      return MaterialPageRoute(
          builder: (context) => pageBuilder(context, arguments: settings.arguments));
    } else {
      // 没有透传参数
      return MaterialPageRoute(builder: (context) => pageBuilder(context));
    }
  }
  return MaterialPageRoute(builder: (context) => UnknownPage());
}
