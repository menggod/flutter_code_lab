import 'package:flutter/material.dart';

class GestureDragDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GestureDragDemoState();
  }
}

class _GestureDragDemoState extends State<GestureDragDemo> {
  double _top = 0.0; //距离顶部的偏移量
  double _left = 0.0; //距离底部的偏移量
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GestureDragDemo',
      home: Scaffold(
          appBar: AppBar(
            title: Text('GestureDragDemo'),
            leading: Icon(Icons.keyboard_backspace),
          ),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: _top,
                left: _left,
                child: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(
                      'A',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPanDown: (DragDownDetails downDetails) {
                    //手指按下时会执行此回调
//                    print('手指按下的位置：$downDetails.globalPosition');
                  },
//                  onPanUpdate: (DragUpdateDetails dragUpdateDetails) {
//                    //手指滑动时会执行次回调
//                    setState(() {
//                      //手指滑动时会多次触发onPanUpdate回调，更新偏移量并重新绘制
//                      //dragUpdateDetails.delta.dx获取y轴方向的偏移量
//                      _top += dragUpdateDetails.delta.dy;
//                      print('Y：$dragUpdateDetails.delta.dy');
//                      //dragUpdateDetails.delta.dy获取x轴方向的偏移量
//                      _left += dragUpdateDetails.delta.dx;
//                      print('X：$dragUpdateDetails.delta.dx');
//                    });
//                  },
                  onHorizontalDragUpdate: (DragUpdateDetails dragUpdateDetails){
                    setState(() {
                      _left += dragUpdateDetails.delta.dx;
                    });
                  },
                  onPanEnd: (DragEndDetails dragEndDetails) {
                    //打印滑动结束时在x、y轴上的速度
//                    print(dragEndDetails.velocity);
                  },
                ),
              ),
            ],
          )),
    );
  }
}