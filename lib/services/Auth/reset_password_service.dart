import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class ResetPasswordService {
  String baseurl = AuthService.baseUrl;

  Future<String> sendEmail({String? email}) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse('$baseurl/forgot-password');
    var body = jsonEncode({
      'email': email,
    });
    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData["message"];
    } else {
      throw Exception("Failed to send reset email");
    }
  }

  Future<String> verifyOTP({String? email, String? otp}) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse('$baseurl/send-otp');
    var body = jsonEncode({'email': email, 'otp': otp});
    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData["message"];
    } else {
      throw Exception("Failed to send reset email");
    }
  }

  Future<String> newPassword(
      {String? email,
      String? otp,
      String? password,
      String? confirmpassword}) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse('$baseurl/new-password');
    var body = jsonEncode({
      'email': email,
      'otp': otp,
      'password': password,
      'password_confirm': confirmpassword
    });
    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData["message"];
    } else {
      throw Exception("Failed to send reset email");
    }
  }

  Future<bool> changePassword(String oldPass, String newPass) async {
    var url = Uri.parse('$baseurl/changePassword');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'xpassword': oldPass,
      'new-password': newPass,
    });
    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
