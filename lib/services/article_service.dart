class ArticleService {
  List<Map<String, String>> products = [
    {'image': 'assets/articles/article1.jpeg', 'title': 'Pull Nike vert', 'size': 'M', 'condition': 'Neuf', 'price': '50€'},
    {'image': 'assets/articles/article2.jpeg', 'title': 'Jean Levi\'s', 'size': 'L', 'condition': 'Bon état', 'price': '45€'},
    {'image': 'assets/articles/article3.jpeg', 'title': 'Chaussures Adidas', 'size': '42', 'condition': 'Neuf', 'price': '75€'},
    {'image': 'assets/articles/article4.jpeg', 'title': 'Veste Zara', 'size': 'S', 'condition': 'Très bon état', 'price': '35€'},
    {'image': 'assets/articles/article5.jpeg', 'title': 'Pull Hollister', 'size': 'M', 'condition': 'Neuf', 'price': '55€'},
    {'image': 'assets/articles/article6.jpeg', 'title': 'Jean Diesel', 'size': 'L', 'condition': 'Très bon état', 'price': '60€'},
    {'image': 'assets/articles/article7.jpeg', 'title': 'Chaussures Nike', 'size': '43', 'condition': 'Neuf', 'price': '80€'},
    {'image': 'assets/articles/article8.jpeg', 'title': 'Veste Uniqlo', 'size': 'M', 'condition': 'Bon état', 'price': '40€'},
    {'image': 'assets/articles/article9.jpeg', 'title': 'T-shirt Adidas', 'size': 'M', 'condition': 'Neuf', 'price': '30€'},
    {'image': 'assets/articles/article10.jpeg', 'title': 'Veste Nike', 'size': 'L', 'condition': 'Bon état', 'price': '50€'},
    {'image': 'assets/articles/article11.jpeg', 'title': 'Pantalon Levi\'s', 'size': 'L', 'condition': 'Neuf', 'price': '65€'},
    {'image': 'assets/articles/article12.jpeg', 'title': 'Short Nike', 'size': 'M', 'condition': 'Très bon état', 'price': '25€'},
  ];

  /// Retourne la liste de tous les articles 
  List<Map<String, String>> getAllArticles() {
    return products.toList(); // Retourne seulement les 3 premiers articles
  }
}