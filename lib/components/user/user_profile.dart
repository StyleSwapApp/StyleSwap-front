import 'package:flutter/material.dart';
import 'package:styleswap/services/user_service.dart';

class UserProfile extends StatelessWidget {
  final UserService userService = UserService(); // Instance du service

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: userService.getUserInformations(1), // Future qui récupère les données utilisateur
      builder: (context, snapshot) {
        // Vérification de l'état de la connexion avec le Future
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Affichage d'un indicateur de chargement
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Affichage d'une erreur si le Future échoue
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          // Cas où aucune donnée n'est retournée
          return Center(child: Text('Aucune information utilisateur disponible.'));
        } else {
          // Affichage des données utilisateur lorsque le Future a réussi
          var userInfo = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  '${userInfo['firstName']} ${userInfo['lastName']}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  userInfo['email'] ?? '', // Si 'email' est nul, affiche une chaîne vide
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
