import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LifeCycle3 extends StatefulWidget {
  @override
  _LifeCycle3State createState() => _LifeCycle3State();
}

class _LifeCycle3State extends State<LifeCycle3> {

  @override
  Widget build(BuildContext context) {
    print('menggod build: LifeCycle3');
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(children: [
            OutlineButton(
              onPressed: () => {Navigator.pop(context)},
              color: Colors.blue,
              child: Text('返回'),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print('menggod initState: LifeCycle3');
  }

  @override
  void didUpdateWidget(LifeCycle3 oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('menggod didUpdateWidget: LifeCycle3');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('menggod deactivate: LifeCycle3');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('menggod didChangeDependencies: LifeCycle3');
  }

  @override
  void dispose() {
    super.dispose();
    print('menggod dispose: LifeCycle3');
  }
}