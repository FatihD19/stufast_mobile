import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/user_course_model.dart';

import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class UserCourseService {
  String baseUrl = 'http://dev.stufast.id/api';

  Future<UserCourseModel> getUserCourse() async {
    var url = Uri.parse(baseUrl + '/profile/course');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('USER_COURSE ' + response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserCourseModel userCourse = UserCourseModel.fromJson(data);
      return userCourse;
    } else {
      throw Exception('failed load usercourse');
    }
  }

  // Future<List<CourseModel>> getUserCourse() async {
  //   var url = Uri.parse(AuthService.baseUrl + '/profile/course');
  //   final prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString('token');
  //   var headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };
  //   var response = await http.get(url, headers: headers);
  //   print('USER_COURSE ' + response.body);
  //   if (response.statusCode == 200) {
  //     List data = jsonDecode(response.body)['course'];
  //     List<CourseModel> course = [];

  //     for (var item in data) {
  //       course.add(CourseModel.fromJson(item));
  //     }
  //     return course;
  //   } else {
  //     throw Exception('failed load usercourse');
  //   }
  // }

  Future<List<BundlingModel>> getUserBundle() async {
    var url = Uri.parse(AuthService.baseUrl + '/profile/course');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('BUNDLE_COURSE ' + response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['bundling'];
      List<BundlingModel> bundle = [];

      for (var item in data) {
        bundle.add(BundlingModel.fromJson(item));
      }
      return bundle;
    } else {
      throw Exception('failed load bundle user');
    }
  }

  Future<CourseModel> getDetailUserCourse(String id) async {
    var url = Uri.parse(AuthService.baseUrl + '/course/detail/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token == null ? '' : 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('DETAIL_COURSE ' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      CourseModel course = CourseModel.fromJson(data);
      return course;
    } else {
      throw Exception('failed load detail course');
    }
  }

  Future<bool> createReview(String courseId, String feedback, int score,
      {bool? isBundling}) async {
    var url = Uri.parse(AuthService.baseUrl + '/review/create_2');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = isBundling == true
        ? jsonEncode({
            'feedback': feedback,
            'score': score,
            'bundling_id': courseId,
          })
        : jsonEncode({
            'feedback': feedback,
            'score': score,
            'course_id': courseId,
          });
    var response = await http.post(url, headers: headers, body: body);
    print('CREATE_REVIEW ' + response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('failed create review');
    }
  }
}
