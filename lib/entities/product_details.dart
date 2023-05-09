import 'package:equatable/equatable.dart';

class ProductDetails extends Equatable {
  final String price;
  final String description;
  final String color;

  const ProductDetails({
    required this.price,
    required this.description,
    required this.color,
  });
  
  @override
  List<Object?> get props => [price, description, color];
}