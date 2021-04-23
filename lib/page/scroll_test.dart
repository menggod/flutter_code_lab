import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScrollTestA extends StatefulWidget {
  @override
  _ScrollTestAState createState() => _ScrollTestAState();
}

class _ScrollTestAState extends State<ScrollTestA> {
  Widget _longText = Text(
      "哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n");
  Widget _longText2 = Text("哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈\n哈哈");
  ScrollController _controllerA = new ScrollController();
  ScrollController _controllerB = new ScrollController();
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _controllerA.addListener(() {
      var maxScrollExtent = _controllerA.position.maxScrollExtent;
      var offset = _controllerA.offset;
      var d = offset / maxScrollExtent * _controllerB.position.maxScrollExtent;
      _controllerB.jumpTo(d);
    });

    _controllerB.addListener(() {
      print(_controllerB.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 50,
            height: 500,
            child: Row(
              children: <Widget>[
                SingleChildScrollView(
                  child: Expanded(
                    child:
                        Container(width: 50, height: 400, color: Colors.yellow, child: _longText),
                  ),
                  controller: _controllerA,
                ),
                Container(
                  child: Text("呵呵"),
                ),
                SingleChildScrollView(
                  child: Expanded(
                    child: _longText2,
                  ),
                  controller: _controllerB,
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 500,
            child: Row(
              children: <Widget>[
                SingleChildScrollView(
                  child: Expanded(
                    child: Container(width: 50, height: 500, child: _longText),
                  ),
                  controller: _controllerA,
                ),
                Container(
                  child: Text("呵呵"),
                ),
                SingleChildScrollView(
                  child: Expanded(
                    child: _longText2,
                  ),
                  controller: _controllerB,
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 500,
            child: Row(
              children: <Widget>[
                SingleChildScrollView(
                  child: Expanded(
                    child: Container(width: 50, height: 500, child: _longText),
                  ),
                  controller: _controllerA,
                ),
                Container(
                  child: Text("呵呵"),
                ),
                SingleChildScrollView(
                  child: Expanded(
                    child: _longText2,
                  ),
                  controller: _controllerB,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
