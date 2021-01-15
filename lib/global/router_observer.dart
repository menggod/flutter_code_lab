import 'package:flutter/material.dart';

class MyRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  final List _pagesList = [];

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    // print('ob-->didPush route: ${route},previousRoute:$previousRoute');
    _pagesList.add(route.settings.name);
    print('ob-->didPush route: ${route.settings.name}<--->${_pagesList.toString()}');
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    // print('ob-->didPop route: $route,previousRoute:$previousRoute');
    _pagesList.removeAt(_pagesList.lastIndexOf(route.settings.name));
    print('ob-->didPop route: ${route.settings.name}<--->${_pagesList.toString()}');
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // print('ob-->didReplace\n newRoute: $newRoute,\n oldRoute:$oldRoute');
    _pagesList.removeAt(_pagesList.lastIndexOf(oldRoute.settings.name));
    _pagesList.add(newRoute.settings.name);
    print('ob-->didReplace route: ${newRoute.settings.name}<--->${_pagesList.toString()}');
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    super.didRemove(route, previousRoute);
    // print('ob-->didRemove route: $route,previousRoute:$previousRoute');
    _pagesList.removeAt(_pagesList.lastIndexOf(route.settings.name));
    print('ob-->didRemove route: ${route.settings.name}<--->${_pagesList.toString()}');
  }

  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    print('ob-->didStartUserGesture route: $route,previousRoute:$previousRoute');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    print('ob-->didStopUserGesture');
  }
}
