class SendNotificationModel {
  String? title;
  String? body;
  String? accountId;
  Map<String, dynamic>? data;

  SendNotificationModel({
    this.title,
    this.body,
    this.accountId,
    this.data,
  });

  SendNotificationModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    accountId = json['accountId'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['accountId'] = accountId;
    data['data'] = this.data;
    return data;
  }
}
