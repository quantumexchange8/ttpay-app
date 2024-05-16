import 'dart:convert';

import 'package:ttpay/models/transaction.dart';

List<Group> listGroupFromJson(String json) {
  List data = jsonDecode(json);
  return List<Group>.from(data.map((e) => Group.fromMap(e)));
}

List<Group> listGroupFromListMap(List<Map<String, dynamic>> transactionList) {
  return List<Group>.from(transactionList.map((e) => Group.fromMap(e)));
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Group {
  int id;
  String name;
  String colorCode;
  int totalDepositNumber;
  double totalGrossDepositAmount;
  double totalNetDepositAmount;
  int totalWithdrawalNumber;
  double totalGrossWithdrawalAmount;
  double totalNetWithdrawalAmount;
  List<Transaction> transactionList;
  Group({
    required this.id,
    required this.name,
    required this.colorCode,
    required this.totalDepositNumber,
    required this.totalGrossDepositAmount,
    required this.totalNetDepositAmount,
    required this.totalWithdrawalNumber,
    required this.totalGrossWithdrawalAmount,
    required this.totalNetWithdrawalAmount,
    required this.transactionList,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color_code': colorCode,
      'total_deposit_number': totalDepositNumber,
      'total_gross_deposit_amount': totalGrossDepositAmount,
      'total_net_deposit_amount': totalNetDepositAmount,
      'total_withdrawal_number': totalWithdrawalNumber,
      'total_gross_withdrawal_amount': totalGrossWithdrawalAmount,
      'total_net_withdrawal_amount': totalNetWithdrawalAmount,
      'transaction_list': transactionList.map((e) => e.toMap()).toList(),
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    List transactionList = map['transaction_list'];

    return Group(
        id: map['id'] as int,
        name: map['name'] as String,
        colorCode: map['color_code'] as String,
        totalDepositNumber: int.parse(map['total_deposit_number']),
        totalGrossDepositAmount:
            double.parse(map['total_gross_deposit_amount']),
        totalNetDepositAmount: double.parse(map['total_net_deposit_amount']),
        totalWithdrawalNumber: int.parse(map['total_withdrawal_number']),
        totalGrossWithdrawalAmount:
            double.parse(map['total_gross_withdrawal_amount']),
        totalNetWithdrawalAmount:
            double.parse(map['total_net_withdrawal_amount']),
        transactionList:
            transactionList.map((e) => Transaction.fromMap(e)).toList());
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));
}
