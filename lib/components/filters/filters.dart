import 'package:flutter/material.dart';

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final List<String> filterOptions = ['Pull', 'Pantalon', 'Nike', 'Chaussures', ' + '];
  final Set<String> selectedFilters = {}; // Stocke les filtres sélectionnés

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterOptions.length,
        itemBuilder: (context, index) {
          String filter = filterOptions[index];
          bool isSelected = selectedFilters.contains(filter); // Vérifie si le filtre est sélectionné

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedFilters.add(filter); // Ajoute le filtre sélectionné
                  } else {
                    selectedFilters.remove(filter); // Retire le filtre désélectionné
                  }
                });
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.indigoAccent, // Couleur lorsque sélectionné
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black, // Texte blanc si sélectionné
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}