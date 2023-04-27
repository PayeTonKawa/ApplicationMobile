import 'product_details.dart';

class Product {
  String id;
  String createdDate;
  String name;
  int stock;
  ProductDetails details;

  Product({
    required this.id,
    required this.createdDate,
    required this.name,
    required this.stock,
    required this.details,
  });
}