import 'dart:convert';
import 'package:stufast_mobile/api/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/hire_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class HireService {
  String? messageNotifConfirm;
  Future<List<HireModel>> getHireOffer() async {
    var url = Uri.parse(ApiUrl.api_url + '/hire/user');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);

    print('HireOffer' + response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<HireModel> hire = [];

      for (var item in data) {
        hire.add(HireModel.fromJson(item));
      }
      return hire;
    } else {
      throw Exception('Gagal get hire offer');
    }
  }

  Future<String> confirmHire(String idHire, String confrim) async {
    var url = Uri.parse(ApiUrl.api_url + '/hire/confirm');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'hire_id': idHire,
      'result': confrim,
    });
    var response = await http.post(url, headers: headers, body: body);

    print('HireOffer' + response.body);

    if (response.statusCode == 200) {
      return messageNotifConfirm = jsonDecode(response.body)['data']['message'];
    } else {
      throw Exception('Gagal get hire offer');
    }
  }

  Future<bool> sendNotifconfirmHire(String message) async {
    var url = Uri.parse(ApiUrl.api_url + '/hire/confirm-notif');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'message': message,
    });
    var response = await http.post(url, headers: headers, body: body);

    print('HireOfferSendNotif' + response.body);

    if (response.statusCode == 200) {
      print('BERHASIL SEND NOTIF');
      return true;
    } else {
      throw Exception('Gagal get hire offer');
    }
  }
}
