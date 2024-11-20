import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cartItems;

  CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de Compras"),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Tu carrito está vacío"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(cartItems[index]["name"]!),
                    subtitle: Text(cartItems[index]["description"]!),
                    leading: Image.network(cartItems[index]["image"]!),
                    trailing: Text("\$${cartItems[index]["precio"]}"),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            
            Navigator.pushNamed(context, '/payment');
          },
          child: Text("Proceder al Pago"),
        ),
      ),
    );
  }
}
