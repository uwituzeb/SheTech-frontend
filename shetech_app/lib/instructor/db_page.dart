import 'package:flutter/material.dart';

class DbPage extends StatelessWidget {
  const DbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        appBar: AppBar(
          title: const Text('SheTech', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 157, 78, 221),
          actions: [
            IconButton(
              icon: const Icon(Icons.person,color: Colors.white,),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
=======
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SheTech'),
        backgroundColor: const Color.fromARGB(255, 157, 78, 221),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
>>>>>>> origin/main
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Header with title and edit button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('COURSE', style: TextStyle(color: Color.fromARGB(255, 157, 78, 221), fontSize: 16)),
                    Text('Database Normalization', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 157, 78, 221)),
                  child: const Text('Edit course',
                  style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Course Description
            Container(
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Understand the principles of database normalization to efficiently structure databases.', 
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text('About the course'),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Course Dates
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.calendar_today),
                    Text('Start date'),
                    Text('10/09/2024'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.calendar_today),
                    Text('End date'),
                    Text('10/11/2024'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Course Facts and Skills
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Icon(Icons.check),
                    Text('Beginner friendly'),
                    Text('0/123 Lessons'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Skills', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Web Page Structure'),
                    Text('Basic Web Development'),
                    Text('Accessibility Awareness'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Lessons
            const Text('Lessons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const LessonItem(lessonNumber: 1, title: 'First Normal Form', completed: true),
            const LessonItem(lessonNumber: 2, title: 'Second Normal Form', completed: false),
            const LessonItem(lessonNumber: 3, title: 'Third Normal Form', completed: false),
            // Add more lessons similarly...
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Widget for Lessons
class LessonItem extends StatelessWidget {
  final int lessonNumber;
  final String title;
  final bool completed;

  const LessonItem({super.key, 
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
