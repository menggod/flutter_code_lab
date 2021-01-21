import 'package:flutter/material.dart';
import 'package:flutter_code_test/kit/vm_helper.dart';
import 'package:vm_service/vm_service.dart';

class VmPage extends StatefulWidget {
  @override
  _VmPageState createState() => _VmPageState();
}

class _VmPageState extends State<VmPage> {
  ScriptList _scriptList;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                  onPressed: () => {VmHelper.instance.getScripts()},
                  splashColor: Colors.green,
                  color: Colors.blue,
                  child: Text('getScripts')),
              FlatButton(
                  color: Colors.pink,
                  onPressed: ()=>{
                    VmHelper.instance.getLibrary()
                  },
                  child: Text('get library'))

            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBuild(BuildContext context, int index) {
    if (_scriptList == null) {
      return Container();
    }
    var script = _scriptList?.scripts[index];
    return script == null ? Container() : ListTile(title: Text(script.toString()));
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Expanded(child: ListView.builder(itemBuilder: _itemBuild));
  }
}

//        FutureBuilder( future: VmHelper.instance.getScriptsFuture(), builder: _buildFuture),
