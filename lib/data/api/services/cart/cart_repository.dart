import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/cart/cart_model.dart';

class CartRepository {
  Future<List<Cart>> getCarts() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/carts"));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Cart.fromJson(e)).toList();
    } else {
      throw Exception("Fetching failed!");
    }
  }
}
