import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paye_ton_kawa/services/secure_storage.dart';

import 'secure_storage_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late SecureStorage secureStorage;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorage();
  });
  /* test('Secure Storage should set emailAddress', () async {

    when(() => mockFlutterSecureStorage.write(key: 'email', value: '123@test.com'))
      .thenAnswer((_)  => Future<dynamic>.value);

    final emailAddress = await secureStorage.setEmailAddress('123@test.com');
    expect(emailAddress, '123@test.com');
  }); */
}