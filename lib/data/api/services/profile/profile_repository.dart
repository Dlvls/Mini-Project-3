import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/profile/profile_model.dart';

class ProfileRepository {
  Future<ProfileModel> getProfile(int userId) async {
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/users/$userId"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return ProfileModel.fromJson(result);
    } else {
      throw Exception("Fetching failed!");
    }
  }
}
