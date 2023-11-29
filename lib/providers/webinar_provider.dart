import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/webinar_model.dart';
import 'package:stufast_mobile/services/Course/webinar_service.dart';

class WebinarProvider with ChangeNotifier {
  List<WebinarModel> _webinar = [];
  List<WebinarModel> get webinar => _webinar;

  set webinar(List<WebinarModel> webinar) {
    _webinar = webinar;
    notifyListeners();
  }

  List<WebinarModel> _userWebinar = [];
  List<WebinarModel> get userWebinar => _userWebinar;

  set userWebinar(List<WebinarModel> webinar) {
    _userWebinar = webinar;
    notifyListeners();
  }

  List<String> _banner = [];
  List<String> get banner => _banner;

  set banner(List<String> banner) {
    _banner = banner;
    notifyListeners();
  }

  bool loading = true;

  Future<void> getWebinar(bool owned) async {
    try {
      List<WebinarModel> webinar = await WebinarService().getWebinar(owned);
      loading = false;
      owned == true ? _userWebinar = webinar : _webinar = webinar;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getBanner() async {
    try {
      List<String> banner = await WebinarService().getBanner();
      loading = false;
      _banner = banner;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
