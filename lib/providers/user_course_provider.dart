import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/services/Course/user_course_service.dart';

class UserCourseProvider with ChangeNotifier {
  List<CourseModel> _userCourses = [];
  List<CourseModel> get userCourses => _userCourses;

  bool loading = true;

  set userCourses(List<CourseModel> userCourses) {
    _userCourses = userCourses;
    notifyListeners();
  }

  CourseModel? _detailCourse;
  CourseModel? get detailCourse => _detailCourse;

  set detailCourse(CourseModel? detailCourse) {
    _detailCourse = detailCourse;
    notifyListeners();
  }

  Future<void> getUserCourses() async {
    try {
      List<CourseModel> userCourses = await UserCourseService().getUserCourse();
      _userCourses = userCourses;
      loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getDetailUserCourse(String id) async {
    try {
      CourseModel detailCourse =
          await UserCourseService().getDetailUserCourse(id);
      _detailCourse = detailCourse;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createCourseReview(String id, String review, int rating) async {
    try {
      bool result = await UserCourseService().createReview(id, review, rating);
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void clearDetailCourse() {
    detailCourse = null;
    notifyListeners();
  }
}
