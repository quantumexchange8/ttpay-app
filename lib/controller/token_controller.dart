import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class TokenController extends GetxController {
  static TokenController instance = Get.find();
  final storage = const FlutterSecureStorage();
  static const tokenStorageKey = 'login_token';
  String token = '';

  Future<void> storeToken(String newToken) async {
    token = newToken;
    await storage.write(key: tokenStorageKey, value: newToken);
    return;
  }

  Future<void> getToken() async {
    token = await storage.read(key: tokenStorageKey) ?? '';
    return;
  }

  Future<void> clearToken() async {
    token = '';
    await storage.delete(key: tokenStorageKey);
    return;
  }
}
