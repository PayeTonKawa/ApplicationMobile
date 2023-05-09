import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:paye_ton_kawa/entities/product.dart';
import 'package:paye_ton_kawa/entities/product_details.dart';
import 'package:paye_ton_kawa/views/product_details_view.dart';

void main() {

  const product =
    Product(
      id: "3", 
      createdDate: "2023-02-20T09:57:59.008Z", 
      name: "Café test", 
      stock: 0, 
      details: ProductDetails(
        price: "80.00",
        description: "The Nagasaki Lander is the trademarked name of several series of Nagasaki sport bikes, that started with the 1984 ABC800J",
        color: "indigo",
      ),
    );
  
  group('ProductDetails view test', () {
    
    testWidgets('should find ProductDetailsView', (tester) async {

      await tester.pumpWidget(const MaterialApp(home: ProductDetailsView(product: product,)));
      
      final productDetailsView = find.byType(ProductDetailsView);
      expect(productDetailsView, findsOneWidget);
    });
  });
}