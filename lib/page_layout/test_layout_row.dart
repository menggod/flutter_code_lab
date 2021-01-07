import 'package:flutter/material.dart';

// void main() => runApp(MyApp());
void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter教程',
      home: new LayoutDemo(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            color: Colors.red,
          )
        ],
      ),
    );
  }
}

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('水平方向布局'),
      ),
      body: new Row(children: <Widget>[
        new RaisedButton(
          onPressed: () {
            print('点击红色按钮事件');
          },
          color: const Color(0xffcc0000),
          child: new Text('红色按钮'),
        ),
        Expanded(
          flex: 1,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 30,
                color: Colors.yellow,
              ),
              Container(
                width: 30,
                height: 30,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        new RaisedButton(
          onPressed: () {
            print('点击粉色按钮事件');
          },
          color: const Color(0xffea9999),
          child: new Text('粉色按钮'),
        ),
      ]),
    );
  }
}
