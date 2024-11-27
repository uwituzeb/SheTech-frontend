import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class AddCoursePopup1 extends StatefulWidget {
  const AddCoursePopup1({super.key});

  @override
  _AddCoursePopup1State createState() => _AddCoursePopup1State();
}

class _AddCoursePopup1State extends State<AddCoursePopup1> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDetailsController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  String? _selectedProficiencyLevel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add new course',
        style: TextStyle(color: Color(0xFF9D4EDD)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _courseNameController,
              decoration: const InputDecoration(
                labelText: 'Course name', 
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _courseDetailsController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Course Details',
                hintText: 'Enter course details',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _startDateController,
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      hintText: 'dd/mm/yyyy',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _startDateController.text = 
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _endDateController,
                    decoration: const InputDecoration(
                      labelText: 'End Date',
                      hintText: 'dd/mm/yyyy',
                      border: OutlineInputBorder(),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        _endDateController.text = 
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Proficiency Level',
                border: OutlineInputBorder(),
              ),
              items: ['Beginner', 'Intermediate', 'Advanced']
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProficiencyLevel = value;
                });
              },
              value: _selectedProficiencyLevel,
            ),
          ],
        ),
      ),
      actions: [
        Row(
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
                if (_validateFirstStep()) {
                  // Navigate to next popup and pass the current data
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AddCoursePopup2(
                      courseData: {
                        'Title': _courseNameController.text,
                        'Details': _courseDetailsController.text,
                        'StartDate': _startDateController.text,
                        'EndDate': _endDateController.text,
                        'ProficiencyLevel': _selectedProficiencyLevel,
                      },
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 157, 78, 221),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Text('Next'),
            ),
          ],
        )
      ],
    );
  }

  bool _validateFirstStep() {
    if (_courseNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a course name')),
      );
      return false;
    }
    if (_courseDetailsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter course details')),
      );
      return false;
    }
    if (_startDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a start date')),
      );
      return false;
    }
    if (_endDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an end date')),
      );
      return false;
    }
    if (_selectedProficiencyLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a proficiency level')),
      );
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _courseNameController.dispose();
    _courseDetailsController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }
}

class AddCoursePopup2 extends StatefulWidget {
  final Map<String, dynamic> courseData;

  const AddCoursePopup2({super.key, required this.courseData});

  @override
  _AddCoursePopup2State createState() => _AddCoursePopup2State();
}

class _AddCoursePopup2State extends State<AddCoursePopup2> {
  File? _imageFile;
  final TextEditingController _skillsController = TextEditingController();
  final List<String> _skillsList = [];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('course_images/${DateTime.now().millisecondsSinceEpoch}');

      // Upload the file to Firebase Storage
      UploadTask uploadTask = storageReference.putFile(_imageFile!);

      // Get the download URL
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void _addSkill() {
    if (_skillsController.text.isNotEmpty) {
      setState(() {
        _skillsList.add(_skillsController.text.trim());
        _skillsController.clear();
      });
    }
  }

  Future<void> _saveCourse() async {
    // Validate inputs
    if (_skillsList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one skill')),
      );
      return;
    }

    // upload image if it exists
    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage();
    }

    Map<String, dynamic> finalCourseData = {
      ...widget.courseData,
      'Skills': _skillsList,
      'image_url': imageUrl ?? 'images/default.jpg',
      'Instructor': 'Current Instructor',
      'Students Enrolled': 0,
      'Rating': 0.0,
      'Schedule': '${widget.courseData['StartDate']} - ${widget.courseData['EndDate']}',
      'Location': 'Online',
    };

    try {
      // Save to Firestore
      await FirebaseFirestore.instance.collection('courses').add(finalCourseData);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course added successfully!')),
      );

      // Close the dialog
      Navigator.pop(context);
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding course: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add new course',
        style: TextStyle(color: Color(0xFF9D4EDD)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Picker
            _imageFile != null
                ? Image.file(_imageFile!, height: 100, width: 100)
                : ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Add image'),
                  ),
            const SizedBox(height: 16),

            // Skills Input
            TextField(
              controller: _skillsController,
              decoration: InputDecoration(
                labelText: 'Skills needed',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addSkill,
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addSkill(),
            ),

            // Skills Chips
            Wrap(
              spacing: 8.0,
              children: _skillsList.map((skill) {
                return Chip(
                  label: Text(skill),
                  onDeleted: () {
                    setState(() {
                      _skillsList.remove(skill);
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        Row(
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
                  color: Color.fromARGB(255, 157, 78, 221),
                  width: 2,
                ),
              ),
              child: const Text('Previous'),
            ),
            TextButton(
              onPressed: _saveCourse,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 157, 78, 221),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: const Text('Save Course'),
            ),
          ],
        )
      ],
    );
  }

  @override
  void dispose() {
    _skillsController.dispose();
    super.dispose();
  }
}