import 'package:flutter/material.dart';
import '../widgets/message_bubble.dart'; // Importation des bulles de messages

class ChatScreen extends StatefulWidget {
  final String user;
  ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> messages = ['Hello', 'Comment ça va ?'];
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          // Liste des messages
          Expanded(
            child: ListView.builder(
              reverse: true, // Affiche les messages du plus récent au plus ancien
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index], isUserMessage: true, time: '12:30');
              },
            ),
          ),
          // Zone de saisie du message
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Écrire un message...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      messages.insert(0, _controller.text); // Ajoute le message à la liste
                    });
                    _controller.clear(); // Efface le champ de saisie
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
