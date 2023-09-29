import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/faq_model.dart';
import 'package:stufast_mobile/services/faq_services.dart';

class FaqProvider with ChangeNotifier {
  List<FaqModel> _faq = [];
  List<FaqModel> get faq => _faq;
  bool loading = true;
  set faq(List<FaqModel> faq) {
    _faq = faq;
    notifyListeners();
  }

  Future<void> getFaq() async {
    try {
      List<FaqModel> faq = await FaqService().getFaq();
      _faq = faq;
      loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
