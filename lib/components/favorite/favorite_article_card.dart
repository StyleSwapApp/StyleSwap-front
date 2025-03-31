import 'package:flutter/material.dart';

class FavoriteArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final String condition;
  final String price;

  const FavoriteArticleCard({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.condition,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 300,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 265.0,
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Centre les éléments horizontalement
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center, // Centre le texte
                  ),
                  Text(
                    '$size - $condition',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center, // Centre le texte
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.indigoAccent,
                    ),
                    textAlign: TextAlign.center, // Centre le texte
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