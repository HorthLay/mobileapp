import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/model/category.dart';
import 'package:vireakrothmobile/services/api_service.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = <Category>[].obs;
  var categoryId = ''.obs; // Define categoryId as an observable string

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading.value = true;
      var categories = await ApiService.getCategories();
      categoryList.value = categories;
      print('Fetched Categories: $categories'); // Debug print to check fetched categories
    } catch (e) {
      Get.snackbar("Error", "Failed to load categories: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  // Optional: Method to update the selected category ID
  void setSelectedCategoryId(String id) {
    categoryId.value = id;
  }
}

