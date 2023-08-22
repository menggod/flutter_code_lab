import 'package:mpa/models/obsolete_goods_activity_bean.dart';
import 'package:mpa/widget/error_page/error_state.dart';

class ObsoleteGoodsListPageState with PageState {
  List<ObsoleteGoodsActivityBean>? list;

  ObsoleteGoodsListPageState() {
    isShowLoading = true;
  }
}
