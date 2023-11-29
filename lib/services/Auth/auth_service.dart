import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/user_model.dart';

class AuthService {
  static String baseUrl = 'https://stufast.id/public/dev2/public/api';

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
    bool? isGoogle,
    String? fullname,
    String? id,
    String? email,
    String? password,
  }) async {
    var url = isGoogle == true
        ? Uri.parse('$baseUrl/login/google')
        : Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = isGoogle == true
        ? jsonEncode({"email": email, "fullname": fullname, "id": id})
        : jsonEncode({
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

  Future<bool> uploadProfilePicture(String id, File imageFile) async {
    var url = Uri.parse('$baseUrl/users/update/profile-picture/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    var response = await http.post(url,
        headers: headers, body: imageFile.readAsBytesSync());
    print('UPLOAD IMAGE' + response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> editProfil(
      {String? id,
      String? nama,
      String? dateBirth,
      String? address,
      String? phoneNumber,
      XFile? profilePicture}) async {
    var url = Uri.parse('$baseUrl/users/update/$id');
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    // Dio dio = Dio();
    // FormData formData = FormData.fromMap({
    //   'fullname': nama,
    //   'phone_number': phoneNumber,
    //   'address': address,
    //   'date_birth': dateBirth,
    //   // 'profile_picture': await MultipartFile.fromFile(profilePicture!.path,
    //   //     filename: profilePicture.path.split('/').last),
    // });
    // if (profilePicture != null) {
    //   // Periksa apakah profilePicture tidak null
    //   final bytes = await profilePicture.readAsBytes();
    //   formData.files.add(MapEntry(
    //     'profile_picture',
    //     await MultipartFile.fromFileSync(
    //       profilePicture.path,
    //       filename: profilePicture.path.split('/').last,
    //     ),
    //   ));
    // }
    // Response response = await dio.post(url.toString(),
    //     data: formData, options: Options(headers: headers));
    // var map = response.data as Map;
    // print(map);
    // if (response.statusCode == 201) {
    //   return true;
    // } else {
    //   print(map);
    //   return false;
    // }
    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..fields['fullname'] = nama!
      ..fields['phone_number'] = phoneNumber!
      ..fields['address'] = address!
      ..fields['date_birth'] = dateBirth!;

    if (profilePicture != null) {
      final bytes = await profilePicture.readAsBytes();
      // Jika profile_picture tidak kosong, tambahkan gambar ke dalam request
      request.files.add(http.MultipartFile.fromBytes(
        'profile_picture',
        bytes,
        filename: profilePicture.name,
      ));
    }

    // Kirim permintaan dengan file gambar jika ada
    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = utf8.decode(responseData);

    print(responseString);
    if (response.statusCode == 201) {
      // final responseData = await response.stream.bytesToString();
      // final data = jsonDecode(responseData);
      // // String status = data['status'].toString();
      return true;
    } else {
      print(response);
      return false;
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
