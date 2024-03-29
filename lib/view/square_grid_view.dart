import 'package:flutter/material.dart';

import 'coordinate_pro.dart';

class SquareGridView extends StatelessWidget {
  final bool displayAxis;

  SquareGridView({this.displayAxis = false});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: SquareGridPainter(displayAxis: displayAxis));
  }
}

class SquareGridPainter extends CustomPainter {
  late final Coordinate coordinate;
  late final bool displayAxis;

  SquareGridPainter({this.displayAxis = false}) {
    coordinate = Coordinate(step: 20, isDisplayAxis: displayAxis);
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
