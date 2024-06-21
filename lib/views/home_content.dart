import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_foodcart.dart';
import 'package:foodnow2/views/category_button.dart';
import 'package:foodnow2/views/detail_page.dart';
import 'package:foodnow2/views/favorite_page.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, dynamic>> foodItems;
  final List<Map<String, String>> favoriteItems;
  final Function(Map<String, dynamic>) onFavoriteToggle;
  final Function(Map<String, dynamic>) addToCart;
  final List<Map<String, dynamic>> categoryItems;

  const HomeContent({
    required this.foodItems,
    required this.favoriteItems,
    required this.onFavoriteToggle,
    required this.addToCart,
    required this.categoryItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: categoryItems.map((category) {
              return CategoryButton(
                label: category['nome'] ?? '',
                imageUrl: category['imagem'] ?? '',
                isSelected: false,
                onTap: () {},
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              final item = foodItems[index];
              final isFavorite = favoriteItems
                  .any((favorite) => favorite['nome'] == item['nome']);
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        foodItem: item,
                        addToCart: addToCart,
                      ),
                    ),
                  );
                },
                child: FoodCard(
                  name: item['nome']!,
                  description: item['descricao']!,
                  imageUrl: item['imagem']!,
                  price: item['preco']!,
                  isFavorite: isFavorite,
                  onFavoriteToggle: () => onFavoriteToggle(item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
