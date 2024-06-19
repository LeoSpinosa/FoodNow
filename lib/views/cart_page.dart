import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_foodcart.dart';
import 'package:foodnow2/services/firebase_connect.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems;
  final Function(Map<String, String>) onRemove;

  const CartPage({
    required this.cartItems,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 168, 168, 168),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return FoodCard(
            name: item['name'] ?? '',
            description: item['description'] ?? '',
            imageUrl: item['imageUrl'] ?? '',
            price: item['price'] ?? '',
            isFavorite: false,  
            onRemove: () async {
              await removeCart(item);
              onRemove(item);
            },
          );
        },
      ),
    );
  }
}