import 'package:flutter/material.dart';
import 'package:styleswap/components/favorite/favorite_article_card.dart';
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
  List<Map<String, String>> favorites = [];
  int currentPage = 1;
  int itemsPerPage = 5;
  int totalPages = 0;

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

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> paginatedFavorites = favorites
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                  padding: EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: paginatedFavorites.length,
                  itemBuilder: (context, index) {
                    Map<String, String> product = paginatedFavorites[index];
                    return FavoriteArticleCard(
                      imageUrl: product['image'] ?? '',
                      title: product['title'] ?? '',
                      size: product['size'] ?? '',
                      condition: product['condition'] ?? '',
                      price: product['price'] ?? '',
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
                        setState(() {
                          currentPage = pageNumber;
                        });
                      },
                      child: Container(
                        width: 30,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        padding: EdgeInsets.all(8.0),
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