import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:styleswap/pages/main_page.dart';
import 'package:styleswap/pages/sign_in_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



/// Page de connexion
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  final _storage = const FlutterSecureStorage(); // Instance de FlutterSecureStorage

  // Méthode pour simuler la connexion
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Vous pouvez ajouter la logique de connexion ici
      // URL de ton API de connexion
    final Uri url = Uri.parse('http://localhost:8080/api/v1/login/login'); // Remplace avec l'URL de ton API

    // Création du body de la requête
    final Map<String, dynamic> body = {
      'useremail': _email,
      'userpw': _password,
    };

    try {
      // Envoi de la requête POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body), // Convertir le body en JSON
      );

      if (response.statusCode == 200) {
        // Si la connexion réussit, récupérer les données de la réponse
        final Map<String, dynamic> data = jsonDecode(response.body);

        final String token = data['token'];
        print('Connexion réussie, Token stocké');

        // Exemple : Récupérer le token si l'API en renvoie un
        await _storage.write(key: 'auth_token', value: token);

        // Rediriger vers la page d'accueil après la connexion réussie
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
        (Route<dynamic> route) => false, 
      );

      } else if (response.statusCode == 401) {
        // Afficher un message d'erreur si les identifiants sont incorrects
        print('Identifiants incorrects');
        // Retourner à la page de connexion
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // Supprimer toutes les autres pages de la pile
        );
      } else {
        // Afficher un message d'erreur pour d'autres codes d'erreur
        print('Erreur de connexion : ${response.statusCode}');
        // Retourner à la page de connexion
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // Supprimer toutes les autres pages de la pile
        );
      }
    } catch (e) {
      // Si une erreur réseau se produit, afficher un message d'erreur
      print('Erreur de connexion : $e');
    }
    }
  }

  // Méthode pour rediriger vers la page de création de compte
  void _goToSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center( // Centrer verticalement le formulaire
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Texte de bienvenue
                Text(
                  'Bienvenue sur StyleSwap',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 80), // Espacement entre le texte et le formulaire
                // Formulaire de connexion
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Champ pour l'email
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Adresse e-mail',
                          labelStyle: TextStyle(color: Colors.indigo),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30), // Bordures arrondies
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.indigoAccent),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre adresse e-mail';
                          } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                            return 'Veuillez entrer un e-mail valide';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      SizedBox(height: 16),

                      // Champ pour le mot de passe
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: TextStyle(color: Colors.indigo),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30), // Bordures arrondies
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.indigoAccent),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      SizedBox(height: 80),

                      // Bouton "Se connecter"
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8, // Largeur ajustée
                        child: ElevatedButton.icon(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent, // Couleur du bouton
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Bordures arrondies
                            ),
                          ),
                          icon: Icon(Icons.login, color: Colors.white),
                          label: Text(
                            'Se connecter',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Bouton "Créer un compte"
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                          onPressed: _goToSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey, // Couleur du bouton
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Bordures arrondies
                            ),
                          ),
                          child: Text(
                            'Créer un compte',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}