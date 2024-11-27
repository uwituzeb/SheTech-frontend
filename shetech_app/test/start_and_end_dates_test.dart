import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shetech_app/instructor/course_detail.dart';

void main() {
  // Sample course data for testing
  final testCourse = {
    'Title': 'Flutter Fundamentals',
    'Description': 'Learn Flutter from scratch',
    'Start Date': '2024-01-01',
    'End Date': '2024-03-01',
    'Lessons': [
      {'number': 1, 'title': 'Introduction to Flutter', 'completed': false},
      {'number': 2, 'title': 'Widgets Overview', 'completed': true},
    ]
  };

  testWidgets('shows correct start and end dates', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CourseDetailPage(course: testCourse),
        ),
      );

      // Verify dates
      expect(find.text('2024-01-01'), findsOneWidget);
      expect(find.text('2024-03-01'), findsOneWidget);
    });
}