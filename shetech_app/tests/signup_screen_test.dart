import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shetech_app/authentication/auth.dart';
import 'package:shetech_app/authentication/signup_screen.dart';
import 'package:shetech_app/firebase_options.dart';

Future<void> main() async {

  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  group("SignUpScreen", () {
    testWidgets("displays correct title", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignupScreen()));
      expect(find.text('Create Your SheTech Account'), findsOneWidget);
    });

    testWidgets('allows users to signup with email and password', 
    (WidgetTester tester) async {
      final mockAuthService = MockAuthService();
      when(mockAuthService.signUpWithEmail(
        email: 'test@example.com',
        password: 'password',
        name: "test",
        role: 'learner'
      )).thenAnswer((_) async => MockUserCredential());

      await tester.pumpWidget(
        MaterialApp(
          home: ProvideAuthService(
            authService: mockAuthService,
            child: const SignupScreen(),
          ),
        ),
      );

      // test data
      await tester.enterText(find.byType(TextFormField).at(0), 'Test User');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'testpassword');
      await tester.enterText(find.byType(TextFormField).at(3), 'testpassword');
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      // Verify the navigation
      expect(find.byType(Navigator), findsOneWidget);
    });
  });
}

// Mock AuthService
class MockAuthService extends Mock implements AuthService {}

// Mock UserCredential
class MockUserCredential extends Mock implements UserCredential {}

class ProvideAuthService extends InheritedWidget {
  final AuthService authService;

  const ProvideAuthService({super.key, 
    required this.authService,
    required super.child,
  });

  static AuthService of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProvideAuthService>()!
        .authService);
  }

  @override
  bool updateShouldNotify(ProvideAuthService oldWidget) {
    return authService != oldWidget.authService;
  }
}