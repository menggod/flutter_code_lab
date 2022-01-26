import 'package:flutter/material.dart';

import 'global/cons.dart';
import 'global/router_observer.dart';
import 'life_cycle/life_cycle.dart';
import 'page/unknown_page.dart';

final MyRouteObserver _myRouteObserver = MyRouteObserver();

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

Widget createApp() {
  return MaterialApp(
    key: Cons.rootKey,
    onUnknownRoute: (RouteSettings setting) =>
        MaterialPageRoute(builder: (context) => UnknownPage()),
    title: '测试',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: CounterWidget(),
    onGenerateRoute: _myGenerateRoute,
  );
}

Widget createSimple() {
  return MaterialApp(
    key: Cons.rootKey,
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
  final String name = settings.name!;
  final Function pageBuilder = Cons.routeList[name] as Function;
  if (settings.arguments != null) {
    // 如果透传了参数
    return MaterialPageRoute(
        builder: (context) =>
            pageBuilder(context, arguments: settings.arguments));
  } else {
    // 没有透传参数
    return MaterialPageRoute(builder: (context) => pageBuilder(context));
  }
}
