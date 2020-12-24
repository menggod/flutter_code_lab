import 'package:flutter/material.dart';

import 'coordinate_pro.dart';

class SquareGridView extends StatelessWidget {
  final bool displayAxis;

  SquareGridView({this.displayAxis});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(double.infinity, double.infinity), painter: SquareGridPainter(displayAxis: displayAxis));
  }
}

class SquareGridPainter extends CustomPainter {
  Coordinate coordinate;
  final bool displayAxis;

  SquareGridPainter({this.displayAxis}) {
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
