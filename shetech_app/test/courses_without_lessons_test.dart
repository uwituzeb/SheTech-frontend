import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shetech_app/instructor/course_detail.dart';

void main() {
  
  testWidgets('handles course with no lessons', (WidgetTester tester) async {
      final courseWithNoLessons = {
        'Title': 'Empty Course',
        'Description': 'No lessons yet',
        'Start Date': null,
        'End Date': null,
        'Lessons': null
      };

      await tester.pumpWidget(
        MaterialApp(
          home: CourseDetailPage(course: courseWithNoLessons),
        ),
      );

      // Verify no lessons text
      expect(find.text('No lessons available'), findsOneWidget);
    });
}
