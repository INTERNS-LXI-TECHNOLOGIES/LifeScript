import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPopup extends StatelessWidget {
  final Function(DateTime selectedDate) onDateSelected;

  const CalendarPopup({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2050),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              return isSameDay(selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              selectedDate = selectedDay;
            },
            calendarFormat: CalendarFormat.month,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onDateSelected(selectedDate);
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}