import 'package:flutter/material.dart';

import '../theme.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget notifTile() {
      return Column(
        children: [
          ListTile(
            leading: Image.asset('assets/ic_notifCourse.png'),
            title: Text(
              'Selamat! Course fundamental sudah bisa diakses!',
              style: primaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            subtitle: Text('10 menit yang lalu', style: secondaryTextStyle),
          ),
          Divider(
            height: 20,
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: secondaryTextColor,
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                'sudah dibaca',
                style: thirdTextStyle,
              ))
        ],
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            notifTile(),
            notifTile(),
          ],
        ),
      ),
    );
  }
}
