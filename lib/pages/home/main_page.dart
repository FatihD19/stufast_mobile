import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stufast_mobile/pages/home/home_page.dart';
import 'package:stufast_mobile/pages/home/my_course_page.dart';
import 'package:stufast_mobile/pages/home/profile_page.dart';
import 'package:stufast_mobile/pages/home/my_webinar_page.dart';
import 'package:stufast_mobile/pages/talent-hub/talent_hub_page.dart';
import 'package:stufast_mobile/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
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
              currentIndex: currentIndex,
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
                BottomNavigationBarItem(
                  icon: Container(
                    child: Image.asset(
                      'assets/icon_webinar.png',
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
                      'assets/ic_talent.png',
                      width: 81,
                      height: 69,
                      color:
                          currentIndex == 3 ? buttonTextColor : Colors.white70,
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
                          currentIndex == 4 ? buttonTextColor : Colors.white70,
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
        case 2:
          return WebinarPage();
          break;
        case 3:
          return TalentHubPage();
          break;
        case 4:
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
