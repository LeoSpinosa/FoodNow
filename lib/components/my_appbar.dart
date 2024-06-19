import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.red,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}