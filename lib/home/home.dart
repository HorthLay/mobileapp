import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:vireakrothmobile/home/homecontent.dart';

import 'package:vireakrothmobile/model/category.dart';
import 'package:vireakrothmobile/navigation/natificationscreen.dart';
import 'package:vireakrothmobile/navigation/shopscreen.dart';
import 'package:vireakrothmobile/navigation/userscreen.dart';

import 'package:get/get.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> listCategory = [];
  @override
  int _selectedIndex = 0; // Default Home Screen
  // start Buttombar
  final List<Widget> _pages = [
    Homecontent(), // Separate home content to prevent nesting issues
    Shopscreen(),
    NotificationScreen(),
    Userscreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  // EndButtombar




  void initState() {
    super.initState();

  }
  int _notificationCount = 2;
  int _currentIndex = 0;

  final List<Map<String, dynamic>> gridItems = [
    {"image": "assets/icons/tik.png", "title": "Tiktok", "color": Colors.pink},
    {
      "image": "assets/icons/face.png",
      "title": "Facebook",
      "color": Colors.blueAccent
    },
    {
      "image": "assets/icons/tele.png",
      "title": "Telegram",
      "color": Colors.blueAccent
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Displays selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart), label: "Shop"),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Iconsax.notification),
                if (_notificationCount > 0) // Show badge if count > 0
                  Positioned(
                    right: -5,
                    top: -5,
                    child: Container(
                      padding: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$_notificationCount',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
        ],
      ),
    );
  }
}



