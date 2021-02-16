import 'package:best_starter_architecture/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthServiceProvider with ChangeNotifier {
  AuthService _authService = AuthService();

  void authStateChanges() {
    _authService.onAuthStateChanges;
    notifyListeners();
  }
}
