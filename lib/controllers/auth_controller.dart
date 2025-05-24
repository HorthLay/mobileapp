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
    _loadToken();
    _loadUsername();
  }

  // Load token from SharedPreferences
  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('auth_token') ?? "";
  }

  // Save token to SharedPreferences
  Future<void> _saveToken(String tokenValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', tokenValue);
  }

  // Load username from SharedPreferences
  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? "";
  }

  // Save username to SharedPreferences
  Future<void> _saveUsername(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
  }

  // Check if user is logged in
  bool isLoggedIn() => token.value.isNotEmpty;

  // Login function
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
        token.value = response["token"];
        username.value = response["user"]["name"];
        await _saveToken(token.value);
        await _saveUsername(username.value);

        Get.snackbar("Success", "Login Successful",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed("/home");
      } else {
        Get.snackbar("Error", "Invalid Credentials",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to login: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Logout function
  Future<void> logout() async {
    try {
      if (token.value.isNotEmpty) {
        await ApiService.logout(token.value);
        token.value = "";
        username.value = "";

        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('auth_token');
        await prefs.remove('username');

        Get.offAllNamed('/login');
        Get.snackbar("Success", "Logged out successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to log out: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Register function
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (password != passwordConfirmation) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;

      final response = await ApiService.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      if (response.containsKey("token")) {
        token.value = response["token"];
        username.value = response["user"]["name"];
        await _saveToken(token.value);
        await _saveUsername(username.value);

        Get.snackbar("Success", "Registration Successful",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed("/home");
      } else {
        final message = response["message"] ?? "Registration failed";
        Get.snackbar("Error", message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to register: ${e.toString()}",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
