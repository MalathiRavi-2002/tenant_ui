import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void init() {
    SharedPreferences.getInstance().then((res) {
      final token = res.getString('token');
      if (token != null) {
        _isAuthenticated = true;
        notifyListeners();
      }
    });
  }

  void login(String token) {
    SharedPreferences.getInstance().then((res) {
      res.setString('token', token);
      _isAuthenticated = true;
      notifyListeners();
    });
  }

  void logout() {
    SharedPreferences.getInstance().then((res) {
      res.remove('token');
      _isAuthenticated = false;
      notifyListeners();
    });
  }

  void register(String token) {
    SharedPreferences.getInstance().then((res) {
      res.setString('token', token);
      _isAuthenticated = true;
      notifyListeners();
    });
  }
}
