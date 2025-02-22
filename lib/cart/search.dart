import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> recentKeywords = ["Samsung", "Oppo", "Vivo", "Samsung"];
  final List<Map<String, dynamic>> suggestedProducts = [
    {"name": "iPhone 12 Pro Max", "rating": 4.6},
    {"name": "iPhone 12 Pro Max", "rating": 4.7},
    {"name": "iPhone 12 Pro Max", "rating": 4.4},
  ];
  final List<Map<String, dynamic>> popularProducts = [
    {"name": "IPHONE 15 PRO MAX", "image": "assets/images/iphone16.png"},
    {"name": "IPHONE 13 PRO MAX", "image": "assets/images/iphone16.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      "Search",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Recent Keywords", style: TextStyle(fontWeight: FontWeight.bold)),
                Wrap(
                  spacing: 8,
                  children: recentKeywords.map((keyword) => Chip(label: Text(keyword))).toList(),
                ),
                const SizedBox(height: 20),
                const Text("Suggested Products", style: TextStyle(fontWeight: FontWeight.bold)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: suggestedProducts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/iphone16.png"),
                      ),
                      title: Text(suggestedProducts[index]['name']),
                      subtitle: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 16),
                          const SizedBox(width: 5),
                          Text(suggestedProducts[index]['rating'].toString()),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text("Popular Products", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: popularProducts.map((product) {
                    return Expanded(
                      child: Column(
                        children: [
                          Image.asset(product['image'], height: 80),
                          Text(product['name'], textAlign: TextAlign.center),
                          const SizedBox(height: 5),
                          const Icon(Icons.add_circle, color: Colors.blue),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
