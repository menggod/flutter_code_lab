import 'package:flutter/material.dart';

import 'hide_follow.dart';

// void main() => runApp(HideFlow());
void main() {
  runApp(
    new MaterialApp(
      title: 'Flutter教程',
      home: HideFlow(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 300,
          height: 300,
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
              color: Colors.pink,
              border: Border.all(color: Colors.green, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ColoredBox(
              color: Colors.yellow,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  child: Text('text'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TestCorner extends StatelessWidget {
  //数据源
  List<String> titleList = <String>[
    '北京市',
    '天津市',
    '河北省',
    '山西省',
    '内蒙古自治区',
    '辽宁省',
    '吉林省',
    '黑龙江省',
    '上海市',
    '江苏省',
    '浙江省',
    '安徽省',
    '江西省',
    '山东省'
  ];

  List<Icon> iconList = <Icon>[
    Icon(Icons.keyboard),
    Icon(Icons.print),
    Icon(Icons.router),
    Icon(Icons.pages),
    Icon(Icons.zoom_out_map),
    Icon(Icons.zoom_out),
    Icon(Icons.youtube_searched_for),
    Icon(Icons.wifi_tethering),
    Icon(Icons.wifi_lock),
    Icon(Icons.widgets),
    Icon(Icons.weekend),
    Icon(Icons.web),
    Icon(Icons.accessible),
    Icon(Icons.ac_unit),
  ];

  List<String> subTitleList = [
    '简称：京',
    '简称：津',
    '简称：冀',
    '简称：晋',
    '简称：内蒙古',
    '简称：辽',
    '简称：吉',
    '简称：黑',
    '简称：沪',
    '简称：苏',
    '简称：浙',
    '简称：皖',
    '简称：赣',
    '简称：鲁',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              border: Border.all(color: Colors.blue, width: 2.0)),
          clipBehavior: Clip.antiAlias,
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              height: 1,
              color: Colors.orange,
            ),
            itemCount: titleList.length,
            itemBuilder: (context, index) => _buildItem(titleList[index]),
          ),
        ),
      ),
    );
  }

  _buildItem(String title) => Container(
        alignment: Alignment.center,
        width: 100,
        height: 50,
        color: Colors.green,
        child: Text(
          title,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontSize: 12,
              shadows: [
                Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
              ]),
        ),
      );
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
