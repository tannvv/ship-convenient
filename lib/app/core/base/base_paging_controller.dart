import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BasePagingController<T> extends BaseController {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  int _pageSize = AppValues.defaultPageSize;
  int _pageIndex = AppValues.defaultPageIndex;
  bool _hasMore = true;
  RxList<T> dataApis = RxList<T>();
  RefreshController get refreshController => _refreshController;
  int get pageSize => _pageSize;
  int get pageIndex => _pageIndex;
  final RxBool _isRefreshing = false.obs;
  bool get isRefreshing => _isRefreshing.value;
  void resetPaging() {
    _pageSize = AppValues.defaultPageSize;
    _pageIndex = AppValues.defaultPageIndex;
    _hasMore = true;
    dataApis.value = [];
    _refreshController.resetNoData();
  }

  Future<void> onRefresh() async {
    _isRefreshing.value = true;
    resetPaging();
    await fetchDataApi();
    _refreshController.refreshCompleted();
    _isRefreshing.value = false;
  }

  Future<void> onLoading() async {
    if (!_hasMore) {
      _refreshController.loadNoData();
      return;
    }
    _pageIndex++;
    await fetchDataApi();
    _refreshController.loadComplete();
  }

  void setHasMore(int responseLength) {
    if (responseLength < _pageSize) {
      _hasMore = false;
    }
  }

  void onSuccess(List<T> response) {
    dataApis.addAll(response);
    setHasMore(response.length);
  }

  void onError(dynamic exception) {
    if (exception is BaseException) {
      MotionToastService.showError(exception.message);
    }
  }

  Future<void> fetchDataApi();
}
