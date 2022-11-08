class SimpleResponseModel {
  bool? success;
  String? message;

  SimpleResponseModel({required this.success, required this.message});

  SimpleResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
