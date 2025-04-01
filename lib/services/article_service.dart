import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:styleswap/services/Token.dart';

class ArticleService {

  Future<List<Map<String, dynamic>>> getAllArticles() async {
    final Uri url = Uri.parse('http://localhost:8080/api/v1/articles');
    
    // Récupérer le token utilisateur depuis le stockage sécurisé
    String? token = await getToken();

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Décoder la réponse JSON comme une liste d'articles
        final List<dynamic> data = jsonDecode(response.body);
        return List<Map<String, dynamic>>.from(data);
      } else {
        print('Failed to load articles: ${response.statusCode}');
        return []; // Retourner une liste vide en cas d'erreur
      }
    } catch (e) {
      print('An error occurred: $e');
      return []; // Retourner une liste vide en cas d'erreur
    }
  }


  /// Retourne un article en fonction de son ID
  Future<Map<String, dynamic>?> getOneArticleById(int id) async {
    final Uri url = Uri.parse('http://localhost:8080/api/v1/articles/$id');

    String? token = await getToken();

    final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

    try {
      if (response.statusCode == 200) {
        // Si la connexion réussit, récupérer les données de la réponse
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        // Gérer les erreurs ici
        print('Failed to load article: ${response.statusCode}');
        return null; // Retourner null en cas d'erreur
      }
    } catch (e) {
      // Gérer les erreurs ici
      print('An error occurred: $e');
      return null; // Retourner null en cas d'erreur
    }
  }
}