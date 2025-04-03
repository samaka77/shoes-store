import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shoes_client/controller/puraches_cotroller.dart';

import 'package:shoes_client/model/product/product.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchesController>(
      builder: (ctrl) {
      
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Product Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        product.image ?? '',
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      product.name ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      product.description ?? '',
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Rs: ${product.price ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: ctrl.addressController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: "Enter your Billing Address",
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.indigoAccent,
                        ),
                        onPressed: ()  async{
                          ctrl.submitOrder(
                            price: product.price ?? 0,
                            item: product.name ?? '',
                              description: product.description ?? '',
                          );
                          await ctrl.makePayment();
                        },
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        );

  }
}
