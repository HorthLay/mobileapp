import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:animate_do/animate_do.dart'; // Add this package

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedCategoryIndex = 0;

  final List<String> cartName = ["All", "Orders", "Alerts", "Promos"];

  final List<Color> catColors = [
    const Color(0xFFFFCF2F),
    const Color(0xFF6FE08D),
    const Color(0xFF61BDFD),
    const Color(0xFFFC7C7F),
  ];

  final List<IconData> catIcons = [
    Iconsax.message,
    Iconsax.shopping_cart,
    Iconsax.notification,
    Icons.newspaper,
  ];

  final List<Map<String, dynamic>> notifications = [
    {
      "name": "Sam John",
      "status": "placed a new order",
      "time": "20 min ago",
      "read": false,
      "category": "Orders",
      "image": "assets/images/iphone16.png",
      "avatar": "assets/images/avatar1.png",
    },
    {
      "name": "Emma Wilson",
      "status": "commented on your post",
      "time": "1 hour ago",
      "read": true,
      "category": "All",
      "image": "assets/images/iphone16.png",
      "avatar": "assets/images/avatar2.png",
    },
    {
      "name": "Promo Alert",
      "status": "50% off on all electronics!",
      "time": "2 hours ago",
      "read": false,
      "category": "Promos",
      "image": "assets/images/iphone16.png",
      "avatar": null,
    },
    {
      "name": "System",
      "status": "your payment was successful",
      "time": "Yesterday",
      "read": true,
      "category": "Alerts",
      "image": null,
      "avatar": null,
    },
    {
      "name": "John Doe",
      "status": "mentioned you in a comment",
      "time": "Yesterday",
      "read": true,
      "category": "All",
      "image": "assets/images/iphone16.png",
      "avatar": "assets/images/avatar3.png",
    },
    {
      "name": "Flash Sale",
      "status": "starts in 2 hours. Don't miss out!",
      "time": "Yesterday",
      "read": false,
      "category": "Promos",
      "image": "assets/images/iphone16.png",
      "avatar": null,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: cartName.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedCategoryIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> getFilteredNotifications() {
    if (_selectedCategoryIndex == 0) {
      return notifications;
    } else {
      return notifications
          .where((notification) => notification["category"] == cartName[_selectedCategoryIndex])
          .toList();
    }
  }

  void markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification["read"] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('All notifications marked as read'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = getFilteredNotifications();
    final unreadCount = notifications.where((n) => n["read"] == false).length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with animation
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 28,
                            fontFamily: "Sen",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          unreadCount > 0 ? "$unreadCount unread messages" : "No unread messages",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Sen",
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: markAllAsRead,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.mark_email_read, color: Colors.blue, size: 18),
                            SizedBox(width: 5),
                            Text(
                              'Mark all read',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Sen",
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories Tabs with animation
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Colors.transparent,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  tabs: List.generate(
                    cartName.length,
                        (index) => _buildCategoryTab(index),
                  ),
                ),
              ),
            ),

            // Divider
            const Divider(thickness: 1, color: Color(0xFFEEEEEE)),

            // Notifications List with animation
            Expanded(
              child: filteredNotifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: filteredNotifications.length,
                itemBuilder: (context, index) {
                  return FadeInUp(
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    child: _buildNotificationItem(filteredNotifications[index], index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTab(int index) {
    final isSelected = _selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
          _tabController.animateTo(index);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? catColors[index] : catColors[index].withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              catIcons[index],
              color: isSelected ? Colors.white : catColors[index],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              cartName[index],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                fontFamily: "Sen",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          notification["read"] = true;
        });
        // Handle notification tap
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: notification["read"] ? Colors.white : Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar or Icon
              _buildAvatar(notification),

              const SizedBox(width: 15),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Category badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(notification["category"]).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            notification["category"],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getCategoryColor(notification["category"]),
                              fontFamily: "Sen",
                            ),
                          ),
                        ),

                        // Time
                        Text(
                          notification["time"],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontFamily: "Sen",
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Message
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontFamily: "Sen",
                        ),
                        children: [
                          TextSpan(
                            text: "${notification["name"]} ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: notification["status"]),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Image if available
                    if (notification["image"] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          notification["image"],
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                  ],
                ),
              ),

              // Unread indicator
              if (!notification["read"])
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(left: 5, top: 5),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(Map<String, dynamic> notification) {
    if (notification["avatar"] != null) {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(notification["avatar"]),
      );
    } else {
      // Use icon based on category
      Color bgColor = _getCategoryColor(notification["category"]);
      IconData iconData = _getCategoryIcon(notification["category"]);

      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: bgColor,
          size: 24,
        ),
      );
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Orders":
        return const Color(0xFF6FE08D);
      case "Alerts":
        return const Color(0xFF61BDFD);
      case "Promos":
        return const Color(0xFFFC7C7F);
      default:
        return const Color(0xFFFFCF2F);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Orders":
        return Iconsax.shopping_cart;
      case "Alerts":
        return Iconsax.notification;
      case "Promos":
        return Icons.newspaper;
      default:
        return Iconsax.message;
    }
  }

  Widget _buildEmptyState() {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.notification,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 20),
            Text(
              "No notifications yet",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
                fontFamily: "Sen",
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "We'll notify you when something arrives",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontFamily: "Sen",
              ),
            ),
          ],
        ),
      ),
    );
  }
}