// import 'package:fish_redux/fish_redux.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_code_test/global/cons.dart';
// import 'package:flutter_code_test/utils/color_utils.dart';
// import 'package:flutter_code_test/view/square_grid_view.dart';
//
// import 'state.dart';
//
// Widget buildView(
//     SplashState state, Dispatch dispatch, ViewService viewService) {
//   var list = Cons.routeList.keys.toList();
//   for (int i = 0; i < list.length; i++) {
//     data.add(PoemItem(title: list[i], summary: Cons.routeIntroList[list[i]]));
//   }
//
//   return Scaffold(body: _buildBody(viewService.context));
// }
//
// Container _buildBody(BuildContext context) {
//   return Container(
//     key: Cons.appKey,
//     child: Stack(
//       alignment: Alignment.topLeft,
//       children: [
//         SquareGridView(displayAxis: false),
//         Positioned(
//           left: 70,
//           top: 3,
//           child: Text(
//             'menggod',
//             style: TextStyle(color: ColorGenerator().getRandomColor()),
//           ),
//         ),
//         SafeArea(
//           child: _buildRealContainer(),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildRealContainer() {
//   return Container(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [Expanded(child: show)],
//     ),
//   );
// }
//
// var data = <PoemItem>[];
//
// var show = ListView.builder(
//     padding: EdgeInsets.all(8.0),
//     itemCount: data.length, //条目的个数
//     itemBuilder: (BuildContext context, int index) {
//       return PoemItemView(
//         //数据填充条目
//         data: data[index],
//         onItemClickListener: () {
//           //事件响应
//           print(index);
//           Navigator.of(context).pushNamed(data?[index]?.title ?? "");
//         },
//       );
//     });
//
// typedef OnItemClickListener = void Function();
//
// class PoemItemView extends StatefulWidget {
//   PoemItem? data;
//   OnItemClickListener? onItemClickListener;
//
//   PoemItemView({Key? key, this.data, this.onItemClickListener})
//       : super(key: key);
//
//   @override
//   State<PoemItemView> createState() => _PoemItemViewState();
// }
//
// class _PoemItemViewState extends State<PoemItemView> {
//   @override
//   Widget build(BuildContext context) {
//     var headIcon = Container(
//         //左边头部
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               offset: Offset(0.0, 0.0),
//               blurRadius: 3.0,
//               spreadRadius: 0.0,
//             ),
//           ],
//         ),
//         width: 70,
//         height: 70,
//         child: Padding(
//           padding: EdgeInsets.all(3),
//           child: CircleAvatar(
//             backgroundColor: widget.data?.image,
//           ),
//         ));
//     var center = Column(
//       //中间介绍
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Text(widget.data?.title ?? "",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         Padding(
//           padding: EdgeInsets.only(top: 8),
//           child: Text(
//             "作者:${widget.data?.author}",
//             style: TextStyle(color: Colors.grey, fontSize: 12),
//           ),
//         ),
//       ],
//     );
//     var summary = Text(
//       //尾部摘要
//       widget.data?.summary ?? "",
//       maxLines: 3,
//       overflow: TextOverflow.ellipsis,
//       style: TextStyle(color: Colors.grey, fontSize: 12),
//     );
//     var item = Row(
//       //条目拼合
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
//         SizedBox(width: 10),
//         headIcon,
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20),
//           child: center,
//         ),
//         Expanded(
//           child: summary,
//         ),
//         SizedBox(width: 10),
//       ],
//     );
//     var result = Card(
//       child: InkWell(
//         onTap: widget.onItemClickListener,
//         child: Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3), child: item),
//       ),
//     );
//     return result;
//   }
// }
//
// class PoemItem {
//   late Color image;
//   String? title; //标题
//   String? author; //作者
//   String? summary; //摘要
//   PoemItem({this.title, this.author = "menggod", this.summary}) {
//     image = ColorGenerator.create(ColorGenerator.materialList).getColor(title!);
//   }
// }
