import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_code_test/draw/day02/page/home_page.dart';
import 'package:flutter_code_test/draw/day02/page/other_page.dart';
import 'package:flutter_code_test/global/cons.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  var _position = 0;
  final _ctrl = PageController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _ctrl,
        onPageChanged: _onPageViewChanged,
        children: _buildContent(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomItems(),
        currentIndex: _position,
        onTap: _onTabBottomItem,
      ),
    );
  }

  _buildContent() => <Widget>[
        HomePage(),
        AcrPage(),
        LovePage(),
        NotePage(),
        MePage(),
      ];

  List<BottomNavigationBarItem> _buildBottomItems() {
    String hh = "";
    hh = null;


    return Cons.bottomNavMap.keys
        .map((e) => BottomNavigationBarItem(
            icon: Icon(Cons.bottomNavMap[e]),
            label: e,
            backgroundColor: Colors.pinkAccent))
        .toList();
  }

  void _onTabBottomItem(int value) {
    _ctrl.jumpToPage(value);
    setState(() {
      _position = value;
    });
  }

  void _onPageViewChanged(int value) {
    setState(() {
      _position = value;
    });
  }
}
