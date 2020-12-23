import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/draw/day04/first_home_pager.dart';
import 'package:flutter_code_test/utils/color_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(30),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.5), offset: const Offset(0.0, 0.0), blurRadius: 6.0, spreadRadius: 0.0)
        ]),
        child: Text('sdfalkjsdhfalksjdhlfakjhs'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final String title ="测试项目";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _color = Colors.black;

  void _changeColor() {
    setState(() {
      _color = randomRGB();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CustomPaint(
          painter: StarView(context, _color),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _changeColor,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
