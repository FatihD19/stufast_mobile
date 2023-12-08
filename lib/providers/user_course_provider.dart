import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<bool> createCourseReview(String id, String review, int rating,
      {bool? isBundle}) async {
    try {
      bool result = await UserCourseService()
          .createReview(id, review, rating, isBundling: isBundle);
      notifyListeners();
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future downloadSertif({
    bool? isBundling,
    String? idBundle,
    String? idCourse,
    bool? courseBundle,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var urlSertif = isBundling == true
        ? 'https://stufast.id/public/dev2/public/certificates?type=bundling&id=${idBundle}&token=$token'
        : courseBundle == true
            ? 'https://stufast.id/public/dev2/public/certificates?type=course-bundling&id=${idCourse}&bundl=${idBundle}&token=$token'
            : 'https://stufast.id/public/dev2/public/certificates?type=course&id=${idCourse}&token=$token';
    await Permission.storage.request();
    final baseStorage = await getExternalStorageDirectory();
    try {
      await FlutterDownloader.enqueue(
        url: urlSertif,
        headers: {}, // optional: header send with url (auth token etc)
        savedDir: baseStorage!.path,
        saveInPublicStorage: true,
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
      );
      print('PATH' + baseStorage.path);
    } catch (e) {
      print(e);
    }

    void clearDetailCourse() {
      detailCourse = null;
      userCourses = [];
      notifyListeners();
    }
  }
}
