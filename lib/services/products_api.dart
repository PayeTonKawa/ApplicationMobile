import 'dart:convert';

import '../entities/product.dart';
import '../entities/product_details.dart';

import 'package:http/http.dart' as http;

class ProductsApi {
  http.Client client = http.Client();
  
  final String uri = 'https://webshop.api.tauzin.dev/api/products';
  //final String uri = 'https://615f5fb4f7254d0017068109.mockapi.io/api/v1/products';

  Future<List<Product>> getProductsList() async {
    List<Product> productList = [];

    var headers = {
      'X-AUTH-TOKEN': 'NTRmZ2psNjhkNWc4NWo0ZzY4',
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