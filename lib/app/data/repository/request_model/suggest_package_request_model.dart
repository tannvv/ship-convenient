class SuggestPackageRequestModel {
  String deliverId;
  int pageIndex;
  int pageSize;

  SuggestPackageRequestModel(
      {required this.deliverId, this.pageIndex = 0, this.pageSize = 20});
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['deliverId'] = deliverId;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}
