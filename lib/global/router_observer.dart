import 'package:flutter/material.dart';
import 'package:flutter_code_test/kit/apm.dart';
import 'package:flutter_code_test/kit/memory_kit.dart';
import 'package:flutter_code_test/kit/vm_helper.dart';

class MyRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  final List _pagesList = [];
  MemoryKit kit = ApmKitManager.instance.getKit<MemoryKit>(ApmKitName.KIT_MEMORY);

  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    // print('ob-->didPush route: ${route},previousRoute:$previousRoute');
    _pagesList.add(route.settings.name);
    print('ob-->didPush route: ${route.settings.name}<--->${_pagesList.toString()}');
    // _processPush();
  }

  _processPush() async {
    await VmHelper.instance.gc();
    await VmHelper.instance.dumpAllocationProfile();
    await VmHelper.instance.updateMemoryUsage();
    var length = -1;
    length = kit.getAllocationProfile()?.members?.where((element) {
      if (element.classRef.name.toLowerCase().contains("LifeCycle2".toLowerCase())) {
        print('menggod router_observer _processPush: ${element.toString()}');
      }
      if (element.classRef.name
          .toLowerCase()
          .contains("ScrollController".toLowerCase())) {
        print('menggod router_observer _processPush: ${element.toString()}');
      }
      return element.bytesCurrent != 0;
    })?.length;

    print('menggod router_observer didPush: $length');
  }

  _processPop() async {
    await VmHelper.instance.gc();
    await VmHelper.instance.dumpAllocationProfile();
    await VmHelper.instance.updateMemoryUsage();
    var length = -1;
    length = kit.getAllocationProfile()?.members?.where((element) {
      if (element.classRef.name.toLowerCase().contains("LifeCycle2".toLowerCase())) {
        print('menggod router_observer _processPop: ${element.toString()}');
      }
      if (element.classRef.name
          .toLowerCase()
          .contains("ScrollController".toLowerCase())) {
        print('menggod router_observer _processPop: ${element.toString()}');
      }
      return element.bytesCurrent != 0;
    })?.length;

    Future.delayed(const Duration(milliseconds: 500), () {
      print('menggod router_observer didPop:  $length');
    });
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    // print('ob-->didPop route: $route,previousRoute:$previousRoute');
    _pagesList.removeAt(_pagesList.lastIndexOf(route.settings.name));
    print('ob-->didPop route: ${route.settings.name}<--->${_pagesList.toString()}');
    // _processPop();
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
