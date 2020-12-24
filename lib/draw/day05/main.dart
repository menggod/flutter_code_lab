import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_test/draw/day05/page.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations( // 使设备横屏显示
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SquareGridView(),
          // Container(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: CustomPaint(
          //     painter: TestPathPainter(),
          //   ),

          // ),
          HandleWidget(),
        ],
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final List<Offset> points = [
    Offset(-100, -100),
    Offset(-80, -80),
    Offset(-40, -40),
    Offset(0, -100),
    Offset(40, -140),
    Offset(80, -160),
    Offset(120, -100),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    Path path = Path();
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset(0, 0), 5, paint);
    canvas.restore();

    // _drawAxis(canvas, paint, size);
    _drawDot(canvas, paint, size);
    _drawPointsWithPoints(canvas, paint, size);
    _drawPointsWithLines(canvas, paint, size);
    _drawTextPaint(canvas, paint);
  }

  void _drawTextPaint(Canvas canvas, Paint paint) {
    var textPainter = TextPainter(
        text: TextSpan(text: 'menggod', style: TextStyle(fontSize: 40, color: Colors.pinkAccent.withOpacity(80))),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset.zero); // 进行绘制
  }

  void _drawAxis(Canvas canvas, Paint paint, Size size) {
    // var colors = [
    //   Color(0xFFF60C0C),
    //   Color(0xFFF3B913),
    //   Color(0xFFE7F716),
    //   Color(0xFF3DF30B),
    //   Color(0xFF0DF6EF),
    //   Color(0xFF0829FB),
    //   Color(0xFFB709F4),
    // ];
    // var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    // paint.shader = ui.Gradient.linear(
    //     Offset(0, 0), Offset(size.width, 0),
    //     colors, pos, TileMode.clamp);
    // paint.blendMode=BlendMode.lighten;
    // canvas.drawPaint(paint);

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(-size.width / 2, 0), Offset(size.width / 2, 0), paint);
    canvas.drawLine(Offset(0, -size.height / 2), Offset(0, size.height / 2), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(0 - 7.0, size.height / 2 - 10), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(0 + 7.0, size.height / 2 - 10), paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), paint);
    canvas.restore();
  }

  void _drawPointsWithLines(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(ui.PointMode.polygon, points, paint);
    canvas.restore();
  }

  void _drawPointsWithPoints(Canvas canvas, Paint paint, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    var path =  Path();
    path
      ..moveTo(0, 0) //移至(0,0)点
      ..lineTo(60, 80) //从(0,0)画线到(60, 80) 点
      ..lineTo(60, 0) //从(60,80)画线到(60, 0) 点
      ..lineTo(0, -80) //从(60, 0) 画线到(0, -80)点
      ..close(); //闭合路径
    canvas.drawPath(path, paint);


    paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(ui.PointMode.points, points, paint);
    canvas.restore();
  }

  void _drawDot(Canvas canvas, Paint paint, Size size) {
    final int count = 12;
    paint
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.stroke;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset(0, 0), 40, paint);

    for (int i = 0; i < count; i++) {
      var step = 2 * pi / count;
      canvas.drawLine(Offset(60, 0), Offset(80, 0), paint);
      canvas.rotate(step);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
