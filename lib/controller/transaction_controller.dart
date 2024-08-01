import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/models/transaction.dart';
import 'package:ttpay/models/withdraw_response.dart';
import 'package:ttpay/services/transaction_services.dart';

class TransactionController extends GetxController {
  static TransactionController instance = Get.find();
  final transactionServices = TransactionServices();
  RxList<Transaction> transactionList =
      List<Transaction>.empty(growable: true).obs;
  RxDouble feeChargePercentage = RxDouble(0.0);
  Rxn<WithdrawResponse> withdrawResponse = Rxn<WithdrawResponse>();

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

  Future<WithdrawResponse?> withdrawAmount(BuildContext context,
      {required String token,
      required String amount,
      required String usdtAddress,
      required String password}) async {
    try {
      final response = await transactionServices.withdrawAmount(
          token: token,
          amount: amount,
          usdtAddress: usdtAddress,
          password: password);
      if (response.statusCode != 200) {
        if (context.mounted) {
          showToastNotification(context,
              title: 'Error ${response.statusCode}', type: 'error');
        }
        return null;
      }
      await userController.getMerchantWallet(token: token);
      await getAllTransaction(token);
      return WithdrawResponse.fromJson(response.body);
    } catch (e) {
      if (context.mounted) {
        showToastNotification(context,
            title: 'Error', description: e.toString(), type: 'error');
      }
      return null;
    }
  }
}
