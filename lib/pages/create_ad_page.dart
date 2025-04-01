import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CreateAdPage extends StatefulWidget {
  const CreateAdPage({super.key});

  @override
  _CreateAdPageState createState() => _CreateAdPageState();
}

class _CreateAdPageState extends State<CreateAdPage> {
  final _storage = const FlutterSecureStorage();
  final _pseudoController = TextEditingController();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _brandController = TextEditingController();
  final _colorController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<int> _imageData = [];

  final ImagePicker _picker = ImagePicker();

  // Récupérer le token d'authentification
  Future<String?> _getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Soumettre l'annonce
  Future<void> _submitAd(BuildContext context) async {
    if (_imageData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner une image')),
      );
      return;
    }

    final String url = 'http://127.0.0.1:8080/api/v1/articles/newArticle'; // Remplace par l'URL de ton API

    // Récupérer le token d'authentification
    String? token = await _getToken();

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token d\'authentification manquant')),
      );
      return;
    }

    // Préparer la requête multipart
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    // Ajouter les champs textuels
    request.fields['pseudo_user'] = _pseudoController.text;
    request.fields['name'] = _nameController.text;
    request.fields['price'] = _priceController.text;
    request.fields['size'] = _sizeController.text;
    request.fields['brand'] = _brandController.text;
    request.fields['color'] = _colorController.text;
    request.fields['description'] = _descriptionController.text;

    // Ajouter l'image sous forme de fichier
    var imageFile = http.MultipartFile.fromBytes(
      'image',
      _imageData,
      filename: 'image.jpg',
      contentType: MediaType('image', 'jpeg'),
    );

    request.files.add(imageFile);

    // Ajouter le token d'authentification
    request.headers['Authorization'] = 'Bearer $token';

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Annonce ajoutée avec succès!')),
        );
      } else {
        print('Annonce ajoutée : ${response.statusCode} - ${await response.stream.bytesToString()}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Annonce ajoutée')),
        );
      }
    } catch (e) {
      print('Erreur: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion au serveur')),
      );
    }
  }

  // Sélectionner l'image depuis la galerie
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        setState(() {
          _imageData = imageBytes;
        });
      }
    } catch (e) {
      print("Erreur lors de la sélection de l'image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une annonce'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _pseudoController,
              decoration: InputDecoration(labelText: 'Pseudo'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _sizeController,
              decoration: InputDecoration(labelText: 'Taille'),
            ),
            TextField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Marque'),
            ),
            TextField(
              controller: _colorController,
              decoration: InputDecoration(labelText: 'Couleur'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: Text('Sélectionner une image depuis la galerie'),
            ),
            if (_imageData.isNotEmpty)
              Image.memory(
                Uint8List.fromList(_imageData),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitAd(context), // Passer le BuildContext ici
              child: Text('Ajouter l\'annonce'),
            ),
          ],
        ),
      ),
    );
  }
}
