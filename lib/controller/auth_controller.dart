// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttpay/component/top_snackbar.dart';
import 'package:ttpay/controller/controller.dart';
import 'package:ttpay/services/auth_services.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final authServices = AuthServices();

  Future<bool> login(
    BuildContext context, {
    required String userId,
    required String password,
  }) async {
    try {
      final response =
          await authServices.login(userId: userId, password: password);

      if (response.statusCode != 200) {
        showToastNotification(context,
            title: 'Error ${response.statusCode}', type: 'error');
        return false;
      }
      final data = jsonDecode(response.body);
      if (data['status'] != 'loggedin') {
        showToastNotification(context,
            title: data['message'].toString(), type: 'error');
        return false;
      }
      tokenController.storeToken(data['token'].toString().split('|').last);
      return true;
    } catch (e) {
      showToastNotification(context,
          title: 'Error', description: e.toString(), type: 'error');
      return false;
    }
  }

  Future<bool> logout(
    BuildContext context, {
    required String token,
  }) async {
    try {
      final response = await authServices.logout(token: token);

      if (response.statusCode != 200) {
        showToastNotification(context,
            title: 'Error ${response.statusCode}', type: 'error');
        return false;
      }
      final data = jsonDecode(response.body);
      if (data['status'] != 'success') {
        showToastNotification(context,
            title: data['message'].toString(), type: 'error');
        return false;
      }
      await tokenController.clearToken();
      return true;
    } catch (e) {
      showToastNotification(context,
          title: 'Error', description: e.toString(), type: 'error');
      return false;
    }
  }
}
