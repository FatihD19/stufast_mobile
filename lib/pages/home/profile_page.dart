import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/models/user_model.dart';
import 'package:stufast_mobile/pages/login_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider? authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;

    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Profil',
              style: primaryTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: ListTile(
              leading: Container(
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

    Widget inviteFriend() {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xFAFAFA), // Warna background FAFAFA
          border: Border.all(color: Color(0xF3F3F3)), // Warna garis tepi F3F3F3
          borderRadius: BorderRadius.circular(8), // Sudut border radius
        ),
        child: Card(
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
                ListTile(
                  leading: Image.asset('assets/icon_secure.png'),
                  title: Text(
                    'Keamanan',
                    style: secondaryTextStyle,
                  ),
                ),
                ListTile(
                  leading: Image.asset('assets/icon_faq.png'),
                  title: Text(
                    'FAQ',
                    style: secondaryTextStyle,
                  ),
                ),
                ListTile(
                  leading: Image.asset('assets/icon_mail.png'),
                  title: Text(
                    'Hubungi Kami',
                    style: secondaryTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(24),
      child: ListView(
        children: [
          header(),
          SizedBox(height: 28),
          learnProgress(),
          SizedBox(height: 16),
          inviteFriend(),
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
                              Navigator.of(context).pop(); // Tutup dialog
                            },
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Hapus token atau lakukan tindakan logout lainnya
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.remove('token');
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false,
                              );
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
    );
  }
}
