class CreateAccountModel {
  String? userName;
  String? password;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? photoUrl;
  String? gender;
  String? role;

  CreateAccountModel(
      {this.userName,
      this.password,
      this.email,
      this.firstName,
      this.lastName,
      this.phone,
      this.photoUrl,
      this.gender,
      this.role});

  CreateAccountModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    photoUrl = json['photoUrl'];
    gender = json['gender'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['photoUrl'] = photoUrl;
    data['gender'] = gender;
    data['role'] = role;
    return data;
  }
}
