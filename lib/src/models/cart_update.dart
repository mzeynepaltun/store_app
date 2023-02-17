// import 'package:store_app/src/models/cart_model.dart';

// class CartUpdate {
//   int id;
//   int userId;
//   DateTime date;
//   List<Product> products;

//   CartUpdate({
//     required this.id,
//     required this.userId,
//     required this.date,
//     required this.products,
//   })

//   factory CartUpdate.fromJson(Map<String, dynamic> json) {
//   return CartUpdate(
//         id: json["id"],
//         userId: json["userId"],
//         date: DateTime.parse(json["date"]),
//         products: List<Product>.from(
//             json["products"].map((x) => Product.fromJson(x))),
//       );}

//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'date': date,
//       'products': products
//     };
//   }
// }
