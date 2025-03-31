import 'package:flutter/material.dart';
import 'package:styleswap/components/favorite/favorite_widget.dart';

class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final String condition;
  final String price;

  const ArticleCard({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.condition,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),  // Coins arrondis
        color: Colors.white,  // Fond blanc pour les articles
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de l'article
            SizedBox(
              width: double.infinity,
              height: 200.0, // Ajuste la hauteur de l'image
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            // Contenu de l'article
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15, // Taille du titre
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '$size - $condition',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Le prix à gauche
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18, // Taille du prix
                          color: Colors.indigoAccent,
                        ),
                      ),
                      // Le cœur à droite
                      FavoriteIconButton(initialFavoriteState: false), // Cœur non favori par défaut
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}