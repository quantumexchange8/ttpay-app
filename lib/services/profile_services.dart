import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:ttpay/helper/const.dart';
import 'package:path/path.dart';

class ProfileServices {
  final client = http.Client();

  Future<http.Response> getProfile({
    required String token,
  }) async {
    return await client.get(Uri.parse('$apiAddress/merchant'),
        headers: {'Authorization': 'Bearer $token'});
  }

  Future<http.Response> updateProfilePicture({
    required String token,
    required File file,
  }) async {
    // Create a multipart request
    var request =
        http.MultipartRequest('POST', Uri.parse('$apiAddress/profile'));

    request.headers.addAll({'Authorization': 'Bearer $token'});
    // Add the file to the request
    request.files.add(
      await http.MultipartFile.fromPath('profile_photo', file.path,
          filename: basename(file.path)),
    );

    return await http.Response.fromStream(await request.send());
  }

  Future<http.Response> getMerchantWallet({
    required String token,
  }) async {
    return await client.get(Uri.parse('$apiAddress/merchant_wallet'),
        headers: {'Authorization': 'Bearer $token'});
  }
}
