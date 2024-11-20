import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moturep/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final List<Map<String, String>> parts = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addPart(String name, String price, String description) async {
    try {
      await _firestore.collection('parts').add({
        'name': name,
        'price': price,
        'description': description,
        'image': 'https://via.placeholder.com/150',
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() {
        parts.add({
          "name": name,
          "price": price,
          "description": description,
          "image": "https://via.placeholder.com/150"
        });
      });
    } catch (e) {
      print("Error al agregar repuesto: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Ventas de Repuestos"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Nombre del repuesto'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _priceController,
              decoration: InputDecoration(hintText: 'Precio'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(hintText: 'Descripción'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty &&
                  _priceController.text.isNotEmpty &&
                  _descriptionController.text.isNotEmpty) {
                _addPart(
                    _nameController.text,
                    _priceController.text,
                    _descriptionController.text);
                _nameController.clear();
                _priceController.clear();
                _descriptionController.clear();
              }
            },
            child: Text("Agregar Repuesto"),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('parts').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final partsData = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: partsData.length,
                  itemBuilder: (context, index) {
                    final part = partsData[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(part['name']),
                        subtitle: Text(part['description']),
                        leading: Image.network(part['image']),
                        trailing: Text("\$${part['price']}"),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
