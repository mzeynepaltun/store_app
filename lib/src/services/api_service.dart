import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ApiService {
  static const String baseURL = "https://fakestoreapi.com";

  static const headers = {'Content-type': 'application/json'};

  Future<List<Product>>? getAllProducts() async {
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
    });
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
    });
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
    });
  }
}
