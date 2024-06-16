import 'package:flutter/material.dart';
import 'package:foodnow2/views/login_page.dart';

main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: false),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}