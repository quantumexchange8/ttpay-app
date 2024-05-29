import 'package:http/http.dart' as http;
import 'package:ttpay/helper/const.dart';

class ProfileServices {
  final client = http.Client();

  Future<http.Response> getProfile({
    required String token,
  }) {
    return client.get(Uri.parse('$apiAddress/merchant'),
        headers: {'Authorization': 'Bearer $token'});
  }
}
