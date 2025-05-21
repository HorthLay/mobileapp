import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vireakrothmobile/model/category.dart';
import 'package:vireakrothmobile/model/product_model.dart';
import 'package:vireakrothmobile/services/api_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var categoryList = <Category>[].obs;
  var products = <Product>[].obs;

  static const String baseUrl = "https://wtd.qpz.temporary.site/api";

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        var products = (json.decode(response.body) as List)
            .map((product) => Product.fromJson(product))
            .toList();
        productList.assignAll(products);
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }

  // Example of a void method
  void printProductNames() {
    for (var product in productList) {
      print(product.name);
    }
  }

  // Another example of a void method that fetches categories
  void fetchCategories() async {
    try {
      isLoading(true);
      var result = await ApiService.getCategories();
      categoryList.value = result;
    } catch (e) {
      Get.snackbar("Error", "Failed to load categories: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
