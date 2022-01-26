import 'package:flutter/material.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';

import 'page.dart';

void main() => runApp(GestureDragDemo());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onLongPress: _onLongPress,
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      child: Container(
        color: Colors.white,
        child: NewWidget(),)
    ,
    );
  }

  void _onTap() {}

  void _onLongPress() {}

  void _onPanDown(DragDownDetails details) {
    print('menggod _onPanDown: $details');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    print('menggod _onPanUpdate: ${details.globalPosition}   ${details.localPosition}');
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key ? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
      SquareGridView(
      displayAxis: true,
    ),
    Positioned(
      top: 100,
      child: Container(
      width: 300,
      height: 300,
      color: Colors.red,
    ),
      )
      ],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
