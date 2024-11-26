import 'package:flutter/material.dart';

class EditCourseScreen extends StatefulWidget {
  final Map<String, dynamic> course;

  const EditCourseScreen({super.key, required this.course});

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  final TextEditingController _lessonTitleController = TextEditingController();
  final TextEditingController _lessonDescriptionController =
      TextEditingController();

  void _addLesson() {
    if (_lessonTitleController.text.isNotEmpty &&
        _lessonDescriptionController.text.isNotEmpty) {
      setState(() {
        // Add the new lesson to the course's lessons list
        if (widget.course['Lessons'] == null) {
          widget.course['Lessons'] = [];
        }

        widget.course['Lessons'].add({
          'title': _lessonTitleController.text,
          'description': _lessonDescriptionController.text,
        });
      });
      _lessonTitleController.clear();
      _lessonDescriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course['Title'] ?? 'Edit Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _lessonTitleController,
              decoration: const InputDecoration(labelText: "Lesson Title"),
            ),
            TextField(
              controller: _lessonDescriptionController,
              decoration: const InputDecoration(labelText: "Lesson Description"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addLesson,
              child: const Text("Add Lesson"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.course['Lessons']?.length ?? 0,
                itemBuilder: (context, index) {
                  final lesson = widget.course['Lessons'][index];
                  return ListTile(
                    title: Text(lesson['title']),
                    subtitle: Text(lesson['description']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
