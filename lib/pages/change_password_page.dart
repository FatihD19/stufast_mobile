// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/succsess_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:stufast_mobile/services/Auth/reset_password_service.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool _obscureTextOld = true;
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  handleChangePassword() async {
    // ResetPasswordService resetPasswordService = ResetPasswordService();
    print('OLD' + _oldPasswordController.text);
    print('NEW' + _passwordController.text);
    if (await ResetPasswordService().changePassword(
      _oldPasswordController.text,
      _confirmPasswordController.text,
    )) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password diubah'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password gagal diubah'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ganti Password',
            style:
                primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
          ),
          elevation: 0, // Menghilangkan shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          centerTitle: false,
        ),
        body: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Password Lama',
                    style: secondaryTextStyle.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
                    border: Border.all(
                      color: Color(0xFFD2D2D2),
                      width: 1,
                    ), // Border dengan stroke D2D2D2
                    borderRadius: BorderRadius.circular(8), // Border radius 8
                  ),
                  child: TextField(
                    controller: _oldPasswordController,
                    obscureText: _obscureTextOld,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Password',
                      hintStyle: secondaryTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextOld = !_obscureTextOld;
                          });
                        },
                        child: Icon(
                          _obscureTextOld
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Password Baru',
                    style: secondaryTextStyle.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
                    border: Border.all(
                      color: Color(0xFFD2D2D2),
                      width: 1,
                    ), // Border dengan stroke D2D2D2
                    borderRadius: BorderRadius.circular(8), // Border radius 8
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Password',
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
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        16), // Jarak antara password dan konfirmasi password
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Konfirmasi Password Baru',
                    style: secondaryTextStyle.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
                    border: Border.all(
                      color: Color(0xFFD2D2D2),
                      width: 1,
                    ), // Border dengan stroke D2D2D2
                    borderRadius: BorderRadius.circular(8), // Border radius 8
                  ),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureTextConfirm,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Confirm Password',
                      hintStyle: secondaryTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureTextConfirm = !_obscureTextConfirm;
                          });
                        },
                        child: Icon(
                          _obscureTextConfirm
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                    width: double.infinity,
                    height: 54,
                    child: PrimaryButton(
                        text: 'Simpan', onPressed: handleChangePassword)),
              ],
            )));
  }
}
