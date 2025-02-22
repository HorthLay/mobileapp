import 'package:flutter/material.dart';

class Userscreen extends StatelessWidget {
  const Userscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Sen",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildProfileSection(),
            SizedBox(height: 20),
            _buildSettingsMenu(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        // Circle Avatar
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.lightBlue[200],
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/images/iphone16.png"), // Replace with your image path
              fit: BoxFit.cover, // Ensures the image covers the entire circle
            ),
          ),
        ),

        SizedBox(width: 20), // Spacing between avatar and text

        // Name and Phone Number
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vishal Khadok",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: "Sen",
              ),
            ),
            SizedBox(height: 8), // Spacing between name and phone number
            Text(
              "+855966011805",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: "Sen",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsMenu() {
    return Column(
      children: [
        _buildSection([
          _buildListItem(Icons.person_outline, "Personal Info",color: Colors.orange),
          _buildListItem(Icons.map_outlined, "Addresses",color: Colors.blueAccent),
        ]),
        SizedBox(height: 16), // Spacing between sections
        _buildSection([
          _buildListItem(Icons.help_outline, "FAQs",color: Colors.orange),
          _buildListItem(Icons.shopping_bag_outlined, "Order",color: Colors.blueAccent),
          _buildListItem(Icons.settings_outlined, "Settings",color: Colors.purple),
        ]),
        SizedBox(height: 100),
        _buildSection([
          _buildListItem(Icons.logout, "Log Out", color: Colors.red),
        ]),
      ],
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListItem(IconData icon, String title, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 24),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,fontFamily: "Sen")),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        // Handle tap
      },
    );
  }
}
