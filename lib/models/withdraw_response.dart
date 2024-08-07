import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WithdrawResponse {
  String message;
  String status;
  String transactionId;
  DateTime dateTime;
  double amount;
  String? usdtAddress;
  WithdrawResponse({
    required this.message,
    required this.status,
    required this.transactionId,
    required this.dateTime,
    required this.amount,
    this.usdtAddress,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'status': status,
      'transaction_id': transactionId,
      'date_time': dateTime.millisecondsSinceEpoch,
      'amount': amount,
      'usdt_address': usdtAddress,
    };
  }

  factory WithdrawResponse.fromMap(Map<String, dynamic> map) {
    return WithdrawResponse(
      message: map['message'] as String,
      status: map['status'] as String,
      transactionId: map['transaction_id'] as String,
      dateTime: DateTime.parse(map['date_time'] as String),
      amount: double.parse(map['amount'] as String),
      usdtAddress:
          map['usdt_address'] != null ? map['usdt_address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawResponse.fromJson(String source) =>
      WithdrawResponse.fromMap(json.decode(source));
}
