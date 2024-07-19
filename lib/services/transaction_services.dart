import 'package:http/http.dart';
import 'package:ttpay/helper/const.dart';

class TransactionServices {
  final client = Client();

  Future<Response> getAllTransaction({required String token}) {
    return client.get(Uri.parse('$apiAddress/transaction'),
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<Response> withdrawAmount(
      {required String token,
      required String amount,
      required String usdtAddress,
      required String password}) {
    return client.post(Uri.parse('$apiAddress/withdrawal'), headers: {
      'Authorization': 'Bearer $token'
    }, body: {
      "withdraw_amount": amount,
      "usdt_address": usdtAddress,
      "password": password,
    });
  }
}
