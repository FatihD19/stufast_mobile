import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/order_model.dart';
import 'package:stufast_mobile/services/checkout_services.dart';

import '../models/chart_model.dart';

class CheckoutProvider with ChangeNotifier {
  ChartModel? _checkout;
  ChartModel? get checkout => _checkout;

  set checkout(ChartModel? checkout) {
    _checkout = checkout;
    notifyListeners();
  }

  OrderModel? _order;
  OrderModel? get order => _order;

  set order(OrderModel? order) {
    _order = order;
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

  Future<void> orderItem(List id) async {
    try {
      OrderModel order = await CheckOutService().orderItem(id);
      _order = order;
    } catch (e) {
      print(e);
    }
  }
}
