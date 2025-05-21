import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:vireakrothmobile/cart/orderdetail.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  List<CartItem> cartItems = [
    CartItem(
      id: 1,
      name: "iPhone 15 Pro Max",
      price: 32,
      color: Colors.black,
      image: "assets/images/iphone16.png",
      quantity: 1,
    ),
    CartItem(
      id: 2,
      name: "iPhone 15 Pro",
      price: 32,
      color: Colors.black,
      image: "assets/images/iphone16.png",
      quantity: 1,
    ),
  ];

  bool isEditing = false;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      isEditing = !isEditing;
      if (isEditing) {
        _slideController.forward();
      } else {
        _slideController.reverse();
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _updateQuantity(int index, int change) {
    setState(() {
      final newQuantity = cartItems[index].quantity + change;
      if (newQuantity >= 1) {
        cartItems[index].quantity = newQuantity;
        _scaleController.reset();
        _scaleController.forward();
      }
    });
  }

  int get _totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 18, 35, 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildCartItemsList(),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button with animation
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
            ),
          ).animate()
              .scale(duration: 300.ms, curve: Curves.elasticOut)
              .fadeIn(duration: 300.ms),

          // Title with animation
          const Text(
            "My Cart",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ).animate()
              .slideY(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic)
              .fadeIn(duration: 400.ms),

          const Spacer(),

          // Edit Items Toggle with animation
          GestureDetector(
            onTap: _toggleEditMode,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isEditing
                    ? Colors.green.withOpacity(0.2)
                    : Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isEditing ? Colors.green : Colors.blueAccent,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isEditing ? Icons.check : Icons.edit,
                    color: isEditing ? Colors.green : Colors.blueAccent,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isEditing ? "DONE" : "EDIT",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isEditing ? Colors.green : Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ).animate(target: isEditing ? 1 : 0)
                .scaleXY(end: 1.05, duration: 300.ms)
                .then()
                .scaleXY(end: 1.0, duration: 200.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemsList() {
    if (cartItems.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.white.withOpacity(0.3),
              ).animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut)
                  .fadeIn(duration: 400.ms),
              const SizedBox(height: 20),
              Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7),
                ),
              ).animate()
                  .slideY(begin: 0.2, end: 0, duration: 400.ms)
                  .fadeIn(duration: 400.ms, delay: 200.ms),
              const SizedBox(height: 10),
              Text(
                "Add items to get started",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.5),
                ),
              ).animate()
                  .slideY(begin: 0.2, end: 0, duration: 400.ms)
                  .fadeIn(duration: 400.ms, delay: 300.ms),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "BROWSE PRODUCTS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ).animate()
                  .scale(duration: 400.ms, delay: 400.ms)
                  .fadeIn(duration: 400.ms, delay: 400.ms),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: cartItems.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return Dismissible(
            key: Key(item.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade800,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30,
              ),
            ),
            onDismissed: (direction) {
              _removeItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.name} removed from cart'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.blueGrey.shade800,
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    textColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        cartItems.insert(index, item);
                      });
                    },
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade800,
                    Colors.blue.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Product Image with animation
                        Hero(
                          tag: 'product-${item.id}',
                          child: Container(
                            width: 80,
                            height: 80,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.asset(
                              item.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),

                        // Product Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "\$${item.price}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Text(
                                    "Color: ",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: item.color,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Quantity controls or delete button
                        isEditing
                            ? SlideTransition(
                          position: _slideAnimation,
                          child: IconButton(
                            onPressed: () => _removeItem(index),
                            icon: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red.shade800,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                            : _buildQuantityControls(index, item),
                      ],
                    ),
                  ),

                  // Swipe hint indicator
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 5,
                      decoration: BoxDecoration(
                        color: Colors.red.shade800,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate()
                .fadeIn(duration: 400.ms, delay: 100.ms * index)
                .slideX(begin: 0.1, end: 0, duration: 400.ms, delay: 100.ms * index, curve: Curves.easeOutCubic),
          );
        },
      ),
    );
  }

  Widget _buildQuantityControls(int index, CartItem item) {
    return Row(
      children: [
        // Decrease button
        GestureDetector(
          onTap: () => _updateQuantity(index, -1),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.remove,
              color: Colors.white,
              size: 18,
            ),
          ),
        ).animate(target: item.quantity > 1 ? 1 : 0)
            .scaleXY(end: 0.9, duration: 100.ms)
            .then()
            .scaleXY(end: 1.0, duration: 100.ms),

        // Quantity display
        AnimatedBuilder(
          animation: _scaleController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + _scaleController.value * 0.3,
              child: Container(
                width: 40,
                alignment: Alignment.center,
                child: Text(
                  "${item.quantity}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),

        // Increase button
        GestureDetector(
          onTap: () => _updateQuantity(index, 1),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 18,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Coupon code input
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                const Icon(Icons.discount_outlined, color: Colors.blueAccent),
                const SizedBox(width: 10),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter coupon code",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "APPLY",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ).animate()
              .slideY(begin: 0.5, end: 0, duration: 500.ms, curve: Curves.easeOutCubic)
              .fadeIn(duration: 400.ms),

          const SizedBox(height: 20),

          // Price breakdown
          Column(
            children: [
              _buildPriceRow("Subtotal", "\$$_totalPrice"),
              const SizedBox(height: 8),
              _buildPriceRow("Shipping", "\$0.00"),
              const SizedBox(height: 8),
              _buildPriceRow("Tax", "\$${(_totalPrice * 0.1).toStringAsFixed(2)}"),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(color: Colors.grey),
              ),
              _buildPriceRow(
                "Total",
                "\$${(_totalPrice + (_totalPrice * 0.1)).toStringAsFixed(2)}",
                isTotal: true,
              ),
            ],
          ).animate()
              .slideY(begin: 0.3, end: 0, duration: 500.ms, delay: 100.ms, curve: Curves.easeOutCubic)
              .fadeIn(duration: 400.ms, delay: 100.ms),

          const SizedBox(height: 20),

          // Place Order Button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: cartItems.isEmpty ? null : () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, animation, secondaryAnimation) => const OrderDetail(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 1),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          )),
                          child: child,
                        ),
                      );
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                disabledBackgroundColor: Colors.grey.shade400,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "PLACE ORDER",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ).animate()
              .slideY(begin: 0.2, end: 0, duration: 500.ms, delay: 200.ms, curve: Curves.easeOutCubic)
              .fadeIn(duration: 400.ms, delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Colors.blueAccent : Colors.black,
          ),
        ),
      ],
    );
  }
}

class CartItem {
  final int id;
  final String name;
  final int price;
  final Color color;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
    required this.image,
    required this.quantity,
  });
}