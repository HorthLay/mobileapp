import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vireakrothmobile/details/productdetail.dart';
import 'package:vireakrothmobile/controllers/product_controller.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
    late final ProductController controller;

  // Fix image URL to replace localhost IP for emulator
  String fixImageUrl(String url) {
    if (url.isEmpty) return url;

    // Parse the URL
    Uri uri = Uri.parse(url);


    Uri fixedUri = uri.replace(host: 'wtd.qpz.temporary.site');

    return fixedUri.toString();
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductController(), permanent: true);
    controller.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        // Enhanced loading state with shimmer effect
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 6, // Show 6 shimmer placeholders
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            );
          },
        );
      }

      return AnimationLimiter(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: controller.productList.length,
          itemBuilder: (context, index) {
            final product = controller.productList[index];
            final imageUrl = fixImageUrl(product.image ?? '');

            // Staggered animation for each grid item
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 2,
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.8, end: 1.0),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    builder: (context, double scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 500),
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                ProductDetail(product: {
                                  'title': product.name,
                                  'description': product.description,
                                  'image': imageUrl,
                                  'category_id': product.categoryId,
                                  'price': product.price.toStringAsFixed(2),
                                  'status': product.status,
                                  'discount': "${product.discount.toStringAsFixed(2)}%",
                                }),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.discount > 0)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.blue[300]!, Colors.blue[700]!],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      "-${product.discount.toStringAsFixed(0)}%",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  LikeButton(
                                    size: 20,
                                    circleColor: const CircleColor(
                                      start: Color(0xffFF5722),
                                      end: Color(0xffFFC107),
                                    ),
                                    bubblesColor: const BubblesColor(
                                      dotPrimaryColor: Color(0xffFF5722),
                                      dotSecondaryColor: Color(0xffFFC107),
                                    ),
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        isLiked ? Icons.favorite : Icons.favorite_border,
                                        color: isLiked ? Colors.red : Colors.grey,
                                        size: 20,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            const SizedBox(height: 8),
                            // Hero animation for smooth image transition
                            Hero(
                              tag: 'product-${product.id}',
                              child: Center(
                                child: TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0, end: 1),
                                  duration: const Duration(milliseconds: 500),
                                  builder: (context, double value, child) {
                                    return Opacity(
                                      opacity: value,
                                      child: child,
                                    );
                                  },
                                  child: Image.network(
                                    imageUrl,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.image_not_supported),
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                              : null,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.blue[300]!),
                                          strokeWidth: 2,
                                        ),
                                      );
                                    },
                                  ),
                                ),
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
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product.status,
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${product.price.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AddToCartButton(
                                  onPressed: () {
                                    // Add to cart logic
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${product.name} added to cart'),
                                        duration: const Duration(seconds: 1),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });



  }

}

// Custom animated add to cart button
class AddToCartButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AddToCartButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[400]!, Colors.blue[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.add_shopping_cart, size: 16, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}

// Like button animation (simplified version)
class LikeButton extends StatefulWidget {
  final double size;
  final CircleColor circleColor;
  final BubblesColor bubblesColor;
  final Widget Function(bool) likeBuilder;

  const LikeButton({
    Key? key,
    required this.size,
    required this.circleColor,
    required this.bubblesColor,
    required this.likeBuilder,
  }) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_controller.value * 0.2),
            child: widget.likeBuilder(isLiked),
          );
        },
      ),
    );
  }
}

class CircleColor {
  final Color start;
  final Color end;

  const CircleColor({required this.start, required this.end});
}

class BubblesColor {
  final Color dotPrimaryColor;
  final Color dotSecondaryColor;

  const BubblesColor({required this.dotPrimaryColor, required this.dotSecondaryColor});
}
