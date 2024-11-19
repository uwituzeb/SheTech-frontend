// ignore_for_file: deprecated_member_use

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shetech_app/firebase_options.dart';
import 'splash/splash.dart';
import 'authentication/signup_screen.dart';
import 'authentication/login_screen.dart';
import 'authentication/forgot_password_screen.dart';
import 'splash/welcome_screen.dart';
import 'authentication/reset_password.dart';
import 'authentication/create_password.dart';
import 'homepage.dart';
import 'events/eventpage.dart';
import 'instructor/course_list_page.dart';
import 'settings/profile.dart';
import 'settings/settings.dart';
import 'events/calendar.dart';
import 'learners/courses_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Existing Firebase Apps: ${Firebase.apps}");

  if(Firebase.apps.isEmpty){
    try {
    print("Before initialization - Firebase apps: ${Firebase.apps}");
    
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    print("After initialization - Firebase apps: ${Firebase.apps}");
  } catch (e) {
    print("Firebase initialization error: $e");
    print("Error details: ${e.runtimeType}");
  }
  }
  


  final dynamicLinks = FirebaseDynamicLinks.instance;
  final PendingDynamicLinkData? initialLink = await dynamicLinks.getInitialLink();
  if (initialLink != null) {
    handleDynamicLink(initialLink.link);
  }

  dynamicLinks.onLink.listen((dynamicLinkData) {
    handleDynamicLink(dynamicLinkData.link);
  }).onError((error) {
    print('Dynamic Links error: $error');
  });

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'SheTech',
      theme: ThemeData(
        fontFamily: 'Outfit',
        primaryColor: const Color(0xFF9D4EDD),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/create-password': (context) => const CreatePasswordScreen(),
        '/book-event': (context) => const BookingScreen(),
        '/instructor/courses': (context) => const CourseListPage(),
        '/profile': (context) => const ShetechProfile(),
        '/settings': (context) => const SettingScreen(),
        '/calendar': (context) => const CalendarPageScreen(),
        '/courses': (context) => const CourseListPageScreen()
      },
    );
  }
}

void handleDynamicLink(Uri deepLink) {
  if (deepLink.path == '/reset-password') {
    final oobCode = deepLink.queryParameters['oobCode'];
    if (oobCode != null) {
      navigatorKey.currentState?.pushNamed(
        '/create-password',
        arguments: oobCode,
      );
    }
  }
}
