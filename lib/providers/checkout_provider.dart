import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/order_model.dart';
import 'package:stufast_mobile/models/voucher_model.dart';
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

  VoucherModel? _voucher;
  VoucherModel? get voucher => _voucher;

  set voucher(VoucherModel? voucher) {
    _voucher = voucher;
    notifyListeners();
  }

  Future<void> checkoutCourse(List id, {String? type}) async {
    try {
      ChartModel checkout =
          await CheckOutService().checkoutCourse(id, type: type);
      _checkout = checkout;
    } catch (e) {
      print(e);
    }
  }

  Future<void> orderItem(List id, {String? kupon, String? type}) async {
    try {
      OrderModel order =
          await CheckOutService().orderItem(id, kupon: kupon, type: type);
      _order = order;
    } catch (e) {
      print(e);
    }
  }

  Future<void> useVoucher(String code) async {
    try {
      VoucherModel voucher = await CheckOutService().useVoucher(code);
      voucher.status = true;
      _voucher = voucher;
    } catch (e) {
      voucher?.status = false;
      print(e);
    }
  }
}
