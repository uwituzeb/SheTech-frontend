import 'package:flutter/material.dart';

void main() {
  runApp(const SheTechApp());
}

class SheTechApp extends StatelessWidget {
  const SheTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingScreen(),
    );
  }
}

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String paymentMethod = 'By Card'; // Default payment method

  @override
  Widget build(BuildContext context) {
    var elevatedButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Handle continue action here
      },
      child: const Text('Continue', style: TextStyle(color: Colors.white)),
    );

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Banner image (use Image.asset for local image)
                Image.asset('assets/images/event.jpeg',
                    height: 200, width: 450, fit: BoxFit.cover),
                const SizedBox(height: 16),
                // Motivational Quote
                const Text(
                  '"Great things never come from comfort zones." This event is your chance to step into new opportunities, meet inspiring personas.',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Booking section
                const Text(
                  'Book your ticket',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Username Input
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 16),
                // Phone Number Input
                TextField(
                  keyboardType:
                      TextInputType.phone, // Ensures phone keyboard appears
                  decoration: InputDecoration(
                    hintText: 'Enter Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 16),
                // Payment Option
                const Text('Pay', style: TextStyle(fontSize: 18)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Payment option - By Card
                    Radio<String>(
                      value: 'By Card',
                      groupValue: paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value!;
                        });
                      },
                    ),
                    const Text('By Card'),
                    // Payment option - By Phone
                    Radio<String>(
                      value: 'By Phone',
                      groupValue: paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value!;
                        });
                      },
                    ),
                    const Text('By Phone'),
                  ],
                ),
                const SizedBox(height: 16),
                // Continue Button
                elevatedButton,
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple, // Set the background color to purple
        selectedItemColor: Colors.purple, // Selected item color
        unselectedItemColor: Colors.purple, // Unselected item color
        showSelectedLabels: false,
        showUnselectedLabels: false,
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
      resizeToAvoidBottomInset: true,
    );
  }
}
