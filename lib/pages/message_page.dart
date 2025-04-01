import 'package:flutter/material.dart';
import 'chat_screen.dart'; // Page de la conversation détaillée

/// Page des messages
class MessagePage extends StatelessWidget {
  // Retirer 'const' du constructeur, car la liste est dynamique
  MessagePage({super.key});

  // Liste des chats
  final List<String> chats = ['Alice', 'Bob', 'Charlie', 'David']; // Liste des contacts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(chats[index]),
              subtitle: Text('Dernier message...'), // Tu peux afficher ici un aperçu du dernier message
              onTap: () {
                // Lorsque l'utilisateur clique sur une conversation, on va vers l'écran de chat
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(user: chats[index]), // Navigue vers la conversation
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
