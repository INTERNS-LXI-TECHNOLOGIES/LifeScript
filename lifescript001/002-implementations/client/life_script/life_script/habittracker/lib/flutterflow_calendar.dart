import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class FlutterFlowCalendar extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final bool weekFormat;
  final bool weekStartsMonday;
  final Function(DateTimeRange?) onChange;
  final TextStyle titleStyle;
  final TextStyle dayOfWeekStyle;
  final TextStyle dateStyle;
  final TextStyle selectedDateStyle;
  final TextStyle inactiveDateStyle;

  const FlutterFlowCalendar({
    Key? key,
    required this.color,
    required this.iconColor,
    required this.weekFormat,
    required this.weekStartsMonday,
    required this.onChange,
    required this.titleStyle,
    required this.dayOfWeekStyle,
    required this.dateStyle,
    required this.selectedDateStyle,
    required this.inactiveDateStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarFormat: weekFormat ? CalendarFormat.week : CalendarFormat.month,
      startingDayOfWeek: weekStartsMonday ? StartingDayOfWeek.monday : StartingDayOfWeek.sunday,
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: color.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        selectedTextStyle: selectedDateStyle,
        todayTextStyle: dateStyle,
        defaultTextStyle: dateStyle,
        weekendTextStyle: dateStyle,
        outsideTextStyle: inactiveDateStyle,
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleTextStyle: titleStyle,
        leftChevronIcon: Icon(Icons.chevron_left, color: iconColor),
        rightChevronIcon: Icon(Icons.chevron_right, color: iconColor),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: dayOfWeekStyle,
        weekendStyle: dayOfWeekStyle,
      ),
      onDaySelected: (selectedDay, focusedDay) {
        onChange(DateTimeRange(start: selectedDay, end: selectedDay));
      },
    );
  }
}