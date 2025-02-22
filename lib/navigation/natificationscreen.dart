import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<String> cartName = ["Mark", "Order", "Alert", "Promote"];

  final List<Color> catColors = [
    Color(0xFFFFCF2F),
    Color(0xFF6FE08D),
    Color(0xFF61BDFD),
    Color(0xFFFC7C7F),
  ];

  final List<Icon> catIcons = [
    Icon(Iconsax.message, color: Colors.white, size: 30),
    Icon(Iconsax.shopping_cart, color: Colors.white, size: 30),
    Icon(Iconsax.notification, color: Colors.white, size: 30),
    Icon(Icons.newspaper, color: Colors.white, size: 30),
  ];

  final List<Map<String, dynamic>> notifications = [
    {"name": "Sam John", "status": "Placed a new order", "time": "20 min ago", "read": false},
    {"name": "Sam John", "status": "Placed a new order", "time": "20 min ago", "read": true},
    {"name": "Sam John", "status": "Placed a new order", "time": "20 min ago", "read": true},
    {"name": "Sam John", "status": "Placed a new order", "time": "20 min ago", "read": true},
    {"name": "Sam John", "status": "Placed a new order", "time": "20 min ago", "read": true},
    {"name": "Sam John", "status": "Placed a new order", "time": "20 min ago", "read": true},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Header Section**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Messages",
                    style: TextStyle(fontSize: 25, fontFamily: "Sen", fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      print("Mark as all read tapped");
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.mail_sharp, color: Colors.blue, size: 24),
                        SizedBox(width: 5),
                        Text(
                          'Mark as all read',
                          style: TextStyle(fontSize: 16, fontFamily: "Sen", fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// **Categories Grid**
            SizedBox(
              height: 120, // Fixed height for the grid
              child: GridView.builder(
                itemCount: cartName.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: catColors[index],
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: catIcons[index]),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        cartName[index],
                        style: const TextStyle(fontSize: 12, fontFamily: "Sen", fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// **Underline Divider**
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Divider(thickness: 0.5, color: Colors.grey),
            ),

            /// **Notifications List (Scrollable)**
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const Divider(thickness: 0.5, color: Colors.white),
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: notification["read"] ? Colors.transparent : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30, // Bigger avatar
                        child: Icon(Icons.person, color: Colors.orange, size: 30),
                      ),

                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${notification['name']} ",
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            TextSpan(
                              text: notification['status'],
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      subtitle: Text(notification['time'], style: TextStyle(color: Colors.grey.shade600)),
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Rounded edges
                        child: Image.asset(
                          "assets/images/iphone16.png",  // Use local asset image
                          width: 80,  // Bigger width
                          height: 80, // Bigger height
                          fit: BoxFit.cover, // Ensures it fills the box properly
                        ),
                      ),
                      onTap: () {
                        print("Tapped on notification");
                      },
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
