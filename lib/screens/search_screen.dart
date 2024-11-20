import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import 'cart_screen.dart';  

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, String>> parts = [
    {"name": "Filtro de aire", "precio": "20.000", "description": "Filtro de aire para moto", "image": "https://via.placeholder.com/150"},
    {"name": "Bujía", "precio": "40.000", "description": "Bujía de alta calidad", "image": "https://via.placeholder.com/150"},
    
  ];

  List<Map<String, String>> cartItems = [];  

  void _addToCart(Map<String, String> part) {
    setState(() {
      cartItems.add(part);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Busca tu Repuesto"),
      body: ListView.builder(
        itemCount: parts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(parts[index]["name"]!),
              subtitle: Text(parts[index]["description"]!),
              leading: Image.network(parts[index]["image"]!),
              trailing: Text("\$${parts[index]["precio"]}"),
              onTap: () {
                _addToCart(parts[index]);  
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${parts[index]["name"]} añadido al carrito")));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(cartItems: cartItems),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
