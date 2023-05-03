import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  final String _keyEmailAddress = 'email';
  final String _keyToken = 'token';

  Future setEmailAddress(String emailAddress) async {
    await _storage.write(key: _keyEmailAddress, value: emailAddress);
  }

  Future<String?> getEmailAddress() async {
    return await _storage.read(key: _keyEmailAddress);
  }

  Future setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }
}