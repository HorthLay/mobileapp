import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:vireakrothmobile/cart/khqr_scan_screen.dart'; // Add this package

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with SingleTickerProviderStateMixin {
  String selectedPayment = "KHQR"; // Default selected method
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "id": "KHQR",
      "name": "KHQR",
      "image": "assets/images/khqr.png",
      "description": "Scan QR code to pay instantly",
    },
    {
      "id": "ABA",
      "name": "ABA Pay",
      "image": "assets/images/aba.png",
      "description": "Pay with ABA mobile banking",
    },

  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // Back Button & Title with animation
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: "Sen",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Subtitle
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 400),
                child: Text(
                  "Select your preferred payment method",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontFamily: "Sen",
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Order Summary
              FadeInDown(
                delay: const Duration(milliseconds: 300),
                duration: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Total",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontFamily: "Sen",
                            ),
                          ),
                          const Text(
                            "\$96.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "Sen",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Fee",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontFamily: "Sen",
                            ),
                          ),
                          const Text(
                            "\$5.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "Sen",
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "Sen",
                            ),
                          ),
                          const Text(
                            "\$101.00",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue,
                              fontFamily: "Sen",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Payment Methods Title
              FadeInDown(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 400),
                child: const Text(
                  "PAYMENT METHODS",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    letterSpacing: 1.2,
                    fontFamily: "Sen",
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Payment Options List
              Expanded(
                child: ListView.builder(
                  itemCount: paymentMethods.length,
                  itemBuilder: (context, index) {
                    final method = paymentMethods[index];
                    return FadeInDown(
                      delay: Duration(milliseconds: 500 + (index * 100)),
                      duration: const Duration(milliseconds: 400),
                      child: _buildPaymentOption(
                        method["id"],
                        method["name"],
                        method["image"],
                        method["description"],
                      ),
                    );
                  },
                ),
              ),

              // Pay & Confirm Button with animation
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedPayment == "KHQR") {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500),
                            pageBuilder: (context, animation, secondaryAnimation) =>
                            const FlutterBakongKhqrExample(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Slide from right
                              const end = Offset.zero;
                              const curve = Curves.easeOutQuint;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      } else {
                        // Handle other payment methods
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Processing ${selectedPayment} payment..."),
                            backgroundColor: Colors.blue,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      "PAY & CONFIRM",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontFamily: "Sen",
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

  // Enhanced Payment Option Widget
  Widget _buildPaymentOption(String id, String title, String imagePath, String description) {
    bool isSelected = selectedPayment == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                imagePath,
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Sen",
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontFamily: "Sen",
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.blue : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}