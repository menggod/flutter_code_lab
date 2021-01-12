import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2021/1/12
/// contact me by email 1981462002@qq.com
/// 说明:

class HideFlow extends StatefulWidget {
  @override
  _HideFlowState createState() => _HideFlowState();
}

class _HideFlowState extends State<HideFlow>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;
  bool _opened = false;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flow(
        delegate:
            HideFlowDelegate(size: MediaQuery.of(context).size, repaint: _ctrl),
        children: [
          Container(
            height: 80,
            color: Colors.red.withOpacity(0.5),
          ),
          GestureDetector(onTap: _toggle, child: Container(color: Colors.blue)),
          Container(
            height: 60,
            color: Colors.yellow.withOpacity(0.5),
          )
        ],
      ),
    );
  }

  void _toggle() {
    if (_opened) {
      _ctrl.reverse();
    } else {
      _ctrl.forward();
    }
    _opened = !_opened;
  }
}

class HideFlowDelegate extends FlowDelegate {
  final Size size;
  final Animation<double> repaint;

  HideFlowDelegate({this.size, this.repaint}) : super(repaint: repaint);

  @override
  void paintChildren(FlowPaintingContext context) {
    assert(context.childCount>=2);
    final int lastIndex = context.childCount - 1;
    final Size topSize = context.getChildSize(0);
    final Size bottomSize = context.getChildSize(lastIndex);

    context.paintChild(1);

    context.paintChild(0,
        transform:
            Matrix4.translationValues(0, -topSize.height * (repaint.value), 0));
    context.paintChild(lastIndex,
        transform: Matrix4.translationValues(
            0, size.height - bottomSize.height * (1 - repaint.value), 0));
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
