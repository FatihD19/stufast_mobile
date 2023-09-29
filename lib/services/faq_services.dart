import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/faq_model.dart';
import 'package:stufast_mobile/services/auth_service.dart';

class FaqService {
  Future<List<FaqModel>> getFaq() async {
    var url = Uri.parse(AuthService.baseUrl + '/faq');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('LIST faq' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<FaqModel> faq = [];

      for (var item in data) {
        faq.add(FaqModel.fromJson(item));
      }
      return faq;
    } else {
      throw Exception('Gagal get faq');
    }
  }
}
