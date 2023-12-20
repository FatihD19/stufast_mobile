import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  List<DropdownJobModel> _listJob = [];
  List<DropdownJobModel> get listJob => _listJob;

  set listJob(List<DropdownJobModel> listJob) {
    _listJob = listJob;
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
    bool? isGoogle,
    String? fullname,
    String? id,
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
        isGoogle: isGoogle,
        fullname: fullname,
        id: id,
      );
      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getProfileUser() async {
    try {
      UserModel user = await AuthService().getProfile();
      _user = user;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getJob() async {
    try {
      List<DropdownJobModel> listJob = await AuthService().getDropdownJob();
      _listJob = listJob;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> uploadProfilePicture(
    String id,
    File profilePicture,
  ) async {
    try {
      final result =
          await AuthService().uploadProfilePicture(id, profilePicture);

      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editProfile({
    String? id,
    String? nama,
    String? dateBirth,
    String? address,
    String? phoneNumber,
    String? job_id,
    XFile? profilePicture,
  }) async {
    try {
      final result = await AuthService().editProfil(
          id: id,
          nama: nama,
          dateBirth: dateBirth,
          address: address,
          phoneNumber: phoneNumber,
          job_id: job_id,
          profilePicture: profilePicture);

      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
