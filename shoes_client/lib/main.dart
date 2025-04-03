import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shoes_client/controller/home_controller.dart';
import 'package:shoes_client/controller/login_controller.dart';
import 'package:shoes_client/controller/puraches_cotroller.dart';
import 'package:shoes_client/pages/login_page.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: FirebaseOptions(
  //     apiKey: "AIzaSyCUO0i8mkZTtX9wgKso_NkcMr9ICfOH4nc",
  //     authDomain: "shoes-store-f80f6.firebaseapp.com",
  //     projectId: "shoes-store-f80f6",
  //     storageBucket: "shoes-store-f80f6.firebasestorage.app",
  //     messagingSenderId: "1055494208360",
  //     appId: "1:1055494208360:web:88690fdfbaf054312a34dd",
  //     measurementId: "G-6BMW2W92RG",
  //   ),
  // );
   await Firebase.initializeApp();
  await Supabase.initialize(
    url: 'https://oomhdfpkhpehdtxnwdya.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vbWhkZnBraHBlaGR0eG53ZHlhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE5NTUyOTMsImV4cCI6MjA1NzUzMTI5M30.Xy800OS9vrFj99WWjfhRjuCvoJQ7qc4kaz6UeMaqz_8',
  );
   Stripe.publishableKey = "pk_test_51R56zi2NR5UwNcLFHh0EttWdRkVovEifh0OEQRSl0ajRrqfupO8IQL2J2JWofkJ22XogQFmIAJukAznDN7TJVbWq00l6eAtv";
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(PurchesController()); 


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LoginPage(),
    );
  }
}
