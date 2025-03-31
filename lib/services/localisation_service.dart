import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// Service pour récupérer la localisation actuelle
class LocalisationService {
  Future<String?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Vérifier si les services de localisation sont activés
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // Les services de localisation sont désactivés
    }

    // Vérifier les permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Permission refusée");
        return null; // Permission refusée
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null; // Permissions bloquées définitivement
    }

    // Récupérer la position actuelle
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Utiliser le géocodage inverse pour obtenir l'adresse à partir des coordonnées GPS
    List<Placemark> placemarks = await GeocodingPlatform.instance!.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    // Retourner l'adresse sous forme de chaîne de caractères
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      return '${placemark.name}, ${placemark.locality}, ${placemark.country}';
    }
    return null;
  }
}