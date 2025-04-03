import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final int? line;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.onChanged, 
     this.line,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: label,
        hintText: hintText,
        
      ),
      maxLines: line,
    );
  }
}
