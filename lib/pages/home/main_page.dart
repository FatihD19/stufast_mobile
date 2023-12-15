import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/main.dart';
import 'package:stufast_mobile/pages/Hire/hire_page.dart';
import 'package:stufast_mobile/pages/home/home_page.dart';
import 'package:stufast_mobile/pages/home/my_course_page.dart';
import 'package:stufast_mobile/pages/home/profile_page.dart';
import 'package:stufast_mobile/pages/home/my_webinar_page.dart';
import 'package:stufast_mobile/pages/notifikasi_page.dart';
import 'package:stufast_mobile/pages/talent-hub/talent_hub_page.dart';
import 'package:stufast_mobile/theme.dart';

import '../succsess_page.dart';

class MainPage extends StatefulWidget {
  int? navIndex;
  MainPage({this.navIndex, Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PermissionStatus _status = PermissionStatus.denied;
  String notifMessTemp = '';

  Future<void> _checkPermissionStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      PermissionStatus status = await Permission.notification.request();
      setState(() {
        _status = status;
      });

      if (status == PermissionStatus.granted) {
        prefs.setBool('isFirstTime', false);
      }
    } else {
      PermissionStatus status = await Permission.notification.status;
      setState(() {
        _status = status;
      });
    }
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int? currentIndex;
  @override
  void initState() {
    currentIndex = widget.navIndex ?? 0;
    _checkPermissionStatus();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                // channel!.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
        setState(() {
          notifMessTemp = "${notification.title}";
        });
        if ("${notification.title}" == 'Pesanan dibatalkan') {
          setState(() {
            print(
              'NOTIF_MESS' + "${notification.title}" + "${channel?.id}",
            );
          });
        } else if ("${notification.title}" == 'Pembayaran berhasil!') {
          setState(() {
            print(
              'NOTIF_MESS' + "${notification.title}" + "${channel?.id}",
            );
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SuccsessPage(
                          titleMess: "Selamat Pembayaran anda Berhasil",
                          mess: "silahkan buka course di halaman My Course",
                          pay: true,
                        )));
          });
        } else {
          print(
            'NOTIF_MESS' + "${notification.title}" + "${channel?.id}",
          );
        }
      }
    });
    _flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        ), onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      if (notifMessTemp.contains('kabar')) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HirePage()));
      } else if (notifMessTemp.contains('berhasil')) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SuccsessPage(
                      titleMess: "Selamat Pembayaran anda Berhasil",
                      mess: "silahkan buka course di halaman My Course",
                      pay: true,
                    )));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          'A new onMessageOpenedApp event was published! ${message.messageType}');
    });
    super.initState();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => exit(0),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    // Widget cartButton() {
    //   return FloatingActionButton(
    //     onPressed: () {},
    //     backgroundColor: primaryColor,
    //     child: Image.asset(
    //       'assets/icon_cart.png',
    //       width: 20,
    //     ),
    //   );
    // }

    Widget customButtonNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              showSelectedLabels: false, // <-- HERE
              showUnselectedLabels: false, // <-- AND HERE
              backgroundColor: primaryColor,
              currentIndex: currentIndex ?? 0,
              onTap: (value) {
                print(value);
                setState(() {
                  currentIndex = value;
                });
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    child: Image.asset(
                      'assets/icon_home.png',
                      width: 81,
                      height: 69,
                      color:
                          currentIndex == 0 ? buttonTextColor : Colors.white70,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: Image.asset(
                      'assets/icon_my_course.png',
                      width: 81,
                      height: 69,
                      color:
                          currentIndex == 1 ? buttonTextColor : Colors.white70,
                    ),
                  ),
                  label: '',
                ),
                // BottomNavigationBarItem(
                //   icon: Container(
                //     child: Image.asset(
                //       'assets/icon_webinar.png',
                //       width: 81,
                //       height: 69,
                //       color:
                //           currentIndex == 2 ? buttonTextColor : Colors.white70,
                //     ),
                //   ),
                //   label: '',
                // ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: Image.asset(
                      'assets/ic_talent.png',
                      width: 81,
                      height: 69,
                      color:
                          currentIndex == 2 ? buttonTextColor : Colors.white70,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    child: Image.asset(
                      'assets/icon_profile.png',
                      width: 81,
                      height: 69,
                      color:
                          currentIndex == 3 ? buttonTextColor : Colors.white70,
                    ),
                  ),
                  label: '',
                ),
              ]),
        ),
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return HomePage();
          break;
        case 1:
          return MyCoursePage();
          break;
        // case 2:
        //   return WebinarPage();
        //   break;
        case 2:
          return TalentHubPage();
          break;
        case 3:
          return ProfilePage();
          break;
        default:
          return HomePage();
      }
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        bottomNavigationBar: customButtonNav(),
        body: body(),
      ),
    );
  }
}
