import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit() async {
    // await Provider.of<CourseProvider>(context, listen: false).getCourses('all');
    Provider.of<CourseProvider>(context, listen: false).loadTags();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var saveLogin = prefs.getBool('saveLogin');
    if (saveLogin == true) {
      await Provider.of<AuthProvider>(context, listen: false).getProfileUser();
      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pushNamed(context, '/landing-page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logo_stufast.png'))),
        ),
      ),
    );
  }
}
