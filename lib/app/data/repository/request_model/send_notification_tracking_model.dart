class SendNotificationTrackingModel {
  String? deliverId;
  String? title;
  Map<String, dynamic>? data;

  SendNotificationTrackingModel({this.title, this.data, this.deliverId});

  SendNotificationTrackingModel.fromJson(Map<String, dynamic> json) {
    deliverId = json['deliverId'];
    title = json['title'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliverId'] = deliverId;
    data['title'] = title;
    data['data'] = this.data;
    return data;
  }
}
