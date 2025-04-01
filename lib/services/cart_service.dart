class CartService {
  List<Map<String, dynamic>> products = [
    {'images': ['assets/articles/article1.jpeg', 'assets/articles/article12.jpeg', 'assets/articles/article7.jpeg'], 'title': 'Pull Nike vert', 'size': 'M', 'condition': 'Neuf', 'price': '50€'},
    {'images': ['assets/articles/article2.jpeg', 'assets/articles/article5.jpeg'], 'title': 'Jean Levi\'s', 'size': 'L', 'condition': 'Bon état', 'price': '45€'},
    {'images': ['assets/articles/article3.jpeg', 'assets/articles/article7.jpeg'], 'title': 'Chaussures Adidas', 'size': '42', 'condition': 'Neuf', 'price': '75€'},
];

  /// Retourne une liste de 3 articles favoris pour un utilisateur donné
  List<Map<String, dynamic>> getAllArticlesInCart(int idUser) {
    return products;
  }
}