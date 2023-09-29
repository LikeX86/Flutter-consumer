import 'package:apif/models/User.dart';
import 'package:apif/services/ApiService.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<bool> registerUser(User user) async {
    final response = await apiService.registerUser(user);
    if (response.statusCode == 200) {
      _currentUser = user;
      notifyListeners();
      return true;
    } else {
      // Trate os erros de registro aqui
      return false;
    }
  }

  Future<bool> loginUser(User user) async {
    final response = await apiService.loginUser(user);
    if (response.statusCode == 200) {
      _currentUser = user;
      notifyListeners();
      return true;
    } else {
      // Trate os erros de login aqui
      return false;
    }
  }

  void logoutUser() {
    _currentUser = null;
    notifyListeners();
  }
}
