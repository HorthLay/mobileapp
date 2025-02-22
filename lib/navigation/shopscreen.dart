import 'package:flutter/material.dart';
import 'package:vireakrothmobile/cart/cart.dart';
import 'package:vireakrothmobile/cart/search.dart';
import 'package:vireakrothmobile/home/productitem.dart';
import 'package:vireakrothmobile/widget/widget_support.dart';

class Shopscreen extends StatelessWidget {
  const Shopscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Product", style: TextStyle(
                  fontSize: 30,fontFamily: "Sen",fontWeight: FontWeight.bold,
                ),),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 300), // Adjust animation speed
                          pageBuilder: (context, animation, secondaryAnimation) => CartScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // Slide from right to left
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 300), // Adjust animation speed
                          pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0); // Slide from right to left
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(Icons.search, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ProductItem(),
            ProductItem(),
            ProductItem(),

          ],
        ),
      ),
    );
  }
}
