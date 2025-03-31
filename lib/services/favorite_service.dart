class FavoriteService {
  List<Map<String, dynamic>> products = [
    {'images': ['assets/articles/article1.jpeg', 'assets/articles/article12.jpeg'], 'title': 'Pull Nike vert', 'size': 'M', 'condition': 'Neuf', 'price': '50€'},
    {'images': ['assets/articles/article2.jpeg', 'assets/articles/article5.jpeg'], 'title': 'Jean Levi\'s', 'size': 'L', 'condition': 'Bon état', 'price': '45€'},
    {'images': ['assets/articles/article3.jpeg', 'assets/articles/article7.jpeg'], 'title': 'Chaussures Adidas', 'size': '42', 'condition': 'Neuf', 'price': '75€'},
    {'images': ['assets/articles/article4.jpeg', 'assets/articles/article8.jpeg'], 'title': 'Veste Zara', 'size': 'S', 'condition': 'Très bon état', 'price': '35€'},
    {'images': ['assets/articles/article5.jpeg', 'assets/articles/article9.jpeg'], 'title': 'Pull Hollister', 'size': 'M', 'condition': 'Neuf', 'price': '55€'},
    {'images': ['assets/articles/article6.jpeg', 'assets/articles/article10.jpeg'], 'title': 'Jean Diesel', 'size': 'L', 'condition': 'Très bon état', 'price': '60€'},
    {'images': ['assets/articles/article7.jpeg', 'assets/articles/article11.jpeg'], 'title': 'Chaussures Nike', 'size': '43', 'condition': 'Neuf', 'price': '80€'},
    {'images': ['assets/articles/article8.jpeg', 'assets/articles/article1.jpeg'], 'title': 'Veste Uniqlo', 'size': 'M', 'condition': 'Bon état', 'price': '40€'},
    {'images': ['assets/articles/article9.jpeg', 'assets/articles/article3.jpeg'], 'title': 'T-shirt Adidas', 'size': 'M', 'condition': 'Neuf', 'price': '30€'},
    {'images': ['assets/articles/article10.jpeg', 'assets/articles/article2.jpeg'], 'title': 'Veste Nike', 'size': 'L', 'condition': 'Bon état', 'price': '50€'},
    {'images': ['assets/articles/article11.jpeg', 'assets/articles/article4.jpeg'], 'title': 'Pantalon Levi\'s', 'size': 'L', 'condition': 'Neuf', 'price': '65€'},
    {'images': ['assets/articles/article12.jpeg', 'assets/articles/article6.jpeg'], 'title': 'Short Nike', 'size': 'M', 'condition': 'Très bon état', 'price': '25€'},
  ];

  /// Retourne une liste de 3 articles favoris pour un utilisateur donné
  List<Map<String, dynamic>> getAllFavorites(int idUser) {
    return products;
  }
}