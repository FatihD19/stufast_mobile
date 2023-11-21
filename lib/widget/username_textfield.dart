import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';

class UsernameTextField extends StatelessWidget {
  final String hintText;
  String? type;
  TextEditingController? controller;
  bool? readOnly = false;

  UsernameTextField(
      {required this.hintText, this.type, this.controller, this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            type ?? '',
            style: primaryTextStyle.copyWith(fontWeight: bold),
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
            readOnly: readOnly ?? false,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: secondaryTextStyle.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 14),
              contentPadding: EdgeInsets.all(12),
              border:
                  InputBorder.none, // Tidak menampilkan border bawaan TextField
            ),
          ),
        ),
      ],
    );
  }
}
