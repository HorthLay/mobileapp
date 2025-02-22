import 'package:flutter/material.dart';
import 'package:vireakrothmobile/cart/orderdetail.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int> quantities = [1, 1]; // Initial quantities
  int pricePerItem = 32; // Price per item
  bool isEditing = false; // Toggle edit mode

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    for (int i = 0; i < quantities.length; i++) {
      totalPrice += quantities[i] * pricePerItem;
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 35, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Title
                  const Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  // Edit Items Toggle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditing = !isEditing; // Toggle edit mode
                      });
                    },
                    child: Text(
                      isEditing ? "DONE" : "EDIT ITEMS",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isEditing ? Colors.green : Colors.blueAccent, // Green when editing, blue when not
                        decoration: TextDecoration.underline,
                      ),
                    ),

                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Cart Items
            Expanded(
              child: ListView.builder(
                itemCount: quantities.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/images/iphone16.png", // Replace with actual image asset
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Product Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "iPhone 15 Pro Max",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Sen",
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "\$${pricePerItem}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Sen",
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Text(
                                      "Color ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Sen",
                                      ),
                                    ),
                                    const Icon(Icons.circle, color: Colors.black, size: 25),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Quantity or Delete Button
                          isEditing
                              ? IconButton(
                            onPressed: () {
                              setState(() {
                                quantities.removeAt(index); // Remove item from cart
                              });
                            },
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                          )
                              : Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantities[index] > 1) quantities[index]--;
                                  });
                                },
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                              ),
                              Text(
                                "${quantities[index]}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantities[index]++;
                                  });
                                },
                                icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Total Price & Place Order Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  // Total Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TOTAL:",
                        style: TextStyle(fontSize: 16, fontFamily: "Sen", fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      Text(
                        "\$$totalPrice",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "Sen",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Place Order Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 300), // Adjust animation speed
                            pageBuilder: (context, animation, secondaryAnimation) => OrderDetail(),
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
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "PLACE ORDER",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
