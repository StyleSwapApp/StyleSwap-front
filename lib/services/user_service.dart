class UserService {
  /// Retourne les informations d'un utilisateur en fonction de son ID.
  Map<String, String> getUserInformations(int idUser) {
    return {
      'firstName': 'Martin',
      'lastName': 'Dupont',
      'email': 'martin.dupont@gmail.com',
    };
  }
}