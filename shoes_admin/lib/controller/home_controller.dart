import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_store/model/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  late SupabaseQueryBuilder product;
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImageCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  String category = 'genral';
  String brand = 'un brand';
  bool offer = false;
  List<Product> products = [];

  @override
  void onInit() async {
    product = supabase.from('product');
    await fetchProduct();
    super.onInit();
  }

  addProduct() async {
    try {
      final uuid = Uuid();
      Product product = Product(
        name: productNameCtrl.text,
        id: uuid.v4(),
        category: category,
        description: productDescriptionCtrl.text,
        price: double.parse(productPriceCtrl.text),
        brand: brand,
        image: productImageCtrl.text,
        offer: offer,
      );
      final productJson = product.toJson();
      await supabase.from('product').insert(productJson);
      Get.snackbar('Success', 'Product Added ', colorText: Colors.green);
      setValueDefult();
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  fetchProduct() async {
    try {
      final response = await supabase.from('product').select();
      final List<Product> reviteproducts =
          response
              .map((doc) => Product.fromJson(doc as Map<String, dynamic>))
              .toList();
      products.clear();
      products.assignAll(reviteproducts);
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

  setValueDefult() {
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productImageCtrl.clear();
    productPriceCtrl.clear();
    category = 'Genral';
    brand = 'un Brand';
    offer = false;
    update();
  }

  deleteProducts(String id) async {
    try {
      await supabase.from('product').delete().eq('id', id);
      fetchProduct();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
    update();
  }
}
