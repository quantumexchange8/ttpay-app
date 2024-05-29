import 'package:http/http.dart' as http;
import 'package:ttpay/helper/const.dart';

class AuthServices {
  final client = http.Client();

  Future<http.Response> login({
    required String userId,
    required String password,
  }) {
    return client.post(
      Uri.parse('$apiAddress/login'),
      body: {'role_id': userId, 'password': password},
    );
  }

  Future<http.Response> logout({
    required String token,
  }) {
    return client.post(Uri.parse('$apiAddress/logout'),
        headers: {'Authorization': 'Bearer $token'});
  }
}
