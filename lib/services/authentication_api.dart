import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paye_ton_kawa/services/secure_storage.dart';

class AuthenticationApi {
  http.Client client = http.Client();

  final String uri = 'https://revendeur.api.tauzin.dev/api/sessions';
  final SecureStorage _secureStorage = SecureStorage();

  Future<bool> sendUserRegistration() async {

    String email = await _secureStorage.getEmailAddress() ?? '';

    Map<String, String> headers = {
      'Content-Type': 'application/json'
    };

    var body = json.encode({"email": email});

    var response = await client.post(Uri.parse(uri), headers: headers, body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      if (data['jwt'] != null) {
        _secureStorage.setToken(data['jwt']);
        return false;
      }

      return true;
    }
    else {
      throw Exception('Failed to register user');
    }
  }
}