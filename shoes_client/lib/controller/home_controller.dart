import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_client/model/category/product_category.dart';
import 'package:shoes_client/model/product/product.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  late SupabaseQueryBuilder product;
  late SupabaseQueryBuilder category;

  List<Product> products = [];
  List<Product> productShowInUi = [];
  List<ProductCategory> categorys = [];

  @override
  void onInit() {
    product = supabase.from('product');
    category = supabase.from('category');
    fetchProduct();
    fetchCtegory();
    super.onInit();
  }

  fetchProduct() async {
    try {
      final response = await supabase.from('product').select();
      print("Response from DB: $response");
      final List<Product> reviteproducts =
          response
              .map((doc) => Product.fromJson(doc as Map<String, dynamic>))
              .toList();
      products.clear();
      products.assignAll(reviteproducts);
      productShowInUi.assignAll(products);
      // Get.snackbar(
      //   'Success',
      //   'Product fetch successfully',
      //   colorText: Colors.green,
      // );
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  fetchCtegory() async {
    try {
      final response = await supabase.from('category').select();
      final List<ProductCategory> reviteproductsCategory =
          response
              .map(
                (doc) => ProductCategory.fromJson(doc as Map<String, dynamic>),
              )
              .toList();
      categorys.clear();
      categorys.assignAll(reviteproductsCategory);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    productShowInUi.clear();
    productShowInUi =
        products.where((product) => product.category == category).toList();
    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productShowInUi = products;
    } else {
      List<String> lowerCaseBrands =
          brands.map((brand) => brand.toLowerCase()).toList();
      productShowInUi =
          products
              .where(
                (product) =>
                    lowerCaseBrands.contains(product.brand?.toLowerCase()),
              )
              .toList();
    }
  }

  SortByPrice({required bool ascending}) {
    List<Product> sortedProducts = List<Product>.from(productShowInUi);
    sortedProducts.sort(
      (a, b) =>
          ascending
              ? a.price!.compareTo(b.price!)
              : b.price!.compareTo(a.price!),
    );
    update();
  }
}
