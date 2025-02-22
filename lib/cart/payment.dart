import 'package:flutter/material.dart';
import 'khqr_scan_screen.dart'; // Import the new scan screen

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPayment = "KHQR"; // Default selected method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // Back Button & Title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Payment",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Sen",
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Payment Options
              _buildKHQRWidget(),
              const SizedBox(height: 10),
              _buildPaymentOption("ABA", "assets/images/aba.png"),

              const Spacer(),

              // Pay & Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedPayment == "KHQR") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FlutterBakongKhqrExample(),
                        ),
                      );
                    } else {
                      // Handle ABA payment logic
                      print("Processing ABA Payment...");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "PAY & CONFIRM",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // KHQR Payment Option
  Widget _buildKHQRWidget() {
    bool isSelected = selectedPayment == "KHQR";
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = "KHQR";
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.black54,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset("assets/images/khqr.png", width: 50, height: 50),
            const SizedBox(width: 10),
            const Text(
              "KHQR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.orange),
          ],
        ),
      ),
    );
  }

  // Other Payment Option (ABA)
  Widget _buildPaymentOption(String title, String imagePath) {
    bool isSelected = selectedPayment == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.black54,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 50, height: 50),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
