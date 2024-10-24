import 'package:flutter/material.dart';
import 'splash.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'forgot_password_screen.dart';
import 'welcome_screen.dart';
import 'reset_password.dart';
import 'create_password.dart';
<<<<<<< HEAD
import 'homepage.dart';
import 'eventpage.dart';
=======
import 'instructor/course_list_page.dart';
import 'settings/profile.dart';
import 'settings/settings.dart';

>>>>>>> 9f64ea8a6534d052fb61038a5497093a68c4511d

void main() {
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
<<<<<<< HEAD
        '/homepage': (context) => HomeScreen(),
        '/': (context) => SplashScreen(),
=======
        '/splash': (context) => SplashScreen(),
>>>>>>> 9f64ea8a6534d052fb61038a5497093a68c4511d
        '/welcome': (context) => const WelcomeScreen(),
        '/signup': (context) => const SignupScreen(),
        '/login': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/create-password': (context) => const CreatePasswordScreen(),
<<<<<<< HEAD
        '/eventpage': (context) => const BookingScreen(),
=======
        '/instructor/course-list': (context) => const CourseListPage(),
        '/profile': (context) => const ShetechProfile(),
        '/settings': (context) => const SettingScreen(),
>>>>>>> 9f64ea8a6534d052fb61038a5497093a68c4511d
      },
    );
  }
}



