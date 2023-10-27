import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/pages/Faq-Support/contact_us_page.dart';
import 'package:stufast_mobile/pages/Faq-Support/faq_page.dart';
import 'package:stufast_mobile/pages/checkout/add_chart_page.dart';
import 'package:stufast_mobile/pages/checkout/checkout_page.dart';
import 'package:stufast_mobile/pages/checkout/order_page.dart';
import 'package:stufast_mobile/pages/course_page.dart';
import 'package:stufast_mobile/pages/edit_profile.dart';
import 'package:stufast_mobile/pages/forgot_password_page.dart';
import 'package:stufast_mobile/pages/home/main_page.dart';
import 'package:stufast_mobile/pages/home/my_course_page.dart';
import 'package:stufast_mobile/pages/landing_page.dart';
import 'package:stufast_mobile/pages/login_page.dart';
import 'package:stufast_mobile/pages/notifikasi_page.dart';
import 'package:stufast_mobile/pages/register_page.dart';
import 'package:stufast_mobile/pages/splash_page.dart';
import 'package:stufast_mobile/providers/auth_provider.dart';
import 'package:stufast_mobile/providers/bundle_provider.dart';
import 'package:stufast_mobile/providers/chart_provider.dart';
import 'package:stufast_mobile/providers/checkout_provider.dart';
import 'package:stufast_mobile/providers/course_provider.dart';
import 'package:stufast_mobile/providers/faq_provider.dart';
import 'package:stufast_mobile/providers/order_provider.dart';
import 'package:stufast_mobile/providers/quiz_provider.dart';
import 'package:stufast_mobile/providers/talentHub_provider.dart';
import 'package:stufast_mobile/providers/user_course_provider.dart';
import 'package:stufast_mobile/providers/webinar_provider.dart';
import 'package:stufast_mobile/theme.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // if (!kIsWeb) {
  //   channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     // 'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   );

  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   await flutterLocalNotificationsPlugin!
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel!);

  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }
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
        ChangeNotifierProvider(create: (context) => TalentHubProvider()),
        ChangeNotifierProvider(create: (context) => QuizProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider())
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
          '/contact-page': (context) => ContactUsPage(),
          '/notif-page': (context) => NotifikasiPage(),
          '/order-page': (context) => OrderPage()
        },
      ),
    );
  }
}
