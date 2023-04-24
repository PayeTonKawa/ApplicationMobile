import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:paye_ton_kawa/secure_storage.dart';

class AuthenticationApi {

  final String uri = '';
  final SecureStorage _secureStorage = SecureStorage();

  Future<bool> sendUserRegistration(String email) async {

    var headers = {
      'Content-Type': 'text/plain'
    };
    
    var request = http.Request('POST', Uri.parse(uri));
    request.headers.addAll(headers);
    request.body = email;
    
    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }
    else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future<String> getToken() async {

    String email = await _secureStorage.getEmailAdress() ?? '';

    var response = await http.get(Uri.parse('$uri?email=$email'));

    if (response.statusCode == 200) {
      return response.body;
    }
    else {
      print(response.reasonPhrase);
      return '';
    }
  }
}