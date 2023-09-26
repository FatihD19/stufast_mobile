import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/chart_model.dart';
import 'package:stufast_mobile/services/auth_service.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ChartService {
  Future<ChartModel> getChart() async {
    var url = Uri.parse(AuthService.baseUrl + '/cart/all');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('LIST CHART' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ChartModel chart = ChartModel.fromJson(data);
      return chart;
    } else {
      throw Exception('Gagal get chart');
    }
  }

  Future<String> addChart(String type, String id) async {
    var url = Uri.parse(AuthService.baseUrl + '/cart/create/$type/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(url, headers: headers);
    // print(response.body);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      print(data);
      return data['message'];
    } else {
      throw Exception('Gagal get chart');
    }
  }

  Future<String> deleteChart(String id) async {
    var url = Uri.parse(AuthService.baseUrl + '/cart/delete/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.delete(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data['status'].toString();
    } else {
      throw Exception('Gagal delete chart');
    }
  }
}
