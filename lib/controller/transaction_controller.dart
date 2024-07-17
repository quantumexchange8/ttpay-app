import 'package:get/get.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/services/transaction_services.dart';

class TransactionController extends GetxController {
  static TransactionController instance = Get.find();
  final transactionServices = TransactionServices();
  RxList<Transaction> transactionList =
      List<Transaction>.empty(growable: true).obs;

  Future<String?> getAllTransaction(String token) async {
    try {
      final response =
          await transactionServices.getAllTransaction(token: token);
      if (response.statusCode != 200) {
        return 'Error: ${response.statusCode}';
      }
      transactionList.value = listTransactionFromJson(response.body);
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
