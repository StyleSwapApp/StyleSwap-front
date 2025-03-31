import 'package:flutter/material.dart';
import 'package:styleswap/components/favorite/favorite_article_card.dart';
import 'package:styleswap/components/favorite/favorite_widget.dart';
import 'package:styleswap/pages/detail_article_page.dart'; // Importez la page de détails
import '../services/favorite_service.dart';
import '../components/titlebar/titlebar.dart';

/// Page des articles favoris
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavoriteService favoriteService = FavoriteService();
  List<Map<String, dynamic>> favorites = [];
  int currentPage = 1;
  int itemsPerPage = 5;
  int totalPages = 0;
  final ScrollController _scrollController = ScrollController(); // Ajout du ScrollController

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  void loadFavorites() {
    setState(() {
      favorites = favoriteService.getAllFavorites(1); // Simule un appel avec un idUser
      totalPages = (favorites.length / itemsPerPage).ceil();
    });
  }

  // Méthode pour gérer le changement de page et réinitialiser la position du scroll
  void goToPage(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
    // Réinitialise le scroll en haut de la page
    _scrollController.jumpTo(0); 
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> paginatedFavorites = favorites
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'StyleSwap',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TitleBar(),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Utilisation du ScrollController
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Text(
                "Mes articles favoris :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 325,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paginatedFavorites.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> product = paginatedFavorites[index];

                    return GestureDetector( // Encapsulez chaque carte dans un GestureDetector
                      onTap: () {
                        // Lorsqu'on clique sur un article, on navigue vers la page de détails
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailArticlePage(
                              product: product, // Passage des données de l'article
                              isInCart: false,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          FavoriteArticleCard(
                            imageUrl: product['images'][0] ?? '', // Prend la première image
                            title: product['title'] ?? '',
                            size: product['size'] ?? '',
                            condition: product['condition'] ?? '',
                            price: product['price'] ?? '',
                          ),
                          Positioned(
                            top: 8, // Positionner le cœur un peu plus bas
                            right: 20, // Positionner le cœur un peu plus à gauche
                            child: FavoriteIconButton(initialFavoriteState: true), // Remplacer par le widget FavoriteIconButton
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            if (totalPages > 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(totalPages, (index) {
                    int pageNumber = index + 1;
                    return GestureDetector(
                      onTap: () {
                        goToPage(pageNumber); // Appel de goToPage pour changer de page
                      },
                      child: Container(
                        width: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: currentPage == pageNumber ? Colors.indigoAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(
                            pageNumber.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: currentPage == pageNumber ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }
}