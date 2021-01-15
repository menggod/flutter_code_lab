import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/life_cycle/life_cycle_3.dart';

class LifeCycle2 extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    print('menggod build: LifeCycle2');
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(children: [
            OutlineButton(
              onPressed: () => {
                Navigator.pop(context)
              },
              color: Colors.blue,
              child: Text('返回'),
            ),
            Text('当前页面是生命周期第二个页面'),
            FlatButton(onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LifeCycle3()))
            }, color: Colors.green, child: Text('跳转三'))
          ]),
        ),
      ),
    );
  }

  LifeCycle2(){
    print('menggod LifeCycle2: 构造');
  }
}
