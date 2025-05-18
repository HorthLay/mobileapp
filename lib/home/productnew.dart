import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/controllers/product_controller.dart';
import 'package:vireakrothmobile/details/productdetail.dart';

class ProductNew extends StatefulWidget {
  const ProductNew({super.key});

  @override
  State<ProductNew> createState() => _ProductNewState();
}

class _ProductNewState extends State<ProductNew> {
  final ProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Filter products with status == 'new'
      final newProducts = controller.productList
          .where((product) => product.status == 'new')
          .toList();

      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.60,
          crossAxisSpacing: 8,
          mainAxisSpacing: 2,
        ),
        itemCount: newProducts.length,
        itemBuilder: (context, index) {
          final product = newProducts[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => ProductDetail(product: {
                    'title': product.name,
                    'image': product.image,
                    'price': product.price.toStringAsFixed(2),
                    'status': product.status,
                    'discount': "${product.discount.toStringAsFixed(2)}%",
                  }),
                  transitionsBuilder: (_, animation, __, child) {
                    final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                        .chain(CurveTween(curve: Curves.easeInOut));
                    return SlideTransition(position: animation.drive(tween), child: child);
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "-${product.discount.toStringAsFixed(2)}%",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const Icon(Icons.favorite_border, color: Colors.red),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Image.network(
                      product.image ?? '',
                      height: 120,
                      width: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.status,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.add, size: 16, color: Colors.white),
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
