import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:http/http.dart' as http;

class CVservice {
  Future<CVmodel> getCV() async {
    var url = Uri.parse(AuthService.baseUrl + '/users/cv');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('CV ' + response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      CVmodel cv = CVmodel.fromJson(data);
      return cv;
    } else {
      throw Exception('Gagal get CV');
    }
  }

  Future<bool> updateCV(
      {String? about,
      String? instagram,
      String? facebook,
      String? linkedin,
      String? status,
      String? method}) async {
    var url = Uri.parse(AuthService.baseUrl + '/users/cv/update-cv');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'about': about,
      'instagram': instagram,
      'facebook': facebook,
      'linkedin': linkedin,
      'status': status,
      'method': method,
    });
    var response = await http.post(url, headers: headers, body: body);

    print('UPDATE CV' + response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadPortofolio(String id, File portoFile) async {
    var url = Uri.parse(AuthService.baseUrl + '/users/cv/portofolio/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(url,
        headers: headers, body: portoFile.readAsBytesSync());
    print('UPLOAD PORTOFOLIO' + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // ignore: avoid_types_as_parameter_names
  Future<bool> updateCVEducation(List cvEducation) async {
    var url = Uri.parse(AuthService.baseUrl + '/users/cv/update-edu');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      "education": cvEducation,
    });
    var response = await http.post(url, headers: headers, body: body);
    print('UPDATE CV EDucation' + response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateExp(List cvExp) async {
    var url = Uri.parse(AuthService.baseUrl + '/users/cv/update-exp');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      "exp": cvExp,
    });
    var response = await http.post(url, headers: headers, body: body);
    print('UPDATE CV EXP' + response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateAch(List cvAch) async {
    var url = Uri.parse(AuthService.baseUrl + '/users/cv/update-ach');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      "ach": cvAch,
    });
    var response = await http.post(url, headers: headers, body: body);
    print('UPDATE CV ACH' + response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
