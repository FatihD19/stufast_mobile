import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/tag_model.dart';

class CourseService {
  String baseUrl = 'https://dev.stufast.id/api';

  Future<List<CourseModel>> getCourse([String? typeCourse]) async {
    var url = typeCourse == 'all'
        ? Uri.parse('$baseUrl/course/all')
        : Uri.parse('$baseUrl/course/latest/10');

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

  Future<List<CourseModel>> searchCourse(String query) async {
    var url = Uri.parse('$baseUrl/course/find/$query');
    var response = await http.get(url);

    print('SEARCH COURSE ' + response.body);

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

  Future<List<CourseModel>> searchCourseByTag(String query) async {
    var url = Uri.parse('$baseUrl/course/all');
    var response = await http.get(url);

    print('SEARCH COURSE ' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<CourseModel> courses = [];

      for (var item in data) {
        CourseModel course = CourseModel.fromJson(item);

        // Check if course has the desired tag_id
        if (course.tag != null &&
            course.tag!.any((tag) => tag.tagId == query)) {
          courses.add(course);
        }
      }

      return courses;
    } else {
      throw Exception('Failed to get courses');
    }
  }

  Future<List<TagModel>> getTags() async {
    var url = Uri.parse('$baseUrl/tag');
    var response = await http.get(url);
    print('TAG COURSE ' + response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<TagModel> tags = data.map((tag) => TagModel.fromJson(tag)).toList();

      return tags;
    } else {
      throw Exception('failed load data');
    }
  }
}
