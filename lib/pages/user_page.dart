import 'package:flutter/material.dart';
import 'package:styleswap/components/popup/confirmation_popup.dart';
import 'package:styleswap/components/user/user_profile.dart';
import 'package:styleswap/pages/login_page.dart';

/// Page du profil utilisateur
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool operationConfirmed = false; // Variable pour vérifier si l'opération est confirmée

  @override
  Widget build(BuildContext context) {
    // Vérifier si l'opération est confirmée pour rediriger
    if (operationConfirmed) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profil Utilisateur',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/user/blueLandscape.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 4 - 80,
                left: MediaQuery.of(context).size.width / 2 - 70,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/user/userIcon.png'),
                ),
              ),
            ],
          ),
          SizedBox(height: 100),
          UserProfile(),
          Expanded(child: Container()),
          Column(
            children: [
              // Bouton de déconnexion
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // Afficher la popup de confirmation avant de déconnecter
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationPopup(
                        message: "Êtes-vous sûr de vouloir vous déconnecter ?",
                        onConfirm: () {
                          setState(() {
                            operationConfirmed = true; // Marque la déconnexion comme confirmée
                          });
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
                      SizedBox(width: 10),
                      Icon(Icons.logout, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Bouton de suppression de compte
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    // Afficher la popup de confirmation avant de supprimer le compte
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmationPopup(
                        message: "Êtes-vous sûr de vouloir supprimer votre compte ?",
                        onConfirm: () {
                          setState(() {
                            operationConfirmed = true; // Marque la suppression du compte comme confirmée
                          });
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
                      SizedBox(width: 10),
                      Icon(Icons.delete, color: Colors.white),
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