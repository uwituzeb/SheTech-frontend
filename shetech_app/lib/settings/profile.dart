import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shetech',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShetechProfile(),
    );
  }
}

class ShetechProfile extends StatefulWidget {
  final int? currentIndex;

  const ShetechProfile({super.key, this.currentIndex});

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

    _nameController.addListener(_updateUsername);
  }

  void _updateUsername() {
    String nameInput = _nameController.text;
    List<String> nameParts = nameInput.split(' ');

    // Check if the input is empty or contains only whitespace
    if (nameParts.isEmpty || nameInput.trim().isEmpty) {
      _usernameController.text = '';
      return;
    }

    // Generate the username
    String username = '@' + nameParts.join('').toLowerCase();
    _usernameController.text = username;

    // Move the cursor to the end of the text
    _usernameController.selection =
        TextSelection.fromPosition(TextPosition(offset: username.length));
  }

  Future<void> fetchUserData() async {
    try {
      currentUser = _auth.currentUser;
      if (currentUser != null) {
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
          print('User  document not found');
        }
      } else {
        print('User  is not logged in');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
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
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData?['name'] ?? 'No name',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color.fromARGB(255, 41, 41, 41),
                                fontFamily: 'Plus Jakarta Sans',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              userData?['role'] ?? 'Learner',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: 250,
                height: 60,
                child: TextButton(
                  onPressed: () async {
                    // Check if the user is logged in
                    if (currentUser != null) {
                      // Update the user data in Firestore
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

                      // Optionally show a success message or feedback to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Profile updated successfully!')),
                      );
                    } else {
                      // Handle the case when the user is not logged in
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('User  not logged in.')),
                      );
                    }
                  },
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
