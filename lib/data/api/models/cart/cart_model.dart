import 'package:miniproject3/data/api/models/cart/quantity_cart_model.dart';

class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<ProductQuantity> products;

  const Cart(
      {required this.id,
      required this.userId,
      required this.date,
      required this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      products: (json['products'] as List)
          .map((productJson) => ProductQuantity.fromJson(productJson))
          .toList(),
    );
  }
}
