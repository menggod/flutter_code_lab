import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_test/api/api.dart';
import 'package:flutter_code_test/utils/color_utils.dart';
import 'package:flutter_code_test/view/image_widget.dart';
import 'package:flutter_code_test/view/square_grid_view.dart';

class TestImagePage extends StatefulWidget {
  @override
  _TestImagePageState createState() => _TestImagePageState();
}

class _TestImagePageState extends State<TestImagePage> {
  var url;
  var text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          SquareGridView(),
          url != null
              ? Container(
              child: Stack(children: [
                Positioned(
                    bottom: 0,
                    child: OfficialNetworkImage(
                      url: url,
                      w: MediaQuery
                          .of(context)
                          .size
                          .width,
                    )),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    text,
                    style: TextStyle(
                        shadows:[Shadow(color:Colors.black,offset: Offset(3, 3), blurRadius: 5)],
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        color: HexColor("#81d8d0")),
                  ),
                )
              ]))
              : Container(),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    Response response;
    Dio dio = Dio();
    response = await dio.get(Api.bingImg);
    print(response.data.toString());
    var data = response.data["images"];
    var imageBean = data[0];

    Future.delayed(Duration(milliseconds: 10000), () {

      setState(() {
        url = "http://cn.bing.com" + imageBean["url"];
        // url = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01a9d85ecf6bdba80120662104b791.jpg%402o.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1621750511&t=8b4eb2f1e27e5c445b1c7c1f35851b48";
        print('menggod _getData: $url');
        text = imageBean["copyright"];
      });

    });

  }
}
