class RegisterAccount {
  String? userName;
  String? password;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  String? gender;

  RegisterAccount(
      {required this.userName,
      required this.password,
      required this.email,
      required this.displayName,
      required this.phoneNumber,
      required this.photoUrl,
      required this.gender});

  RegisterAccount.fromJson(Map<String, dynamic> json) {
    userName = json['userName'] ?? '';
    password = json['password'] ?? '';
    email = json['email'] ?? '';
    displayName = json['displayName'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    photoUrl = json['photoUrl'] ?? '';
    gender = json['gender'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['email'] = email;
    data['displayName'] = displayName;
    data['phoneNumber'] = phoneNumber;
    data['photoUrl'] = photoUrl;
    data['gender'] = gender;
    return data;
  }
}
