import 'package:flutter/material.dart';

class BugPage extends StatefulWidget {
  @override
  _BugPageState createState() => _BugPageState();
}

class _BugPageState extends State<BugPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Builder(builder: (ctx) {
        return FlatButton(
          color: Colors.red,
          child: Text(
            '点击弹窗',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            showBottomSheet(context: ctx, builder: (context) => TestDemo());
            // Scaffold.of(context).showBottomSheet((context) => TestDemo());
          },
        );
      })),
    );
  }
}

class TestDemo extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: true,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        backgroundColor: Colors.black,
        onClosing: () => print('OnClosing'),
        builder: (ctx) {
          return Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: double.infinity),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Navigator(
              key: navigatorKey,
              initialRoute: "/",
              onGenerateRoute: (RouteSettings settings) {
                WidgetBuilder builder;
                switch (settings.name) {
                  case "/":
                    builder = (_) => TestThirdDemo();
                    break;
                  default:
                    // builder = (_) => TestThirdDemo();
                    break;
                }
                return MaterialPageRoute(maintainState: true, builder: builder);
              },
            ),
          );
        });
  }
}

class TestSecondDemo extends StatefulWidget {
  @override
  _TestSecondDemoState createState() => _TestSecondDemoState();
}

class _TestSecondDemoState extends State<TestSecondDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.bottomCenter,
          color: Colors.red,
          child: Column(
            children: [
              Text('弹窗的第一个页面'),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => TestThirdDemo()));
                },
                child: Text('跳转弹窗第二个页面'),
                color: Colors.white,
              )
            ],
          )),
    );
  }
}

class TestThirdDemo extends StatefulWidget {
  @override
  _TestThirdDemoState createState() => _TestThirdDemoState();
}

class _TestThirdDemoState extends State<TestThirdDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('点击页面最下方的输入框'),
          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.orange,
            child: TextField(),
          ),
        ],
      ),
    );
  }
}
