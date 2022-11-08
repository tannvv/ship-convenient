// ignore_for_file: constant_identifier_names

abstract class PackageStatus {
  static const String WAITING = "WAITING";
  static const String APPROVED = "APPROVED";
  static const String REJECT = "REJECT";
  static const String SHIPPER_PICKUP = "SHIPPER_PICKUP";
  static const String SHIPPER_CANCEL = "SHIPPER_CANCEL";
  static const String SHOP_CANCEL = "SHOP_CANCEL";
  static const String DELIVERY = "DELIVERY";
  static const String DELIVERED = "DELIVERED";
  static const String DELIVERY_FAILED = "DELIVERY_FAILED";
  static const String SHOP_CONFIRM_DELIVERED = "SHOP_CONFIRM_DELIVERED";
  static const String REFUND_SUCCESS = "REFUND_SUCCESS";
  static const String REFUND_FAILED = "REFUND_FAILED";
  static const String NOT_EXIST = "NOT_EXIST";
}
