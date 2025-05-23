// ignore_for_file: prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:stufast_mobile/services/Auth/login_google_service.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/loading_button.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:stufast_mobile/widget/username_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  bool _obscureText = true;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider? authProvider = Provider.of<AuthProvider>(context);
    // Future<SharedPreferences> coreUser = SharedPreferences.getInstance();

    sendDeviceToken() async {
      String? token = await FirebaseMessaging.instance.getToken();
      AuthService.sendDeviceToken("${token}");
    }

    Widget loadingPopUp() {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white.withOpacity(0.5),
        child: Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
      );
    }

    googleSignIn() async {
      var user = await LoginApi.login();
      if (user != null) {
        setState(() {
          isLoading = true;
        });
        print('sukses login' + user.displayName.toString());
        print('sukses login' + user.email.toString());
        print('sukses login' + user.id.toString());
        final result = await authProvider.login(
          isGoogle: true,
          fullname: user.displayName,
          id: user.id,
          email: user.email,
        );
        if (result == true) {
          await sendDeviceToken();
          await authProvider.getProfileUser();
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('saveLogin', true);

          setState(() {
            isLoading = false;
          });
          Navigator.pushNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                'Gagal Login!',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        await sendDeviceToken();
        await authProvider.getProfileUser();
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    saveLogin() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('saveLogin', true);
    }

    Widget formEmail() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 8),
            child: UsernameTextField(
              type: 'Email',
              hintText: 'Masukan Email kamu',
              controller: emailController,
            ),
          ),
          SizedBox(height: 24),
        ],
      );
    }

    Widget remember_forgot() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (newValue) {
                  setState(() {
                    _rememberMe = newValue!;
                    if (_rememberMe == true) {
                      saveLogin();
                    }
                  });
                },
              ),
              Text(
                'Ingat Saya',
                style: secondaryTextStyle,
              ),
            ],
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgotpass-page');
              },
              child: Text(
                'Lupa kata sandi ?',
                style: thirdTextStyle,
              ))
        ],
      );
    }

    Widget formPassword() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Password',
              style: secondaryTextStyle.copyWith(fontWeight: bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
              border: Border.all(
                  color: Color(0xFFD2D2D2),
                  width: 1), // Border dengan stroke D2D2D2
              borderRadius: BorderRadius.circular(8), // Border radius 8
            ),
            child: TextField(
              controller: passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'password',
                hintStyle: secondaryTextStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 14),
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget lineToregis() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 1.0,
            width: 140.0,
            color: secondaryTextColor,
          ),
          Text('atau', style: secondaryTextStyle),
          Container(
            height: 1.0,
            width: 140.0,
            color: secondaryTextColor,
          ),
        ],
      );
    }

    Widget registerButton() {
      return Container(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: googleSignIn,
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Latar belakang putih
            onPrimary: Color(0xFF757575), // Warna teks saat di atas latar putih
            side: BorderSide(
                color: Color(0xFF757575),
                width: 2), // Border berwarna 248043 dengan lebar 2
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Border radius 10
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/ic_google.png'),
                SizedBox(width: 10),
                Text(
                  'Masuk dengan Google',
                  style: secondaryTextStyle.copyWith(fontWeight: bold),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/landing-page');
        return true; // Kembalikan true agar tombol "back" tidak keluar dari aplikasi.
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Masuk',
              style: primaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            elevation: 0, // Menghilangkan shadow
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pushNamed(context, '/landing-page');
              },
            ),
            backgroundColor: Colors.white,
            centerTitle: false,
          ),
          body: isLoading == true
              ? loadingPopUp()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      formEmail(),
                      formPassword(),
                      remember_forgot(),
                      SizedBox(height: 32),
                      isLoading
                          ? LoadingButton()
                          : Container(
                              width: double.infinity,
                              height: 54,
                              child: PrimaryButton(
                                  text: 'Masuk', onPressed: handleSignIn)),
                      SizedBox(height: 35),
                      lineToregis(),
                      SizedBox(height: 35),
                      registerButton()
                    ],
                  ),
                )),
    );
  }
}
