import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vireakrothmobile/model/product_model.dart';
import 'package:animate_do/animate_do.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryDetail extends StatefulWidget {
  final int categoryId;
  final String? categoryName;

  const CategoryDetail({
    super.key,
    required this.categoryId,
    this.categoryName,
  });

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> with SingleTickerProviderStateMixin {
  late Future<List<Product>> futureProducts;
  late TabController _tabController;
  bool _isGridView = true;
  String _sortBy = "Default";
  bool _isLoading = true;
  String? _errorMessage;
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  // Filter options
  final List<String> _filterOptions = ["All", "New", "Second-Hand", "Sale"];
  String _selectedFilter = "All";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadProducts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String fixImageUrl(String url) {
    if (url.isEmpty) return url;
    Uri uri = Uri.parse(url);
    Uri fixedUri = uri.replace(host: 'wtd.qpz.temporary.site');
    return fixedUri.toString();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final products = await fetchProductsByCategory(widget.categoryId);
      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('https://wtd.qpz.temporary.site/api/categories/$categoryId'),
      );

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        if (jsonBody['data'] is List) {
          final List data = jsonBody['data'];
          return data.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Unexpected JSON structure');
        }
      } else {
        throw Exception('Failed to load products (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  void _applyFilter(String filter) {
    setState(() {
      _selectedFilter = filter;

      if (filter == "All") {
        _filteredProducts = _products;
      } else if (filter == "New") {
        _filteredProducts = _products.where((p) => p.status == 'new').toList();
      } else if (filter == "Second-Hand") {
        _filteredProducts = _products.where((p) => p.status == 'second_hand').toList();
      } else if (filter == "Sale") {
        _filteredProducts = _products.where((p) => p.discount > 0).toList();
      }
    });
  }

  void _applySorting(String sortOption) {
    setState(() {
      _sortBy = sortOption;

      switch (sortOption) {
        case "Price: Low to High":
          _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case "Price: High to Low":
          _filteredProducts.sort((a, b) => b.price.compareTo(a.price));
          break;
        case "Name: A-Z":
          _filteredProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case "Name: Z-A":
          _filteredProducts.sort((a, b) => b.name.compareTo(a.name));
          break;
        default:
        // Default sorting (could be by ID or featured status)
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            if (_isLoading)
              _buildLoadingState()
            else if (_errorMessage != null)
              _buildErrorState()
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _loadProducts,
                  child: Column(
                    children: [
                      _buildCategoryHeader(),
                      _buildFilterOptions(),
                      Expanded(
                        child: _filteredProducts.isEmpty
                            ? _buildEmptyState()
                            : _isGridView
                            ? _buildProductGrid()
                            : _buildProductList(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 18),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.categoryName ?? 'Category Details',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Sen",
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Implement search functionality
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.search, size: 18),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                _showSortingBottomSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.filter_list, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.blue.shade700],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.categoryName ?? 'Category ${widget.categoryId}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sen",
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_filteredProducts.length} products found',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontFamily: "Sen",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _isGridView = true),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _isGridView ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.grid_view,
                        size: 18,
                        color: _isGridView ? Colors.blue.shade700 : Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => setState(() => _isGridView = false),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: !_isGridView ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.view_list,
                        size: 18,
                        color: !_isGridView ? Colors.blue.shade700 : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOptions() {
    return FadeInDown(
      duration: const Duration(milliseconds: 700),
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(bottom: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _filterOptions.length,
          itemBuilder: (context, index) {
            final filter = _filterOptions[index];
            final isSelected = _selectedFilter == filter;

            return GestureDetector(
              onTap: () => _applyFilter(filter),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                  ),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ] : null,
                ),
                child: Center(
                  child: Text(
                    filter,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                      fontFamily: "Sen",
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          duration: Duration(milliseconds: 500 + (index * 50)),
          child: _buildProductGridItem(_filteredProducts[index]),
        );
      },
    );
  }

  Widget _buildProductGridItem(Product product) {
    final imageUrl = fixImageUrl(product.image ?? '');

    return GestureDetector(
      onTap: () {
        // Navigate to product detail
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.error, color: Colors.grey),
                      ),
                    )
                        : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                    ),

                    if (product.discount > 0)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "-${_calculateDiscount(product.price, product.price - product.discount)}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: "Sen",
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    'Status: ${product.status}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontFamily: "Sen",
                    ),
                  ),
                  Text(
                    'Stock: ${product.stock}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontFamily: "Sen",
                    ),
                  ),

                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: product.discount > 0 ? Colors.grey : Colors.blue.shade700,
                          decoration: product.discount > 0 ? TextDecoration.lineThrough : null,
                          fontFamily: "Sen",
                        ),
                      ),
                      if (product.discount > 0) ...[
                        const SizedBox(width: 6),
                        Text(
                          "\$${(product.price - product.discount).toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.blue.shade700,
                            fontFamily: "Sen",
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          duration: Duration(milliseconds: 500 + (index * 50)),
          child: _buildProductListItem(_filteredProducts[index]),
        );
      },
    );
  }

  Widget _buildProductListItem(Product product) {
    final imageUrl = fixImageUrl(product.image ?? '');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to product detail
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.error, color: Colors.grey),
                      ),
                    )
                        : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                    ),

                    if (product.discount > 0)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "-${_calculateDiscount(product.price, product.price - product.discount)}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "Sen",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: "Sen",
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.discount > 0)
                              Text(
                                "\$${product.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: "Sen",
                                ),
                              ),
                            Text(
                              "\$${(product.discount > 0 ? product.price - product.discount : product.price).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue.shade700,
                                fontFamily: "Sen",
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_shopping_cart, size: 16, color: Colors.blue.shade700),
                              const SizedBox(width: 4),
                              Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                  fontFamily: "Sen",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Expanded(
      child: _isGridView ? _buildLoadingGrid() : _buildLoadingList(),
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 120,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
                fontFamily: "Sen",
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontFamily: "Sen",
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadProducts,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
              fontFamily: "Sen",
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your filter options',
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

  void _showSortingBottomSheet(BuildContext context) {
    final sortOptions = [
      "Default",
      "Price: Low to High",
      "Price: High to Low",
      "Name: A-Z",
      "Name: Z-A",
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sort By",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Sen",
                    ),
                  ),
                  Icon(Icons.sort),
                ],
              ),
              const SizedBox(height: 16),
              ...sortOptions.map((option) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    option,
                    style: TextStyle(
                      fontFamily: "Sen",
                      fontWeight: _sortBy == option ? FontWeight.bold : FontWeight.normal,
                      color: _sortBy == option ? Colors.blue : Colors.black,
                    ),
                  ),
                  trailing: _sortBy == option
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                  onTap: () {
                    _applySorting(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  int _calculateDiscount(double originalPrice, double discountPrice) {
    if (originalPrice <= 0) return 0;
    final discount = ((originalPrice - discountPrice) / originalPrice) * 100;
    return discount.round();
  }
}
