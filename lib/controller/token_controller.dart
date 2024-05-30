import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class TokenController extends GetxController {
  static TokenController instance = Get.find();
  final storage = const FlutterSecureStorage();
  RxList tokenList = List<String>.empty(growable: true).obs;
  String currentKey = 'login_token_0';
  String currentToken = '';

  Future<void> storeToken(String newToken) async {
    await storage.write(
        key: 'login_token_${(tokenList.length)}', value: newToken);
    tokenList.add(newToken);
    await storage.write(
        key: 'token_list_length', value: tokenList.length.toString());
    return;
  }

  Future<void> getAllToken() async {
    await storage
        .read(key: 'token_list_length')
        .then((tokenListLengthString) async {
      if (tokenListLengthString != null) {
        final tokenListLength = int.parse(tokenListLengthString);
        if (tokenListLength != 0) {
          tokenList.clear();
          for (var i = 0; i < tokenListLength; i++) {
            final token = await storage.read(key: 'login_token_$i');
            if (token != null && token.isNotEmpty) {
              tokenList.add(token);
            }
          }
        }
      }
    });
  }

  Future<void> setCurrentToken(String token) async {
    currentToken = token;
    final newKey = 'login_token_${tokenList.indexOf(currentToken)}';
    await storage.write(key: 'current_token_key', value: newKey);
    currentKey = newKey;
    return;
  }

  Future<void> getCurrentKeyToken() async {
    final tokenKey = await storage.read(key: 'current_token_key');
    if (tokenKey != null) {
      final token = await storage.read(key: tokenKey);
      currentToken = token ?? '';
    }
    return;
  }

  Future<void> clearCurrentToken() async {
    int currentTokenIndex = tokenList.indexOf(currentToken);
    int newTokenIndex = currentTokenIndex > 0 ? currentTokenIndex - 1 : 0;
    tokenList.removeAt(currentTokenIndex);
    await storage.write(
        key: 'token_list_length', value: tokenList.length.toString());
    currentToken = tokenList.isEmpty ? '' : tokenList[newTokenIndex];
    await storage.delete(key: currentKey);
    final newKey = 'login_token_$newTokenIndex';
    await storage.write(key: 'current_token_key', value: newKey);
    currentKey = newKey;

    return;
  }

  Future<void> deleteToken(String token) async {
    await storage.delete(key: 'login_token_${tokenList.indexOf(token)}');
    tokenList.remove(token);
    await storage.write(
        key: 'token_list_length', value: tokenList.length.toString());
  }
}
