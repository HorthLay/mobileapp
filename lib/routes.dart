import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/auth/forgot_password.dart';
import 'package:vireakrothmobile/auth/login.dart';
import 'package:vireakrothmobile/auth/register.dart';
import 'package:vireakrothmobile/home/home.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
      ],
    );
  }
}
