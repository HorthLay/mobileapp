import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final List<String> recentKeywords = ["Samsung", "Oppo", "Vivo", "iPhone"];
  final List<Map<String, dynamic>> suggestedProducts = [
    {"name": "iPhone 12 Pro Max", "rating": 4.6, "price": "\$999"},
    {"name": "Samsung Galaxy S21", "rating": 4.7, "price": "\$899"},
    {"name": "Google Pixel 6", "rating": 4.4, "price": "\$799"},
  ];
  final List<Map<String, dynamic>> popularProducts = [
    {"name": "IPHONE 15 PRO MAX", "image": "assets/images/iphone16.png", "price": "\$1299"},
    {"name": "IPHONE 13 PRO MAX", "image": "assets/images/iphone16.png", "price": "\$999"},
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                _buildAppBar(),
                const SizedBox(height: 20),
                _buildSearchField(),
                Expanded(
                  child: _isSearching
                      ? _buildSearchResults()
                      : _buildSearchSuggestions(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          },
          child: GestureDetector(
            onTap: () {
              _animationController.reverse().then((_) {
                Navigator.pop(context);
              });
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue[300]!, Colors.blue[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
        const SizedBox(width: 20),
        TweenAnimationBuilder<Offset>(
          tween: Tween<Offset>(begin: const Offset(50, 0), end: Offset.zero),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          builder: (context, offset, child) {
            return Transform.translate(
              offset: offset,
              child: child,
            );
          },
          child: const Text(
            "Search",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              background: null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: _isSearching
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _isSearching = value.isNotEmpty;
            });
          },
          decoration: InputDecoration(
            hintText: "Search products...",
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                _isSearching ? Icons.search : Icons.search_outlined,
                key: ValueKey<bool>(_isSearching),
                color: _isSearching ? Colors.blue : Colors.grey,
              ),
            ),
            suffixIcon: AnimatedOpacity(
              opacity: _searchController.text.isNotEmpty ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _isSearching = false;
                  });
                },
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: AnimationLimiter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              const SizedBox(height: 25),
              _buildSectionTitle("Recent Keywords"),
              const SizedBox(height: 10),
              _buildRecentKeywords(),
              const SizedBox(height: 25),
              _buildSectionTitle("Suggested Products"),
              const SizedBox(height: 10),
              _buildSuggestedProducts(),
              const SizedBox(height: 25),
              _buildSectionTitle("Popular Products"),
              const SizedBox(height: 15),
              _buildPopularProducts(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    // Simulated search results based on the search query
    final query = _searchController.text.toLowerCase();
    final filteredProducts = [
      ...suggestedProducts,
      {"name": "iPhone SE", "rating": 4.3, "price": "\$399"},
      {"name": "iPhone 11", "rating": 4.5, "price": "\$599"},
    ].where((product) =>
        product["name"].toString().toLowerCase().contains(query)
    ).toList();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: filteredProducts.isEmpty
          ? _buildEmptySearchResults()
          : _buildSearchResultsList(filteredProducts),
    );
  }

  Widget _buildEmptySearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_wnqlfojb.json',
            height: 200,
            repeat: true,
          ),
          const SizedBox(height: 20),
          Text(
            "No results found for '${_searchController.text}'",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "Try different keywords or browse categories",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultsList(List<Map<String, dynamic>> results) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: results.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildProductCard(results[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Handle product tap
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/iphone16.png",
                      height: 60,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.smartphone, size: 30, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["name"],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${product["rating"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            product["price"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart_outlined, color: Colors.blue),
                  onPressed: () {
                    // Add to cart animation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product["name"]} added to cart'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentKeywords() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: recentKeywords.asMap().entries.map((entry) {
        final index = entry.key;
        final keyword = entry.value;

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 400 + (index * 100)),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: InkWell(
            onTap: () {
              setState(() {
                _searchController.text = keyword;
                _isSearching = true;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.history, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 6),
                  Text(
                    keyword,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuggestedProducts() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: suggestedProducts.length,
      itemBuilder: (context, index) {
        final product = suggestedProducts[index];

        return AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/iphone16.png",
                      height: 40,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.smartphone, size: 24, color: Colors.grey),
                    ),
                  ),
                ),
                title: Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product['rating'].toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      product['price'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    // Navigate to product details
                  },
                ),
                onTap: () {
                  // Navigate to product details
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopularProducts() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Show more items for better scrolling experience
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          // Repeat the products if we have more indices than actual products
          final productIndex = index % popularProducts.length;
          final product = popularProducts[productIndex];

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // Navigate to product details
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                product['image'],
                                height: 80,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.smartphone, size: 40, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product['price'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[700],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildAddButton(),
                          ],
                        ),
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
  }

  Widget _buildAddButton() {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[300]!, Colors.blue[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            // Add to cart animation
          },
          child: const Center(
            child: Text(
              "Add to Cart",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}