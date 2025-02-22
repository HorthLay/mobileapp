import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int quantity = 1;
  List<Color> colors = [Colors.grey, Colors.black, Colors.pinkAccent];
  int selectedColorIndex = 0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button & Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text("Details",style: TextStyle(fontFamily: "Sen",fontSize: 20,fontWeight: FontWeight.bold),),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.blueAccent,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
            ),
            Center(
              child: Image.asset(
                widget.product["image"],
                height: 200,
                width: 250,
                fit: BoxFit.contain,
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product["title"],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,fontFamily: "Sen"),
                  ),
                  Text(
                    "RAM 8 Storage 225 Grade A",
                    style: TextStyle(color: Colors.grey, fontSize: 14,fontFamily: "Sen"),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.local_shipping, color: Colors.blueAccent, size: 20),
                      SizedBox(width: 5),
                      Text("shipped", style: TextStyle(color: Colors.grey,fontFamily: "Sen")),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Color Options
                  Text("COLOR:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: "Sen")),
                  Row(
                    children: List.generate(colors.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColorIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: colors[index],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedColorIndex == index ? Colors.blueAccent : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            Spacer(),

            // Price, Quantity Selector, and Add to Cart Button
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        "\$${widget.product["price"]}",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      // Quantity Selector
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.white, size: 16),
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                            ),
                            Text(
                              "$quantity",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.white, size: 16),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        "ADD TO CART",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold,fontFamily: "Sen"),
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
