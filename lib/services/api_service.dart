import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api"; // 🔴 Localhost for Android Emulator

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
}
