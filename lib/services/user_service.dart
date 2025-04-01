import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:styleswap/services/Token.dart';

class UserService {

  /// Retourne les informations d'un utilisateur en fonction de son ID.
  Future<Map<String, String>> getUserInformations(int idUser) async {

    // Récupérer le token utilisateur depuis le stockage sécurisé

    String? token = await getToken();
    
    final Uri url = Uri.parse('http://localhost:8080/api/v1/user/$idUser');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Remplacez par le token d'authentification si nécessaire
        },
      );

      if (response.statusCode == 200) {
        // Si la connexion réussit, récupérer les données de la réponse
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'firstName': data['userfname'],
          'lastName': data['userlname'],
          'email': data['useremail'],
        };
      } else {
        // Gérer les erreurs ici
        print('Failed to load user information: ${response.statusCode}');
        return {
          'firstName': 'Erreur',
          'lastName': 'Erreur',
          'email': 'Erreur',
        }; // Retourner un map vide en cas d'erreur
      }
    } catch (e) {
      // Gérer les erreurs ici
      print('An error occurred: $e');
      return {
        'firstName': 'Erreur',
        'lastName': 'Erreur',
        'email': 'Erreur',
      }; // Retourner un map vide en cas d'erreur
    }
  }
}