import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String title;
  final DateTime date;

  Event({required this.title, required this.date});

  // Factory constructor to create Event from Firestore document
  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Event(
      title: data['EventName'] ?? 'Unnamed Event',
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}

class CalendarPageScreen extends StatefulWidget {
  const CalendarPageScreen({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPageScreen> {
  int _selectedIndex = 2; // For bottom nav
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Map to store events
  final Map<DateTime, List<Event>> _events = {};
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _fetchEvents();  // Fetch events from Firestore
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay)); 
  }

  Future<void> _fetchEvents() async {
    try {
      // Fetch documents from the Firestore 'events' collection
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('events').get();

      // Clear existing events
      _events.clear();

      // Iterate through each document in the snapshot
      for (var doc in snapshot.docs) {
        Event event = Event.fromFirestore(doc);

        // Normalize date to just year, month, day
        DateTime normalizedDate = DateTime(event.date.year, event.date.month, event.date.day);

        // Add the event to the map
        if (_events[normalizedDate] == null) {
          _events[normalizedDate] = [event];
        } else {
          _events[normalizedDate]!.add(event);
        }
      }

      // Update the selected events after fetching
      _selectedEvents.value = _getEventsForDay(_focusedDay);
      
      // Update loading state
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching events: $e');
      
      // Update loading state and show error
      setState(() {
        _isLoading = false;
      });
      
      // Optional: Show error to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load events: $e')),
      );
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Normalize the day to remove time components
    DateTime normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? []; 
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0: // Home
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1: // Courses
          Navigator.pushReplacementNamed(context, '/courses');
          break;
        case 2: // Calendar
          // Already on calendar
          break;
        case 3: // Settings
          Navigator.pushReplacementNamed(context, '/settings');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SheTech', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: _isLoading 
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 20, left: 20, right: 20, bottom: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 208, 206, 230),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TableCalendar<Event>(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                selectedDecoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                // Add marker style for events
                markerDecoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 139, 69, 205),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  if (value.isEmpty) {
                    return const Center(
                      child: Text('No events for this day'),
                    );
                  }
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.event, 
                            color: Theme.of(context).primaryColor
                          ),
                          title: Text(
                            value[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            'Date: ${value[index].date.toLocal()}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
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