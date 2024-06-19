import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String price;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onRemove;
 
  const FoodCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isFavorite,
    this.onFavoriteToggle,
    this.onRemove,
  });
 
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            SizedBox(height: 4.0),
            Text(
              price,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: onRemove != null
            ? IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: onRemove,
              )
            : IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                onPressed: onFavoriteToggle,
              ),
      ),
    );
  }
}