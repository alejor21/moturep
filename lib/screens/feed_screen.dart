import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, String>> posts = [];
  final TextEditingController _textController = TextEditingController();
  String _imageUrl = "";

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _addPost(String text, String imageUrl) async {
    
    try {
      await _firestore.collection('posts').add({
        'text': text,
        'image': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
      setState(() {
        posts.add({"text": text, "image": imageUrl});
      });
    } catch (e) {
      print("Error al agregar post: $e");
    }
  }

  Future<void> _pickImage() async {
    setState(() {
      _imageUrl = "https://via.placeholder.com/150"; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Feed de Publicaciones"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(hintText: 'Escribe algo...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_textController.text.isNotEmpty && _imageUrl.isNotEmpty) {
                      _addPost(_textController.text, _imageUrl);
                      _textController.clear();
                      _imageUrl = "";
                    }
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text("Cargar Imagen"),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('posts').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final postsData = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: postsData.length,
                  itemBuilder: (context, index) {
                    final post = postsData[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(post['text']),
                        leading: Image.network(post['image']),
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
