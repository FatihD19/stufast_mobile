import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:stufast_mobile/widget/username_textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime? selectedDate;
  bool? isLoading;
  File? _profilePicture;
  XFile? _image;
  bool errorImage = false;
  AuthService authService = AuthService();
  String? _jobSelected;
  @override
  void initState() {
    // TODO: implement initState

    _jobSelected =
        Provider.of<AuthProvider>(context, listen: false).user?.jobId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider? authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    TextEditingController emailController = TextEditingController(text: '');
    TextEditingController fullNameController =
        TextEditingController(text: '${user?.fullname}');
    TextEditingController addressController =
        TextEditingController(text: '${user?.address}');
    TextEditingController phoneNumberController =
        TextEditingController(text: '${user?.phoneNumber}');
    TextEditingController dateController =
        TextEditingController(text: '${user?.dateBirth}');

    // _pickProfilePicture() async {
    //   FilePickerResult? result = await FilePicker.platform.pickFiles(
    //     type: FileType.image,
    //   );

    //   if (result != null) {
    //     setState(() {
    //       _profilePicture = File(result.files.single.path!);
    //     });
    //   } else {
    //     // User canceled the picker
    //   }
    // }

    Future<void> _pickProfilePicture() async {
      // await Permission.storage.request();
      final ImagePicker _picker = ImagePicker();
// Pick an image
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//TO convert Xfile into file
      File file = File(image!.path);
//print(‘Image picked’);
      setState(() {
        isLoading = true;
        _profilePicture = file;
        _image = image;
      });
      if (await authProvider.uploadProfilePicture(
          '${user?.id}', _profilePicture!)) {
        await authProvider.getProfileUser();
        setState(() {
          errorImage = false;
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Berhasil ubah profil',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
          errorImage = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Gagal Upload Foto',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }

    handleEditProfile() async {
      if (await authProvider.editProfile(
        id: '${user?.id}',
        nama: fullNameController.text,
        address: addressController.text,
        phoneNumber: phoneNumberController.text,
        job_id: _jobSelected,
        dateBirth: selectedDate.toString(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Berhasil ubah profil',
              textAlign: TextAlign.center,
            ),
          ),
        );
        await authProvider.getProfileUser();
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
            isLoading == true
                ? CircularProgressIndicator()
                : errorImage == true
                    ? Icon(
                        Icons.error_outline_rounded,
                        size: 80,
                        color: Colors.red,
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: _profilePicture != null
                              ? DecorationImage(
                                  image: FileImage(_profilePicture!),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image:
                                      NetworkImage('${user?.profilePicture}'),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
            SizedBox(height: 8),
            InkWell(
              onTap: _pickProfilePicture,
              child: Text('Ubah Foto profil',
                  style: thirdTextStyle.copyWith(fontWeight: bold)),
            )
          ],
        ),
      );
    }

    Widget form() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsernameTextField(
              hintText: '${user?.fullname}',
              type: 'Nama',
              controller: fullNameController,
            ),
            SizedBox(height: 24),
            Text(
              'Pekerjaan',
              style: primaryTextStyle.copyWith(fontWeight: bold),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField2(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
              value: _jobSelected,
              hint: Text('Pilih Pekerjaan', style: primaryTextStyle),
              items: authProvider.listJob
                  .map(
                    (job) => DropdownMenuItem(
                      child: Text('${job.jobName}', style: primaryTextStyle),
                      value: job.jobId,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _jobSelected = value;
                });
              },
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

    Widget uploadImgButton() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: _pickProfilePicture,
            child: Row(
              children: [
                Icon(Icons.upload_file),
                Text('Upload Foto profile', style: buttonTextStyle)
              ],
            )),
      );
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
          children: [
            profilPic(),
            form(),
            SizedBox(height: 24),
            // uploadImgButton(),
            saveButton()
          ],
        ),
      ),
    );
  }
}
