import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/services/user_course_service.dart';

class UserBundleProvider with ChangeNotifier {
  List<BundlingModel> _userBundle = [];
  List<BundlingModel> get userBundle => _userBundle;

  set userBundle(List<BundlingModel> userBundle) {
    _userBundle = userBundle;
    notifyListeners();
  }

  Future<void> getUserBundle() async {
    try {
      List<BundlingModel> userBundle =
          await UserCourseService().getUserBundle();
      _userBundle = userBundle;
    } catch (e) {
      print(e);
    }
  }
}
