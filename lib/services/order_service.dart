import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/invoice_model.dart';
import 'package:stufast_mobile/models/orderHistoryModel.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class OrderService {
  Future<List<OrderHistoryModel>> getOrder(String option) async {
    var url =
        Uri.parse(AuthService.baseUrl + '/order/get-order-by-member/$option');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('ORDERHistory' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<OrderHistoryModel> order = [];

      for (var item in data) {
        order.add(OrderHistoryModel.fromJson(item));
      }
      return order;
    } else {
      throw Exception('Gagal get faq');
    }
  }

  Future<InvoiceModel> getInvoice(String orderId) async {
    var url =
        Uri.parse(AuthService.baseUrl + '/invoice/get-invoice-by-id/$orderId');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('InvoiceView' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      InvoiceModel invoice = InvoiceModel.fromJson(data);
      return invoice;
    } else {
      throw Exception('Gagal get chart');
    }
  }
}
