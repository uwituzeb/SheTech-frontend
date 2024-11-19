import 'package:flutter/material.dart';
import 'package:shetech_app/instructor/db_page.dart';
import 'package:shetech_app/instructor/frontend_page.dart';
import 'ml_page.dart';
import 'html_page.dart';
import 'popups.dart';



class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});
  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }

    switch (index) {
      case 0: // Home
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1: // Calendar
        Navigator.pushReplacementNamed(context, '/courses');
        break;
      case 2: // Setting
        Navigator.pushReplacementNamed(context, '/calendar');
        break;
      case 3: // Profile
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('SheTech', style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
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
                    child: const CourseItem(
                      imageUrl: 'images/html.jpg',
                      title: 'Introduction to HTML',
                      instructor: 'Samule Doe',
                      students: '4k student',
                      rating: 4.7,
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
                    child: const CourseItem(
                      imageUrl: 'images/ml.jpg',
                      title: 'Machine Learning',
                      instructor: 'Sarrah Morry',
                      students: '2k student',
                      rating: 4.0,
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
                    child: const CourseItem(
                      imageUrl: 'images/front-end.jpg',
                      title: 'Front-end Development',
                      instructor: 'Sarrah Morry',
                      students: '1k student',
                      rating: 4.2,
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
                    child: const CourseItem(
                      imageUrl: 'images/database.jpg',
                      title: 'Database normalization',
                      instructor: 'Sarrah Morry',
                      students: '2k student',
                      rating: 4.0,
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
                    foregroundColor: Theme.of(context).primaryColor,
                    side: const BorderSide(
                      color: Color.fromARGB(255, 157, 78, 221), // Purple border color
                      width: 2, // Border width
                    ),
                  ),
                  child: const Text('Add new course'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Manage courses'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: const Color.fromARGB(255, 46, 45, 45),
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_sharp),
            label: 'calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
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

  const CourseItem({super.key, 
    required this.imageUrl,
    required this.title,
    required this.instructor,
    required this.students,
    required this.rating,
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
                  Text(
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
          ],
        ),
      ),
    );
  }
}