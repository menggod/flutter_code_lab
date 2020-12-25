import 'package:flutter/material.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';

class AcrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("AcrPage"),
      ),
    );
  }
}

class LovePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("LovePage"),
      ),
    );
  }
}

class NotePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text("NotePage"),
      ),
    );
  }

  @override
  StatelessElement createElement() {
    return super.createElement();
  }
}

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [Container(
            constraints: BoxConstraints.expand(),
            child: SquareGridView()), Text('MePage')],
      ),
    );
  }
}
