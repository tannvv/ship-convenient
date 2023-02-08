class NotificationModel {
  String? id;
  String? title;
  String? content;
  bool? isSend;
  DateTime? createdAt;
  String? accountId;
  int? filter;

  NotificationModel(
      {this.id,
      this.title,
      this.content,
      this.isSend,
      this.createdAt,
      this.accountId});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    isSend = json['isSend'];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['isSend'] = isSend;
    data['createdAt'] = createdAt;
    data['accountId'] = accountId;
    return data;
  }
}
