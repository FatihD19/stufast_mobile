import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/webinar_model.dart';
import 'package:stufast_mobile/services/webinar_service.dart';

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
}
