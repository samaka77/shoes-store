import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shoes_client/controller/login_controller.dart';
import 'package:shoes_client/pages/forgetPassowrd_page.dart';
import 'package:shoes_client/pages/home_page.dart';
import 'package:shoes_client/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.blueGrey[53]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),

                const SizedBox(height: 20),
                TextField(
                  controller: ctrl.emailCtrl,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.phone_android),
                    labelText: 'Email',
                    hintText: 'Enter You Email',
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => TextField(
                    obscureText: !ctrl.isPasswordVisible.value,
                    controller: ctrl.passwordCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          ctrl.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          ctrl.togglePasswordVisibility();
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                 alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Get.to(Forgetpassword());
                    },
                    child: Text(
                      'Forget Passowrd?',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(HomePage());
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Login'),
                ),
                
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.to(RegisterPage());
                  },
                  child: const Text('Register new account'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
