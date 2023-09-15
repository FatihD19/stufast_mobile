import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/services/bundle_service.dart';
import 'package:stufast_mobile/services/user_course_service.dart';

class BundleProvider with ChangeNotifier {
  List<BundlingModel> _userBundle = [];
  List<BundlingModel> get userBundle => _userBundle;

  set userBundle(List<BundlingModel> userBundle) {
    _userBundle = userBundle;
    notifyListeners();
  }

  List<BundlingModel> _bundle = [];
  List<BundlingModel> get bundle => _bundle;

  set bundle(List<BundlingModel> bundle) {
    _bundle = bundle;
    notifyListeners();
  }

  BundlingModel? _detailBundling;
  BundlingModel? get detailBundling => _detailBundling;

  set detailBundling(BundlingModel? detailBundling) {
    _detailBundling = detailBundling;
    notifyListeners();
  }

  Future<void> getBundles() async {
    try {
      List<BundlingModel> bundle = await BundleService().getBundle();
      _bundle = bundle;
    } catch (e) {
      print(e);
    }
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

  Future<void> getDetailBundle(String id) async {
    try {
      BundlingModel detailBundling = await BundleService().getDetailBundle(id);
      _detailBundling = detailBundling;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
