import 'package:equatable/equatable.dart';

import 'product_details.dart';

class Product extends Equatable {
  final String id;
  final String createdDate;
  final String name;
  final int stock;
  final ProductDetails details;

  const Product({
    required this.id,
    required this.createdDate,
    required this.name,
    required this.stock,
    required this.details,
  });
  
  @override
  List<Object?> get props => [id, createdDate, name, stock, details];
}