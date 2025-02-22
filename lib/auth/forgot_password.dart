import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 35, 1),
      body: SafeArea(
        child: Stack(
          children: [
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SizedBox(height: 120),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(
                    "Reset Your Password",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontFamily: "Poppins"),
                  ),

                  SizedBox(height: 50),

                  Expanded(child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Background color
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      )
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email Field


                            SizedBox(height: 20),
                            // Email
                            Text(
                              "Email",
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none),
                              ),
                            ),

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
                                  "Reset Your Password",
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
                  ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
