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

  Future<Map<String, dynamic>> submitQuiz(
      String id, List selectedQuizId, List selectedAnswer) async {
    var url = Uri.parse('http://dev.stufast.id/api/course/video_2/$id');

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body =
        jsonEncode({'question': selectedQuizId, 'answer': selectedAnswer});

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print('RESULT_QUIZ' + response.body);

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to submit quiz');
    }
  }
}
