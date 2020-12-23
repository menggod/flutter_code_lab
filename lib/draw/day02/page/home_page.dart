import 'package:flutter/material.dart';
import 'package:flutter_code_test/global/cons.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: Cons.homeTabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Flutter 联盟"),
            bottom: _buildHomeTabBar(),
            actions: [Icon(Icons.search), HomeMenu()],
          ),
          body: _homeContent(),
          floatingActionButton: HomeButton(),
        ));
  }

  PreferredSizeWidget _buildHomeTabBar() {
    return TabBar(
        labelStyle: TextStyle(fontSize: 14),
        labelColor: Color(0xffffff),
        unselectedLabelColor: Color(0xffeeeeee),
        tabs: Cons.homeTabs
            .map((e) =>
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(e),
            ))
            .toList());
  }

  Widget _homeContent() =>
      TabBarView(
        children: Cons.homeTabs
            .map((e) =>
            Align(
              alignment: Alignment(0, -0.8),
              child: Text(e),
            ))
            .toList(),
      );
}

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    );
  }
}

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: _buildMenuItem,
      onSelected: (value) => _onSelected(context, value),
    );
  }

  List<PopupMenuEntry> _buildMenuItem(BuildContext context) {
    return Cons.menuInfo
        .map((e) =>
        PopupMenuItem(
          child: Text(e),
          value: Cons.menuInfo.indexOf(e),
        ))
        .toList();
  }

  void _onSelected(BuildContext context, int value) {
    print("menggod--->$value");
    if (value == 0) {
      var snackBar = SnackBar(
          duration: Duration(seconds: 5), content: Container(child: Text(" 这个是我的测试")), backgroundColor: Colors.green);
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      var content = Container(
        height: 50,
        color: Colors.amberAccent,
        child: Center(
          child: Text('text'),
        ),
      );
      showBottomSheet(context: context, builder: (context) => content);
    }
  }
}
