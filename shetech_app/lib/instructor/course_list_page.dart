import 'package:flutter/material.dart';
import 'package:shetech_app/instructor/db_page.dart';
import 'package:shetech_app/instructor/frontend_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ml_page.dart';
import 'html_page.dart';
import 'popups.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});
  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  int _selectedIndex = 0;
  bool isEditing = false; // State for managing edit mode

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
            icon: const Icon(Icons.person),color: Colors.white,
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

            // Course List from Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore.collection('courses').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading courses'));
                  }

                  final courses = snapshot.data?.docs ?? [];

                  if (courses.isEmpty) {
                    return const Center(child: Text('No courses available'));
                  }

                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course =
                          courses[index].data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          // Navigate to the specific course page based on course title
                          if (course['title'] == 'Introduction to HTML') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HtmlPage()));
                          } else if (course['title'] == 'Machine Learning') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MlPage()));
                          } else if (course['title'] ==
                              'Front-end Development') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FrontEndPage()));
                          } else if (course['title'] ==
                              'Database Normalization') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DbPage()));
                          }
                        },
                        child: CourseItem(
                          imageUrl: course['image_url'] ?? 'images/default.jpg',
                          title: course['Title'] ?? 'Untitled Course',
                          instructor:
                              course['Instructor'] ?? 'Unknown Instructor',
                          students:
                              '${course['Students Enrolled'] ?? 0} students',
                          rating: (course['Rating'] ?? 0.0).toDouble(),
                          isEditing: isEditing,
                        ),
                      );
                    },
                  );
                },
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
                      builder: (BuildContext context) =>
                          const AddCoursePopup1(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    foregroundColor: Theme.of(context).primaryColor,
                    side: const BorderSide(
                      color: Color.fromARGB(
                          255, 157, 78, 221), // Purple border color
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

  const CourseItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.instructor,
    required this.students,
    required this.rating,
    required bool isEditing,
  });

  get isEditing => null;

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
            Image.network(
              imageUrl,
              width: 60, // Adjusted for larger size
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'images/default.jpg', // Local fallback image
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                );
              },
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
                              borderSide:
                                  const BorderSide(color: Colors.purple),
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
            if (isEditing) const Icon(Icons.edit, size: 20),
          ],
        ),
      ),
    );
  }
}
