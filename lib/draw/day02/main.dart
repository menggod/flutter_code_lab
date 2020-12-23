import 'package:flutter/material.dart';
import 'package:flutter_code_test/draw/day02/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App Day02',
      theme: ThemeData(
        primarySwatch: Colors.pink
      ),
      home: NavPage()
    );
  }
}
