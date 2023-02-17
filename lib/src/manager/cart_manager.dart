import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:store_app/src/models/product_model.dart';

class CartElement {
  final Product product;
  int quantity;

  CartElement(this.product, this.quantity);

  double get price => product.price * quantity;
}

class CartManager {
  late Box productBox;
  late Box quantityBox;

  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;

  CartManager._internal();

  Future<void> init() async {
    productBox = await Hive.openBox('productBox');
    quantityBox = await Hive.openBox('quantityBox');
  }

  Future<void> addToCart(Product product) async {
    if (productBox.containsKey(product.id)) {
      await quantityBox.put(product.id, quantityBox.get(product.id)! + 1);
    } else {
      await productBox.put(product.id, jsonEncode(product.toJson()));
      await quantityBox.put(product.id, 1);
    }
  }

  Future<void> removeFromCart(Product product) async {
    if (productBox.containsKey(product.id)) {
      if (quantityBox.get(product.id) == 1) {
        await productBox.delete(product.id);
        await quantityBox.delete(product.id);
      } else {
        quantityBox.put(product.id, quantityBox.get(product.id)! - 1);
      }
    }
  }

  Future<List<CartElement>> getCartElements() async {
    final cartproductBox = <CartElement>[];

    for (var key in productBox.keys) {
      final product =
          Product.fromJson(jsonDecode(productBox.get(key) as String));
      final quantity = quantityBox.get(key) as int;
      cartproductBox.add(CartElement(product, quantity));
    }

    return cartproductBox;
  }

  Future<void> clearCart() async {
    for (var key in productBox.keys) {
      productBox.delete(key);
      quantityBox.delete(key);
    }
  }

  Future<int> getCartCount() async {
    var count = 0;

    for (var key in productBox.keys) {
      count += quantityBox.get(key) as int;
    }

    return count;
  }

  Future<double> getCartTotal() async {
    var total = 0.0;

    for (var key in productBox.keys) {
      final product =
          Product.fromJson(jsonDecode(productBox.get(key) as String));
      final quantity = quantityBox.get(key) as int;
      total += product.price * quantity;
    }

    return total;
  }

  CartElement getCartElement(int id) {
    final product = Product.fromJson(jsonDecode(productBox.get(id) as String));
    final quantity = quantityBox.get(id) as int;
    return CartElement(product, quantity);
  }
}
