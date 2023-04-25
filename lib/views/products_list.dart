import 'package:flutter/material.dart';
import 'package:paye_ton_kawa/services/products_api.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';
import 'package:paye_ton_kawa/widgets/custom_appBar.dart';

import '../entities/product.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  Future<List<Product>> fetchProductsList() async {
    return await ProductsApi().getProducts();
  }

  Widget _listView() {
    final Future<List<Product>> productsList = fetchProductsList();

    double heigth = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
      future: productsList,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder:(context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: SizedBox(
                  height: heigth * 0.1,
                  child: Card(
                    //color: snapshot.data![index].details.color,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data![index].name.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Center(
          child: CircularProgressIndicator(
            color: CustomColors.gold,
          ),
        );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Liste des produits"),
      body: _listView(),
    );
  }
}