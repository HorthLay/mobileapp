import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:vireakrothmobile/home/home.dart';
import 'package:lottie/lottie.dart'; // Add this package in pubspec.yaml

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> with SingleTickerProviderStateMixin {
  late AnimationController _confettiController;
  bool _showOrderDetails = false;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Start confetti animation
    _confettiController.forward();

    // Show order details after a delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _showOrderDetails = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pattern.png'),
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Success animation and text
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Confetti animation
                      SizedBox(
                        height: 200,
                        width: 200,

                      ),

                      // Success icon with pulsing effect
                      ZoomIn(
                        duration: const Duration(milliseconds: 800),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.cyan, Colors.blue],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // Success text with animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        delay: const Duration(milliseconds: 400),
                        child: const Text(
                          "Order Successful!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontFamily: "Sen",
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Subtitle text
                      FadeInUp(
                        duration: const Duration(milliseconds: 800),
                        delay: const Duration(milliseconds: 600),
                        child: const Text(
                          "Your order has been placed successfully",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: "Sen",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Order details card
                if (_showOrderDetails)
                  FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildOrderDetailRow("Order ID", "#ORD-2023-8756"),
                          const Divider(height: 20),
                          _buildOrderDetailRow("Date", "May 19, 2025"),
                          const Divider(height: 20),
                          _buildOrderDetailRow("Total Amount", "\$96.00"),
                          const Divider(height: 20),
                          _buildOrderDetailRow("Payment Method", "Credit Card"),
                        ],
                      ),
                    ),
                  ),

                const Spacer(flex: 2),

                // OK Button with animation
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: BounceInUp(
                    duration: const Duration(milliseconds: 1000),
                    delay: const Duration(milliseconds: 800),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(milliseconds: 500),
                              pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(0.0, 1.0); // Slide from bottom to top
                                const end = Offset.zero;
                                const curve = Curves.easeOutQuint;

                                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                          shadowColor: Colors.blue.withOpacity(0.5),
                        ),
                        child: const Text(
                          "CONTINUE SHOPPING",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            fontFamily: "Sen",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Track order button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: FadeInUp(
                    duration: const Duration(milliseconds: 800),
                    delay: const Duration(milliseconds: 1000),
                    child: TextButton(
                      onPressed: () {
                        // Navigate to order tracking screen
                      },
                      child: const Text(
                        "TRACK YOUR ORDER",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: "Sen",
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: "Sen",
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontFamily: "Sen",
          ),
        ),
      ],
    );
  }
}