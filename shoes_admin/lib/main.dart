import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoes_store/controller/home_controller.dart';
import 'package:shoes_store/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  
   WidgetsFlutterBinding.ensureInitialized();
   await Supabase.initialize(
    url: 'https://oomhdfpkhpehdtxnwdya.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vbWhkZnBraHBlaGR0eG53ZHlhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE5NTUyOTMsImV4cCI6MjA1NzUzMTI5M30.Xy800OS9vrFj99WWjfhRjuCvoJQ7qc4kaz6UeMaqz_8',
  );
    Get.put(HomeController()); 
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoes Store',
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}
