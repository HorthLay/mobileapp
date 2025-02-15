import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
 ContactWidget({super.key});
  final List<Map<String, dynamic>> gridItems = [
    {"image": "assets/icons/tik.png", "title": "Tiktok","color": Colors.pink},
    {"image": "assets/icons/face.png", "title": "Facebook","color": Colors.blueAccent},
    {"image": "assets/icons/tele.png", "title": "Telegram","color": Colors.blueAccent},
  ];
  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
          colors:[
            Colors.blue.shade500,
            Colors.blueAccent,
            Colors.blue.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      //
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(left: 5,top: 15),
            child: Row(
              children: [
                Icon(
                  Icons.call,
                  color: Colors.greenAccent,
                  size: 30,
                ),
                SizedBox(width: 8,),
                Text(
                  "ទំនាក់ទំនង",
                  style: TextStyle(
                    fontFamily: "Dongrek",
                    fontSize: 20,fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

              ],
            ),

          ),
          GridView.builder(
            shrinkWrap: true, // Allows GridView inside a scrollable view
            physics: NeverScrollableScrollPhysics(), // Prevents inner scrolling
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 1,
            ),
            itemCount: gridItems.length,
            itemBuilder: (context, index) {
              // Route
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          gridItems[index]['image'],
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          gridItems[index]['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: gridItems[index]['color'],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
