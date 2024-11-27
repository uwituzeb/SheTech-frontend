import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shetech_app/instructor/landing_page.dart';

// mock Firestore class
// class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  testWidgets('InstructorHomeScreen has a title', (WidgetTester tester) async {
    // Build the widget.
    await tester.pumpWidget(
      const MaterialApp(
        home: InstructorHomeScreen(),
      ),
    );

    // Verify if the title "SheTech" is present in the AppBar.
    expect(find.text('SheTech'), findsOneWidget);
  });
}
