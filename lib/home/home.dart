import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vireakrothmobile/details/category_detail.dart';
import 'package:vireakrothmobile/home/contact.dart';
import 'package:vireakrothmobile/home/search.dart';
import 'package:vireakrothmobile/home/slider.dart';
import 'package:vireakrothmobile/model/category.dart';
import 'package:vireakrothmobile/widget/widget_category.dart';
import 'package:vireakrothmobile/widget/widget_support.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> listCategory = [];
  @override
  void initState() {
    super.initState();
    listCategory.add(
        new Category(id: 1, title: "Oppo", image: "assets/images/oppo.png"));
    listCategory.add(
        new Category(id: 2, title: "Iphone", image: "assets/images/apple.png"));
    listCategory.add(new Category(
        id: 3, title: "Samsunge", image: "assets/images/samsung.png"));
    listCategory
        .add(new Category(id: 4, title: "jbl", image: "assets/images/jbl.png"));
  }

  int _currentIndex = 0;

  final _items = [
    SalomonBottomBarItem(
        icon: Image.asset(
          'assets/icons/home.png',
          width: 40,
          height: 24,
        ),
        title: const Text("Home")),
    SalomonBottomBarItem(
      icon: Image.asset('assets/icons/box.png', width: 40, height: 24),
      title: const Text("Product"),
    ),
    SalomonBottomBarItem(
        icon: const Icon(Icons.shopping_cart), title: const Text("Order")),
    SalomonBottomBarItem(
        icon: Image.asset(
          'assets/icons/use.png',
          width: 40,
          height: 24,
        ),
        title: const Text("Users")),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 53.0, left: 10.0, right: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👤 Greeting & Cart Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hello User!", style: AppWidget.boldTextFeildStyle()),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/cambodia.png', // Replace with your image path
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                          width:
                              8), // Adds space between the image and the icon
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // 🔍 Search Bar
              Search(),
              const SizedBox(height: 20),

              // 📢 Welcome Text
              Row(
                children: [
                  Image.asset(
                    'assets/icons/smartphone.png',
                    width: 25,
                    height: 25,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Phone",
                    style: AppWidget.HeadlineTextFeildStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Welcome to VireakRoth App",
                  style: AppWidget.LightTextFeildStyle()),
              const SizedBox(height: 10),

              // 📸 Slider
              MySlider(),
              const SizedBox(height: 10),

              // 📂 Category Title
              Row(
                children: [
                  Image.asset(
                    'assets/icons/cate.png',
                    height: 25,
                    width: 25,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Category", style: AppWidget.HeadlineTextFeildStyle())
                ],
              ),
              const SizedBox(height: 10),

              // 🏷️ Categories List
              SizedBox(
                height: 100, // Ensure it fits
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCategory.length,
                  itemBuilder: (BuildContext context, index) {
                    var data = listCategory[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CategoryDetailScreen(
                                          title: data.title,
                                          category: data,
                                        ),
                                ),
                            );
                          },
                          child: Container(
                            width: 135,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey.shade200,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: data.image != null
                                  ? Image.asset(
                                      data.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: Text(
                                        "No Image",
                                        style: TextStyle(
                                            color: Colors.grey.shade700),
                                      ),
                                    ),
                            ),
                          )),
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              // 🧱 Grid List with Scroll
              Container(
                child: Column(

                  children: [
                    GridView.builder(
                      padding: EdgeInsets.all(10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 16,
                        childAspectRatio: 11/16,
                      ),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 5,
                                  offset: Offset(3, 3),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/iphone16.png"
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "New",style:
                                          TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],

                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),

              ContactWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        items: _items,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
      ),
    );
  }
}
