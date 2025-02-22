import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:vireakrothmobile/home/home.dart'; // Add this package in pubspec.yaml

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          // Animated Success Icon
          Center(
            child: Column(
              children: [
                ZoomIn(
                  duration: const Duration(milliseconds: 800),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Animated Text
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: const Text(
                    "Order Successful",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Animated OK Button
          BounceInUp(
            duration: const Duration(milliseconds: 1000),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 300), // Adjust animation speed
                      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, -1.0); // Slide from top to bottom
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

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
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
