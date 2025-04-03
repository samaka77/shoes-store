import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_store/controller/home_controller.dart';
import 'package:shoes_store/pages/add_product_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchProduct();
          },

          child: Scaffold(
            appBar: AppBar(title: Text('Shoes Store Admin')),
            body: ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.products[index].name ?? ''),
                  subtitle: Text(
                    (controller.products[index].price ?? 0.0).toString(),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.deleteProducts(controller.products[index].id ?? '');
                    },
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Get.to(() => AddProductPage());
              },
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
