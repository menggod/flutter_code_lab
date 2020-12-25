
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/utils/color_utils.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';

import 'state.dart';

Widget buildView(SplashState state, Dispatch dispatch, ViewService viewService) {
  data.add(PoemItem(title: "/nav_page", summary: "跳转到nav测试页面"));
  return Scaffold(body: _buildBody());
}

Container _buildBody() {
  return Container(
    child: Stack(
      alignment: Alignment.topLeft,
      children: [
        SquareGridView(displayAxis: false),
        Positioned(
          left: 70,
          top: 3,
          child: Text(
            'menggod',
            style: TextStyle(color: ColorGenerator().getRandomColor()),
          ),
        ),
        SafeArea(
          child: _buildRealContainer(),
        )
      ],
    ),
  );
}

Widget _buildRealContainer() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Expanded(child: show)],
    ),
  );
}

var data = <PoemItem>[];

var show = ListView.builder(
    padding: EdgeInsets.all(8.0),
    itemCount: data.length, //条目的个数
    itemBuilder: (BuildContext context, int index) {
      return PoemItemView(
        //数据填充条目
        data: data[index],
        onItemClickListener: () {
          //事件响应
          print(index);
          Navigator.of(context).pushNamed(data[index].title);
        },
      );
    });

typedef OnItemClickListener = void Function();

class PoemItemView extends StatelessWidget {
  final PoemItem data;
  final OnItemClickListener onItemClickListener;

  PoemItemView({Key key, this.data, this.onItemClickListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var headIcon = Container(
        //左边头部
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: Offset(0.0, 0.0),
              blurRadius: 3.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        width: 70,
        height: 70,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: CircleAvatar(
            backgroundImage: data.image,
          ),
        ));
    var center = Column(
      //中间介绍
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(data.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "作者:${data.author}",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
    var summary = Text(
      //尾部摘要
      data.summary,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );
    var item = Row(
      //条目拼合
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 10),
        headIcon,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: center,
        ),
        Expanded(
          child: summary,
        ),
        SizedBox(width: 10),
      ],
    );
    var result = Card(
      child: InkWell(
        onTap: onItemClickListener,
        child: item,
      ),
    );
    return result;
  }
}

class PoemItem {
  ImageProvider image; //图片
  var title; //标题
  var author; //作者
  var summary; //摘要
  PoemItem({this.image, this.title, this.author = "menggod", this.summary});
}
