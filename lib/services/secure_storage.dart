import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  final String _keyEmailAdress = 'email';
  final String _keyToken = 'token';

  Future setEmailAdress(String emailAdress) async {
    await storage.write(key: _keyEmailAdress, value: emailAdress);
  }

  Future<String?> getEmailAdress() async {
    return await storage.read(key: _keyEmailAdress);
  }

  Future setToken(String token) async {
    await storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _keyToken);
  }
}