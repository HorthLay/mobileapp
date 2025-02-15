import 'package:flutter/material.dart';

class Search extends StatelessWidget {
   Search({super.key});
  final List<Map<String, dynamic>> gridItems = [
    {"image": "assets/icons/tik.png", "title": "Tiktok","color": Colors.pink},
    {"image": "assets/icons/face.png", "title": "Facebook","color": Colors.blueAccent},
    {"image": "assets/icons/tele.png", "title": "Telegram","color": Colors.blueAccent},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.grey.shade200,
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 4,
              child: TextField(
                decoration: InputDecoration(
                    hintText: "Search", border: InputBorder.none),
              ),
            )
          ],
        ));
  }
}
