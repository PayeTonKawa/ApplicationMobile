import 'package:flutter/material.dart';
import 'package:paye_ton_kawa/entities/product.dart';
import 'package:paye_ton_kawa/styles/custom_circle.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';
import 'package:paye_ton_kawa/widgets/custom_app_bar.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: CustomColors.test,
      appBar: const CustomAppBar(
        title: 'Détails du produit',
        isAuthent: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 42),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              Image.asset(
                'assets/images/coffee_beans_PNG9277.png',
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontFamily: 'Satisfy',
                  fontSize: 32,
                  color: CustomColors.brown
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                widget.product.details.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: CustomColors.brown
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Prix : ${widget.product.details.price}€",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: CustomColors.brown
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Stock : ${widget.product.stock}",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: (widget.product.stock != 0)
                          ? CustomColors.brown
                          : Colors.red
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: width * 0.1,
                  ),
                  const Text(
                    'Couleur du produit : ',
                    style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: CustomColors.brown
                        ),
                  ),
                  CustomPaint(
                    painter: CustomCircle(
                      circleColor: CustomColors.nameToColor[widget.product.details.color]!,
                      horizontalOffset: 30,
                      verticalOffset: 0,
                      circleSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}