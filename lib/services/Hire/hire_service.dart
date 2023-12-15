import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/hire_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class HireService {
  Future<List<HireModel>> getHireOffer() async {
    var url = Uri.parse(AuthService.baseUrl + '/hire/user');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);

    print('HireOffer' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<HireModel> hire = [];

      for (var item in data) {
        hire.add(HireModel.fromJson(item));
      }
      return hire;
    } else {
      throw Exception('Gagal get hire offer');
    }
  }

  Future<bool> confirmHire(String idHire, String confrim) async {
    var url = Uri.parse(AuthService.baseUrl + '/hire/confirm');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'hire_id': idHire,
      'result': confrim,
    });
    var response = await http.post(url, headers: headers, body: body);

    print('HireOffer' + response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal get hire offer');
    }
  }
}
