import 'package:flutter/material.dart';
import 'package:shetech_app/instructor/db_page.dart';
import 'package:shetech_app/instructor/frontend_page.dart';
import 'ml_page.dart';
import 'html_page.dart';
import 'popups.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  CourseListPageState createState() => CourseListPageState();
}

class CourseListPageState extends State<CourseListPage> {
  bool isEditing = false; // State for managing edit mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SheTech', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 157, 78, 221),
        actions: const [
          Icon(Icons.person), // User profile icon
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search course',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            const SizedBox(height: 20),

            // Course List
            Expanded(
              child: ListView(
                children: [
                  // Course 1
                  GestureDetector(
                    onTap: () {
                      // Navigate to the lesson page when the first course is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HtmlPage()),
                      );
                    },
                    child: CourseItem(
                      imageUrl: 'images/html.jpg',
                      title: 'Introduction to HTML',
                      instructor: 'Samule Doe',
                      students: '4k student',
                      rating: 4.7,
                      isEditing: isEditing,
                    ),
                  ),
                  // Course 2
                  GestureDetector(
                    onTap: () {
                      // Navigate to the lesson page when the first course is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MlPage()),
                      );
                    },
                    child: CourseItem(
                      imageUrl: 'images/ml.jpg',
                      title: 'Machine Learning',
                      instructor: 'Sarrah Morry',
                      students: '2k student',
                      rating: 4.0,
                      isEditing: isEditing,
                    ),
                  ),
                  // Course 3
                  GestureDetector(
                    onTap: () {
                      // Navigate to the lesson page when the first course is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FrontEndPage()),
                      );
                    },
                    child: CourseItem(
                      imageUrl: 'images/front-end.jpg',
                      title: 'Front-end Development',
                      instructor: 'Sarrah Morry',
                      students: '1k student',
                      rating: 4.2,
                      isEditing: isEditing,
                    ),
                  ),
                  // Course 4
                  GestureDetector(
                    onTap: () {
                      // Navigate to the lesson page when the first course is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DbPage()),
                      );
                    },
                    child: CourseItem(
                      imageUrl: 'images/database.jpg',
                      title: 'Database normalization',
                      instructor: 'Sarrah Morry',
                      students: '2k student',
                      rating: 4.0,
                      isEditing: isEditing,
                    ),
                  ),
                ],
              ),
            ),

            // Buttons at the bottom
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Show first popup when "Add new course" is pressed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const AddCoursePopup1(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor: const Color.fromARGB(255, 157, 78, 221),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 157, 78, 221), // Purple border color
                      width: 2, // Border width
                    ),
                  ),
                  child: const Text('Add new course'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing; // Toggle editing mode
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 157, 78, 221),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Manage courses'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget to represent each course item
class CourseItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String instructor;
  final String students;
  final double rating;
  final bool isEditing; // State for managing edit mode

  const CourseItem({super.key, 
    required this.imageUrl,
    required this.title,
    required this.instructor,
    required this.students,
    required this.rating,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            Image.asset(
              imageUrl,
              width: 60, // Adjusted for larger size
              height: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 15), // Space between image and text
            // Course Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEditing 
                    ? TextField(
                        decoration: InputDecoration(
                          hintText: title,
                          contentPadding: const EdgeInsets.all(8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(color: Colors.purple),
                          ),
                        ),
                      )
                  : Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18, // Increase font size
                    ),
                  ),
                  Text(instructor),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 16),
                      const SizedBox(width: 5),
                      Text(students),
                      const SizedBox(width: 10),
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 5),
                      Text(rating.toString()),
                    ],
                  ),
                ],
              ),
            ),

            if (isEditing) const Icon(Icons.edit, size: 20),
          ],
        ),
      ),
    );
  }
}
