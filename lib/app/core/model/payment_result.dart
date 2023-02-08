import 'package:convenient_way/app/core/enum/payment_method.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:intl/intl.dart';

class PaymentResult {
  bool _status = false;
  String? _uid;
  int? _amount;
  DateTime? _createdDate;
  PaymentMethod _source = PaymentMethod.vnpay;

  DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
  bool get status => _status;
  String get uid => _uid ?? '-';
  int? get amount => _amount;
  DateTime? get createdDate => _createdDate;
  PaymentMethod get source => _source;

  String get amountVND => _amount != null ? _amount!.toVND() : '-';
  String get createdDateVN =>
      createdDate != null ? formatter.format(createdDate!) : '-';

  PaymentResult({
    status = false,
    uid,
    amount,
    createdDate,
    PaymentMethod source = PaymentMethod.vnpay,
  }) {
    _status = status;
    _uid = uid;
    _amount = amount;
    _createdDate = createdDate;
    _source = source;
  }

  PaymentResult.fromString({
    String? status,
    String? uid,
    int? amount,
    String? createdDate,
    PaymentMethod? source,
  }) {
    _status = status == 'success' ? true : false;
    _uid = uid;
    _amount = amount;
    _createdDate = createdDate != null
        ? DateFormat('dd/MM/yyyy hh:mm:ss').parse(createdDate)
        : null;
    _source = source ?? PaymentMethod.vnpay;
  }
}
