import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/api/api_url.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:http/http.dart' as http;

class BundleService {
  String baseUrl = '${ApiUrl.api_url}/api';

  Future<List<BundlingModel>> getBundle() async {
    var url = Uri.parse('${ApiUrl.api_url}/bundling/all');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('LIST BUNDLE' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['bundling'];
      List<BundlingModel> bundle = [];

      for (var item in data) {
        bundle.add(BundlingModel.fromJson(item));
      }
      return bundle;
    } else {
      throw Exception('Gagal get bundle');
    }
  }

  Future<BundlingModel> getDetailBundle(String id) async {
    var url = Uri.parse('${ApiUrl.api_url}/bundling/detail/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token == null ? '' : 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('DETAIL_BUNDLE ' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      BundlingModel model = BundlingModel.fromJson(data);
      return model;
    } else {
      throw Exception('failed load detail course');
    }
  }
}
