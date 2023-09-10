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

  Future<bool> register(
      {String? email,
      String? nama,
      String? dateBirth,
      String? address,
      String? phoneNumber,
      String? password,
      String? confirmPassword}) async {
    try {
      UserModel user = await AuthService().register(
          email: email,
          nama: nama,
          dateBirth: dateBirth,
          address: address,
          phoneNumber: phoneNumber,
          password: password,
          confirmPassword: confirmPassword);

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

  Future<void> getProfileUser(String token) async {
    try {
      UserModel user = await AuthService().getProfile(token);
      _user = user;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> editProfile({
    String? id,
    String? nama,
    String? dateBirth,
    String? address,
    String? phoneNumber,
  }) async {
    try {
      await AuthService().editProfil(id, nama, dateBirth, address, phoneNumber);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
