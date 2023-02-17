import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ApiService {
  static const String baseURL = "https://fakestoreapi.com";

  static const headers = {'Content-type': 'application/json'};

  Future<List<Product>> getAllProducts() async {
    return http
        .get(Uri.parse('$baseURL/products'), headers: headers)
        .then((data) {
      final products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var product in jsonData) {
          products.add(Product.fromJson(product));
        }
      }
      return products;
    }).catchError((err) => debugPrint(err));
  }

  Future<Product?> getProduct(int id) {
    return http
        .get(Uri.parse('$baseURL/products/$id'), headers: headers)
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Product.fromJson(jsonData);
      }
      return null;
    }).catchError((err) => debugPrint(err));
  }

  Future<List<Product>> getProductsByCategory(String categoryName) {
    return http
        .get(Uri.parse('$baseURL/products/category/$categoryName'),
            headers: headers)
        .then((data) {
      final products = <Product>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        for (var product in jsonData) {
          products.add(Product.fromJson(product));
        }
      }
      return products;
    }).catchError((err) => debugPrint(err));
  }

//   Future<CartsModel?> getCart(String id) {
//     return http
//         .get(Uri.parse('$baseURL/carts/$id'), headers: headers)
//         .then((data) {
//       if (data.statusCode == 200) {
//         final jsonData = json.decode(data.body);
//         return CartsModel.fromJson(jsonData);
//       }
//       return null;
//     }).catchError((err) => debugPrint(err));
//   }

//   Future<void> updateCart(int cartId, int productId) {
//     final cartUpdate =
//         CartUpdate(userId: cartId, date: DateTime.now(), products: [
//       {'productId': productId, 'quantity': 1}
//     ]);
//     return http
//         .put(Uri.parse('$baseURL/carts/$cartId'),
//             body: json.encode(cartUpdate.toJson()), headers: headers)
//         .then((data) {
//       if (data.statusCode == 200) {
//         final jsonData = json.decode(data.body);
//         debugPrint(jsonData);
//       }
//     }).catchError((err) => debugPrint(err));
//   }

//   Future<void> deleteCart(String cartId) {
//     return http
//         .delete(Uri.parse('$baseURL/carts/$cartId'), headers: headers)
//         .then((data) {
//       if (data.statusCode == 200) {
//         final jsonData = json.decode(data.body);
//         debugPrint(jsonData);
//       }
//     }).catchError((err) => debugPrint(err));
//   }
}
