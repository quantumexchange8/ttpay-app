import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/models/user.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rxn<User> user = Rxn<User>();
  RxList<User> accountList = List<User>.empty(growable: true).obs;

  Future<String?> getUser() async {
    try {
      final String response =
          await rootBundle.loadString('assets/dummy_data/user.json');

      user.value = User.fromJson(response);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getAllAccounts() async {
    try {
      final String response =
          await rootBundle.loadString('assets/dummy_data/accounts.json');

      accountList.value = listUserFromJson(response);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
