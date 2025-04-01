import 'package:flutter/material.dart';
import 'package:styleswap/components/hall/article_card.dart';
import 'package:styleswap/services/article_service.dart';
import 'package:styleswap/pages/detail_article_page.dart'; // Import de la page de détail

class Hall extends StatefulWidget {
  const Hall({super.key});

  @override
  _HallState createState() => _HallState();
}

class _HallState extends State<Hall> {
  // Variables pour la pagination
  int currentPage = 1;
  final int itemsPerPage = 10;

  // Instance du service
  final ArticleService articleService = ArticleService();
  List<Map<String, dynamic>> products = [];

  int totalPages = 0;

  @override
  void initState() {
    super.initState();
    // Récupérer les articles depuis le service
    // products = articleService.getAllArticles();
    totalPages = (products.length / itemsPerPage).ceil();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> paginatedProducts = products
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              padding: const EdgeInsets.all(8.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.6,
              ),
              itemCount: paginatedProducts.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> product = paginatedProducts[index];
                return GestureDetector(
                  onTap: () {
                    // Transmettre toutes les informations de l'article
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailArticlePage(
                          product: product, // Passer l'article complet
                          isInCart: false,
                        ),
                      ),
                    );
                  },
                  child: ArticleCard(
                    imageUrl: (product['images'] as List<String>?)?.first ?? '',
                    title: product['title'] ?? '',
                    size: product['size'] ?? '',
                    condition: product['condition'] ?? '',
                    price: product['price'] ?? '',
                  ),
                );
              },
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
                        width: 25,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: currentPage == pageNumber ? Colors.indigoAccent : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          pageNumber.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: currentPage == pageNumber ? Colors.white : Colors.black,
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