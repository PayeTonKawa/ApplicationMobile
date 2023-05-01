import 'dart:convert';

import '../entities/product.dart';
import '../entities/product_details.dart';

import 'package:http/http.dart' as http;

class ProductsApi {
  http.Client client = http.Client();
  final String uri = 'https://615f5fb4f7254d0017068109.mockapi.io/api/v1/products';

  Future<List<Product>> getProductsList() async {
    List<Product> productList = [];
    var response = await client.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
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