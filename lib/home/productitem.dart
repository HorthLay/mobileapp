import 'package:flutter/material.dart';
import 'package:vireakrothmobile/details/productdetail.dart';
 // Import the ProductDetail screen

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final List<Map<String, dynamic>> products = [
    {
      "title": "iPhone 16 Pro Max",
      "image": "assets/images/iphone16.png",
      "discount": "-12%",
      "status": "New",
      "price": "55"
    },
    {
      "title": "Samsung S24",
      "image": "assets/images/samsung.png",
      "discount": "-10%",
      "status": "New",
      "price": "60"
    },
  ];

  List<bool> _isFavorited = [false, false];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.60,
        crossAxisSpacing: 8,
        mainAxisSpacing: 2,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        // slide animation
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500), // Animation duration
                pageBuilder: (context, animation, secondaryAnimation) => ProductDetail(product: product),
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
            );
          },

          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        product["discount"],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isFavorited[index] ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorited[index] = !_isFavorited[index];
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Center(
                  child: Image.asset(
                    product["image"],
                    height: 120,
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  product["title"],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product["status"],
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product["price"]}",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        color: Colors.blueAccent,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.add, size: 16, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
