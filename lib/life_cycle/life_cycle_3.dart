import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/kit/vm_helper.dart';
import 'package:flutter_code_test/view/leak_widget.dart';

import 'life_cycle.dart';

class LifeCycle3 extends StatefulWidget {
  final String name1 = "haha";

  @override
  _LifeCycle3State createState() => _LifeCycle3State();
}

class _LifeCycle3State extends State<LifeCycle3> with WidgetsBindingObserver {
  var _controller = TestController();
  var _test;

  @override
  Widget build(BuildContext context) {
    ModalRoute rootRoute = ModalRoute.of(context);
    print('menggod build: LifeCycle3');
    return LeakCheckWidget(
      child: SafeArea(
        child: SingleChildScrollView(
          controller: _controller,
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(children: [
                OutlineButton(
                  onPressed: () => {Navigator.pop(context)},
                  color: Colors.blue,
                  child: Text('返回'),
                ),
                FlatButton(
                  onPressed: () => {Navigator.of(context).pushNamed("/life_cycle_3")},
                  color: Colors.blue,
                  child: Text('进入当前页面'),
                ),
                OutlineButton(
                  onPressed: () => {debugDumpRenderTree()},
                  color: Colors.blue,
                  child: Text('render'),
                ),
                OutlineButton(
                  onPressed: () => {debugDumpApp()},
                  color: Colors.blue,
                  child: Text('dump app'),
                ),
                OutlineButton(
                  onPressed: () => {
                    _test = WidgetsBinding.instance.renderViewElement,
                    debugPrint('menggod life_cycle_3 build: ')
                  },
                  color: Colors.blue,
                  child: Text('test app'),
                ),
                OutlineButton(
                  onPressed: () => {resolveTree(context)},
                  color: Colors.blue,
                  child: Text('resolveTree'),
                ),
                OutlineButton(
                  onPressed: () => {_processTree()},
                  color: Colors.blue,
                  child: Text('_processTree'),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  RenderObjectElement resolveTree(BuildContext context) {
    Element currentPage;
    List<RenderObjectElement> inBounds = new List();
    // 记录根路由，用以过滤overlay
    BuildContext _buildContext = context;
    ModalRoute rootRoute = ModalRoute.of(context);

    void filter(Element element) {
      // 兼容IOS，IOS的MaterialApp会在Navigator后再插入一个PositionedDirectional控件，用以处理右滑关闭手势，遍历的时候跳过该控件
      // if (!(element.widget is PositionedDirectional)) {
      //   if (element is RenderObjectElement) {
      //     ModalRoute route = ModalRoute.of(element);
      //     // overlay不包含route信息，通过ModalRoute.of会获取到当前所在materialapp在其父节点内的route,此处对overlay做过滤。只能过滤掉直接添加在根MaterialApp的overlay,
      //     // 并且该overlay的子widget不能包含materialApp或navigator
      //     if (route != null && route != rootRoute) {
      //       currentPage = element;
      //       RenderBox renderBox = element.renderObject;
      //       if (renderBox.hasSize && renderBox.attached) {
      //
      //       }
      //     }
      //     debugPrint('menggod life_cycle_3 filter: ${rootRoute.settings.name}  ${route.settings.name}');
      //   }
      //   element.visitChildren(filter);
      // }
      ModalRoute route = ModalRoute.of(element);
      debugPrint(
          'menggod life_cycle_3 filter: ${rootRoute.settings.name}  ${route.settings.name} ${element.widget}');
      element.visitChildren(filter);
    }

    _buildContext.visitChildElements(filter);
    RenderObjectElement topElement;
    ModalRoute route = currentPage != null ? ModalRoute.of(currentPage) : null;
    inBounds.forEach((element) {});
    return topElement;
  }

  @override
  void initState() {
    super.initState();
    print('menggod initState: LifeCycle3');
    WidgetsBinding.instance.addObserver(this);
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
    // _controller.dispose();
    print('menggod dispose: LifeCycle3');
  }

  _processTree() {
    Element rootElement = WidgetsBinding.instance.renderViewElement;

    void filter(Element element) {
      if (element.widget is LifeCycle3) {
        debugPrint(
            'menggod --> : ${element.runtimeType}-->${element is RenderObjectElement}-->${element.hashCode}');
        VmHelper.instance.getObject(element);
      } else {}
      element.visitChildren(filter);
    }

    rootElement.visitChildren(filter);
    // debugPrint('menggod --> : ${rootElement.runtimeType}-->${rootElement is RenderObjectElement}');
  }
}

class TestController extends ScrollController {}
