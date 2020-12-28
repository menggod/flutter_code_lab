import 'package:flutter/material.dart';
import 'package:flutter_code_test/apple/day2/anima_pager.dart';
import 'package:flutter_code_test/draw/day02/home.dart';
import 'package:flutter_code_test/draw/day04/main.dart';
import 'package:flutter_code_test/life_cycle/life_cycle.dart';
import 'package:flutter_code_test/page/test_image.dart';
import 'package:flutter_code_test/page_first/view.dart';

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
    "/life_cycle": (BuildContext context) => CounterWidget(),
    "/test_image": (BuildContext context) => TestImagePage()
  };

  static final routeIntroList = <String, String>{
    "/nav_page": "跳转  nav page  测试页面",
    "/my_home_page": "跳转到  星星测试页面",
    "/animation_page": "day2 动画测试页面",
    "/baidu_page": "跳转百度",
    "/life_cycle": "生命周期测试",
    "/test_image": "测试图片"
  };
}
