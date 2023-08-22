import 'package:fish_redux/fish_redux.dart';
import 'package:get/get.dart';
import 'package:mpa/actions/global_router.dart';
import 'package:mpa/models/response_bean.dart';
import 'package:mpa/routes/mavigator.dart';
import 'package:mpa/utils/date_util.dart';
import 'package:mpa/widget/error_page/error_state.dart';

enum PageStateAction {
  setLoadingState,
  setErrorPageState,
  onErrorRefresh,
  setPageInitMs
}

class PageStateActionCreator {
  static Action setErrorPageState(bool isShow, BaseResponse? response) {
    return Action(PageStateAction.setErrorPageState,
        payload: {"isShow": isShow, "response": response});
  }

  static Action setLoadingState(bool isShow) {
    return Action(PageStateAction.setLoadingState, payload: isShow);
  }

  static Action setPageInitMs(int ms) {
    return Action(PageStateAction.setPageInitMs, payload: ms);
  }

  static Action onErrorRefresh() {
    return Action(PageStateAction.onErrorRefresh);
  }
}

class PageReducer {
  static T setLoadingState<T extends dynamic>(T state, Action action) {
    T newState = state.clone();
    newState.isShowLoading = action.payload;
    return newState;
  }

  static T setPageInitMs<T extends dynamic>(T state, Action action) {
    T newState = state.clone();
    newState.pageInitMs = action.payload;
    return newState;
  }

  static T setErrorPageState<T extends dynamic>(T state, Action action) {
    T newState = state.clone();
    var payload = action.payload;
    var isShow = payload['isShow'];
    var response = payload['response'];
    newState.isShowErrorPage = isShow;
    newState.baseResponse = response;
    return newState;
  }
}

class PageStateUtils {
  static setGetXLoadingState(
      GetxController controller, PageState state, bool isShow) {
    state.isShowLoading = isShow;
    controller.update();
  }

  static setGetXErrorPageState(
      GetxController controller, PageState state, bool isShow,
      {BaseResponse? response}) {
    state.isShowErrorPage = isShow;
    state.baseResponse = response;
    controller.update();
  }

  static setPageInitMs(Context ctx) {
    ctx.dispatch(PageStateActionCreator.setPageInitMs(DateUtil.getNowDateMs()));
  }

  static setLoadingState(Context ctx, bool isShow) {
    ctx.dispatch(PageStateActionCreator.setLoadingState(isShow));
  }

  static setErrorPageState(Context ctx, bool isShow, {BaseResponse? response}) {
    ctx.dispatch(PageStateActionCreator.setErrorPageState(isShow, response));
  }

  static processResult(BaseResponse response) {
    if (response?.code == 508) {
      Mavigator.toSuspendPage(NavigationService.navigationKey.currentContext!);
      return;
    } else {
      return response;
    }
  }
}
