import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/product/product_model.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    if (response.statusCode == 200) {
      final List<dynamic> result = jsonDecode(response.body);
      return result.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch products");
    }
  }
}
