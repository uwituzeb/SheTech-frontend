import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPageScreen extends StatefulWidget {
  const CalendarPageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPageScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Map to store events for different days
  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    // Populate the map with some sample events
    _events[DateTime.now()] = [Event("Today’s Event")];
    _events[DateTime.now().add(const Duration(days: 1))] = [
      Event("Tomorrow's Event")
    ];
    _selectedEvents = ValueNotifier(_getEventsForDay(_focusedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ??
        []; // return the events for the specific day or an empty list if none
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SheTech'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        backgroundColor: const Color.fromARGB(255, 157, 78, 221),
        actions: const [
          Icon(Icons.person), // Icon representing user
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 208, 206, 230),
            margin: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 20),
            padding:const EdgeInsets.all(10),
            child: TableCalendar<DateTime>(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: _onDaySelected,
              eventLoader: (day) {
                return [];
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                selectedDecoration:const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: const Color.fromARGB(182, 101, 39, 176).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle:const HeaderStyle(
                titleTextStyle: TextStyle(
                  color: Color.fromARGB(255, 139, 69, 205),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            color: Colors
                .blue, // Set the background color of the events list to blue
            child: Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index) {
                      return ListTile(title: Text(value[index].title));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;

  Event(this.title);
}
 