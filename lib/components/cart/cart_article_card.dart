import 'package:flutter/material.dart';

class CartArticleCard extends StatelessWidget {
  final Map<String, dynamic> cartItem;

  const CartArticleCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Augmentation du border radius
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Détails de l'article, alignés à gauche avec un léger padding à gauche
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 8.0, bottom: 8.0), // Padding à gauche, et réduisant l'espacement vertical
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem['title'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        '${cartItem['size']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${cartItem['condition']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${cartItem['price']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent, // Prix en indigoAccent
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Image de l'article avec un padding autour
          Padding(
            padding: const EdgeInsets.all(8.0), // Petit padding autour de l'image
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12), // Bord arrondi de l'image
              child: Image.asset(
                cartItem['images'][0], // On prend la première image pour le moment
                width: 90, // Réduction de la taille pour diminuer la hauteur globale
                height: 90, // Réduction de la taille pour diminuer la hauteur globale
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}