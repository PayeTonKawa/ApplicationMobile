import 'dart:convert';

import 'package:paye_ton_kawa/services/secure_storage.dart';

import '../entities/product.dart';
import '../entities/product_details.dart';

import 'package:http/http.dart' as http;

class ProductsApi {
  http.Client client = http.Client();
  
  final String uri = 'https://revendeur.api.tauzin.dev/api/products';

  final SecureStorage _secureStorage = SecureStorage();

  Future<List<Product>> getProductsList() async {
    List<Product> productList = [];

    String token = await _secureStorage.getToken() ?? '';

    Map<String, String> headers = {
      'auth-token': token,
    };

    var response = await client.get(Uri.parse(uri), headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      for (var product in data) {
        Product pdt = Product(
          id: product["id"], 
          createdDate: product["createdAt"], 
          name: product["name"], 
          stock: product["stock"], 
          details: ProductDetails(
            price: product["details"]["price"], 
            description: product["details"]["description"], 
            color: product["details"]["color"],
          ),
        );
        productList.add(pdt);
      }
      return productList;
    }
    else {
      throw Exception('Failed to load products');
    }
  }
}