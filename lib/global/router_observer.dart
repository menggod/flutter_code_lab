import 'package:flutter/material.dart';

class MyRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  final List _pagesList = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _pagesList.add(route.settings.name);
    print(
        'ob-->didPush route: ${route.settings.name}<--->${_pagesList.toString()}');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    print('ob-->didStopUserGesture');
  }
}
