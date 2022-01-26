import 'package:flutter/material.dart';

import '../common_path.dart';
import '../help_view.dart';

class AnimaView extends CustomPainter {
  late Paint mPaint;
  BuildContext context;
  double? _R;
  int? _num;

  AnimaView(this.context, {required double R, required int num, Color? color}) {
    mPaint = new Paint();
    mPaint.color = color!;
    _R = R;
    _num = num;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var winSize = MediaQuery.of(context).size;
    drawGrid(canvas, winSize);
    canvas.translate(160, 320);
    canvas.drawPath(nStarPath(_num!, _R!, 50), mPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
