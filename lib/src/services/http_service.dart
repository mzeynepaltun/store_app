import 'package:http/http.dart' as http;
import 'package:store_app/src/models/user_model.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class HttpService {
  // static var client = http.Client();

  static Future<List<ProductsModel>> fetchProducts() async {
    var response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      var data = response.body;
      return productsModelFromJson(data);
    } else {
      // throw Exception();
      var data = response.body;
      return productsModelFromJson(data);
    }
  }

  static Future<List<UsersModel>> fetchUsers() async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/users"));
    if (response.statusCode == 200) {
      var data = response.body;
      return usersModelFromJson(data);
    } else {
      // throw Exception();
      var data = response.body;
      return usersModelFromJson(data);
    }
  }

  static Future<List<CartsModel>> fetchCart() async {
    var response = await http.get(Uri.parse("https://fakestoreapi.com/carts"));
    if (response.statusCode == 200) {
      var data = response.body;
      return cartsModelFromJson(data);
    } else {
      // throw Exception();
      var data = response.body;
      return cartsModelFromJson(data);
    }
  }
}
