import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:paye_ton_kawa/services/secure_storage.dart';

class MockStorage extends Mock implements FlutterSecureStorage{}
void main() {
  final mockStorage = MockStorage();
  final secureStorage = SecureStorage(storage: mockStorage);
  const String email = 'test@gmail.com';
  const String token = '1234';

  group('SecureStorage unit tests', () {
    test('should write emailAddress', () async {
      when(mockStorage.write(key: 'email', value: email))
          .thenAnswer((_) => Future<void>.value());

      await secureStorage.setEmailAddress(email);

      verify(mockStorage.write(key: 'email', value: email)).called(1);
    });

    test('should read emailAddress', () async {
      when(mockStorage.read(key: 'email'))
          .thenAnswer((_) => Future.value());

      await secureStorage.getEmailAddress();

      verify(mockStorage.read(key: 'email')).called(1);
    });

    test('should write token', () async {
      when(mockStorage.write(key: 'token', value: token))
          .thenAnswer((_) => Future<void>.value());

      await secureStorage.setToken(token);

      verify(mockStorage.write(key: 'token', value: token)).called(1);
    });

    test('should read token', () async {
      when(mockStorage.read(key: 'token'))
          .thenAnswer((_) => Future.value());

      await secureStorage.getToken();

      verify(mockStorage.read(key: 'token')).called(1);
    });
  });
}