import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'sales_screen.dart';
import 'search_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  
  final List<Widget> _screens = [
    MainScreenContent(), 
    FeedScreen(),        
    SalesScreen(),      
    SearchScreen(),      
  ];

  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moturep'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Text(
                'Moturep',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Chatbot'),
              onTap: () => _selectScreen(0),
            ),
            ListTile(
              title: Text('Feed de Publicaciones'),
              onTap: () => _selectScreen(1),
            ),
            ListTile(
              title: Text('Venta de Repuestos'),
              onTap: () => _selectScreen(2),
            ),
            ListTile(
              title: Text('Buscar Repuestos'),
              onTap: () => _selectScreen(3),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}


class MainScreenContent extends StatefulWidget {
  @override
  _MainScreenContentState createState() => _MainScreenContentState();
}

class _MainScreenContentState extends State<MainScreenContent> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  
  void _sendMessage(String message) {
    setState(() {
      
      _messages.add({"sender": "user", "message": message});
      
      _messages.add({"sender": "bot", "message": _getBotResponse(message)});
    });
    _controller.clear();
  }

  
  String _getBotResponse(String message) {
    if (message.contains("precio") || message.contains("moto")) {
      return "El precio de las motos varía según el modelo. ¿Qué moto te interesa?";
    } else if (message.contains("hola") || message.contains("ayuda")) {
      return "¡Hola! Soy el asistente de Moturep. ¿En qué puedo ayudarte?";
    } else {
      return "No entiendo esa consulta. ¿Puedes ser más específico?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 20),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'Moturep',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Align(
                    alignment: _messages[index]["sender"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _messages[index]["sender"] == "user"
                            ? Colors.blueAccent
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _messages[index]["message"]!,
                        style: TextStyle(
                          color: _messages[index]["sender"] == "user"
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.red),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
