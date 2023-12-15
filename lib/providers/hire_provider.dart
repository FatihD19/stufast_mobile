import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/hire_model.dart';

import '../services/Hire/hire_service.dart';

class HireProvider with ChangeNotifier {
  List<HireModel> _hires = [];
  List<HireModel> get hires => _hires;

  bool loading = true;
  bool loadingConfirm = true;

  set hires(List<HireModel> hires) {
    _hires = hires;
    notifyListeners();
  }

  Future<void> getHire() async {
    try {
      List<HireModel> hires = await HireService().getHireOffer();
      _hires = hires;
      loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> confirmHire(String idHire, String confrim) async {
    try {
      final result = await HireService().confirmHire(idHire, confrim);
      loadingConfirm = false;
      notifyListeners();
      return result;
    } catch (e) {
      return false;
    }
  }
}
