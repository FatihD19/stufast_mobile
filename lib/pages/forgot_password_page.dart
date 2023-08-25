import 'package:flutter/material.dart';
import 'package:stufast_mobile/pages/succsess_page.dart';
import 'package:stufast_mobile/services/reset_password_service.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:stufast_mobile/widget/username_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool aturUlang = false;
  bool inputOtp = false;
  bool buatpass = false;

  int stepReset = 0;

  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  bool _rememberMe = false;

  TextEditingController _emailController = TextEditingController(text: '');
  TextEditingController _otpController = TextEditingController(text: '');
  TextEditingController _passwordController = TextEditingController(text: '');
  TextEditingController _confirmPasswordController =
      TextEditingController(text: '');

  ResetPasswordService reset = ResetPasswordService();
  @override
  Widget build(BuildContext context) {
    _showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: primaryColor,
          content: Text(
            message,
            style: primaryTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    sendResetEmail() async {
      try {
        String message = await reset.sendEmail(email: _emailController.text);
        _showSnackBar(message);
      } catch (e) {
        _showSnackBar("Failed to send reset email");
      }
    }

    Widget aturUlangPass() {
      return Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Atur Ulang Kata sandi',
                style: primaryTextStyle.copyWith(fontWeight: semiBold),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Silakan masukkan alamat email kamu',
                style: secondaryTextStyle,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Email',
                style: secondaryTextStyle.copyWith(fontWeight: bold),
              ),
            ),
            UsernameTextField(
              hintText: 'Masukan Email kamu',
              controller: _emailController,
            ),
            SizedBox(
              height: 24,
            ),
            Container(
                width: double.infinity,
                height: 54,
                child: PrimaryButton(
                    text: 'Selanjutnya',
                    onPressed: () {
                      sendResetEmail();
                      setState(() {
                        //email ada ?
                        stepReset++;
                        print(stepReset);
                      });
                    })),
          ],
        ),
      );
    }

    Widget inputOTP() {
      return Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Kode OTP',
                style: primaryTextStyle.copyWith(fontWeight: semiBold),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Expanded(
                child: Text(
                  'Silakan masukkan kode OTP yang telah dikirimkan ke email ***********@gmail.com',
                  style: secondaryTextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'OTP',
                style: secondaryTextStyle.copyWith(fontWeight: bold),
              ),
            ),
            UsernameTextField(hintText: 'Masukkan kode OTP'),
            SizedBox(
              height: 24,
            ),
            Container(
                width: double.infinity,
                height: 54,
                child: PrimaryButton(
                    text: 'Konfirmasi',
                    onPressed: () {
                      setState(() {
                        //email ada ?
                        stepReset++;
                        print(stepReset);
                      });
                    })),
          ],
        ),
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
              style: secondaryTextStyle.copyWith(fontWeight: FontWeight.bold),
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
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16), // Jarak antara password dan konfirmasi password
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Confirm Password',
              style: secondaryTextStyle.copyWith(fontWeight: FontWeight.bold),
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
                  text: 'Simpan',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SuccsessPage(
                                  titleMess: 'Berhasil Diperbarui!',
                                  mess:
                                      'Kata sandi kamu berhasil diperbarui. Silakan masuk ke akun kamu',
                                )));
                  })),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lupa Kata Sandi',
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
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
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 24),
              stepReset == 0
                  ? aturUlangPass()
                  : stepReset == 1
                      ? inputOTP()
                      : stepReset == 2
                          ? formPassword()
                          : aturUlangPass()
            ],
          ),
        ));
  }
}
