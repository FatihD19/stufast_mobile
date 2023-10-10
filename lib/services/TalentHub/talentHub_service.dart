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

      // // Melakukan sorting berdasarkan kriteria tertentu jika sortBy ditentukan
      // if (sortBy != null) {
      //   if (sortBy == 'average_score') {
      //     talent.sort((a, b) => b.averageScore.compareTo(a.averageScore));
      //   } else if (sortBy == 'total_course') {
      //     talent.sort((a, b) => b.totalCourse.compareTo(a.totalCourse));
      //   }
      // }

      // // Melakukan pencarian jika searchQuery ditentukan
      // if (searchQuery != null && searchQuery.isNotEmpty) {
      //   talent = talent.where((t) => t.fullname!.contains(searchQuery)).toList();
      // }

      return talent;
    } else {
      throw Exception('Gagal get bundle');
    }
  }
}
