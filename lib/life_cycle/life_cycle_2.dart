import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_code_test/life_cycle/life_cycle_3.dart';

class LifeCycle2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('menggod LifeCycle2: build');
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Flex(direction: Axis.vertical, children: [
            Row(
              children: <Widget>[
                Expanded(child: Text('这里是超长的或者是可变的不搞这个就会超出屏幕的')),
                Expanded(child: Text('这里是超长的或者是可变的不搞这个就会超出屏幕的')),
                Expanded(child: Text('这里是超长的或者是可变的不搞这个就会超出屏幕的')),
                Expanded(child: Text('这里是超长的或者是可变的不搞这个就会超出屏幕的')),
//           Text('Count: $_counter'),
              ],
            ),
            TextButton(
              onPressed: () => {
                Future.delayed(const Duration(hours: 1), () {
                  print('menggod life_cycle_2 build: ');
                }),
                Navigator.maybePop(context)
              },
              child: Text('返回'),
            ),
            Text(
              '当前页面是生命周期第二个页面',
              style: TextStyle(fontSize: 12, decoration: TextDecoration.none),
            ),
            FlatButton(
                onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LifeCycle3()))
                          .then(
                              (value) => debugPrint('menggod life_cycle_2 build: ${value.data}] '))
                    },
                color: Colors.green,
                child: Text('跳转三')),
            TextButton(onPressed: () => {_processTaskLoop()}, child: Text('分析三'))
          ]),
        ),
      ),
    );
  }

  static const platform = const MethodChannel('com.megretail.mpa/mainChannel');

  _processTaskLoop() {
    platform.invokeMethod('startTaskLoop');
  }

  _processTree() {
    Element rootElement = WidgetsBinding.instance.renderViewElement;

    void filter(Element element) {
      if (element.widget is LifeCycle3) {
        debugPrint(
            'menggod --> : ${element.runtimeType}-->${element is RenderObjectElement}-->${element.hashCode}');
        // VmHelper.instance.getObject(element);
        // LeakManager.instance.watch(element).analyze();
      } else {}
      element.visitChildren(filter);
    }

    rootElement.visitChildren(filter);
  }

  LifeCycle2() {
    print('menggod LifeCycle2: 构造');
  }
}
