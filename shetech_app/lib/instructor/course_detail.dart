import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'editing_course.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseId; // ID to fetch the course details

  const CourseDetailPage({super.key, required this.courseId, required Map<String, dynamic> course});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  Map<String, dynamic>? courseData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCourseDetails();
  }

  Future<void> fetchCourseDetails() async {
    try {
      final DocumentSnapshot courseSnapshot = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .get();

      if (courseSnapshot.exists) {
        setState(() {
          courseData = courseSnapshot.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        // Handle the case where the document does not exist
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course not found!')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching course details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseData?['Title'] ?? 'Course Detail'),
        backgroundColor: const Color.fromARGB(255, 157, 78, 221),
        actions: const [
          Icon(Icons.person), // Icon representing user
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : courseData == null
              ? const Center(child: Text('No course details available.'))
              : SingleChildScrollView(
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
                              ClipRRect(
  borderRadius: BorderRadius.circular(8.0), // Optional for rounded corners
  child: Image.asset(
    'images/default.jpg',
    width: 250, // Ensures it fits the screen width
    height: 250, // Fixed height
    fit: BoxFit.cover, // Scales the image while maintaining aspect ratio
  ),
),
                              const SizedBox(height: 20),
                              const Text(
                                'COURSE',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 157, 78, 221),
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                courseData!['Title'] ?? 'Untitled Course',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to editing course page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditCourseScreen(
                                    course: courseData!,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 157, 78, 221),
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
                        courseData!['Description'] ??
                            'No description available.',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),

                      // Additional Course Details
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
                              Text(courseData!['StartDate'] ?? 'N/A'),
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(Icons.calendar_today),
                              const Text('End date'),
                              Text(courseData!['EndDate'] ?? 'N/A'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Skills
                      const Text(
                        'Skills',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      if (courseData!['Skills'] != null &&
                          courseData!['Skills'] is List)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: (courseData!['Skills'] as List<dynamic>)
                              .map((skill) => Text('- $skill'))
                              .toList(),
                        )
                      else
                        const Text('No skills listed.'),
                    ],
                  ),
                ),
    );
  }
}

class EditCourseScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const EditCourseScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${course['Title'] ?? 'Course'}'),
      ),
      body: const Center(
        child: Text('Edit course screen here'),
      ),
    );
  }
}