import 'package:flutter/material.dart';
import 'package:flutter_code_test/apple/day2/anima_pager.dart';
import 'package:flutter_code_test/draw/day02/home.dart';
import 'package:flutter_code_test/draw/day02/page/crash_page.dart';
import 'package:flutter_code_test/draw/day04/main.dart';
import 'package:flutter_code_test/kit/memory_kit.dart';
import 'package:flutter_code_test/life_cycle/life_cycle.dart';
import 'package:flutter_code_test/life_cycle/life_cycle_2.dart';
import 'package:flutter_code_test/life_cycle/life_cycle_3.dart';
import 'package:flutter_code_test/page/scroll_test.dart';
import 'package:flutter_code_test/page/test_image.dart';
import 'package:flutter_code_test/page/vm_test_page.dart';
import 'package:flutter_code_test/page_first/view.dart';
import 'package:flutter_code_test/page_layout/custom_view_layout.dart';
import 'package:flutter_code_test/test1/bug_page.dart';

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
    "/animation_page": (BuildContext context) => AnimaPage(),
    "/baidu_page": (BuildContext context) => FirstPage(),
    "/custom_view_layout": (BuildContext context) => CustomViewLayout(),
    "/life_cycle": (BuildContext context) => CounterWidget(),
    "/life_cycle_2": (BuildContext context) => LifeCycle2(),
    "/life_cycle_3": (BuildContext context) => LifeCycle3(),
    "/scroll_test": (BuildContext context) => ScrollTestA(),
    "/test_image": (BuildContext context) => TestImagePage(),
    "/crash_page": (BuildContext context) => CrashPage(),
    "/bug_page": (BuildContext context) => BugPage(),
    "/memory": (BuildContext context) => MemoryPageContainer(),
    "/vm_page": (BuildContext context) => VmPage()
  };

  static final routeIntroList = <String, String>{
    "/nav_page": "跳转  nav page  测试页面",
    "/my_home_page": "跳转到  星星测试页面",
    "/animation_page": "day2 动画测试页面",
    "/baidu_page": "跳转百度",
    "/custom_view_layout": "自定义 view 测试",
    "/life_cycle": "生命周期测试",
    "/life_cycle_2": "生命周期测试2",
    "/life_cycle_3": "生命周期测试2",
    "/scroll_test": "滚动测试",
    "/test_image": "测试图片",
    "/crash_page": "崩溃测试",
    "/bug_page": "测试 context",
    "/memory": "内存测试",
    "/vm_page": "vm 方法测试"
  };

  // 放置dokit悬浮窗的容器
  static GlobalKey rootKey = new GlobalKey();

  // 放置应用真实widget的容器
  static GlobalKey appKey = new GlobalKey();

}
