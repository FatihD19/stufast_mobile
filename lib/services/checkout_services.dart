import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/services/auth_service.dart';

import '../models/chart_model.dart';

class CheckOutService {
  Future<ChartModel> checkoutCourse(List id) async {
    var url = Uri.parse(AuthService.baseUrl + '/cart/process');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({"nama": id});

    var response = await http.post(url, headers: headers, body: body);

    print('LIST CHECKOUT' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ChartModel chart = ChartModel.fromJson(data);
      return chart;
    } else {
      throw Exception('Gagal get chart');
    }
  }
}
