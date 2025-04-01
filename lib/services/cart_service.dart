class CartService {
  List<Map<String, dynamic>> products = [
    {'id': 1, 'images': ['assets/articles/article1.jpeg', 'assets/articles/article12.jpeg', 'assets/articles/article7.jpeg'], 'title': 'Pull Nike vert', 'size': 'M', 'condition': 'Neuf', 'price': '50€'},
    {'id': 2, 'images': ['assets/articles/article2.jpeg', 'assets/articles/article5.jpeg'], 'title': 'Jean Levi\'s', 'size': 'L', 'condition': 'Bon état', 'price': '45.68€'},
    {'id': 3, 'images': ['assets/articles/article3.jpeg', 'assets/articles/article7.jpeg'], 'title': 'Chaussures Adidas', 'size': '42', 'condition': 'Neuf', 'price': '75€'},
  ];

  /// Retourne tous les articles du panier
  List<Map<String, dynamic>> getAllArticlesInCart(int idUser) {
    return products;
  }

  /// Supprimer un article du panier
  void removeArticleFromCart(int id) {
    products.removeWhere((item) => item['id'] == id);
  }
}