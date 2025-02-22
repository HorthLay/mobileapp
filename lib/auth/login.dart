import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:vireakrothmobile/auth/forgot_password.dart';
import 'package:vireakrothmobile/auth/password.dart';
import 'package:vireakrothmobile/auth/register.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 35, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              SizedBox(height: 10),
              Text(
                "Log In",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Sen"),
              ),
              SizedBox(height: 10),
              Text(
                "Please sign in to your existing account",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                    fontFamily: "Sen"),
              ),
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                          Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Sen")),
                          SizedBox(height: 8),
                          TextField(
                            controller: emailController,
                            style: TextStyle(
                              fontFamily: 'Sen', // Apply font
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins', // Apply font to hint
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: "Sen")),
                          SizedBox(height: 8),
                          PasswordField(passwordController: passwordController),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Obx(() => Checkbox(
                                    value: authController.rememberMe.value,
                                    onChanged: (bool? value) {
                                      authController.rememberMe.value = value!;
                                    },
                                  )),
                                  Text("Remember Me", style: TextStyle(color: Colors.black)),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => ForgotPasswordScreen(),
                                    transition: Transition.rightToLeftWithFade, // Slide from right to left
                                    duration: Duration(milliseconds: 500), // Smooth animation
                                  );
                                },
                                child: Text("Forgot Password?", style: TextStyle(color: Colors.blueAccent)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: Obx(() => ElevatedButton(
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                print("Attempting to login..."); // Debugging log
                                authController.login(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: authController.isLoading.value
                                  ? CircularProgressIndicator(color: Colors.white)
                                  : Text("Log In", style: TextStyle(color: Colors.white, fontSize: 16)),
                            )),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? "),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => RegisterScreen(), transition: Transition.rightToLeft, duration: Duration(milliseconds: 500));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Or", style: TextStyle(fontSize: 18, color: Colors.grey.shade500)),
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
