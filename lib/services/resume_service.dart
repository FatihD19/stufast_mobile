import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/resume_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class ResumeService {
  Future<Resume> getResume(String idResume) async {
    var url = Uri.parse(AuthService.baseUrl + '/resume/detail/$idResume');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('DETAIL RESUME ' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Resume resume = Resume.fromJson(data);
      return resume;
    } else {
      throw Exception('Gagal get resume');
    }
  }

  Future<bool> storeResume(String videoId, String resume, {bool? later}) async {
    var url = Uri.parse(AuthService.baseUrl + '/resume/create');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'video_id': videoId,
      'resume': resume,
      'empty': later == true ? 1 : null
    });

    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateResume(
      String resumeId, String videoId, String resume) async {
    var url = Uri.parse(AuthService.baseUrl + '/resume/update/$resumeId');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'video_id': videoId,
      'resume': resume,
    });

    var response = await http.put(url, headers: headers, body: body);
    print('UPDATE RESUME ' + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
