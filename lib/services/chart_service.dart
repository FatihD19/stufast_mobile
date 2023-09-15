import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/services/auth_service.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ChartService {
  Future<List<ChartModel>> getChart() async {
    var url = Uri.parse(AuthService.baseUrl + '/cart');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('LIST CHART' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['item'];
      List<ChartModel> chart = [];

      for (var item in data) {
        chart.add(ChartModel.fromJson(item));
      }
      return chart;
    } else {
      throw Exception('Gagal get chart');
    }
  }
}
