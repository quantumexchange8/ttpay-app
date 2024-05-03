import 'dart:convert';

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
  Transaction({
    required this.id,
    required this.createdAt,
    required this.transactionNumber,
    required this.transactionType,
    required this.status,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt,
      'transaction_number': transactionNumber,
      'transaction_type': transactionType,
      'status': status,
      'amount': amount,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at']),
      transactionNumber: map['transaction_number'] as String,
      transactionType: map['transaction_type'] as String,
      status: map['status'] as String,
      amount: double.parse(map['amount'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
