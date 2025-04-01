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
    final Future<Map<String, String>> userInfo = userService.getUserInformations(1); // ID utilisateur fictif

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
            FutureBuilder<Map<String, String>>(
              future: userInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return TextField(
                    controller: TextEditingController(text: snapshot.data!['firstName']),
                    decoration: InputDecoration(labelText: 'Nom'),
                  );
                } else {
                  return Text('Aucune donnée disponible');
                }
              },
            ),
            SizedBox(height: 10),

            // Champ Prénom
            FutureBuilder<Map<String, String>>(
              future: userInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return TextField(
                    controller: TextEditingController(text: snapshot.data!['lastName']),
                    decoration: InputDecoration(labelText: 'Prénom'),
                  );
                } else {
                  return Text('Aucune donnée disponible');
                }
              },
            ),
            SizedBox(height: 10),

            // Champ Email
            FutureBuilder<Map<String, String>>(
              future: userInfo,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return TextField(
                    controller: TextEditingController(text: snapshot.data!['email']),
                    decoration: InputDecoration(labelText: 'Email'),
                  );
                } else {
                  return Text('Aucune donnée disponible');
                }
              },
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