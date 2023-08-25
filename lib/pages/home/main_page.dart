import 'package:flutter/material.dart';
import 'package:stufast_mobile/pages/home/home_page.dart';
import 'package:stufast_mobile/pages/home/my_course_page.dart';
import 'package:stufast_mobile/pages/home/profile_page.dart';
import 'package:stufast_mobile/pages/home/webinar_page.dart';
import 'package:stufast_mobile/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

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
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
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
                          currentIndex == 0 ? buttonTextColor : secondaryColor,
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
                          currentIndex == 1 ? buttonTextColor : secondaryColor,
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
                          currentIndex == 2 ? buttonTextColor : secondaryColor,
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
                          currentIndex == 3 ? buttonTextColor : secondaryColor,
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
          return ProfilePage();
          break;
        default:
          return HomePage();
      }
    }

    return Scaffold(
      bottomNavigationBar: customButtonNav(),
      body: body(),
    );
  }
}
