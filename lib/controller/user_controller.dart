// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ttpay/models/user.dart';
import 'package:ttpay/services/profile_services.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final userServices = ProfileServices();
  Rxn<User> user = Rxn<User>();
  RxList<User> accountList = List<User>.empty(growable: true).obs;

  Future<String?> getUser({required String token}) async {
    try {
      final response = await userServices.getProfile(token: token);
      if (response.statusCode != 200) {
        return 'Error ${response.statusCode}';
      }
      user.value = User.fromMap(jsonDecode(response.body)['merchant']);
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
