import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shetech_app/authentication/auth.dart';
import 'package:shetech_app/authentication/forgot_password_screen.dart';

class MockAuthService extends AuthService {
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    // Simulate success
    if (email == "success@test.com") {
      return;
    }
    // Simulate failure
    throw Exception("Failed to send email");
  }
}

void main() {
  testWidgets('ForgotPasswordScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ForgotPasswordScreen(),
      ),
    );

    expect(find.text('Forgot Password'), findsOneWidget);
    expect(find.text('Enter your email to receive OTP'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
  });

  testWidgets('Shows validation error for empty email', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ForgotPasswordScreen(),
      ),
    );

    await tester.tap(find.text('Continue'));
    await tester.pump(); // Rebuild the widget with the validation error

    expect(find.text('Please enter your email'), findsOneWidget);
  });

  testWidgets('Shows validation error for invalid email', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ForgotPasswordScreen(),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'invalid-email');
    await tester.tap(find.text('Continue'));
    await tester.pump(); // Rebuild the widget with the validation error

    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('Handles successful password reset email', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ForgotPasswordScreen(),
      ),
    );

    final emailControllerFinder = find.byType(TextFormField);
    await tester.enterText(emailControllerFinder, 'success@test.com');
    await tester.tap(find.text('Continue'));
    await tester.pump(); // Simulate processing time

    // Check if the SnackBar is displayed
    expect(find.text('Password reset email sent. Please check your inbox.'), findsOneWidget);
  });

  testWidgets('Handles failed password reset email', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ForgotPasswordScreen(),
      ),
    );

    final emailControllerFinder = find.byType(TextFormField);
    await tester.enterText(emailControllerFinder, 'failure@test.com');
    await tester.tap(find.text('Continue'));
    await tester.pump(); // Simulate processing time

    // Check if the error message is displayed
    expect(find.text('Failed to send email'), findsOneWidget);
  });

  testWidgets('Navigates to login screen on Log In button press', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const ForgotPasswordScreen(),
        routes: {
          '/login': (context) => const Scaffold(body: Text('Login Screen')),
        },
      ),
    );

    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle(); // Wait for navigation animation

    expect(find.text('Login Screen'), findsOneWidget);
  });
}
