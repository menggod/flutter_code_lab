import 'package:flutter/material.dart';
import 'package:flutter_code_test/kit/vm_helper.dart';

class VmPage extends StatefulWidget {
  @override
  _VmPageState createState() => _VmPageState();
}

class _VmPageState extends State<VmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => {VmHelper.instance.getScripts()},
              child: FlatButton(
                  color: Colors.blue,
                  child: Text('getScripts')),
            )
          ],
        ),
      ),
    );
  }
}
