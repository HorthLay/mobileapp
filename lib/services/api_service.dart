import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vireakrothmobile/model/product_model.dart';

class ApiService {
    static const String baseUrl = "https://wtd.qpz.temporary.site/api"; // 🔴 Localhost for Android Emulator

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Login failed");
    }
  }

  static Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // Send the user's token for authentication
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Logout failed");
    }
  }

  // New method to check token validity
  static Future<Map<String, dynamic>> checkTokenValidity(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/check-token'), // Assuming you have this route in your API
      headers: {
        "Authorization": "Bearer $token", // Send the user's token for validation
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return the response body if token is valid
    } else {
      throw Exception("Token is invalid or expired");
    }
  }

  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: {
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
