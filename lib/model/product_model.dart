class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final int stock;
  final int categoryId;
  final String? image;
  final int quantitySold;
  final String status;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.stock,
    required this.categoryId,
    this.image,
    required this.quantitySold,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      discount: double.tryParse(json['discount'].toString()) ?? 0.0,
      stock: json['stock'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      image: json['image'],
      quantitySold: json['quantity_sold'] ?? 0,
      status: json['status'] ?? '',
    );
  }
}
