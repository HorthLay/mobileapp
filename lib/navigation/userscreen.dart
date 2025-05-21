import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/controllers/auth_controller.dart';
import 'package:animate_do/animate_do.dart'; // Add this package

class Userscreen extends StatelessWidget {
  const Userscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom App Bar with gradient
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade600,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "My Profile",
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: "Sen",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Add edit profile functionality
                            },
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      child: _buildProfileSection(),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              // Stats Section
              Padding(
                padding: const EdgeInsets.all(20),
                child: FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem("Orders", "12"),
                      _buildStatItem("Wishlist", "24"),
                      _buildStatItem("Reviews", "8"),
                    ],
                  ),
                ),
              ),

              // Settings Menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInLeft(
                      duration: const Duration(milliseconds: 800),
                      child: const Text(
                        "Account Settings",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: "Sen",
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    FadeInUp(
                      duration: const Duration(milliseconds: 900),
                      child: _buildSettingsMenu(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        // Profile Image with border
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: Hero(
            tag: 'profile-image',
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage("assets/images/iphone16.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        // User Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Vishal Khadok",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: "Sen",
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "+855 966 011 805",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                fontFamily: "Sen",
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Premium Member",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: "Sen",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontFamily: "Sen",
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontFamily: "Sen",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsMenu() {
    return Column(
      children: [
        _buildSection([
          _buildListItem(
            Icons.person_outline,
            "Personal Information",
            subtitle: "Manage your personal details",
            color: Colors.blue,
          ),
          _buildListItem(
            Icons.map_outlined,
            "My Addresses",
            subtitle: "Set your delivery locations",
            color: Colors.orange,
          ),
        ]),
        const SizedBox(height: 16),
        _buildSection([
          _buildListItem(
            Icons.shopping_bag_outlined,
            "My Orders",
            subtitle: "Track and manage your orders",
            color: Colors.green,
          ),
          _buildListItem(
            Icons.favorite_border,
            "Wishlist",
            subtitle: "Products you've saved",
            color: Colors.red,
          ),
          _buildListItem(
            Icons.notifications_outlined,
            "Notifications",
            subtitle: "Manage your alerts",
            color: Colors.purple,
          ),
        ]),
        const SizedBox(height: 16),
        _buildSection([
          _buildListItem(
            Icons.help_outline,
            "Help & Support",
            subtitle: "FAQs and contact information",
            color: Colors.amber,
          ),
          _buildListItem(
            Icons.settings_outlined,
            "Settings",
            subtitle: "App preferences and more",
            color: Colors.blueGrey,
          ),
          _buildListItem(
            Icons.logout,
            "Log Out",
            subtitle: "Sign out from your account",
            color: Colors.red,
            onTap: () {
              Get.defaultDialog(
                title: "Confirm Logout",
                titleStyle: const TextStyle(
                  fontFamily: "Sen",
                  fontWeight: FontWeight.bold,
                ),
                middleText: "Are you sure you want to log out?",
                middleTextStyle: const TextStyle(fontFamily: "Sen"),
                radius: 10,
                contentPadding: const EdgeInsets.all(20),
                confirm: ElevatedButton(
                  onPressed: () async {
                    Get.back(); // Close the dialog
                    await Get.find<AuthController>().logout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Log Out",
                    style: TextStyle(fontFamily: "Sen"),
                  ),
                ),
                cancel: OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontFamily: "Sen"),
                  ),
                ),
              );
            },
          ),
        ]),
      ],
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListItem(
      IconData icon,
      String title, {
        String? subtitle,
        Color color = Colors.black,
        VoidCallback? onTap,
      }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: "Sen",
        ),
      ),
      subtitle: subtitle != null
          ? Text(
        subtitle,
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
          fontFamily: "Sen",
        ),
      )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}