// ignore_for_file: constant_identifier_names

abstract class PackageStatus {
  static const String WAITING = "WAITING";
  static const String APPROVED = "APPROVED";
  static const String REJECT = "REJECT";
  static const String DELIVER_PICKUP = "DELIVER_PICKUP";
  static const String DELIVER_CANCEL = "DELIVER_CANCEL";
  static const String SENDER_CANCEL = "SENDER_CANCEL";
  static const String DELIVERY = "DELIVERY";
  static const String DELIVERED = "DELIVERED";
  static const String DELIVERY_FAILED = "DELIVERY_FAILED";
  static const String SENDER_CONFIRM_DELIVERED = "SENDER_CONFIRM_DELIVERED";
  static const String REFUND_SUCCESS = "REFUND_SUCCESS";
  static const String REFUND_FAILED = "REFUND_FAILED";
  static const String NOT_EXIST = "NOT_EXIST";
}
