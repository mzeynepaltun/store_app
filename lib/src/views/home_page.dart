import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/src/manager/cart_manager.dart';
import 'products_all.dart';
import 'products_category.dart';
import '../../app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: beige,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.shopping_basket_outlined,
                  color: beige,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/cart");
                }),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: beige,
                  ),
                  onPressed: () {
                    CartManager().clearCart();
                  })
            ],
            title: Text(
              "Welcome",
              style: GoogleFonts.poppins(color: beige),
            ),
            backgroundColor: raspberry,
            bottom: TabBar(indicatorColor: latte, tabs: [
              Tab(icon: Icon(Icons.all_inclusive, color: beige), text: "All"),
              Tab(icon: Icon(Icons.woman_2, color: beige), text: "Women"),
              Tab(icon: Icon(Icons.man_2, color: beige), text: "Men"),
              Tab(
                  icon: Icon(Icons.diamond_outlined, color: beige),
                  text: "Jewelery"),
              Tab(
                  icon: Icon(Icons.headphones, color: beige),
                  text: "Electronics"),
            ]),
          ),
          body: const TabBarView(children: [
            AllProducts(),
            ProductsByCategories(categoryName: "women's clothing"),
            ProductsByCategories(categoryName: "men's clothing"),
            ProductsByCategories(categoryName: "jewelery"),
            ProductsByCategories(categoryName: "electronics"),
          ]),
        ));
  }
}
