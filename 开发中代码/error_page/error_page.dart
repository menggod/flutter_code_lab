import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mpa/actions/adapt.dart';
import 'package:mpa/actions/global_router.dart';
import 'package:mpa/actions/request.dart';
import 'package:mpa/config/global.dart';
import 'package:mpa/models/response_bean.dart';
import 'package:mpa/routes/mavigator.dart';
import 'package:mpa/utils/app_colors.dart';
import 'package:mpa/utils/lego_utils.dart';
import 'package:mpa/utils/tips_utils.dart';
import 'package:mpa/widget/wrapper_dialog.dart';

import '../button_widget.dart';
import 'action.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage(this.isShow, this.baseResponse, this.dispatch,
      {this.onTryClick = Tips.empty, this.isAllowShow = false, Key? key})
      : super(key: key);
  final bool isShow;
  final bool isAllowShow;
  final BaseResponse? baseResponse;
  final Dispatch? dispatch;
  final Function onTryClick;

  AssetImage _processImageShow() {
    if (baseResponse?.netCode != null) {
      if (baseResponse?.netCode == LocalErrorCode.NEED_TO_HANDLE_NO_DATA) {
        return AssetImage("assets/images/bg_error_no_data.png");
      }
      return AssetImage("assets/images/bg_error_not_net.png");
    } else {
      if (baseResponse?.code == 508) {
        return AssetImage("assets/images/bg_error_no_time.png");
      } else {
        return AssetImage("assets/images/bg_error_response.png");
      }
    }
  }

  String _processTipTitleTextShow() {
    if (baseResponse?.netCode != null) {
      return baseResponse?.msg ?? "";
    } else if (baseResponse?.code != null) {
      if (baseResponse?.code == 508) {
        return '非订货时间';
      } else {
        return '抱歉!系统出现${baseResponse?.code}异常';
      }
    } else {
      return '抱歉!系统出现异常';
    }
  }

  String _processTipsText() {
    if (baseResponse?.code == 508) {
      return '${baseResponse?.msg}';
    }
    if (baseResponse?.netCode == LocalErrorCode.NEED_TO_HANDLE_NO_DATA) {
      return '';
    } else {
      return '请重新刷新一下';
    }
  }

  String _processBtnText() {
    if (baseResponse?.code == 508) {
      return '返回';
    } else {
      return '刷新';
    }
  }

  bool _processBtnVisible() {
    if (baseResponse?.netCode == LocalErrorCode.NEED_TO_HANDLE_NO_DATA) {
      return false;
    } else {
      return true;
    }
  }

  void _processJump() {
    if (baseResponse?.code == 508) {
      Mavigator.onBackUntil(
        NavigationService.navigationKey.currentContext!,
        PageNameConstant.typeChoosePage,
      );
    } else {
      dispatch!(PageStateActionCreator.onErrorRefresh());
    }
  }

  bool _processShow() {
    if (isAllowShow) {
      return true;
    } else {
      if (baseResponse?.code == 508) {
        return false;
      } else {
        return isShow ?? false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _processShow(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.c_f2f0ee_ff,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
            decoration: LegoUtils.getCornersBgTop(6),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onLongPress: () {
                    Wrapper.showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "--感谢您的帮助-- | --更多信息-- | --ORZ--  | --小订因你而更好--",
                              style: LegoUtils.getTextStyle(fs: 20),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text(
                                    "msg: ${baseResponse?.msg}",
                                    style: LegoUtils.getTextStyle(fs: 18),
                                  ),
                                  Text(
                                    "baseResponse:  ${baseResponse?.toJson()}",
                                    style: LegoUtils.getTextStyle(fs: 18),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Image(
                    image: _processImageShow(),
                    width: Adapt.px(280),
                    height: Adapt.px(230),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Adapt.px(20), bottom: Adapt.px(7)),
                  child: Text(
                    _processTipTitleTextShow()!,
                    style: LegoUtils.getw500TextStyle(26, color: AppColors.c_383735_ff),
                  ),
                ),
                Text(
                  _processTipsText(),
                  style: LegoUtils.getw400TextStyle(19, color: AppColors.c_8c8681_ff),
                ),
                Container(
                  margin: EdgeInsets.only(top: Adapt.px(20)),
                  child: Visibility(
                    visible: _processBtnVisible(),
                    child: OrangeHollowButton(
                      _processBtnText(),
                      width: 200,
                      height: 48,
                      corner: 90,
                      onPressed: () {
                        _processJump();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
