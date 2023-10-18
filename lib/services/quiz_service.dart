import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/quiz_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class QuizService {
  Future<List<QuizModel>> getQuiz(String id) async {
    var url = Uri.parse(AuthService.baseUrl + '/course/video_2/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('QUIZ_API' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['quiz'];
      List<QuizModel> quiz = [];

      for (var item in data) {
        quiz.add(QuizModel.fromJson(item));
      }
      return quiz;
    } else {
      throw Exception('Gagal get bundle');
    }
  }
}
