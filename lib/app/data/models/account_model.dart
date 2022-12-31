import 'package:convenient_way/app/data/models/info_user_model.dart';

class Account {
  String? id;
  String? userName;
  String? status;
  int? balance;
  String? role;
  InfoUser? infoUser;

  Account(
      {this.id,
      this.userName,
      this.status,
      this.balance,
      this.role,
      this.infoUser});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    status = json['status'];
    balance = json['balance'];
    role = json['role'];
    infoUser =
        json['infoUser'] != null ? InfoUser?.fromJson(json['infoUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['status'] = status;
    data['balance'] = balance;
    data['role'] = role;
    if (infoUser != null) {
      data['infoUser'] = infoUser?.toJson();
    }
    return data;
  }
}
