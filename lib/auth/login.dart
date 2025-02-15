import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vireakrothmobile/auth/forgot_password.dart';
import 'package:vireakrothmobile/auth/register.dart';
import 'package:vireakrothmobile/home/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 35, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Logo
              SizedBox(height: 40),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  image: const DecorationImage(
                      image: AssetImage("assets/logo.jpg"), fit: BoxFit.cover),
                ),
              ),

              // Title
              SizedBox(height: 10),
              Text(
                "Log In",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              ),

              // Subtitle
              SizedBox(height: 10),
              Text(
                "Please sign in to your existing account",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontFamily: "Poppins"),
              ),

              SizedBox(height: 40),

              // Login Form Box

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email Field
                          Text(
                            "Email",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Password Field
                          Text(
                            "Password",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),

                          SizedBox(height: 10),

                          // Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  const Text(
                                    "Remember Me",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => ForgotPasswordScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0); // Slide from right to left
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;

                                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                        var offsetAnimation = animation.drive(tween);

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                "Log In",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),

                          // Signup Redirect
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => RegisterScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0); // Slide from right to left
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;

                                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                        var offsetAnimation = animation.drive(tween);

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Or",style: TextStyle(
                                fontSize: 18,color: Colors.grey.shade500,
                              ),),
                            ],
                          ),

                          SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Logo(Logos.facebook_f),
                              Logo(Logos.twitter),
                              Logo(Logos.google),
                              Logo(Logos.apple),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
