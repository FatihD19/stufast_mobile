import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/Faq-Support/faq_page.dart';
import 'package:stufast_mobile/pages/checkout/add_chart_page.dart';
import 'package:stufast_mobile/pages/checkout/checkout_page.dart';
import 'package:stufast_mobile/pages/course_page.dart';
import 'package:stufast_mobile/pages/edit_profile.dart';
import 'package:stufast_mobile/pages/forgot_password_page.dart';
import 'package:stufast_mobile/pages/home/main_page.dart';
import 'package:stufast_mobile/pages/home/my_course_page.dart';
import 'package:stufast_mobile/pages/landing_page.dart';
import 'package:stufast_mobile/pages/login_page.dart';
import 'package:stufast_mobile/pages/register_page.dart';
import 'package:stufast_mobile/pages/splash_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/providers/chart_provider.dart';
import 'package:stufast_mobile/providers/checkout_provider.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/providers/faq_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/providers/webinar_provider.dart';
import 'package:stufast_mobile/theme.dart';

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
        ChangeNotifierProvider(create: (context) => BundleProvider()),
        ChangeNotifierProvider(create: (context) => ChartProvider()),
        ChangeNotifierProvider(create: (context) => WebinarProvider()),
        ChangeNotifierProvider(create: (context) => CheckoutProvider()),
        ChangeNotifierProvider(create: (context) => FaqProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: primaryColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/landing-page': (context) => LandingPage(),
          '/login-page': (context) => LoginPage(),
          '/register-page': (context) => RegisterPage(),
          '/forgotpass-page': (context) => ForgotPasswordPage(),
          '/home': (context) => MainPage(),
          '/course-page': (context) => CoursePage(),
          '/user-course': (context) => MyCoursePage(),
          '/edit-profile': (context) => EditProfile(),
          '/chart-page': (context) => AddToChartPage(),
          '/faq-page': (context) => FaqPage(),
        },
      ),
    );
  }
}
