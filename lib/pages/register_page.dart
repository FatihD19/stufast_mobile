// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/succsess_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/loading_button.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../widget/username_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  bool _rememberMe = false;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController fullNameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  DateTime? selectedDate;
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleRegister() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
          email: emailController.text,
          nama: fullNameController.text,
          address: addressController.text,
          dateBirth: selectedDate.toString(),
          phoneNumber: phoneNumberController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text)) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuccsessPage(
                      titleMess: 'Berhasil Mendaftar',
                      mess:
                          'Silakan cek email kamu untuk mengaktifkan akun kamu',
                    )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Register!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget formEmail() {
      return Column(
        children: [
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
            controller: emailController,
          ),
          SizedBox(height: 24),
        ],
      );
    }

    Widget formFullName() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Full Name',
              style: secondaryTextStyle.copyWith(fontWeight: bold),
            ),
          ),
          UsernameTextField(
            hintText: 'Masukan Nama',
            controller: fullNameController,
          ),
          SizedBox(height: 24),
        ],
      );
    }

    Widget formAddress() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Address',
              style: secondaryTextStyle.copyWith(fontWeight: bold),
            ),
          ),
          UsernameTextField(
            hintText: 'Masukan Address kamu',
            controller: addressController,
          ),
          SizedBox(height: 24),
        ],
      );
    }

    Widget formPhone() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Phone',
              style: secondaryTextStyle.copyWith(fontWeight: bold),
            ),
          ),
          UsernameTextField(
            hintText: 'Masukan Phone kamu',
            controller: phoneNumberController,
          ),
          SizedBox(height: 24),
        ],
      );
    }

    Widget formTglLahir() {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Tanggal Lahir',
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
            child: DateTimeField(
                decoration: InputDecoration(
                  hintText: 'masukan tanggal lahir',
                  hintStyle: secondaryTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  contentPadding: EdgeInsets.all(12),
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                mode: DateTimeFieldPickerMode.date,
                dateFormat: DateFormat('yyyy-MM-dd'),
                selectedDate: selectedDate,
                onDateSelected: (DateTime value) {
                  setState(() {
                    selectedDate = value;
                  });
                }),
          ),
          SizedBox(height: 16),
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
              controller: passwordController,
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
              controller: confirmPasswordController,
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
        ],
      );
    }

    Widget termCond() {
      return Row(
        children: [
          Checkbox(
            value: _rememberMe,
            onChanged: (newValue) {
              setState(() {
                _rememberMe = newValue!;
              });
            },
          ),
          Expanded(
            child: Text(
              'Dengan mendaftar kamu menyetujui Terms & Condition dan Kebijakan Privasi.',
              style: secondaryTextStyle,
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

    Widget daftarButton() {
      return Container(
          width: double.infinity,
          height: 54,
          child: PrimaryButton(text: 'Daftar', onPressed: handleRegister));
    }

    Widget registerButton() {
      return Container(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login-page');
          },
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Daftar',
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
          child: ListView(
            children: [
              formFullName(),
              formEmail(),
              formAddress(),
              formPhone(),
              formTglLahir(),
              formPassword(),
              SizedBox(height: 24),
              termCond(),
              SizedBox(height: 32),
              isLoading ? LoadingButton() : daftarButton(),
              SizedBox(height: 35),
              lineToregis(),
              SizedBox(height: 35),
              registerButton()
            ],
          ),
        ));
  }
}
