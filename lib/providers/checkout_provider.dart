import 'package:flutter/material.dart';
import 'package:stufast_mobile/services/checkout_services.dart';

import '../models/chart_model.dart';

class CheckoutProvider with ChangeNotifier {
  ChartModel? _checkout;
  ChartModel? get checkout => _checkout;

  set checkout(ChartModel? checkout) {
    _checkout = checkout;
    notifyListeners();
  }

  Future<void> checkoutCourse(List id) async {
    try {
      ChartModel checkout = await CheckOutService().checkoutCourse(id);
      _checkout = checkout;
    } catch (e) {
      print(e);
    }
  }
}
