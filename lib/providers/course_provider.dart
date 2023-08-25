import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/services/course_service.dart';

class CourseProvider with ChangeNotifier {
  List<CourseModel> _courses = [];
  List<CourseModel> get courses => _courses;

  set courses(List<CourseModel> courses) {
    _courses = courses;
    notifyListeners();
  }

  Future<void> getCourses() async {
    try {
      List<CourseModel> courses = await CourseService().getCourse();
      _courses = courses;
    } catch (e) {
      print(e);
    }
  }
}
