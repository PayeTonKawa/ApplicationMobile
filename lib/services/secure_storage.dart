import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {

  final FlutterSecureStorage storage;

  final String _keyEmailAddress = 'email';
  final String _keyToken = 'token';

  SecureStorage({FlutterSecureStorage? storage})
      : storage = storage ?? const FlutterSecureStorage();

  Future setEmailAddress(String emailAddress) async {
    await storage.write(key: _keyEmailAddress, value: emailAddress);
  }

  Future<String?> getEmailAddress() async {
    return await storage.read(key: _keyEmailAddress);
  }

  Future setToken(String token) async {
    await storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: _keyToken);
  }
}