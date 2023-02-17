import 'package:flutter/material.dart';
import 'package:store_app/app_colors.dart';
import 'package:store_app/src/manager/cart_manager.dart';
import 'package:store_app/src/services/api_service.dart';
import '../models/product_model.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: beige,
          body: Center(
            child: FutureBuilder(
                future: ApiService().getAllProducts(),
                builder: ((context, AsyncSnapshot<List<Product>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(color: raspberry);
                  }
                  final products = snapshot.data!;
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 1),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return ListTile(
                        title: Text(product.title),
                        leading: Image.network(
                          product.image,
                          height: 50,
                          width: 50,
                        ),
                        subtitle: Text("\$${product.price}"),
                        onTap: () {
                          CartManager().addToCart(product);
                        },
                      );
                    },
                  );
                })),
          )),
    );
  }
}
