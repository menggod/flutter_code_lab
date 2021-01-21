import 'package:dokit/kit/apm/apm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/global/cons.dart';



// 入口btn
// ignore: must_be_immutable
class FloatBtn extends StatefulWidget {
  static GlobalKey<FloatBtnState> doKitBtnKey = new GlobalKey<FloatBtnState>();
  OverlayEntry overlayEntry;

  FloatBtn() : super(key: doKitBtnKey);

  @override
  FloatBtnState createState() => FloatBtnState(overlayEntry);

  void addToOverlay() {
    assert(overlayEntry == null);
    overlayEntry = new OverlayEntry(builder: (context) {
      return this;
    });
    OverlayState rootOverlay = Overlay.of(Cons.appKey.currentContext);
    assert(rootOverlay != null);
    rootOverlay.insert(overlayEntry);
    ApmKitManager.instance.startUp();
  }
}

class FloatBtnState extends State<FloatBtn> {
  Offset offsetA; //按钮的初始位置
  OverlayEntry owner;
  OverlayEntry debugPage;
  bool showDebugPage = false;

  FloatBtnState(this.owner);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: offsetA?.dx,
        top: offsetA?.dy,
        right: offsetA == null ? 20 : null,
        bottom: offsetA == null ? 120 : null,
        child: Draggable(
            child: Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Image.asset('assets/images/bg.jpeg',
                    package: "menggod", height: 70, width: 70),
                onPressed: openDebugPage,
              ),
            ),
            feedback: Container(
              width: 70,
              height: 70,
              alignment: Alignment.center,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Image.asset('assets/images/bg.jpeg',
                    package: "menggod", height: 70, width: 70),
                onPressed: openDebugPage,
              ),
            ),
            childWhenDragging: Container(),
            onDragEnd: (DraggableDetails detail) {
              Offset offset = detail.offset;
              setState(() {
                final size = MediaQuery.of(context).size;
                final width = size.width;
                final height = size.height;
                var x = offset.dx;
                var y = offset.dy;
                if (x < 0) {
                  x = 0;
                }
                if (x > width - 80) {
                  x = width - 80;
                }
                if (y < 0) {
                  y = 0;
                }
                if (y > height - 26) {
                  y = height - 26;
                }
                offsetA = Offset(x, y);
              });
            },
            onDraggableCanceled: (Velocity velocity, Offset offset) {}));
  }

  openDebugPage() {
    debugPage ??= new OverlayEntry(builder: (context) {
      return Container();
    });
    if (showDebugPage) {
      closeDebugPage();
    } else {
      Overlay.of(context).insert(debugPage, below: owner);
      showDebugPage = true;
    }
  }

  closeDebugPage() {
    if (showDebugPage && debugPage != null) {
      debugPage.remove();
      showDebugPage = false;
    }
  }
}
