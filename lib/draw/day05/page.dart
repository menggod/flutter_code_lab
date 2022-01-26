import 'dart:math';

import 'package:flutter/material.dart';

class TestPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pinkAccent
      ..strokeWidth = 4
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    var path = Path();
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    for (int i = 0; i < 8; i++) {
      canvas.drawPath(
          path.transform(Matrix4.rotationZ(i * pi / 4).storage), paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HandleWidget extends StatefulWidget {
  final double size;
  final double handleRadius;

  HandleWidget({Key? key, this.size = 60.0, this.handleRadius = 30.0})
      : super(key: key);

  @override
  _HandleWidgetState createState() => _HandleWidgetState();
}

class _HandleWidgetState extends State<HandleWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _HandlePainter(handleR: widget.handleRadius));
  }
}

class _HandlePainter extends CustomPainter {
  var _paint = Paint();
  var handleR;

  _HandlePainter({this.handleR}) {
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final bgR = size.width / 2 - handleR;
    canvas.translate(size.width / 2, size.height / 2);
    _paint.color = _paint.color.withAlpha(100);
    canvas.drawCircle(Offset(0, 0), bgR, _paint);
    _paint.color = _paint.color.withAlpha(150);
    canvas.drawCircle(Offset(0, 0), handleR, _paint);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) =>
      oldDelegate.handleR != handleR;
}
