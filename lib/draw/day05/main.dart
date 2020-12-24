import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations(// 使设备横屏显示
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
          CustomPaint(
            painter: PaperPainter(),
          )
        ],
      ),
    );
  }
}

class PaperPainter extends CustomPainter {


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
    canvas.translate(20, 20);
    canvas.drawCircle(Offset(0, 0), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
