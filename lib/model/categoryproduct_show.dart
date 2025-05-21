class CategoryProductShow{
  final String name;
  final String image;
  final double price;


  CategoryProductShow({
   required this.name,
   required this.image,
  required this.price,
});


  factory CategoryProductShow.fromJson(Map<String, dynamic> json){
    return CategoryProductShow(
      name: json['name'],
      image: json['image'],
      price: double.parse(json['price'].toString()),
    );
  }
}