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
    // Vérifie si l'appareil est en mode paysage
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    // Ajuste la hauteur de l'image et les tailles de texte en fonction de l'orientation
    double imageHeight = isLandscape ? 140.0 : 200.0; // Image plus petite en paysage
    double titleFontSize = isLandscape ? 14.0 : 15.0; // Titre plus petit en paysage
    double priceFontSize = isLandscape ? 16.0 : 18.0; // Prix plus petit en paysage

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de l'article
            SizedBox(
              width: double.infinity,
              height: imageHeight, // Hauteur dynamique de l'image
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
                      fontSize: titleFontSize, // Taille du titre ajustée
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
                          fontSize: priceFontSize, // Taille du prix ajustée
                          color: Colors.indigoAccent,
                        ),
                      ),
                      // Le cœur à droite
                      FavoriteIconButton(initialFavoriteState: false),
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