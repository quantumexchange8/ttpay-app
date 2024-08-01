// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/models/merchant_wallet.dart';
import 'package:ttpay/models/user.dart';
import 'package:ttpay/services/profile_services.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  final userServices = ProfileServices();
  Rxn<User> user = Rxn<User>();
  RxList<User> accountList = List<User>.empty(growable: true).obs;
  Rxn<MerchantWallet> merchantWallet = Rxn<MerchantWallet>();

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

  Future<bool> updateProfilePhoto(BuildContext context,
      {required String token, required File file}) async {
    try {
      final response =
          await userServices.updateProfilePicture(token: token, file: file);
      if (response.statusCode != 200) {
        if (context.mounted) {
          showToastNotification(context,
              title: 'Error ${response.statusCode}', type: 'error');
        }
        return false;
      }
      Map<String, dynamic> data = jsonDecode(response.body);
      if (!data['message'].toString().contains('success')) {
        if (context.mounted) {
          showToastNotification(context,
              title: 'Error',
              description: data['message'].toString(),
              type: 'error');
        }
        return false;
      }
      await getCurrentUser(token: token);
      await getAllAccounts();
      return true;
    } catch (e) {
      if (context.mounted) {
        showToastNotification(context,
            title: 'Error', description: e.toString(), type: 'error');
      }
      return false;
    }
  }

  Future<String?> getAllAccounts() async {
    try {
      await tokenController.getAllToken();
      accountList.clear();
      for (var i = 0; i < tokenController.tokenList.length; i++) {
        final token = tokenController.tokenList[i];
        final account = await getUser(token: token);
        if (account != null) {
          accountList.add(account);
        }
      }

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getMerchantWallet({required String token}) async {
    try {
      final response = await userServices.getMerchantWallet(token: token);
      if (response.statusCode != 200) {
        return 'Error ${response.statusCode}';
      }
      merchantWallet.value = MerchantWallet.fromJson(response.body);
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}
