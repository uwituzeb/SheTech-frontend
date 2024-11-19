import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheTech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShetechProfile(),
      routes: {
        '/home': (context) =>
            const Placeholder(), // Replace with actual Home Screen
        '/courses': (context) =>
            const Placeholder(), // Replace with actual Courses Screen
        '/calendar': (context) =>
            const Placeholder(), // Replace with actual Calendar Screen
        '/settings': (context) =>
            const Placeholder(), // Replace with actual Settings Screen
      },
    );
  }
}

class ShetechProfile extends StatefulWidget {
  const ShetechProfile({super.key});

  @override
  State<ShetechProfile> createState() => _ShetechProfileState();
}

class _ShetechProfileState extends State<ShetechProfile> {
  int _selectedIndex = 3;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? currentUser;
  Map<String, dynamic>? userData;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    currentUser = _auth.currentUser;
    if (currentUser != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc =
            await _firestore.collection('users').doc(currentUser!.uid).get();

        if (userDoc.exists) {
          setState(() {
            userData = userDoc.data();
            _nameController.text = userData?['name'] ?? '';
            _emailController.text = userData?['email'] ?? '';
            _usernameController.text = userData?['username'] ?? '';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User document not found.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user data: $e')),
        );
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/courses');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/calendar');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SheTech'),
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 224, 223, 223),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        'https://pluspng.com/img-png/women-hd-png-woman-white-background-free-picture-3397.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData?['name'] ?? 'No name',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData?['role'] ?? 'Student',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildProfileField('Name', _nameController),
              _buildProfileField('Email Address', _emailController),
              _buildProfileField('Username', _usernameController),
              const SizedBox(height: 20),
              _buildActionButton('Change Password', Colors.grey, () {
                // Handle change password
              }),
              const SizedBox(height: 10),
              _buildActionButton('Save Changes', Theme.of(context).primaryColor,
                  () async {
                if (currentUser != null) {
                  await _firestore
                      .collection('users')
                      .doc(currentUser!.uid)
                      .set(
                    {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'username': _usernameController.text,
                    },
                    SetOptions(merge: true),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Profile updated successfully!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User not logged in.')),
                  );
                }
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'Courses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_sharp), label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onPressed) {
    return Container(
      width: 250,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
