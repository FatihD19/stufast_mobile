import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/task_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class TaskService {
  Future<List<TaskModel>> getTasks(String id) async {
    var url = Uri.parse(AuthService.baseUrl + '/course/task-history/$id');
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
    var url = Uri.parse(AuthService.baseUrl + '/course/submit-task-mobile/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(url,
        headers: headers, body: taskFile.readAsBytesSync());
    print('UPLOAD IMAGE' + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
