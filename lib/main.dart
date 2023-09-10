import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/course_page.dart';
import 'package:stufast_mobile/pages/edit_profile.dart';
import 'package:stufast_mobile/pages/forgot_password_page.dart';
import 'package:stufast_mobile/pages/home/main_page.dart';
import 'package:stufast_mobile/pages/landing_page.dart';
import 'package:stufast_mobile/pages/login_page.dart';
import 'package:stufast_mobile/pages/register_page.dart';
import 'package:stufast_mobile/pages/splash_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => UserCourseProvider()),
        ChangeNotifierProvider(create: (context) => UserBundleProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/landing-page': (context) => LandingPage(),
          '/login-page': (context) => LoginPage(),
          '/register-page': (context) => RegisterPage(),
          '/forgotpass-page': (context) => ForgotPasswordPage(),
          '/home': (context) => MainPage(),
          '/course-page': (context) => CoursePage(),
          '/edit-profile': (context) => EditProfile(),
        },
      ),
    );
  }
}
