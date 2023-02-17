import 'package:flutter/material.dart';
import 'package:store_app/src/manager/cart_manager.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartElement> cartElements;

  @override
  void initState() {
    super.initState();
    updateElement();
  }

  void updateElement() {
    CartManager().getCartElements().then((value) {
      setState(() {
        cartElements = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: cartElements.length,
        itemBuilder: (_, i) {
          return ListTile(
            title: Text(cartElements[i].product.title),
            leading: Image.network(
              cartElements[i].product.image,
              height: 50,
              width: 50,
            ),
            trailing: Text("\$${cartElements[i].price.toStringAsFixed(3)}"),
            subtitle: Row(
              children: [
                IconButton(
                    onPressed: () async {
                      await CartManager()
                          .removeFromCart(cartElements[i].product);
                      updateElement();
                    },
                    icon: const Icon(Icons.remove)),
                Text("${cartElements[i].quantity}"),
                IconButton(
                    onPressed: () async {
                      await CartManager().addToCart(cartElements[i].product);
                      updateElement();
                    },
                    icon: const Icon(Icons.add)),
              ],
            ),
            onTap: () {
              CartManager().addToCart(cartElements[i].product);
            },
          );
        },
      ),
    );
  }
}
