import 'package:flutter/material.dart';

/// Page pour créer une annonce
class CreateAdPage extends StatelessWidget {
  const CreateAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une annonce'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Page pour ajouter une annonce',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Action pour ajouter une annonce (exemple)
                  print('Annonce ajoutée');
                },
                child: Text('Ajouter une annonce'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}