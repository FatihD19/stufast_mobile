import 'dart:io';

import 'package:date_field/date_field.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:stufast_mobile/widget/username_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController fullNameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController dateController = TextEditingController(text: '');
  DateTime? selectedDate;
  bool isLoading = false;
  File? _profilePicture;

  @override
  Widget build(BuildContext context) {
    AuthProvider? authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    // void _pickProfilePicture() async {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.image,
    //     allowMultiple: false,
    //   );

    //   if (result != null && result.files.isNotEmpty) {
    //     setState(() {
    //       _profilePicture = File(result.files.first.path!);
    //     });
    //   }
    // }

    handleEditProfile() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.editProfile(
          id: '${user?.id}',
          nama: fullNameController.text,
          address: addressController.text,
          phoneNumber: phoneNumberController.text,
          dateBirth: selectedDate.toString(),
          profilePicture: _profilePicture)) {
        final prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
        await authProvider.getProfileUser(token!);
        Navigator.pop(context);
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
    }

    Widget profilPic() {
      return Container(
        child: Column(
          children: [
            SizedBox(height: 24),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage('${user?.profilePicture}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text('Ubah Foto profil',
                style: thirdTextStyle.copyWith(fontWeight: bold))
          ],
        ),
      );
    }

    Widget form() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            UsernameTextField(
              hintText: '${user?.fullname}',
              type: 'Nama',
              controller: fullNameController,
            ),
            SizedBox(height: 24),
            UsernameTextField(
              hintText: '${user?.phoneNumber}',
              type: 'Nomor Hp',
              controller: phoneNumberController,
            ),
            SizedBox(height: 24),
            UsernameTextField(
              hintText: '${user?.address}',
              type: 'Alamat',
              controller: addressController,
            ),
            SizedBox(height: 24),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Tanggal Lahir',
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
              child: DateTimeField(
                  decoration: InputDecoration(
                    hintText: '${user?.dateBirth}',
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
          ],
        ),
      );
    }

    Widget saveButton() {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          width: double.infinity,
          height: 54,
          child: PrimaryButton(text: 'Simpan', onPressed: handleEditProfile));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: primaryTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
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
        child: ListView(
          children: [profilPic(), form(), SizedBox(height: 24), saveButton()],
        ),
      ),
    );
  }
}
