import 'package:flutter/material.dart';

import 'package:shetech_app/learners/course_detail.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shetech_app/learners/course_detail.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class CourseListPageScreen extends StatefulWidget {
  const CourseListPageScreen({super.key});

  @override
  State<CourseListPageScreen> createState() => _CourseListPageScreenState();
}

class _CourseListPageScreenState extends State<CourseListPageScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the selected index based on the current route
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String? currentRoute = ModalRoute.of(context)?.settings.name;
      setState(() {
        _selectedIndex = _getIndexFromRoute(currentRoute);
      });
    });
  }

  int _getIndexFromRoute(String? route) {
    switch (route) {
      case '/home':
        return 0;
      case '/courses':
        return 1;
      case '/calendar':
        return 2;
      case '/settings':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    String currentRoute = ModalRoute.of(context)?.settings.name ?? '/home';
    String targetRoute;

    switch (index) {
      case 0:
        targetRoute = '/home';
        break;
      case 1:
        targetRoute = '/courses';
        break;
      case 2:
        targetRoute = '/calendar';
        break;
      case 3:
        targetRoute = '/settings';
        break;
      default:
        targetRoute = '/home';
    }

    if (currentRoute != targetRoute) {
      Navigator.pushReplacementNamed(context, targetRoute).then((_) {
        setState(() {
          _selectedIndex = index;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          Navigator.pushReplacementNamed(context, '/home');
          return false;
        }
        return true;
      },
      child: Scaffold(
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
                          // Navigate to CourseDetailPage and pass the course data
                          final courseId = courses[index].id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CourseDetailPage(course: course, courseId: courseId),
                            ),
                          );
                        },
                        child: CourseItem(
                          imageUrl: course['image_url'] ?? 'images/default.jpg',
                          title: course['Title'] ?? 'Untitled Course',
                          instructor:
                              course['Instructor'] ?? 'Unknown Instructor',
                          students:
                              '${course['Students Enrolled'] ?? 0} students',
                          rating: (course['Rating'] ?? 0.0),
                          
                        ),
                      );
                    },
                  );
                },
              ),
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
