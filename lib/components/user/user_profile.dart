import 'package:flutter/material.dart';
import 'package:styleswap/services/user_service.dart';

class UserProfile extends StatelessWidget {
  final UserService userService = UserService(); // Instance du service

  @override
  Widget build(BuildContext context) {
    // Simulation d'un utilisateur avec ID 1
    Map<String, String> userInfo = userService.getUserInformations(1);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '${userInfo['firstName']} ${userInfo['lastName']}', // Récupération dynamique
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            userInfo['email'] ?? '', // Récupération dynamique
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}