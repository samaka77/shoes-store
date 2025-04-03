import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_client/controller/login_controller.dart';
import 'package:shoes_client/pages/login_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctr) {
        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.blueGrey[50]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create Your Account!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: ctr.nameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Your Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: ctr.emailCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
                const SizedBox(height: 20),
                Obx( () =>
                   TextField(
                     obscureText: !ctr.isPasswordVisible.value, 
                    controller: ctr.passwordCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      suffixIcon:  IconButton(
                        icon: Icon(ctr.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          ctr.togglePasswordVisibility();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ctr.registerUser();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const LoginPage());
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
