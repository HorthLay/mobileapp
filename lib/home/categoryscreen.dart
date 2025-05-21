import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/controllers/category_controller.dart';
import 'package:vireakrothmobile/details/category_detail.dart';
import 'package:vireakrothmobile/widget/widget_support.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Row(
          children: [
            Image.asset('assets/icons/cate.png', height: 25, width: 25),
            const SizedBox(width: 10),
            Text("Category", style: AppWidget.HeadlineTextFeildStyle()),
          ],
        ),

        const SizedBox(height: 10),

        // Category List
        Obx(() {
          if (categoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = categoryController.categoryList;

          if (categories.isEmpty) {
            return const Center(child: Text("No categories available"));
          }

          return SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      // Debug print to check the value of category.id
                      print('Category ID: ${category.id}');

                      // Null check for category.id
                      if (category.id != null) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  CategoryDetail(categoryId: category.id),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.easeInOut;
                                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );

                      } else {
                        // Handle the case where category.id is null
                        print('Category ID is null');
                        Get.snackbar("Error", "Category ID is null");
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: category.imageUrl != null
                                ? Image.network(
                              category.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                            )
                                : Center(
                              child: Text("No Image",
                                  style: TextStyle(color: Colors.grey.shade700)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category.name,
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
