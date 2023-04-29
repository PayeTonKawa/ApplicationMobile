import 'package:flutter/material.dart';
import 'package:paye_ton_kawa/services/products_api.dart';
import 'package:paye_ton_kawa/styles/custom_colors.dart';
import 'package:paye_ton_kawa/widgets/custom_app_bar.dart';

import '../entities/product.dart';
import 'product_details_view.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  late final Future<List<Product>> productsList;

  @override
  void initState() {
    super.initState();
    productsList = ProductsApi().getProductsList();
  }

  Widget _listView() {

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
                  child: FloatingActionButton(
                    heroTag: 'Button$index',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: width / 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    snapshot.data![index].name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: CustomColors.gold,
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    snapshot.data![index].details.description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: CustomColors.darkGold,
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (width - 70) / 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${snapshot.data![index].details.price.toString()}€',
                                    style: const TextStyle(
                                      color: CustomColors.gold,
                                      fontFamily: 'Roboto',
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    'Stock : ${snapshot.data![index].stock.toString()}',
                                    style: TextStyle(
                                      color: (snapshot.data![index].stock == 0)
                                        ? Colors.red
                                        : CustomColors.darkGold,
                                      fontFamily: 'Roboto',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: ((context) => ProductDetailsView(product: snapshot.data![index]))));
                    },
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
      appBar: const CustomAppBar(
        title: "Liste des produits",
        isAuthent: true,
      ),
      body: _listView(),
    );
  }
}