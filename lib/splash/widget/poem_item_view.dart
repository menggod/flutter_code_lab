import 'package:flutter/material.dart';
import 'package:flutter_code_test/splash/model/poem_item_bean.dart';

class PoemItemView extends StatelessWidget {
  final PoemItem? data;

  const PoemItemView(this.data, {Key? key}) : super(key: key);

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
            backgroundColor: data?.image,
          ),
        ));
    var center = Column(
      //中间介绍
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(data?.title ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "作者:${data?.author}",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
    var summary = Text(
      //尾部摘要
      data?.summary ?? "",
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

    return Card(
      child: InkWell(
        onTap: () {},
        child: Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3), child: item),
      ),
    );
  }
}
