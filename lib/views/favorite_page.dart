import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_foodcart.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, String>> favoriteItems;
  final Function(Map<String, dynamic>) onFavoriteToggle;

  const FavoritePage({
    required this.favoriteItems,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return FoodCard(
            name: item['nome']!,
            description: item['descricao']!,
            imageUrl: item['imagem']!,
            price: item['preco']!,
            isFavorite: true,
            onFavoriteToggle: () => onFavoriteToggle(item),
          );
        },
      ),
    );
  }
}