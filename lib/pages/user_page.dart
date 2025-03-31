import 'package:flutter/material.dart';
import 'package:styleswap/components/popup/confirmation_popup.dart';
import 'package:styleswap/components/user/user_profile.dart';

/// Page du profil utilisateur
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profil Utilisateur',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 24, // Taille du texte du titre
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centrer le contenu
        children: [
          Stack(
            clipBehavior: Clip.none, // Cela permet à l'avatar de dépasser du conteneur
            children: [
              // Image en haut de la page
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4, // 1/4 de la hauteur de l'écran
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/user/blueLandscape.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                // Positionner l'avatar à moitié sur l'image et à moitié en dehors
                top: MediaQuery.of(context).size.height / 4 - 80, // Ajuster l'avatar
                left: MediaQuery.of(context).size.width / 2 - 70, // Centrer l'avatar horizontalement
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/user/userIcon.png'), // Utiliser la bonne syntaxe ici
                ),
              ),
            ],
          ),
          SizedBox(height: 100), // Espacement sous l'avatar pour mieux espacer
          UserProfile(),
          Expanded(child: Container()), // Permet de pousser le contenu vers le haut et laisser de l'espace pour les boutons
          Column(
            children: [
              // Bouton de déconnexion
              Container(
                width: MediaQuery.of(context).size.width * 0.7, // Définit la largeur à 80% de l'écran
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationPopup(
                        message: "Êtes-vous sûr de vouloir vous déconnecter ?",
                        onConfirm: () {
                          // Action pour se déconnecter
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Se déconnecter",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 10), // Espacement entre le texte et l'icône
                      Icon(Icons.logout, color: Colors.white), // Icône de déconnexion
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Bouton de suppression de compte
              Container(
                width: MediaQuery.of(context).size.width * 0.7, // Définit la largeur à 80% de l'écran
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationPopup(
                        message: "Êtes-vous sûr de vouloir supprimer votre compte ?",
                        onConfirm: () {
                          // Action pour supprimer le compte
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigoAccent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Supprimer le compte",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 10), // Espacement entre le texte et l'icône
                      Icon(Icons.delete, color: Colors.white), // Icône de poubelle
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(height: 60),
    );
  }
}