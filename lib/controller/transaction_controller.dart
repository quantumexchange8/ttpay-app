import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/models/transaction.dart';

class TransactionController extends GetxController {
  static TransactionController instance = Get.find();
  RxList<Transaction> transactionList =
      List<Transaction>.empty(growable: true).obs;

  Future<String?> getAllTransaction() async {
    try {
      final String response =
          await rootBundle.loadString('assets/dummy_data/transactions.json');

      transactionList.value = listTransactionFromJson(response);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void updateTransaction(
      {required int id, required Transaction newTransaction}) {
    for (var i = 0; i < transactionList.length; i++) {
      if (transactionList[i].id == id) {
        transactionList[i] = newTransaction;
      }
    }

    return;
  }
}
