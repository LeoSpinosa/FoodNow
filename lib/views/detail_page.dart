import 'package:flutter/material.dart';
import 'package:foodnow2/components/my_appbar.dart';
import 'package:foodnow2/services/firebase_connect.dart';

class DetailsPage extends StatelessWidget {
  final Map<String, dynamic> foodItem;
  final Function(Map<String, dynamic>) addToCart;

  const DetailsPage({
    required this.foodItem,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: foodItem['nome'] ?? 'Detalhes'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              foodItem['imagem'] ?? '',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Descrição: ${foodItem['descricao'] ?? ''}"),
                  SizedBox(height: 16.0),
                  Text("Preço: R\$ ${foodItem['preco'] ?? ''}"),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      await addToCart(foodItem);
                      addCart(foodItem.cast<String, String>());
                      Navigator.pop(context);
                    },
                    child: Text('Adicionar ao Carrinho'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
