import 'dart:convert';
import 'dart:developer';

import '../entities/product.dart';
import '../entities/product_details.dart';

import 'package:http/http.dart' as http;

class ProductsApi {
  final String uri = 'https://615f5fb4f7254d0017068109.mockapi.io/api/v1/products';

  Future<List<Product>> getProductsList() async {
    List<Product> productList = [];
    
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
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
      log(response.reasonPhrase.toString());
      return productList;
    }
  }
}