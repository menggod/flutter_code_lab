import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mpa/actions/adapt.dart';

class GetLoadingView extends StatelessWidget {
  final bool? isShowLoading;
  final Color? coverColor;

  GetLoadingView(this.isShowLoading, {this.coverColor});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShowLoading!,
      maintainState: true,
      child: Container(
        color: coverColor == null ? Color(0x3374716E)  : coverColor,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(6)),
              color: Colors.deepOrange[400],
            ),
            width: Adapt.px(80),
            height: Adapt.px(80),
            child: SpinKitWave(
              color: Colors.white,
              size: Adapt.px(30),
            ),
          ),
        ),
      ),
    );
  }
}
