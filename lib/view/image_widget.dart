import 'package:flutter/material.dart';

class OfficialNetworkImage extends StatefulWidget {
  OfficialNetworkImage(
      {@required this.url,
      this.w,
      this.fit,
      this.errorWidget,
      this.defImagePath = "assets/images/goods.png"});

  final String url;
  final double w;
  final BoxFit fit;
  final String defImagePath;
  final Widget errorWidget;

  @override
  State<StatefulWidget> createState() {
    return _StateImageWidget(url);
  }
}

class _StateImageWidget extends State<OfficialNetworkImage> {
  Image _image;
  Widget _widget;
  String url;

  _StateImageWidget(this.url);

  _processClick() {
    // url = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01a9d85ecf6bdba80120662104b791.jpg%402o.jpg&refer=http%3A%2F%2Fimg.zcool.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1621750511&t=8b4eb2f1e27e5c445b1c7c1f35851b48";
    _requestImg();
  }
  _requestImg() {
    _image = Image(fit: widget.fit ?? BoxFit.contain, width: widget.w, image: NetworkImage(url));
    debugPrint('menggod official_network_image_view initState:$url  开始加载');
    var resolve = _image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      //加载成功
      debugPrint('menggod official_network_image_view initState:$url 加载成功');
      setState(() {
        _widget = _image;
      });
    }, onError: (dynamic exception, StackTrace stackTrace) {
      debugPrint('menggod official_network_image_view initState:$url 加载失败');
      //加载失败
      setState(() {
        _image = widget.errorWidget ??
            Image.asset(
              widget.defImagePath,
              width: 360,
              fit: widget.fit ?? BoxFit.contain,
            );
      });
    }));
  }

  @override
  void initState() {
    super.initState();
    _widget = GestureDetector(
      child: Text("点击重试"),
      onTap: () => {_processClick()},
    );
    _requestImg();
  }

  @override
  Widget build(BuildContext context) {
    return _widget;
  }
}
