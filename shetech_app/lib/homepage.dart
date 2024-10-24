import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('SheTech', style: TextStyle(color: Colors.white)),
        actions: [
          DropdownButton<String>(
            dropdownColor: Colors.purple,
            value: 'Elliane Munezero',
            items: <String>['Elliane Munezero'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
            onChanged: (_) {},
          ),
        ],
        elevation: 0, // Flat design, remove shadow
      ),
      body: _pages[_selectedIndex],

      // Bottom Navigation Bar 
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey, // White for selected item
        unselectedItemColor: Colors.purple, // Lighter white for unselected items
        backgroundColor: Colors.purple, // Purple background
        currentIndex: _selectedIndex, // Keep track of the selected index
        onTap: _onItemTapped, // Handle tap
        showSelectedLabels: true, // Show labels for selected items
        showUnselectedLabels: true, // Show labels for unselected items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
            'Welcome, Eliane!',
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, // Set button background color to purple
                    ),
                    child: const Text('Learn More', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Enrolled Courses
          const Text(
            'Enrolled Courses',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          CourseCard(
            courseName: 'Graphic Fundamentals-ART101',
            courseColor: Colors.blue.shade100,
            instructor: 'Prof.Smith',
            schedule: 'Mon & Wed, 9:00 AM - 10:30 AM',
            location: 'Design Studio A',
          ),
          const SizedBox(height: 16.0), // Add space between CourseCards
          CourseCard(
            courseName: 'Graphic Fundamentals-ART101',
            courseColor: Colors.green.shade100,
            instructor: 'Prof.Smith',
            schedule: 'Mon & Wed, 9:00 AM - 10:30 AM',
            location: 'Design Studio A',
          ),
          const SizedBox(height: 16.0), // Add space between CourseCards
          CourseCard(
            courseName: 'Graphic Fundamentals-ART101',
            courseColor: Colors.blueGrey.shade100,
            instructor: 'Prof.Smith',
            schedule: 'Mon & Wed, 9:00 AM - 10:30 AM',
            location: 'Design Studio A',
          ),
          const SizedBox(height: 16.0), // Add space between CourseCards
          // ignore: prefer_const_constructors
          CourseCard(
            courseName: 'Graphic Fundamentals-ART101',
            courseColor: const Color.fromARGB(255, 114, 169, 179),
            instructor: 'Prof.Smith',
            schedule: 'Mon & Wed, 9:00 AM - 10:30 AM',
            location: 'Design Studio A',
          ),
          const SizedBox(height: 16.0),
          // Assignments
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Assignments',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          const AssignmentCard(
            assignmentName: 'Graphic Fundamentals',
            dueDate: 'Due: Oct 21, 2023',
            assignmentColor: Color.fromARGB(255, 253, 247, 248),
          ),
          const AssignmentCard(
            assignmentName: 'User Experience Research',
            dueDate: 'Due: Nov 1, 2024',
            assignmentColor: Color.fromARGB(255, 253, 247, 248),
          ),
          const AssignmentCard(
            assignmentName: 'Advanced Web Design',
            dueDate: 'Due: Nov 1, 2024',
            assignmentColor: Color.fromARGB(255, 253, 247, 248),
          ),
        ],
      ),
    );
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
