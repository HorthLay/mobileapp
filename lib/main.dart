import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vireakrothmobile/auth/login.dart';
import 'package:vireakrothmobile/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Shop',
      theme: ThemeData(
        fontFamily: 'Poppins', // Use the custom font family name
      ),
      home: SplashScreen(),
    );
  }


}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/logo1.gif", width: 500), // Splash logo
      ),
    );
  }
}

