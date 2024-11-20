import 'package:flutter/material.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage(String message) {
    setState(() {
      _messages.add({"sender": "user", "message": message});
      _messages.add({"sender": "bot", "message": _getBotResponse(message)});
      _messages.add({"sender": "bot", "message": getBotResponse(message)});
    });
    _controller.clear();
  }

  String _getBotResponse(String message) {
    if (message.contains("precio") || message.contains("moto")) {
      return "El precio de las motos varía según el modelo. ¿Qué moto te interesa?";
    } else {
      return "¡Hola! Soy el asistente de Moturep. ¿En qué puedo ayudarte?";
    }
  }
   String getBotResponse(String message) {
    if (message.contains("hola") || message.contains("me gustaria saber")) {
      return "claro cuentame que es lo que te gustaria saber!";
    } else {
      return "¡Hola! Soy el asistente de Moturep. ¿En qué puedo ayudarte?";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Align(
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
                    hintText: 'Escribe  mensajes como hola, precio, moto aquí...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
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
    );
  }
}
