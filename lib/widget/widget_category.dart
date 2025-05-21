import 'package:flutter/material.dart';
import 'package:vireakrothmobile/model/category.dart';

class CategoryWidget extends StatelessWidget {
Category category;
   CategoryWidget({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print("Category Tapped!");
      },

        child: Container(

          width: 135,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('${category.imageUrl}'),
              fit: BoxFit.cover,

              // Adjust based on your design preference
            ),

            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey.shade200,
          ),

        ),

    );


  }
}
