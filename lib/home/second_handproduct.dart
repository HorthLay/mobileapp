import 'package:flutter/material.dart';
import 'package:vireakrothmobile/controllers/product_controller.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/details/productdetail.dart';
class SecondHandproduct extends StatefulWidget {
  const SecondHandproduct({super.key});

  @override
  State<SecondHandproduct> createState() => _SecondHandproductState();
}

class _SecondHandproductState extends State<SecondHandproduct> {
  final ProductController controller = Get.find(); // Get the existing controller instance

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      // Filter products with status == 'second_hand'
      final secondHandProducts = controller.productList.where((p) => p.status == 'second_hand').toList();

      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.60,
          crossAxisSpacing: 8,
          mainAxisSpacing: 2,
        ),
        itemCount: secondHandProducts.length,
        itemBuilder: (context, index) {
          final product = secondHandProducts[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) => ProductDetail(product: {
                    'title': product.name,
                    'image': product.image,
                    'description': product.description,
                    'category_id': product.categoryId,
                    'price': product.price.toStringAsFixed(2),
                    'status': product.status,
                    'discount': "${product.discount.toStringAsFixed(2)}%",
                  }),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    final tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeInOut));
                    return SlideTransition(position: animation.drive(tween), child: child);
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (product.discount > 0)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "-${product.discount.toStringAsFixed(2)}%",
                            style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      Icon(Icons.favorite_border, color: Colors.red),
                    ],
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Image.network(
                      product.image ?? '',
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 14, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.status,
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(20)),
                        child: Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

