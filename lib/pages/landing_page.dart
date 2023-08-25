// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget landingUi() {
      return Column(
        children: [
          Container(
              // width: 173,
              // height: 142,
              padding: EdgeInsets.only(top: 30, left: 25),
              alignment: Alignment.bottomLeft,
              child: Image.asset('assets/landing_ui_head.png')),
          Container(
              width: 538,
              height: 332,
              alignment: Alignment.centerRight,
              child: Image.asset('assets/landing_ui_body.png')),
        ],
      );
    }

    Widget toLoginButton() {
      return Container(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login-page');
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Latar belakang putih
            onPrimary: Color(0xFF248043), // Warna teks saat di atas latar putih
            side: BorderSide(
                color: Color(0xFF248043),
                width: 2), // Border berwarna 248043 dengan lebar 2
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Border radius 10
            ),
          ),
          child: Text(
            'Masuk Ke Akun Kamu',
            style: thirdTextStyle.copyWith(fontWeight: bold),
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: 428,
        height: 297,
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  'Selamat Datang',
                  style: primaryTextStyle.copyWith(
                      fontSize: 30, fontWeight: semiBold),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Ayo mulai belajar dengan topik yang kamu minati di Stufast.id!',
                    style: secondaryTextStyle,
                  ),
                ),
                SizedBox(height: 46),
                Container(
                    width: double.infinity,
                    height: 54,
                    child: PrimaryButton(
                        text: 'Daftar Sekarang',
                        onPressed: () {
                          Navigator.pushNamed(context, '/register-page');
                        })),
                SizedBox(
                  height: 16,
                ),
                toLoginButton()
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [landingUi(), content()],
      ),
    );
  }
}
