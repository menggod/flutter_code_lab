import 'package:flutter/material.dart';
import 'package:flutter_code_test/draw/day02/home.dart';
import 'package:flutter_code_test/draw/day02/page/crash_page.dart';
import 'package:flutter_code_test/draw/day04/main.dart';
import 'package:flutter_code_test/life_cycle/life_cycle.dart';
import 'package:flutter_code_test/life_cycle/life_cycle_2.dart';
import 'package:flutter_code_test/life_cycle/life_cycle_3.dart';
import 'package:flutter_code_test/page/scroll_test.dart';
import 'package:flutter_code_test/page/test_image.dart';
import 'package:flutter_code_test/page_layout/custom_view_layout.dart';

class Cons {
  static const homeTabs = <String>["展示集", "神画技", "趣谈集", "bug 集"];
  static const menuInfo = <String>["关于", "帮助", "问题反馈"];
  static const bottomNavMap = {
    "首页": Icons.home,
    "动态": Icons.toys,
    "喜欢": Icons.favorite,
    "手册": Icons.class_,
    "我的": Icons.account_circle
  };

  static final routeList = <String, WidgetBuilder>{
    "/nav_page": (BuildContext context) => NavPage(),
    "/my_home_page": (BuildContext context) => MyHomePage(),
    "/custom_view_layout": (BuildContext context) => CustomViewLayout(),
    "/life_cycle": (BuildContext context) => CounterWidget(),
    "/life_cycle_2": (BuildContext context) => LifeCycle2(),
    "/life_cycle_3": (BuildContext context) => LifeCycle3(),
    "/scroll_test": (BuildContext context) => ScrollTestA(),
    "/test_image": (BuildContext context) => TestImagePage(),
    "/crash_page": (BuildContext context) => CrashPage(),
  };

  static final routeIntroList = <String, String>{
    "/nav_page": "跳转  nav page  测试页面",
    "/my_home_page": "跳转到  星星测试页面",
    "/custom_view_layout": "自定义 view 测试",
    "/life_cycle": "生命周期测试",
    "/life_cycle_2": "生命周期测试2",
    "/life_cycle_3": "生命周期测试2",
    "/scroll_test": "滚动测试",
    "/test_image": "测试图片",
    "/crash_page": "崩溃测试",
  };

  // 放置dokit悬浮窗的容器
  static GlobalKey rootKey = new GlobalKey();

  // 放置应用真实widget的容器
  static GlobalKey appKey = new GlobalKey();
}
