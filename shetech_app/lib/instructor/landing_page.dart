import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:shetech_app/instructor/course_list_page.dart';

class InstructorHomeScreen extends StatefulWidget {
  const InstructorHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InstructorHomeScreenState createState() => _InstructorHomeScreenState();
}

class _InstructorHomeScreenState extends State<InstructorHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }

    switch (index) {
      case 0: // Home
        Navigator.pushReplacementNamed(context, '/instructor/landing_page');
        break;
      case 1: // Calendar
        Navigator.pushReplacementNamed(context, '/instructor/courses');
        break;
      case 2: // Setting
        Navigator.pushReplacementNamed(context, '/calendar');
        break;
      case 3: // Profile
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  static const List<Widget> _pages = <Widget>[
    DashboardScreen(),
    Center(child: Text('Events Page')),
    Center(child: Text('Settings Page')),
    Center(child: Text('Profile Page')),
  ];

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
      body: _pages[_selectedIndex],

      // Bottom Navigation Bar
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

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '👋 Welcome, Instructor!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          // Get Involved Card
          Card(
            color: Colors.purple.shade100,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Get Involved - Join a Club!',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Our next event, happening at African Leadership University this Saturday, will open to countless learning opportunities.',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/book-event');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors
                          .purple, // Set button background color to purple
                    ),
                    child: const Text('Learn More',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Enrolled Courses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '📘 Added courses',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/instructor/courses');
                },
                child: const Text(
                  'View all >',
                  style: TextStyle(
                    color: Color(0xFF9D4EDD),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Fetch Courses
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('courses').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No courses available'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var courseData = snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return CourseCard(
                    courseName: courseData['Title'] ?? 'Untitled Course',
                    courseColor: _getColorForIndex(index),
                    instructor: courseData['Instructor'] ?? 'Unknown Instructor',
                    schedule: courseData['Schedule'] ?? 'Schedule not provided',
                    location: courseData['Location'] ?? 'Location not specified',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getColorForIndex(int index) {
    final colors = [
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.blueGrey.shade100,
      const Color.fromARGB(255, 114, 169, 179),
      Colors.purple.shade100,
      Colors.orange.shade100,
    ];
    return colors[index % colors.length];
  }
}

class CourseCard extends StatelessWidget {
  final String courseName;
  final Color courseColor;
  final String instructor;
  final String schedule;
  final String location;

  const CourseCard({
    super.key,
    required this.courseName,
    required this.courseColor,
    required this.instructor,
    required this.schedule,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: courseColor,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseName,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Instructor: $instructor'),
            Text('Schedule: $schedule'),
            Text('Location: $location'),
          ],
        ),
      ),
    );
  }
}

class AssignmentCard extends StatelessWidget {
  final String assignmentName;
  final String dueDate;
  final Color assignmentColor;

  const AssignmentCard({
    super.key,
    required this.assignmentName,
    required this.dueDate,
    required this.assignmentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: assignmentColor,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignmentName,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(dueDate),
          ],
        ),
      ),
    );
  }
}
