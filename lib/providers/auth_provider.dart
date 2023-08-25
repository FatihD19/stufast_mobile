import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? email,
    String? password,
    String? confirmpassword,
  }) async {
    try {
      UserModel user = await AuthService().register(
          email: email, password: password, confirmPassword: confirmpassword);

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
