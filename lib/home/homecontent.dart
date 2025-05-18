import 'package:flutter/material.dart';
import 'package:vireakrothmobile/cart/cart.dart';
import 'package:vireakrothmobile/controllers/auth_controller.dart';
import 'package:vireakrothmobile/details/category_detail.dart';
import 'package:vireakrothmobile/home/contact.dart';
import 'package:vireakrothmobile/home/productitem.dart';
import 'package:vireakrothmobile/home/productnew.dart';
import 'package:vireakrothmobile/home/second_handproduct.dart';
import 'package:vireakrothmobile/home/slider.dart';
import 'package:vireakrothmobile/widget/widget_support.dart';
import 'package:vireakrothmobile/model/category.dart';
import 'package:get/get.dart';
class Homecontent extends StatefulWidget {
  const Homecontent({super.key});

  @override
  State<Homecontent> createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {
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


  final AuthController auth = Get.find();

  int cartItemCount = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(  // Wrap the entire body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              // 👤 Greeting & Cart Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text(
                    "Hello ${auth.username.value}!",
                    style: AppWidget.boldTextFeildStyle(),
                  )),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/cambodia.png',
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 300), // Adjust animation speed
                            pageBuilder: (context, animation, secondaryAnimation) => CartScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Slide from right to left
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none, // Allows overflow for the badge
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Icon(Icons.shopping_cart, color: Colors.white),
                            ),
                            Positioned(
                              right: -5,
                              top: -10, // Adjust position
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Text(
                                  '$cartItemCount', // Change this to dynamic cart count
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),



                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
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

              const SizedBox(height: 20),
              MySlider(),
              const SizedBox(height: 10),

              // 📂 Category Section
              Row(
                children: [
                  Image.asset('assets/icons/cate.png', height: 25, width: 25),
                  const SizedBox(width: 10),
                  Text("Category", style: AppWidget.HeadlineTextFeildStyle())
                ],
              ),
              const SizedBox(height: 10),

              // 🏷️ Categories List
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCategory.length,
                  itemBuilder: (context, index) {
                    var data = listCategory[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return CategoryDetailScreen(
                                title: data.title,
                                category: data,
                              );
                            },
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0); // Starting position (slide in from the right)
                              const end = Offset.zero; // Final position
                              const curve = Curves.easeInOut; // Animation curve

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(position: offsetAnimation, child: child); // Apply the slide transition
                            },
                          ),
                        ),

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
                                ? Image.asset(data.image!, fit: BoxFit.cover)
                                : Center(
                              child: Text("No Image",
                                  style: TextStyle(
                                      color: Colors.grey.shade700)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("New",style: TextStyle(
                    fontSize: 25,fontFamily: "Sen",fontWeight: FontWeight.w600,color: Colors.red,
                  ),)
                ],
              ),
              // 📦 Product Grid
              ProductNew(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Second Hand",style: TextStyle(
                    fontSize: 25,fontFamily: "Sen",fontWeight: FontWeight.w600,color: Colors.yellow[600],
                  ),)
                ],
              ),
              SecondHandproduct(),
              const SizedBox(height: 20),
              ContactWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

