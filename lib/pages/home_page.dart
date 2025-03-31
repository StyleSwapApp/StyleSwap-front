import 'package:flutter/material.dart';
import '../components/titlebar/titlebar.dart';
import '../components/searchbar/searchbar.dart';
import '../components/filters/filters.dart';
import '../components/hall/hall.dart';

/// Page d'accueil
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          TitleBar(), // Utilisation correcte dans la liste
        ],
      ),
      body: Column(
        children: [
          SearchBarWidget(),
          Filters(),
          SizedBox(height: 10),
          Expanded(child: Hall()),
        ],
      ),
    );
  }
}