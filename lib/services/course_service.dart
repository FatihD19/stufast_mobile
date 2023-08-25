import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stufast_mobile/models/course_model.dart';

class CourseService {
  String baseUrl = 'https://dev.stufast.id/api';

  Future<List<CourseModel>> getCourse() async {
    var url = Uri.parse('$baseUrl/course/latest/10');
    // var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url);

    print('RESPONSE COURSE ' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<CourseModel> course = [];

      for (var item in data) {
        course.add(CourseModel.fromJson(item));
      }
      return course;
    } else {
      throw Exception('Gagal get Products');
    }
  }
}
