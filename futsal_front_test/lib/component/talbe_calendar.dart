import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyTableCalendar extends StatefulWidget {
  const MyTableCalendar({super.key});

  @override
  State<MyTableCalendar> createState() => _MyTableCalendarState();
}

class _MyTableCalendarState extends State<MyTableCalendar> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR', // 추가
      headerStyle: const HeaderStyle(
        // headerMargin: EdgeInsets.only(
        //   left: 40,
        //   top: 10,
        //   right: 40,
        //   bottom: 10,
        // ),
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontSize: 17.0,
        ),
      ),
      rowHeight: 40,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: focusedDay,
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = selectedDay;
        });
      },
      selectedDayPredicate: (day) {
        return isSameDay(selectedDay, day);
      },
    );
  }
}
