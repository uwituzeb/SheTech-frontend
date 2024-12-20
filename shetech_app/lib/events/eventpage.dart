import 'package:flutter/material.dart';
import 'payment_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String paymentMethod = 'By Card'; // Default payment method
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }

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
  Widget build(BuildContext context) {
    var elevatedButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Navigate to PaymentScreen and wait for the result
  Navigator.push(
    context, 
    MaterialPageRoute(
      builder: (context) => const PaymentScreen(),
    ),
  ).then((selectedPaymentMethod) {
    // Handle the selected payment method here
    if (selectedPaymentMethod != null) {
      // Do something with the selected payment method
      print('Selected Payment Method: $selectedPaymentMethod');
      
      // Optional: You might want to show a confirmation or proceed with booking
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment method selected: $selectedPaymentMethod'),
        ),
      );
    }
  });
      },
      child: const Text('Continue', style: TextStyle(color: Colors.white)),
    );

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Banner image (use Image.asset for local image)
                Image.asset('images/event.jpg',
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
      resizeToAvoidBottomInset: true,
    );
  }
}
