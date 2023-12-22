import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/models/user_course_model.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/pages/login_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';
import 'package:stufast_mobile/services/Auth/login_google_service.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

import '../../providers/cv_provider.dart';
import '../cv/create_cv_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider? authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await AuthService.sendDeviceToken(''); // remove device token
      await prefs.remove('token');
      // context.read<UserCourseProvider>().userCourses = [];
      // context.read<BundleProvider>().userBundle = [];
      context.read<UserCourseProvider>().dispose();

      prefs.remove('saveLogin');
      await LoginApi.logout().then((value) => print('suksesLogout'));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: ListTile(
              leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FadeInImage.assetNetwork(
                      placeholder: 'assets/img_loading.gif',
                      image: '${user?.profilePicture}',
                      fit: BoxFit.cover,
                    ).image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                '${user?.fullname}',
                style: primaryTextStyle.copyWith(fontWeight: bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user?.job_name}',
                    style: secondaryTextStyle,
                  ),
                  Text('${user?.address}', style: secondaryTextStyle),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit-profile');
                },
                icon: Image.asset(
                  'assets/icon_edit.png',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget learnProgress() {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFAFAFA), // Warna background FAFAFA
          border: Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
          borderRadius: BorderRadius.circular(8), // Sudut border radius
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Learning Progress',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 16),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 10 / 100,
                        backgroundColor: Color(0xffF0DB96),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffFEC202)),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '10%',
                      style: primaryTextStyle.copyWith(fontWeight: bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget navCv() {
      return InkWell(
        onTap: () async {
          await Provider.of<CvProvider>(context, listen: false).getCV();
          CVmodel cv = Provider.of<CvProvider>(context, listen: false).cv!;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateCvPage(cv)));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xF3F3F3), // Warna background FAFAFA
              border:
                  Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
              borderRadius: BorderRadius.circular(8)), // Sudut border radius
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 3,
            child: ListTile(
              leading: Image.asset('assets/lg_cv.png', width: 30, height: 30),
              title: Text('CV',
                  style: primaryTextStyle.copyWith(fontWeight: semiBold)),
              // trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ),
      );
    }

    Widget orderBtn() {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/order-page');
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xF3F3F3), // Warna background FAFAFA
              border:
                  Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
              borderRadius: BorderRadius.circular(8)), // Sudut border radius
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.shopping_cart_outlined),
              title: Text('Riwayat Order',
                  style: primaryTextStyle.copyWith(fontWeight: semiBold)),
              // trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ),
      );
    }

    Widget hireInfo() {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/hire-page');
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xF3F3F3), // Warna background FAFAFA
              border:
                  Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
              borderRadius: BorderRadius.circular(8)), // Sudut border radius
          child: Card(
            clipBehavior: Clip.antiAlias,
            elevation: 3,
            child: ListTile(
              leading: Icon(Icons.business_rounded),
              title: Text('Daftar Tawaran',
                  style: primaryTextStyle.copyWith(fontWeight: semiBold)),
              // trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ),
      );
    }

    Widget inviteFriend() {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFAFAFA), // Warna background FAFAFA
          border: Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
          borderRadius: BorderRadius.circular(8), // Sudut border radius
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Image.asset('assets/icon_people.png'),
                      SizedBox(width: 8),
                      Text(
                        'Invite Your Friends',
                        style: primaryTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Code Refferal',
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 15),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xffE9E9E9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '80777082234107340',
                        style: primaryTextStyle,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Copy',
                          style: thirdTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget settings() {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFAFAFA), // Warna background FAFAFA
          border: Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
          borderRadius: BorderRadius.circular(8), // Sudut border radius
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Settings',
                    style: primaryTextStyle.copyWith(
                        fontWeight: bold, fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/change-password-page');
                  },
                  child: ListTile(
                    leading: Image.asset('assets/icon_secure.png'),
                    title: Text(
                      'Keamanan',
                      style: secondaryTextStyle,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/faq-page');
                  },
                  child: ListTile(
                    leading: Image.asset('assets/icon_faq.png'),
                    title: Text(
                      'FAQ',
                      style: secondaryTextStyle,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/contact-page');
                  },
                  child: ListTile(
                    leading: Image.asset('assets/icon_mail.png'),
                    title: Text(
                      'Hubungi Kami',
                      style: secondaryTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Container(
          // margin: EdgeInsets.only(top: 24),
          child: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: false,
              leadingWidth: 0,
              title: Container(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  'Profil',
                  style:
                      primaryTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                ),
              )),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: user?.fullname == null
            ? Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Text(
                      'Selamat datang di Stufast',
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 18),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        'Silahkan login untuk mengakses lebih banyak fitur',
                        style: secondaryTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor, // Warna teks saat di atas latar hijau
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Border radius 10
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/landing-page');
                          },
                          child: Text(
                            'Login',
                            style: buttonTextStyle.copyWith(
                                fontSize: 18, fontWeight: bold),
                          )),
                    )
                  ],
                ),
              )
            : ListView(
                children: [
                  header(),
                  SizedBox(height: 28),
                  hireInfo(),
                  navCv(),
                  orderBtn(),
                  SizedBox(height: 12),
                  // inviteFriend(),
                  settings(),
                  SizedBox(height: 25),
                  Container(
                      width: double.infinity,
                      height: 54,
                      child: PrimaryButton(
                        text: 'Keluar',
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Konfirmasi Logout'),
                                content: Text('Anda yakin ingin keluar?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog
                                    },
                                    child: Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      logout();
                                      // Hapus token atau lakukan tindakan logout lainnya
                                    },
                                    child: Text('Ya, Keluar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )),
                ],
              ),
      ),
    );
  }
}
