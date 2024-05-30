// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:get/get.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/models/user.dart';
import 'package:ttpay/services/profile_services.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final userServices = ProfileServices();
  Rxn<User> user = Rxn<User>();
  RxList<User> accountList = List<User>.empty(growable: true).obs;

  Future<String?> getCurrentUser({required String token}) async {
    try {
      final response = await userServices.getProfile(token: token);
      if (response.statusCode != 200) {
        return 'Error ${response.statusCode}';
      }
      Map<String, dynamic> data = jsonDecode(response.body)['merchant'];
      user.value = User.fromMap(data);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<User?> getUser({required String token}) async {
    try {
      final response = await userServices.getProfile(token: token);
      if (response.statusCode != 200) {
        return null;
      }
      Map<String, dynamic> data = jsonDecode(response.body)['merchant'];
      return User.fromMap(data);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAllAccounts() async {
    try {
      await tokenController.getAllToken();
      accountList.clear();
      for (var i = 0; i < tokenController.tokenList.length; i++) {
        final token = tokenController.tokenList[i];
        final account = await getUser(token: token);
        if (account != null &&
            !accountList.map((element) => element.id).contains(account.id)) {
          accountList.add(account);
        }
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
