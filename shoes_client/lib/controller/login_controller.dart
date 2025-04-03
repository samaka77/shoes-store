import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_client/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SupabaseClient _supabase = Supabase.instance.client;

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
   var isPasswordVisible = false.obs; 

  Future<void> registerUser() async {
    try {
      if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty || nameCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please fill all fields', colorText: Colors.red);
        return;
      }
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );
      
      String userId = userCredential.user!.uid;
      await _supabase.from('users').insert({
        'id': userId,
        'name': nameCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
      });
      
      Get.snackbar('Success', 'User registered successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  Future<void> loginUser() async {
    try {
      if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
        Get.snackbar('Error', 'Please enter email and password', colorText: Colors.red);
        return;
      }
      
      await _auth.signInWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );
      
      Get.snackbar('Success', 'Login successful', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  Future<void> logoutUser() async {
    await _auth.signOut();
    Get.snackbar('Success', 'Logged out', colorText: Colors.green);
      Get.offAll(LoginPage());
  }
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
