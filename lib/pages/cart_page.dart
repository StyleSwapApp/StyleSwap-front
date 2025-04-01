import 'package:flutter/material.dart';
import 'package:styleswap/components/cart/cart_article_card.dart';
import 'package:styleswap/services/cart_service.dart';
import 'package:styleswap/services/user_service.dart';

/// Page du panier
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();
    final userService = UserService();
    final userInfo = userService.getUserInformations(1); // ID utilisateur fictif

    List<Map<String, dynamic>> cartItems = cartService.getAllArticlesInCart(1);
    double totalPrice = 0;

    cartItems.forEach((item) {
      // Extraire et additionner le prix de chaque article
      totalPrice += double.tryParse(item['price']?.replaceAll('€', '') ?? '0') ?? 0;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Panier'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Liste des articles
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartArticleCard(cartItem: cartItems[index]);
                },
              ),
            ),

            // Prix total
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Prix total: €${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Informations utilisateur
            Text(
              'Mes informations',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Champ Nom
            TextField(
              controller: TextEditingController(text: userInfo['firstName']),
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            SizedBox(height: 10),

            // Champ Prénom
            TextField(
              controller: TextEditingController(text: userInfo['lastName']),
              decoration: InputDecoration(labelText: 'Prénom'),
            ),
            SizedBox(height: 10),

            // Champ Email
            TextField(
              controller: TextEditingController(text: userInfo['email']),
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),

            // Champ Adresse de livraison
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Adresse de livraison'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.pin_drop),
                  onPressed: () {
                    // Action pour la localisation (pour l'instant rien)
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}