import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:http/http.dart' as http;

class TalentService {
  Future<List<TalentHubModel>> getTalentHub(
      {String? sortBy, String? searchQuery}) async {
    var url = Uri.parse(AuthService.baseUrl + '/talent-hub');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('LIST BUNDLE' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<TalentHubModel> talent = [];

      for (var item in data) {
        talent.add(TalentHubModel.fromJson(item));
      }

      return talent;
    } else {
      throw Exception('Gagal get bundle');
    }
  }

  Future<DetailTalentHubModel> getDetailTalent(String id) async {
    var url = Uri.parse(AuthService.baseUrl + '/talent-hub/detail/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('DETAIL_TALENT ' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DetailTalentHubModel detail = DetailTalentHubModel.fromJson(data);
      return detail;
    } else {
      throw Exception('failed load detail course');
    }
  }
}
