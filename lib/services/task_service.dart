import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/task_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'dart:convert';
import 'package:stufast_mobile/api/api_url.dart';
import 'package:http/http.dart' as http;

class TaskService {
  Future<List<TaskModel>> getTasks(String id) async {
    var url = Uri.parse(ApiUrl.api_url + '/course/task-history/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('LIST TASK' + response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<TaskModel> tasks = [];
      for (var item in data) {
        tasks.add(TaskModel.fromJson(item));
      }
      return tasks;
    } else {
      throw Exception('Gagal mendapatkan data task');
    }
  }

  Future<bool> uploadTask(String id, File taskFile) async {
    var url = Uri.parse(ApiUrl.api_url + '/course/submit-task-mobile/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/pdf',
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(url,
        headers: headers, body: taskFile.readAsBytesSync());
    print('UPLOAD TASK' + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
