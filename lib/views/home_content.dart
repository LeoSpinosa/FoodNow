import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_foodcart.dart';
import 'package:foodnow2/views/category_button.dart';
import 'package:foodnow2/views/detail_page.dart';
import 'package:foodnow2/views/favorite_page.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> foodItems;
  final List<Map<String, String>> favoriteItems;
  final Function(Map<String, String>) onFavoriteToggle;
  final Function(Map<String, String>) addToCart;

  const HomeContent({
    required this.foodItems,
    required this.favoriteItems,
    required this.onFavoriteToggle,
    required this.addToCart,
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
            children: <Widget>[
              CategoryButton(
                label: 'Bebida',
                isSelected: false,
                onTap: () {},
              ),
              CategoryButton(
                label: 'Lanches',
                isSelected: false,
                onTap: () {},
              ),
              CategoryButton(
                label: 'Sobremesa',
                isSelected: false,
                onTap: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: foodItems.length,
            itemBuilder: (context, index) {
              final item = foodItems[index];
              final isFavorite = favoriteItems.any((favorite) => favorite['name'] == item['name']);
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
                  name: item['name']!,
                  description: item['description']!,
                  imageUrl: item['imageUrl']!,
                  price: item['price']!,
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

