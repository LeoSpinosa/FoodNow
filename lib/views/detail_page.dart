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
      backgroundColor: Colors.green[50],
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
                  Text("Descrição: ${foodItem['descricao'] ?? ''}",
                  style: TextStyle(fontSize: 18), ),
                  SizedBox(height: 16.0),
                  Text("Preço: R\$ ${foodItem['preco'] ?? ''}",
                  style: TextStyle(fontSize: 18), ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[800],
                        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
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
