import 'package:http/http.dart';
import 'package:ttpay/helper/const.dart';

class TransactionServices {
  final client = Client();

  Future<Response> getAllTransaction({required String token}) {
    return client.get(Uri.parse('$apiAddress/transaction'),
        headers: {'Authorization': 'Bearer $token'});
  }
}
