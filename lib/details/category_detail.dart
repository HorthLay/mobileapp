import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text(widget.title ?? "Category Detail"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
           Center(
            child: ClipRRect(
               borderRadius: BorderRadius.circular(10),
               child: widget.category?.image != null && widget.category!.image!.isNotEmpty
                   ? Image.asset(

                 widget.category!.image!,

                 width: 200,
                 height: 200,

                 errorBuilder: (context, error, stackTrace) => Center(
                   child: Text(
                     "Image Error",
                     style: TextStyle(color: Colors.red),
                   ),
                 ),
               )
                   : Center(
                 child: Text(
                   "No Image Available",
                   style: TextStyle(color: Colors.grey),
                 ),
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}
