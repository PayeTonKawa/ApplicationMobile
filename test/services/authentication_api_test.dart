import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:paye_ton_kawa/services/authentication_api.dart';

import 'authentication_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String uri = 'https://revendeur.api.tauzin.dev/api/sessions';

  Map<String, String> headers = {
    'Content-Type': 'application/json'
  };

  var body = json.encode({'email': 'test@gmail.com'});

  setUpAll(() {
    FlutterSecureStorage.setMockInitialValues({'email': 'test@gmail.com'});
  });

  group('Authentication API tests', () {
    final authenticationApi = AuthenticationApi();
    authenticationApi.client = MockClient();

    test('should return true if the http call completes successfully for new user', () async {
      const String jsonString = """
      {
        "code": 200,
        "data": {
            "message": "test",
            "emailSent": true
        }
      }
      """;

      when(authenticationApi.client.post(Uri.parse(uri), headers: headers, body: body))
        .thenAnswer((_) async => http.Response(jsonString, 200));

      final result = await authenticationApi.sendUserRegistration();
      expect(result, true);
      verify(authenticationApi.client.post(Uri.parse(uri), headers: headers, body: body));
    });

    test('should return false if the http call completes successfully for existing user', () async {
      const String jsonString = """
      {
        "code": 200,
        "data": {
            "jwt": "test",
            "emailSent": false
        }
      }
      """;

      when(authenticationApi.client.post(Uri.parse(uri), headers: headers, body: body))
        .thenAnswer((_) async => http.Response(jsonString, 200));

      final result = await authenticationApi.sendUserRegistration();
      expect(result, false);
      verify(authenticationApi.client.post(Uri.parse(uri), headers: headers, body: body));
    });

    test('throws an exception if the http call completes with an error', () async {

      when(authenticationApi.client.post(Uri.parse(uri), headers: headers, body: body))
        .thenAnswer((_) async => http.Response('Failed to register user', 404));

      try {
        await authenticationApi.sendUserRegistration();
      }
      catch (e) {
        expect(e, isA<Exception>());
      }
      verify(authenticationApi.client.post(Uri.parse(uri), headers: headers, body: body)).called(1);
    });
  });
}