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
      theme: ThemeData(primaryColor: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
          centerTitle: true,
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 6.0,
                  spreadRadius: 0.0)
            ]),
            child: Text('sdfalkjsdhfalksjdhlfakjhs'),
          ),
          Text('text'),
          Row(
            children: <Widget>[
              Text('绝域从军计惘然，,'),
              Text('东南幽恨满词笺。'),
              Text('一箫一剑平生意，'),
              Text('负尽狂名十五年。'),
            ],
          ),
          Column(
            children: <Widget>[
              Text('绝域从军计惘然，,'),
              Text('东南幽恨满词笺。'),
              Text('一箫一剑平生意，'),
              Text('负尽狂名十五年。'),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('绝域从军计惘然，'),
              ),
              Expanded(
                child: Text('东南幽恨满词笺。'),
              ),
              Expanded(
                child: Text('一箫一剑平生意，'),
              ),
              Card(
                child: Text('负尽狂名十五年。'),
              ),
            ],
          ),
          Transform(
              origin: Offset(-10, 0),
              transform: Matrix4.rotationZ(3.1415 / 4),
              child: Text('text') //同上面的Container，挺长的，不贴了
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title = "测试项目";

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
