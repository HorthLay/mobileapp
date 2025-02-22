import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 35, 1),
      body: SafeArea(
        child: Stack(
          children: [
            // Small Back Button
            Positioned(
              top: 15, // Adjust position
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  shape: BoxShape.circle, // Circular shape
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26, // Soft shadow
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black), // Black arrow
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            // Centered "Sign Up" Text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50), // Pushes text below back button
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Please sign in to your existing account",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontFamily: "Poppins"),
                  ),

                  SizedBox(height: 20),

                  Expanded(child: Container(
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
                              "Name",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Enter your Name",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none),
                              ),
                            ),

                            SizedBox(height: 20),
                            // Email
                            Text(
                              "Email",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none),
                              ),
                            ),

                            SizedBox(height: 20),

                            //Phone

                            Text(
                              "Phone",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              keyboardType: TextInputType.phone, // Only numeric keyboard
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly, // Restricts input to digits only
                              ],
                              decoration: InputDecoration(
                                hintText: "Enter your Phone",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none,
                                ),
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

                            SizedBox(height: 20),
                            Text(
                              "Confirm Password",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Confirm your password",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                            // Forgot Password


                            SizedBox(height: 20),

                            // Login Button
                            SizedBox(
                              width: double.infinity,
                              height: 60,
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




                          ],
                        ),
                      ),
                    ),
                  ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
