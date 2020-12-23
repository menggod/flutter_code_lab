import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('绘制'),
      ),
      body: CustomPaint(
        painter: GridLinePainter(),
      ),
    );
  }
}

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App Day02',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: Scaffold(
          appBar: AppBar(
            title: Text('绘制网格'),
          ),
          body: CustomPaint(
            painter: GridLinePainter(),
          ),
        ));
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
}

class GridLinePainter extends CustomPainter {
  Paint _paint;
  Path _path = Path();
  Size _size = Size(500, 500);

  GridLinePainter() {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      // ..color = Color(0xffbbc3c5);
      ..color = Colors.black87;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawPath(gridPath(20, _size), _paint);
    canvas.drawPoints(PointMode.points, [Offset(300, 400),Offset(100, 100)], _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path gridPath(double step, Size area) {
    for (int i = 0; i < area.height / step + 1; i++) {
      _path.moveTo(area.width, step * i);
      _path.lineTo(area.width, step * i);
    }
    for (int i = 0; i < area.width / step + 1; i++) {
      _path.moveTo(area.height, step * i);
      _path.lineTo(area.height, step * i);
    }
    return _path;
  }
}
