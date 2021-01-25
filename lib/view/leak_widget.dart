import 'package:flutter/material.dart';

class LeakCheckWidget extends StatefulWidget {
  final Widget child;

  LeakCheckWidget({this.child});

  @override
  _LeakCheckWidgetState createState() => _LeakCheckWidgetState();
}

class _LeakCheckWidgetState extends State<LeakCheckWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    // resolveTree(context);
    super.dispose();
    debugPrint('menggod leak_widget dispose: ');
  }
}
