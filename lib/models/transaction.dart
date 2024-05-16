import 'dart:convert';

import 'package:ttpay/models/group.dart';
import 'package:ttpay/models/user.dart';

List<Transaction> listTransactionFromJson(String json) {
  List data = jsonDecode(json);
  return List<Transaction>.from(data.map((e) => Transaction.fromMap(e)));
}

List<Transaction> listTransactionFromListMap(
    List<Map<String, dynamic>> transactionList) {
  return List<Transaction>.from(
      transactionList.map((e) => Transaction.fromMap(e)));
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Transaction {
  int id;
  DateTime createdAt;
  String transactionNumber;
  String transactionType;
  String status;
  double amount;
  double fee;
  double netAmount;
  String txId;
  String sentAddress;
  String receivingAddress;
  String? description;
  DateTime? approvalDate;
  Group? pinnedGroup;
  User userInfo;
  Transaction({
    required this.id,
    required this.createdAt,
    required this.transactionNumber,
    required this.transactionType,
    required this.status,
    required this.amount,
    required this.fee,
    required this.netAmount,
    required this.txId,
    required this.sentAddress,
    required this.receivingAddress,
    this.description,
    this.approvalDate,
    this.pinnedGroup,
    required this.userInfo,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt.millisecondsSinceEpoch,
      'transaction_number': transactionNumber,
      'transaction_type': transactionType,
      'status': status,
      'amount': amount,
      'fee': fee,
      'net_amount': netAmount,
      'txID': txId,
      'sent_address': sentAddress,
      'receiving_address': receivingAddress,
      'description': description,
      'approval_date': approvalDate?.millisecondsSinceEpoch,
      'pinned_group': pinnedGroup?.toMap(),
      'user': userInfo.toMap()
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
        id: map['id'] as int,
        createdAt: DateTime.parse(map['created_at']),
        transactionNumber: map['transaction_number'] as String,
        transactionType: map['transaction_type'] as String,
        status: map['status'] as String,
        amount: double.parse(map['amount']),
        fee: double.parse(map['fee']),
        netAmount: double.parse(map['net_amount']),
        txId: map['txID'] as String,
        sentAddress: map['sent_address'] as String,
        receivingAddress: map['receiving_address'] as String,
        description:
            map['description'] != null ? map['description'] as String : null,
        approvalDate: map['approval_date'] != null
            ? DateTime.parse(map['approval_date'])
            : null,
        pinnedGroup: map['pinned_group'] == null
            ? null
            : Group.fromMap(map['pinned_group']),
        userInfo: User.fromMap(map['user']));
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
