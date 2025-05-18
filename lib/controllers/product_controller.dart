import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vireakrothmobile/model/product_model.dart';
import 'package:vireakrothmobile/services/api_service.dart';
class ProductController extends GetxController{
  var isLoading = true.obs;
  var productList = <Product>[].obs;
@override
void onInit() {
  fetchProducts();
  super.onInit();
}
  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ApiService.getProducts(); // or getProducts(token) if protected
      productList.value = products;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
