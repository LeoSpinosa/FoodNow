import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final String placeholder;
  final bool type;
  final TextEditingController controller;
  final bool enabled;
  final bool showSearchIcon; 

  MyInput({
    Key? key,
    required this.placeholder,
    required this.type,
    required this.controller,
    required this.enabled,
    this.showSearchIcon = false, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: type,
        enabled: enabled,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: placeholder,
          prefixIcon: showSearchIcon ? Icon(Icons.search) : null, 
        ),
      ),
    );
  }
}