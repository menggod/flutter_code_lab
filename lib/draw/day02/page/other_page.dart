import 'dart:io';

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
  // testCatch() async {
  //   var dir = new Directory('/tmp11111');
  //   var dirList = dir.list();
  //   await for (FileSystemEntity f in dirList) {
  //     if (f is File) {
  //       print('Found file ${f.path}');
  //     } else if (f is Directory) {
  //       print('Found dir ${f.path}');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // testCatch();
    // testCatch();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //
    // });

    return Container(
      color: Colors.white,
      child: Stack(
        children: [SquareGridView(), Center(child: Text('MePage'))],
      ),
    );
  }

}
