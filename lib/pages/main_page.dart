import 'package:flutter/material.dart';
import 'package:styleswap/pages/home_page.dart';
import 'package:styleswap/pages/favorite_page.dart';
import 'package:styleswap/pages/create_ad_page.dart';  // Page pour ajouter une annonce
import 'package:styleswap/pages/cart_page.dart';     // Page du panier
import 'package:styleswap/pages/message_page.dart';    // Page des messages

/// Navbar commune aux pages
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Liste des pages correspondantes aux onglets
  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    CreateAdPage(),    // Page pour ajouter une annonce
    CartPage(),        // Page du panier
    MessagePage(),     // Page des messages
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

/// 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Conserve l'état des pages
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoris'),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Panier'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        ],
        selectedItemColor: Colors.indigoAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}