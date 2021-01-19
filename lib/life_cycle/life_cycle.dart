import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {

  final int initValue;

  @override
  _CounterWidgetState createState() {
    print('menggod lifecycle createState: ');
    return  _CounterWidgetState();
  }

  CounterWidget({this.initValue=0}){
    print('menggod lifecycle 构造: ');
  }
}

class _CounterWidgetState extends State<CounterWidget> with WidgetsBindingObserver {
  int _counter;
  List dataList;

  Future<Null> _fetchData() async {
    await Future.delayed(Duration(seconds: 5), () {
      print('_fetchData');
      setState(() {
        // dataList = List.generate(40, (i) => i);
        return null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('menggod  lifecycle build: ');
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              Text('这个是生命周期测试页面一'),
              MaterialButton(onPressed: () => {
                Navigator.pushNamed(context, "/life_cycle_2")
              },color: Colors.pink,textColor: Colors.white, child: Text('跳转到页面二'),),
              FlatButton(
                color: Colors.blue,
                child: Text('$_counter'),
                onPressed: () => setState(() => ++_counter),
              ),
            ])),
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _counter = widget.initValue;
    print('menggod  lifecycle  initState: ');
    // _fetchData();
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('menggod lifecycle didUpdateWidget: ');
  }

  @override
  void deactivate() {
    // 失效
    super.deactivate();
    print('menggod lifecycle deactivate: ');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // 丢掉, 处理, 安置
    super.dispose();
    print('menggod lifecycle dispose: ');
  }

  @override
  void reassemble() {
    // 重组
    super.reassemble();
    print('menggod lifecycle reassemble: ');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('menggod lifecycle didChangeDependencies: ');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('menggod lifecycle didChangeAppLifecycleState: resumed');
        break;
      case AppLifecycleState.inactive:
        print('menggod lifecycle didChangeAppLifecycleState: inactive');
        break;
      case AppLifecycleState.paused:
        print('menggod lifecycle didChangeAppLifecycleState: paused');
        break;
      case AppLifecycleState.detached:
        print('menggod lifecycle didChangeAppLifecycleState: detached');
        break;
    }
  }
}
