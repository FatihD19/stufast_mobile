import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/webinar_model.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

class WebinarService {
  Future<List<WebinarModel>> getWebinar(bool owned) async {
    var url = Uri.parse(AuthService.baseUrl + '/webinar');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('Webinar ' + response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<WebinarModel> webinar = [];
      List<WebinarModel> userWebinar = [];

      for (var item in data) {
        final webinarModel = WebinarModel.fromJson(item);

        // Filter webinar berdasarkan nilai owned
        if (owned && webinarModel.owned == true) {
          userWebinar.add(webinarModel);
          print('USER_WEBINAR' + '${userWebinar}');
          return userWebinar;
        } else if (!owned) {
          webinar.add(webinarModel);
        }
      }
      return owned == false ? webinar : userWebinar;
    } else {
      throw Exception('failed load webinar');
    }
  }
}
