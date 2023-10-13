import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/user_model.dart';

class AuthService {
  static String baseUrl = 'https://dev.stufast.id/api';

  Future<UserModel> register(
      {String? email,
      String? nama,
      String? dateBirth,
      String? address,
      String? phoneNumber,
      String? password,
      String? confirmPassword}) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'fullname': nama,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'date_birth': dateBirth,
      'password': password,
      'password_confirm': confirmPassword
    });
    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['data'][0]);
      UserModel user = UserModel.fromJson(data['user']);
      user.token = data['data'][0];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['data'][0]);
      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<String> editProfil(
    String? id,
    String? nama,
    String? dateBirth,
    String? address,
    String? phoneNumber,
    File? profilePicture,
  ) async {
    var url = Uri.parse('$baseUrl/users/update/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    // var body = jsonEncode({
    //   'fullname': nama,
    //   'phone_number': phoneNumber,
    //   'address': address,
    //   'date_birth': dateBirth,
    // });
    // var response = await http.post(url, headers: headers, body: body);

    // print(response.body);
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['fullname'] = nama!
      ..fields['phone_number'] = phoneNumber!
      ..fields['address'] = address!
      ..fields['date_birth'] = dateBirth!;

    // Cek apakah profile_picture tidak null, jika tidak, tambahkan gambar ke permintaan
    // if (profilePicture != null) {
    //   var pic = await http.MultipartFile.fromPath(
    //       'profile_picture', profilePicture.path);
    //   request.files.add(pic);
    //   print(pic.filename);
    // }
    if (profilePicture != null) {
      // Jika profile_picture tidak kosong, tambahkan gambar ke dalam request
      request.files.add(await http.MultipartFile.fromPath(
        'profile_picture',
        profilePicture.path,
      ));
    }

    // Kirim permintaan dengan file gambar jika ada
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = utf8.decode(responseData);

    print(responseString);
    if (response.statusCode == 201) {
      final responseData = await response.stream.bytesToString();
      final data = jsonDecode(responseData);
      String status = data['status'].toString();
      return status;
    } else {
      print(response);
      throw Exception('Gagal Edit Profile');
    }
  }

  Future<UserModel> getProfile() async {
    var url = Uri.parse('$baseUrl/profile');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    print('USER ' + response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UserModel user = UserModel.fromJson(data);
      return user;
    } else {
      throw Exception('failed load data');
    }
  }

  static Future<bool> sendDeviceToken(String dToken) async {
    var url = Uri.parse('$baseUrl/device-token');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({'device_token': dToken});
    var response = await http.post(url, headers: headers, body: body);
    print('sendToken ' + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('failed load data');
    }
  }
}
