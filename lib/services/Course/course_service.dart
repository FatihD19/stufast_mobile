import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stufast_mobile/api/api_url.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/tag_model.dart';

class CourseService {
  String baseUrl = '${ApiUrl.api_url}/api';

  Future<List<CourseModel>> getCourse([String? typeCourse]) async {
    var url = typeCourse == 'all'
        ? Uri.parse('${ApiUrl.api_url}/course/all')
        : Uri.parse('${ApiUrl.api_url}/course/latest/10');

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

  Future<CoursePaginationModel> getCourseFilter(
      {int? index,
      String? tag,
      String? category,
      String? sort,
      String? search}) async {
    var url = Uri.parse('${ApiUrl.api_url}/course/pagination');
    var body = jsonEncode({
      "page": index,
      "tag": tag != null ? [tag] : [],
      "category": category != null ? [category] : [],
      "sort": sort != null
          ? {"value": "new_price", "order": sort}
          : {"value": "updated_at", "order": "desc"},
      "search": search ?? ""
    });

    var response = await http.post(url, body: body);
    print(body);
    print('FILTER COURSE ' + response.body);

    if (response.statusCode == 200) {
      CoursePaginationModel coursePagination =
          CoursePaginationModel.fromJson(jsonDecode(response.body));
      return coursePagination;
    } else {
      throw Exception('Gagal get Products');
    }
  }

  Future<List<CourseModel>> searchCourse(String query) async {
    var url = Uri.parse('${ApiUrl.api_url}/course/find/$query');
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

  Future<List<CourseModel>> searchCourseByTag(
      {String? query, String? category}) async {
    var url = Uri.parse('${ApiUrl.api_url}/course/all');
    var response = await http.get(url);

    print('SEARCH COURSE ' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<CourseModel> courses = [];

      for (var item in data) {
        CourseModel course = CourseModel.fromJson(item);

        // Check if course has the desired tag_id and category if provided
        if ((query == null ||
                course.tag != null &&
                    course.tag!.any((tag) => tag.tagId == query)) &&
            (category == null || course.category == category)) {
          courses.add(course);
        }
      }

      return courses;
    } else {
      throw Exception('Failed to get courses');
    }
  }

  Future<List<TagModel>> getTags(String id) async {
    var url = Uri.parse('${ApiUrl.api_url}/tag/filter/$id');
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
