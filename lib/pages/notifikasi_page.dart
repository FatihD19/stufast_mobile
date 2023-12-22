import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/providers/notif_provider.dart';
import 'package:stufast_mobile/services/Auth/auth_service.dart';

import '../theme.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});
  String calculateTimeDifference(String apiTimeString) {
    // Konversi string waktu dari API menjadi objek DateTime
    DateTime apiTime = DateTime.parse(apiTimeString);

    // Waktu saat ini
    DateTime currentTime = DateTime.now();

    // Hitung selisih waktu
    Duration difference = currentTime.difference(apiTime);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inHours < 1) {
      int minutes = difference.inMinutes;
      return '$minutes menit yang lalu';
    } else if (difference.inDays < 1) {
      int hours = difference.inHours;
      return '$hours jam yang lalu';
    } else if (difference.inDays < 30) {
      int days = difference.inDays;
      return '$days hari yang lalu';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months bulan yang lalu';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years tahun yang lalu';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget notifTile(String img, String tite, String time, String id) {
      String apiTimeString = time;
      String timeAgo = calculateTimeDifference(apiTimeString);

      return Column(
        children: [
          ListTile(
            onTap: () {
              id == '1' || id == '2'
                  ? Navigator.pushNamed(context, '/order-page')
                  : id == '3'
                      ? Navigator.pushNamed(context, '/edit-profile')
                      : Navigator.pushNamed(context, '/hire-page');
            },
            leading: Image.network('$img', width: 40, height: 40),
            title: Text(
              '$tite',
              style: primaryTextStyle.copyWith(fontWeight: semiBold),
            ),
            subtitle: Text('$timeAgo', style: secondaryTextStyle),
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
        // actions: [
        //   TextButton(
        //       onPressed: () async {
        //         String? token = await FirebaseMessaging.instance.getToken();
        //         AuthService.sendDeviceToken("${token}");
        //         print(token);
        //       },
        //       child: Text(
        //         'sudah dibaca',
        //         style: thirdTextStyle,
        //       ))
        // ],
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
          padding: EdgeInsets.all(24),
          child: Consumer<NotificationProvider>(
            builder: (context, notifState, _) {
              if (notifState.notification!.notification!.isNotEmpty) {
                return ListView.builder(
                  itemCount: notifState.notification!.notification!.length,
                  itemBuilder: (context, index) {
                    return notifTile(
                        '${notifState.notification!.notification![index].thumbnail}',
                        '${notifState.notification!.notification![index].message}',
                        '${notifState.notification!.notification![index].createdAt}',
                        '${notifState.notification!.notification![index].notificationCategoryId}');
                  },
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      // Image.asset('assets/img_null_notif.png'),
                      SizedBox(height: 20),
                      Text('Kamu tidak punya notifikasi',
                          style: primaryTextStyle.copyWith(fontWeight: bold)),
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
