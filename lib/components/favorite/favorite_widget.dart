import 'package:flutter/material.dart';

/// Widget qui est le cœur pour gérer les favoris
class FavoriteIconButton extends StatefulWidget {
  final bool initialFavoriteState; // Paramètre pour spécifier l'état initial du cœur

  const FavoriteIconButton({
    Key? key,
    required this.initialFavoriteState, // Requis lors de la création du widget
  }) : super(key: key);

  @override
  _FavoriteIconButtonState createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavoriteState; // Initialiser l'état avec le paramètre
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite; // Toggle l'état du favori
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 50, // Augmenter la taille de la zone cliquable
        height: 50, // Augmenter la taille de la zone cliquable
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border, // Icône en fonction de l'état
            color: isFavorite ? Colors.red : Colors.blueGrey, // Couleur en fonction de l'état
            size: 28, // Taille de l'icône
          ),
        ),
      ),
    );
  }
}