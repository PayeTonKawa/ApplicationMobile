import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paye_ton_kawa/services/products_api.dart';
import 'package:paye_ton_kawa/views/products_list.dart';
import 'package:http/http.dart' as http;

import 'products_list_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String uri = 'https://webshop.api.tauzin.dev/api/products';

  const Map<String,String> headers = {
    'X-AUTH-TOKEN': 'NTRmZ2psNjhkNWc4NWo0ZzY4',
  };

  const String jsonString = """
  {
    "code": 200,
    "data": [
      {
        "createdAt": "2023-02-20T09:57:59.008Z",
        "name": "Café test",
        "details": {
            "price": "80.00",
            "description": "The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J",
            "color": "indigo"
        },
        "stock": 0,
        "id": "3"
      },
      {
        "createdAt": "2023-02-20T09:57:59.008Z",
        "name": "Café test",
        "details": {
            "price": "80.00",
            "description": "The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J",
            "color": "indigo"
        },
        "stock": 0,
        "id": "3"
      }
    ]
  }
  """;

  setUpAll(() {
    FlutterSecureStorage.setMockInitialValues({'token': 'test'});
  });

  group('ProductsList view test', () {
    final productsApi = ProductsApi();
    productsApi.client = MockClient();
    
    testWidgets('should find ProductsList and CircularProgressIndicator', (tester) async {
      
      when(productsApi.client.get(Uri.parse(uri), headers: headers))
        .thenAnswer((_) async => http.Response(jsonString, 200));

      await productsApi.getProductsList();

      await tester.pumpWidget(const MaterialApp(home: ProductsList()));
      
      final productsList = find.byType(ProductsList);
      expect(productsList, findsOneWidget);

      verify(productsApi.client.get(Uri.parse(uri), headers: headers)).called(1);

      final circularProgressIndicator = find.byType(CircularProgressIndicator);
      expect(circularProgressIndicator, findsOneWidget);
    });
  });
}