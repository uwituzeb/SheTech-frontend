import "package:flutter/material.dart";

class AddCoursePopup1 extends StatelessWidget {
  const AddCoursePopup1 ({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new course',
      style: TextStyle(color: Color(0xFF9D4EDD)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Course name', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 40),
            const TextField(
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Course Details',
                hintText: 'Enter course details',
                border: OutlineInputBorder(),
              ),
            ),
            const Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'dd/mm/yyyy',
                      ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'End Date',
                      hintText: 'dd/mm/yyyy',
                      ),
                  ),
                ),
              ],
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Proficiency Level'),
              items: ['Beginner', 'Intermediate', 'Advanced']
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ],
        ),
      ),
      actions: [
        Row (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              foregroundColor: const Color.fromARGB(255, 157, 78, 221),
              side: const BorderSide(
                color: Color.fromARGB(255, 157, 78, 221),
                width: 2,
              ),
            ),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Navigate to next popup
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) => const AddCoursePopup2(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 157, 78, 221),
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              // side: const BorderSide(
              //   color: Color.fromARGB(255, 157, 78, 221), // Purple border color
              //   width: 2, // Border width
              // ),
            ),
            child: const Text('Next'),
          ),
        ]
        )
      ],
    );
  }
}

// Popup 2: Add Image and Skills
class AddCoursePopup2 extends StatelessWidget {
  const AddCoursePopup2({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new course', 
      style: TextStyle(color: Color(0xFF9D4EDD)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add image functionality
              },
              child: const Text('Add image'),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Skills needed',
                suffixIcon: Icon(Icons.tag),
                border: OutlineInputBorder(),
              ),
            ),
            // const Wrap(
            //   spacing: 8.0,
            //   children: [
            //     Chip(label: Text('Leadership')),
            //     Chip(label: Text('Computer skills')),
            //   ],
            // ),
          ],
        ),
      ),
      actions: [
        Row (
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
          onPressed: () {
            // Navigate back to the first popup
            Navigator.pop(context);
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
          child: const Text('Previous'),
        ),
        TextButton(
          onPressed: () {
            // Save course details and close the popup
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 157, 78, 221),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            // side: const BorderSide(
            //   color: Color.fromARGB(255, 157, 78, 221), // Purple border color
            //   width: 2, // Border width
            // ),
          ),
          child: const Text('Save Course'),
        ),
          ],
        )
      ],
    );
  } 
}