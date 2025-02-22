import 'package:flutter/material.dart';
import 'package:vireakrothmobile/cart/payment.dart';
import 'package:vireakrothmobile/cart/successscreen.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  int selectedDeliveryIndex = 2; // Default selected delivery method (J&T EXPRESS)

  final List<Map<String, String>> deliveryMethods = [
    {"name": "ZTO", "image": "assets/images/zto.png"},
    {"name": "VET", "image": "assets/images/vet.png"},
    {"name": "J&T EXPRESS", "image": "assets/images/jnt.png"},
  ];

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
              SizedBox(height: 15),
              // Close Button and Title
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Order Detail",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sen"
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Name Input
              const Text(
                "NAME",
                style: TextStyle(fontSize: 15, color: Colors.grey,fontFamily: "Sen"),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              const SizedBox(height: 15),

              // Phone Input
              const Text(
                "PHONE",
                style: TextStyle(fontSize: 15, color: Colors.grey,fontFamily: "Sen"),
              ),
              const SizedBox(height: 5),
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Province",
                style: TextStyle(fontSize: 15, color: Colors.grey,fontFamily: "Sen"),
              ),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              const SizedBox(height: 15),

              // Delivery Method
              const Text(
                "DELIVERY METHOD",
                style: TextStyle(fontFamily: "Sen",fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(deliveryMethods.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDeliveryIndex = index;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 70,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: selectedDeliveryIndex == index
                                  ? Colors.orange
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25), // Match container's border radius
                            child: Image.asset(
                              deliveryMethods[index]["image"]!,
                              width: 70,
                              height: 60,
                              fit: BoxFit.contain, // Ensures image fits without cropping
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          deliveryMethods[index]["name"]!,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),

                  );
                }),
              ),
              const SizedBox(height: 20),

              // Total Amount
              Row(
                children: [
                  const Text(
                    "TOTAL:",
                    style: TextStyle(fontSize: 15, color: Colors.grey,fontFamily: "Sen"),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "\$96",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: "Sen"),
                  ),
                ],
              ),
              const Spacer(),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 300), // Adjust animation speed
                            pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "PAYMENT",
                        style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: "Sen"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 300), // Adjust animation speed
                            pageBuilder: (context, animation, secondaryAnimation) => OrderSuccessPage(),
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
                        backgroundColor: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        "ORDER",
                        style: TextStyle(color: Colors.white, fontSize: 16,fontFamily: "Sen",fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
