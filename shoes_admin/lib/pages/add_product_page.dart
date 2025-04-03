import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shoes_store/components/custom_text_field.dart';
import 'package:shoes_store/components/dropdown_button.dart';
import 'package:shoes_store/controller/home_controller.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('Add  Product')),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Add New Product',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    controller: controller.productNameCtrl,
                    label: 'Product Name',
                    hintText: 'Enter Your Product Name',
                  ),

                  SizedBox(height: 10),
                  CustomTextField(
                    controller: controller.productDescriptionCtrl,
                    label: "Product Description",
                    hintText: 'Enter Your Product Description',
                    line: 4,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: controller.productImageCtrl,
                    label: 'Image URL',
                    hintText: 'Enter Your Image Url',
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: controller.productPriceCtrl,
                    label: "Product Price",
                    hintText: 'Enter You Product Price',
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Flexible(
                        child: CustomDropDown(
                          selectedItemText: controller.category,
                          items: [
                            'Boots',
                            'Shoes',
                            'Beach Shoes',
                            'High heels',
                          ],
                          onSelected: (select) {
                            controller.category = select ?? 'Genral';
                            controller.update();
                          },
                        ),
                      ),
                      Flexible(
                        child: CustomDropDown(
                          selectedItemText: controller.brand,
                          items: ['Puma', 'Adidas', 'Clarks', 'Sketchers'],
                          onSelected: (select) {
                            controller.brand = select ?? 'un Brand';
                            controller.update();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Offer Product ?'),
                  CustomDropDown(
                    selectedItemText: controller.offer.toString(),
                    items: ['True', 'False'],
                    onSelected: (selected) {
                      controller.offer =
                          bool.tryParse(selected ?? 'false') ?? false;
                      controller.update();
                    },
                  ),

                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,

                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      controller.addProduct();
                      
                      
                    },
                    child: Text(
                      'Add Product',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
