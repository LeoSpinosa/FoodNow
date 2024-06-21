import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_BottomNavigation.dart';
import 'package:foodnow2/components/my_appbar.dart';
import 'package:foodnow2/services/firebase_connect.dart';
import 'package:foodnow2/views/cart_page.dart';
import 'package:foodnow2/views/favorite_page.dart';
import 'package:foodnow2/views/feedback_page.dart';
import 'package:foodnow2/views/home_content.dart';
import 'package:foodnow2/views/user_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _foodItems = [];
  List<Map<String, String>> _favoriteItems = [];
  List<Map<String, String>> _cartItems = [];
  List<Map<String, dynamic>> _categoryItems = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
    _loadFavorites();
    _loadCategories();
  }

  Future<void> _loadItems() async {
    _foodItems = await get_itens();
    setState(() {});
  }

  Future<void> _loadFavorites() async {
    _favoriteItems = await getFavorites();
    setState(() {});
  }

  Future<void> _loadCategories() async {
    _categoryItems = await get_categorias();
    setState(() {});
  }

  void _toggleFavorite(Map<String, dynamic> foodItem) async {
    setState(() {
      if (_favoriteItems.any((item) => item['nome'] == foodItem['nome'])) {
        _favoriteItems.removeWhere((item) => item['nome'] == foodItem['nome']);
        removeFromFavorites(foodItem.cast<String, String>());
      } else {
        _favoriteItems.add(foodItem.cast<String, String>());
        addToFavorites(foodItem.cast<String, String>());
      }
    });
  }

  void _addToCart(Map<String, dynamic> foodItem) {
    setState(() {
      _cartItems.add(foodItem.cast<String, String>());
    });
  }

  void _removeFromCart(Map<String, String> foodItem) {
    setState(() {
      _cartItems.remove(foodItem);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: MyAppBar(title: 'FoodNow'),
      body: _widgetOptions().elementAt(_selectedIndex),
      bottomNavigationBar: MyBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> _widgetOptions() => [
        HomeContent(
          foodItems: _foodItems,
          favoriteItems: _favoriteItems,
          onFavoriteToggle: _toggleFavorite,
          addToCart: _addToCart,
          categoryItems: _categoryItems,
        ),
        FavoritePage(
          favoriteItems: _favoriteItems,
          onFavoriteToggle: _toggleFavorite,
        ),
        CartPage(
          cartItems: _cartItems,
          onRemove: _removeFromCart,
        ),
        FeedbackPage(),
        UpdateUser(),
      ];
}
