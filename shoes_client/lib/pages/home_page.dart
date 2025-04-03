import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shoes_client/controller/home_controller.dart';
import 'package:shoes_client/controller/login_controller.dart';
import 'package:shoes_client/pages/login_page.dart';
import 'package:shoes_client/pages/product_details.dart';
import 'package:shoes_client/widgets/drop_down.dart';
import 'package:shoes_client/widgets/multi_select_drop_down.dart';
import 'package:shoes_client/widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // String data = Get.arguments['data'];
    // print(data);
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return RefreshIndicator(
          onRefresh: () async {
            ctrl.fetchProduct();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Shoes Store',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                GetBuilder<LoginController>(
                  builder: (ctrl) {
                    return IconButton(
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Center(child: Text('Logout',style: TextStyle(fontSize: 20,color: Colors.white))),
                            content: Text('Are you sure you want to logout?',style: TextStyle(fontSize: 16,color: Colors.white),),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  ctrl.logoutUser();
                                  Get.offAll(LoginPage());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Text('Yes',style: TextStyle(color: Colors.black),)),
                              ),
                              SizedBox(width: 60),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  
                                  child: Text('No',style: TextStyle(color: Colors.black))),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.logout_outlined),
                    );
                  },
                ),
              ],
            ),

            body: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.categorys.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterByCategory(
                            ctrl.categorys[index].name ?? 'no filter',
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Chip(
                            label: Text(ctrl.categorys[index].name ?? 'Error'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: CustomDropDown(
                        items: ['Rs: Low to High ', 'Rs: High to Low'],
                        selectedItemText: 'Sort',
                        onSelected: (selected) {
                          ctrl.SortByPrice(
                            ascending:
                                selected == 'Rs: Low to High ' ? true : false,
                          );
                        },
                      ),
                    ),
                    Flexible(
                      child: MultiSelectDropDown(
                        items: ['Adidas ', 'Puma', 'Clarks', 'Sketchers'],
                        onSelectionChanged: (selectedItems) {
                          ctrl.filterByBrand(selectedItems);
                        },
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: ctrl.productShowInUi.length,

                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? 'No Name',
                        imageUrl: ctrl.productShowInUi[index].image ?? 'URL',

                        price: ctrl.productShowInUi[index].price ?? 00,
                        offerTag: '20 % off',
                        onTap: () {
                          // Get.to(
                          //   ProductDetails(),
                          //   arguments: {'data': ctrl.productShowInUi[index]},

                          // );
                          print(
                            'Sending product data: ${ctrl.productShowInUi[index]}',
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => ProductDetails(
                                    product: ctrl.productShowInUi[index],
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
