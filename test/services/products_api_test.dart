import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;
import 'package:paye_ton_kawa/entities/product.dart';
import 'package:paye_ton_kawa/entities/product_details.dart';
import 'package:paye_ton_kawa/services/products_api.dart';

import 'products_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const String uri = 'https://revendeur.api.tauzin.dev/api/products';

  const Map<String,String> headers = {
    'auth-token': 'test',
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
      }
    ]
  }
  """;

  final productsList = [
    const Product(
      id: "3", 
      createdDate: "2023-02-20T09:57:59.008Z", 
      name: "Café test", 
      stock: 0, 
      details: ProductDetails(
        price: "80.00",
        description: "The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J",
        color: "indigo",
      ),
    ),
  ];

  setUpAll(() {
    FlutterSecureStorage.setMockInitialValues({'token': 'test'});
  });

  group('ProductsList API tests', () {
    final productsApi = ProductsApi();
    productsApi.client = MockClient();

    test('should return a list of Products if the http call completes successfully', () async {
      when(productsApi.client.get(Uri.parse(uri), headers: headers))
        .thenAnswer((_) async => http.Response(jsonString, 200));

      final result = await productsApi.getProductsList();
      expect(result, equals(productsList));
      verify(productsApi.client.get(Uri.parse(uri), headers: headers)).called(1);
    });

    test('throws an exception if the http call completes with an error', () async {
      when(productsApi.client.get(Uri.parse(uri), headers: headers))
        .thenAnswer((_) async => http.Response('Failed to load products', 404));

      try {
        await productsApi.getProductsList();
      }
      catch (e) {
        expect(e, isA<Exception>());
      }
      verify(productsApi.client.get(Uri.parse(uri), headers: headers)).called(1);
    });
  });
}