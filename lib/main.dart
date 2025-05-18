import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/auth/forgot_password.dart';
import 'package:vireakrothmobile/auth/login.dart';
import 'package:vireakrothmobile/auth/register.dart';
import 'package:vireakrothmobile/controllers/auth_controller.dart';
import 'package:vireakrothmobile/controllers/product_controller.dart';
import 'package:vireakrothmobile/home/home.dart';

void main() {
  Get.lazyPut(() => ProductController());
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "VireakRoth Mobile Shop",
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',  // ✅ Start with SplashScreen
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()), // ✅ Added SplashScreen
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}

// ✅ SplashScreen (Handles redirection)
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulate some loading time or token check
    Timer(Duration(seconds: 2), () async {
      // Assuming you have a method to check if the user is logged in
      final token = Get.find<AuthController>().token.value;
      if (token.isNotEmpty) {
        Get.offNamed('/home'); // Navigate to Home if logged in
      } else {
        Get.offNamed('/login'); // Otherwise, navigate to Login
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/logo1.gif", width: 500),
      ),
    );
  }
}
