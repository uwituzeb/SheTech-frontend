import 'package:firebase_auth/firebase_auth.dart';
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
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
