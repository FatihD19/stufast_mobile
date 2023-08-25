import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class SuccsessPage extends StatelessWidget {
  String? titleMess;
  String? mess;

  SuccsessPage({this.titleMess, this.mess});

  @override
  Widget build(BuildContext context) {
    Widget succsessMessage(String title, String messasge) {
      return Column(
        children: [
          Text(
            '$title',
            style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 30),
          ),
          SizedBox(height: 8),
          Text(
            '$messasge',
            style: secondaryTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    Widget klikSuccsess() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        height: 54,
        child: PrimaryButton(
            text: 'Masuk',
            onPressed: () {
              Navigator.pushNamed(context, '/login-page');
            }),
      );
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image_sucsess.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 32),
            succsessMessage(titleMess!, mess!)
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: klikSuccsess(),
    );
  }
}
