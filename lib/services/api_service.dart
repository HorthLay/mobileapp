import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vireakrothmobile/model/category.dart';
import 'package:vireakrothmobile/model/categoryproduct_show.dart';
import 'package:vireakrothmobile/model/product_model.dart';

class ApiService {
  static const String baseUrl = "https://wtd.qpz.temporary.site/api";

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

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      // Try to parse error response
      try {
        final body = jsonDecode(response.body);

        // API error format might differ, adapt this accordingly
        if (body is Map<String, dynamic>) {
          if (body.containsKey('errors')) {
            // Laravel style validation errors
            final errors = body['errors'];
            final errorMessages = errors.values
                .expand((list) => (list as List).map((e) => e.toString()))
                .join('\n');
            return {"error": true, "message": errorMessages};
          }
          return {"error": true, "message": body["message"] ?? "Registration failed"};
        } else {
          return {"error": true, "message": "Registration failed"};
        }
      } catch (e) {
        throw Exception("Registration failed with status ${response.statusCode}");
      }
    }
  }






  static Future<void> logout(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode != 200) {
        print("Logout failed on server: ${response.body}");
      }
    } catch (e) {
      print("API logout error: $e");
    }
  }

  static Future<Map<String, dynamic>> checkTokenValidity(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/check-token'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Token is invalid or expired");
    }
  }

  static Future<List<Product>> fetchProductsByCategoryApi(int categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl/categories/$categoryId'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);

      if (jsonBody['data'] is List) {
        final List data = jsonBody['data'];
        return data.map((json) => Product.fromJson(json)).toList();
      } else if (jsonBody['data'] is Map && jsonBody['data']['products'] != null) {
        final List data = jsonBody['data']['products'];
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } else {
      throw Exception('Failed to load products (Status: ${response.statusCode})');
    }
  }



  static Future<List<Category>> getCategories() async {
    // Simulate fetching categories from an API
    final response = await http.get(Uri.parse('$baseUrl/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

}
