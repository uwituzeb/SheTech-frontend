import 'package:flutter/material.dart';
import 'editing_course.dart';

class CourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course['Title'] ?? 'Course Detail'),
        backgroundColor: const Color.fromARGB(255, 157, 78, 221),
        actions: const [
          Icon(Icons.person), // Icon representing user
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Header with title and edit button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'COURSE',
                      style: TextStyle(
                        color: Color.fromARGB(255, 157, 78, 221),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      course['Title'] ?? 'Untitled Course',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the editing course page
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => 
                            EditCourseScreen(course: course),
                      ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 157, 78, 221),
                  ),
                  child: const Text(
                    'Edit course',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Course Description
            Text(
              course['Description'] ?? 'No description available.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text('About the course'),

            const SizedBox(height: 10),

            // Course Dates
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Icon(Icons.calendar_today),
                    const Text('Start date'),
                    Text(course['Start Date'] ?? 'N/A'),
                  ],
                ),
                Column(
                  children: [
                    const Icon(Icons.calendar_today),
                    const Text('End date'),
                    Text(course['End Date'] ?? 'N/A'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Lessons
            const Text(
              'Lessons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ..._buildLessons(course['Lessons']),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLessons(dynamic lessons) {
    if (lessons is List) {
      return lessons.map((lesson) {
        return LessonItem(
          lessonNumber: lesson['number'] ?? 0,
          title: lesson['title'] ?? 'Untitled Lesson',
          completed: lesson['completed'] ?? false,
        );
      }).toList();
    }
    return [const Text('No lessons available')];
  }
}

class LessonItem extends StatelessWidget {
  final int lessonNumber;
  final String title;
  final bool completed;

  const LessonItem({
    super.key,
    required this.lessonNumber,
    required this.title,
    this.completed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(completed ? Icons.check_circle : Icons.circle),
        title: Text('Lesson $lessonNumber: $title'),
        trailing: const Icon(Icons.download),
      ),
    );
  }
}

class Lesson {
  String title;
  String description;

  Lesson({required this.title, required this.description});
}

class Course {
  String name;
  List<Lesson> lessons;

  Course({required this.name, required this.lessons});
}