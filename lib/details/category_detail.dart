import 'package:flutter/material.dart';
import 'package:vireakrothmobile/home/productitem.dart';
import 'package:vireakrothmobile/model/category.dart';
import 'package:vireakrothmobile/widget/widget_support.dart';

class CategoryDetailScreen extends StatefulWidget {
  String? title;
  Category? category;

  CategoryDetailScreen({super.key, this.title, this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),

            // Back button, title, and shopping cart in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items with space between
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context), // Go back to previous screen
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),

                // Title in the middle, takes up remaining space
                Expanded(
                  child: Text(
                    widget.title ?? 'Category Details', // Default title if none provided
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "Sen"),
                    textAlign: TextAlign.center, // Center the title
                  ),
                ),

                GestureDetector(
                  onTap: () => print("Shopping Cart Clicked"),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            ProductItem(),
            ProductItem(),
            ProductItem(),


          ],
        ),
      ),
    );
  }
}
