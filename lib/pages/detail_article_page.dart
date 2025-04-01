import 'package:flutter/material.dart';

class DetailArticlePage extends StatefulWidget {
  final Map<String, dynamic> product;
  final bool isInCart; // Ajout du paramètre isInCart

  const DetailArticlePage({super.key, required this.product, required this.isInCart});

  @override
  _DetailArticlePageState createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  int _currentIndex = 0; // Index de l'image actuellement affichée
  late PageController _pageController; // PageController pour gérer le carrousel

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calcul de l'espacement conditionnel en fonction de isInCart
    double spacing = widget.isInCart ? 30.0 : 10.0;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Détails de l\'article',
          style: TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: spacing), // Espacement conditionnel

            // Indicateurs de photo (points) au-dessus du carrousel
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  (widget.product['images'] as List<String>?)?.length ?? 0,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.indigoAccent
                              : Colors.grey,
                        ),
                      ),
                ),
              ),
            ),
            SizedBox(height: 10), // Espacement conditionnel

            // Carrousel d'images avec bords blancs
            SizedBox(
              height: 330.0,
              child: PageView.builder(
                controller: _pageController,
                itemCount: (widget.product['images'] as List<String>?)?.length ?? 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Image.asset(
                      (widget.product['images'] as List<String>?)?[index] ?? '',
                      fit: BoxFit.cover,
                    ),
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 10.0), // Espacement entre le carrousel et les informations suivantes

            // Détails de l'article
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    widget.product['title'] ?? 'Nom de l\'article',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${widget.product['size'] ?? 'Taille'} - ${widget.product['condition'] ?? 'État'} - Nike',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '\$${widget.product['price'] ?? 'Prix'}',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.0),
                  // Vendeur
                  Text(
                    'Vendeur: ${widget.product['seller'] ?? 'Nom du vendeur'}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.0),
                  // Description de l'article
                  Text(
                    'Description de l\'article:',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Jamais porté, jolis détails au niveau des épaules. Très confortable.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // Boutons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      minimumSize: Size(0.7 * MediaQuery.of(context).size.width, 50),
                    ),
                    icon: Icon(Icons.message, color: Colors.blue),
                    label: Text(
                      'Envoyer un message',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  // Ajouter au panier uniquement si isInCart est false
                  if (!widget.isInCart) 
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: Size(0.7 * MediaQuery.of(context).size.width, 50),
                      ),
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      label: Text(
                        'Ajouter au panier',
                        style: TextStyle(color: Colors.white),
                      ),
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