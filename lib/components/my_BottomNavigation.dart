import 'package:flutter/material.dart';

class MyBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MyBottomNavigation({
    required this.currentIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, // Define a cor de fundo vermelha
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrrinho',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.white),
        unselectedIconTheme: IconThemeData(color: Colors.white),
        selectedLabelStyle: TextStyle(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        onTap: onTap,
        backgroundColor: Colors.red, // Isso ainda é necessário para alguns casos
        type: BottomNavigationBarType.fixed, // Certifique-se de que o tipo é "fixed"
      ),
    );
  }
}
