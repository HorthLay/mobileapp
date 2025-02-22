import 'package:flutter/material.dart';
import 'package:flutter_bakong_khqr/core/khqr_curency.dart';
import 'dart:async';
import 'package:flutter_bakong_khqr/flutter_bakong_khqr.dart';
import 'package:flutter_bakong_khqr/view/bakong_khqr.dart';

void main() {
  runApp(const FlutterBakongKhqrExample());
}

class FlutterBakongKhqrExample extends StatefulWidget {
  const FlutterBakongKhqrExample({super.key});

  @override
  State<FlutterBakongKhqrExample> createState() =>
      _FlutterBakongKhqrExampleState();
}

class _FlutterBakongKhqrExampleState extends State<FlutterBakongKhqrExample> {
  String _qrCodeIndividual = '';
  final _bakongKhqr = FlutterBakongKhqr();
  Timer? _timer;
  int _timeLeft = 300; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
    _generateKhqrIndividual();
    _startTimer();
  }

  /// Generates QR Code
  Future<void> _generateKhqrIndividual() async {
    final response = await _bakongKhqr.generateKhqrIndividual(
      bakongAccountId: "soung_layhorth@trmc",
      acquiringBank: "Dev Bank",
      merchantName: "Soung LayHorth",
      currency: KhqrCurrency.usd,
      amount: 100,
    );
    setState(() {
      _qrCodeIndividual = response.qrCode;
      _timeLeft = 300; // Reset countdown
    });
  }

  /// Starts countdown timer
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "QR Code Details",
          style: TextStyle(
            fontFamily: "Sen",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                "Scan to Pay",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Show QR Code or Expired Message
              if (_timeLeft > 0)
                Column(
                  children: [
                    BakongKhqrView(
                      width: 250,
                      amount: 0.01,
                      receiverName: "Soung LayHorth",
                      currency: KhqrCurrency.usd,
                      qr: _qrCodeIndividual,
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 50),
                    const SizedBox(height: 10),
                    const Text(
                      "QR Code Expired!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 10),

              // Countdown Timer
              Text(
                "Expires in: ${_timeLeft ~/ 60}:${(_timeLeft % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
