import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/notif_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<NotificationModel> getNotification() async {
    var url = Uri.parse(AuthService.baseUrl + '/notification');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      "Connection": "Keep-Alive",
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('NOTIFICATION ' + response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      NotificationModel notification = NotificationModel.fromJson(data);
      return notification;
    } else {
      throw Exception('failed load notification');
    }
  }
}
