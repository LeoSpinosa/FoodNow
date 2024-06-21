import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_foodcart.dart';
import 'package:foodnow2/services/firebase_connect.dart';
import 'package:foodnow2/views/home_page.dart';

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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return FoodCard(
                  name: item['nome']!,
                  description: item['descricao']!,
                  imageUrl: item['imagem']!,
                  price: item['preco']!,
                  isFavorite: false,
                  onFavoriteToggle: () {},
                  onRemove: () async {
                    await onRemove(item);
                    removeCart(item);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await finalizePurchase(cartItems);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Text('Finalizar Compra'),
          ),
        ],
      ),
    );
  }
}
