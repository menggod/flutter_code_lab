import 'package:flutter/material.dart';

class SquareGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
          painter: SquareGridPainter()
      ),
    );
  }
}

class SquareGridPainter extends CustomPainter {
  Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线

  @override
  void paint(Canvas canvas, Size size) {
    _gridPint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.stroke;

      print(size.width);
    canvas.save();
    for (int i = 0; i < size.height / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
