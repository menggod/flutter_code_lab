import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CrashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CrashPage',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Crashy'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new ElevatedButton(
              child: new Text('null exception'),
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 500), () {
                  String? text = "";
                  print('menggod build: ${text.length}');
                });
              },
            ),
            new ElevatedButton(
              child: new Text('Dart exception'),
              onPressed: () {
                throw new StateError('This is a Dart exception.');
              },
            ),
            new ElevatedButton(
              child: new Text('async Dart exception'),
              onPressed: () async {
                foo() async {
                  throw new StateError('This is an async Dart exception.');
                }

                bar() async {
                  await foo();
                }

                await bar();
              },
            ),
            new ElevatedButton(
              child: new Text('Java exception'),
              onPressed: () async {
                final channel = const MethodChannel('crashy-custom-channel');
                await channel.invokeMethod('blah');
              },
            ),
          ],
        ),
      ),
    );
  }
}
