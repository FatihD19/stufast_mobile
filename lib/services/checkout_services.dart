import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/order_model.dart';
import 'package:stufast_mobile/models/voucher_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

import '../models/chart_model.dart';

class CheckOutService {
  Future<ChartModel> checkoutCourse(List id, {String? type}) async {
    var url = Uri.parse(AuthService.baseUrl + '/cart/process');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      "item_id": id,
      "type": type,
    });

    var response = await http.post(url, headers: headers, body: body);

    print('LIST CHECKOUT' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ChartModel chart = ChartModel.fromJson(data);
      return chart;
    } else {
      throw Exception('Gagal get chart');
    }
  }

  Future<OrderModel> orderItem(List id, {String? kupon, String? type}) async {
    var url = Uri.parse(AuthService.baseUrl + '/order/generatesnap-2');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      "item_id": id, "type": "$type", //langsung course/bundling
      "code": '$kupon'
    });

    var response = await http.post(url, headers: headers, body: body);

    print('ORDER' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      OrderModel order = OrderModel.fromJson(data);
      return order;
    } else {
      throw Exception('Gagal get chart');
    }
  }

  Future<bool> cancelOrder(String orderID) async {
    var url = Uri.parse(AuthService.baseUrl + '/order/cancel');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      "order_id": orderID,
    });

    var response = await http.post(url, headers: headers, body: body);

    print('CANCEL ORDER' + response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<VoucherModel> useVoucher(String code) async {
    var url =
        Uri.parse(AuthService.baseUrl + '/voucher/code-detail?code=$code');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(url, headers: headers);

    print('get VOUCHER' + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      VoucherModel voucher = VoucherModel.fromJson(data);

      return voucher;
    } else {
      throw Exception('Gagal get voucher');
    }
  }
}
