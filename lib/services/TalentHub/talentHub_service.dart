import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/talent_hub_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:http/http.dart' as http;

class TalentService {
  Future<List<TalentHubModel>> getTalentHub(
      {bool? useFilter,
      String? sortBy,
      String? searchQuery,
      int? index}) async {
    var url = useFilter == true
        ? Uri.parse(AuthService.baseUrl + '/talent-hub')
        : Uri.parse(AuthService.baseUrl + '/talent-hub/page/$index');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('TALENTHUB' + response.body);

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

  Future<TalentHubModel> getTalentFilter(
      {String? sort,
      int? index,
      String? searchQuery,
      String? status,
      String? method}) async {
    var url = Uri.parse(AuthService.baseUrl + '/talent-hub/pagination');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var body = jsonEncode({
      "page": index,
      "status": status != null ? [status] : [],
      "method": method != null ? [method] : [],
      "min_salary": 0,
      "max_salary": 0,
      "sort": sort != null
          ? {"value": sort, "order": "desc"}
          : {"value": "total_course", "order": "desc"},
      "search": searchQuery ?? ""
    });

    var response = await http.post(url, headers: headers, body: body);
    print(body);
    print('TALENTHUB' + response.body);

    if (response.statusCode == 200) {
      TalentHubModel talent =
          TalentHubModel.fromJson(jsonDecode(response.body));

      return talent;
    } else {
      throw Exception('Gagal filter talent');
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
