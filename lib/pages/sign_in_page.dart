import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:styleswap/pages/home_page.dart';
import 'package:styleswap/pages/login_page.dart';
import 'package:styleswap/pages/main_page.dart';
import 'package:styleswap/services/Token.dart';

/// Page de création de compte
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';

  // Méthode pour créer un objet User et naviguer vers la page d'accueil
  Future<void> _createAccount() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Créer un objet User avec les informations
      User newUser = User(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        password: _password,
      );

      // Vous pouvez sauvegarder cet utilisateur ou faire d'autres actions ici
      final Uri url = Uri.parse('http://172.20.10.4:8080/api/v1/register/newUser');

      final Map<String, dynamic> body = {
      'userfname': _firstName,
      'userlname': _lastName,
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

        // Stocker le token dans le shared preferences
        saveToken(token);

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
      // Rediriger vers la page d'accueil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }

  // Méthode pour annuler et rediriger vers la page de connexion
  void _cancel() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
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
                // Formulaire de création de compte
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Champ pour le prénom
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75, // Largeur ajustée
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Prénom',
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
                              return 'Veuillez entrer votre prénom';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _firstName = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      // Champ pour le nom
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75, // Largeur ajustée
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nom',
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
                              return 'Veuillez entrer votre nom';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _lastName = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      // Champ pour l'email
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75, // Largeur ajustée
                        child: TextFormField(
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
                      ),
                      SizedBox(height: 16),

                      // Champ pour le mot de passe
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75, // Largeur ajustée
                        child: TextFormField(
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
                              return 'Veuillez entrer un mot de passe';
                            } else if (value.length < 6) {
                              return 'Doit contenir au moins 6 caractères';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                      ),
                      SizedBox(height: 80),

                      // Bouton "Créer le compte"
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75, // Largeur ajustée
                        child: ElevatedButton(
                          onPressed: _createAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent, // Couleur du bouton
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Bordures arrondies
                            ),
                          ),
                          child: Text(
                            'Créer le compte',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Bouton "Annuler"
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75, // Largeur ajustée
                        child: ElevatedButton(
                          onPressed: _cancel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey, // Couleur du bouton
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), // Bordures arrondies
                            ),
                          ),
                          child: Text(
                            'Annuler',
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

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}