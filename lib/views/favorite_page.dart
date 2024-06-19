import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_foodcart.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, String>> favoriteItems;
  final Function(Map<String, String>) onFavoriteToggle;

  const FavoritePage({
    required this.favoriteItems,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return FoodCard(
            name: item['name']!,
            description: item['description']!,
            imageUrl: item['imageUrl']!,
            price: item['price']!,
            isFavorite: true,
            onFavoriteToggle: () => onFavoriteToggle(item),
          );
        },
      ),
    );
  }
}

