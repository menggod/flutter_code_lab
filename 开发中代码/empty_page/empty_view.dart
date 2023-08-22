import 'package:flutter/material.dart';
import 'package:mpa/actions/adapt.dart';
import 'package:mpa/utils/app_colors.dart';
import 'package:mpa/utils/lego_utils.dart';

class EmptyView extends StatelessWidget {
  static const int imageNoData = 1;
  static const int imageFilter = 2;

  const EmptyView(this.isShow,
      {this.title,
      this.subTitle = "",
      this.imgType = EmptyView.imageNoData,
      Key? key})
      : super(key: key);
  final bool isShow;
  final String? title;
  final String subTitle;
  final int imgType;

  AssetImage _processImageShow() {
    if (imgType == EmptyView.imageFilter) {
      return AssetImage("assets/images/bg_error_no_filter.png");
    }
    return AssetImage("assets/images/bg_error_no_data.png");
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isShow,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: _processImageShow(),
                width: Adapt.px(245),
                height: Adapt.px(116),
              ),
              Container(
                margin: EdgeInsets.only(top: Adapt.px(20), bottom: Adapt.px(7)),
                child: Text(
                  "$title",
                  style: LegoUtils.getw500TextStyle(20,
                      color: AppColors.c_383735_ff),
                ),
              ),
              Text(
                "$subTitle",
                style: LegoUtils.getw400TextStyle(17,
                    color: AppColors.c_8c8681_ff),
              ),
            ],
          ),
        ));
  }
}
