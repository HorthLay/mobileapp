import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vireakrothmobile/services/api_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var rememberMe = false.obs;
  var username = "".obs;
  var token = "".obs; // Store token in memory

  @override
  void onInit() {
    super.onInit();
    _loadToken(); // Load the token when the app starts
    loadUserData(); // Load the username when the app starts
  }

  // Load the token from SharedPreferences
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('auth_token') ?? ""; // Retrieve saved token
  }

  // Save token to SharedPreferences
  Future<void> _saveToken(String tokenValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', tokenValue); // Save the token
  }

  // Save username to SharedPreferences
  Future<void> _saveUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name); // Save the username
  }

  // Load username from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? '';
  }

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and password cannot be empty",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;
      final response = await ApiService.login(email, password);

      if (response.containsKey("token")) {
        token.value = response["token"]; // Store token in-memory
        username.value = response["user"]["name"];
        await _saveToken(token.value); // Save token to SharedPreferences
        await _saveUsername(username.value); // Save username to SharedPreferences

        Get.snackbar("Success", "Login Successful",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed("/home"); // Navigate to home
      } else {
        Get.snackbar("Error", "Invalid Credentials",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to login",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  bool isLoggedIn() {
    return token.value.isNotEmpty;
  }

  void logout() async {
    try {
      if (token.value.isNotEmpty) {
        await ApiService.logout(token.value); // Call the logout API
        token.value = ""; // Clear the token
        username.value = ""; // Clear the username
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token'); // Remove token from SharedPreferences
        await prefs.remove('username'); // Remove username from SharedPreferences
        Get.offAllNamed("/login"); // Navigate to login screen after logging out
        Get.snackbar("Success", "Logged out successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to log out",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
