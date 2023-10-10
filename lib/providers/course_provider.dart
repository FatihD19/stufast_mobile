import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/tag_model.dart';
import 'package:stufast_mobile/services/Course/course_service.dart';

class CourseProvider with ChangeNotifier {
  List<CourseModel> _courses = [];
  List<CourseModel> get courses => _courses;
  bool loading = true;

  List<CourseModel> _coursesFilter = [];
  List<CourseModel> get coursesFilter => _coursesFilter;

  List<TagModel> _tags = [];

  List<TagModel> get tags => _tags;

  List<TagModel> _tagsIT = [];

  List<TagModel> get tagsIT => _tagsIT;

  set courses(List<CourseModel> courses) {
    _courses = courses;
    notifyListeners();
  }

  Future<void> getCourses([String? typeCourse]) async {
    try {
      List<CourseModel> courses = await CourseService().getCourse(typeCourse);
      _courses = courses;
      loading = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchCourses(String query) async {
    try {
      List<CourseModel> courses = await CourseService().searchCourse(query);
      // _coursesFilter = courses;
      _courses = courses;
    } catch (e) {
      _courses = [];
      print(e);
    }
  }

  Future<void> searchbyCourses([String? query, String? category]) async {
    try {
      List<CourseModel> courses = await CourseService()
          .searchCourseByTag(query: query, category: category);
      // _coursesFilter = courses;
      _courses = courses;
    } catch (e) {
      print(e);
    }
  }

  Future<void> loadTags() async {
    try {
      List<TagModel> tags = await CourseService().getTags('1');
      List<TagModel> tagsIT = await CourseService().getTags('2');
      _tags = tags;
      _tagsIT = tagsIT;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
