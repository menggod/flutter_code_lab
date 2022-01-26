import 'package:flutter/material.dart';

class MaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black45,
        shape: HoleShapeBorder(size: 20, offset: Offset(0.05, 0.1)));
  }
}

class HoleShapeBorder extends ShapeBorder {
  late final Offset offset;
  late final double size;

  HoleShapeBorder({this.offset = const Offset(0.1, 0.1), this.size = 20});

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    var path = Path();
    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    var path = Path();
    path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(0)));

    var w = rect.width;
    var h = rect.height;
    var offsetXY = Offset(offset.dx * w, offset.dy * h);
    var d = size;
    _getHold(path, 1, d, offsetXY);
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  _getHold(Path path, int? count, double? d, Offset offset) {
    var left = offset.dx;
    var top = offset.dy;
    var right = left + (d ?? 0);
    var bottom = top + (d ?? 0);
    path.addRect(Rect.fromLTRB(left, top, 800, 800));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) {
    throw UnimplementedError();
  }

  @override
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();
}
