import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class CustomFooterSmartRefresh {
  static Widget defaultCustom() => CustomFooter(builder: ((context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text("Có lỗi khi tải trang");
        } else if (mode == LoadStatus.canLoading) {
          body = const Text("Tải thêm");
        } else {
          body = const Text("Đã đến cuối danh sách");
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      }));
}
