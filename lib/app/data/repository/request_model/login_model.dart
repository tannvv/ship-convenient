class LoginModel {
  String? userName;
  String? password;
  String? registrationToken;

  LoginModel({this.userName, this.password, this.registrationToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    registrationToken = json['registrationToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['registrationToken'] = registrationToken;
    return data;
  }
}
