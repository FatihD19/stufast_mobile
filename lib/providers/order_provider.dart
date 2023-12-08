import 'package:flutter/foundation.dart';
import 'package:stufast_mobile/models/invoice_model.dart';
import 'package:stufast_mobile/models/orderHistoryModel.dart';
import 'package:stufast_mobile/services/checkout_services.dart';
import 'package:stufast_mobile/services/order_service.dart';

class OrderProvider with ChangeNotifier {
  List<OrderHistoryModel> _orderHistoryPending = [];
  List<OrderHistoryModel> get orderHistoryPending => _orderHistoryPending;

  InvoiceModel? _invoice;
  InvoiceModel? get invoice => _invoice;

  set invoice(InvoiceModel? invoice) {
    _invoice = invoice;
    notifyListeners();
  }

  bool loading = true;

  Future<void> getorderHistory(String option) async {
    try {
      List<OrderHistoryModel> orderHistory =
          await OrderService().getOrder(option);
      _orderHistoryPending = orderHistory;
      notifyListeners();
      loading = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getInvoice(String orderId) async {
    try {
      InvoiceModel invoice = await OrderService().getInvoice(orderId);
      _invoice = invoice;
      notifyListeners();
      loading = false;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> cancelOrder(String orderID) async {
    try {
      bool cancel = await CheckOutService().cancelOrder(orderID);
      return cancel;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
