import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/constrant.dart';

class Calender extends StatefulWidget {
  final bool week_or_month;
//true -> month
//false -> week

  // ignore: non_constant_identifier_names
  const Calender({@required this.week_or_month});

  @override
  _CalenderState createState() => _CalenderState(week_or_month);
// _CalenderState obj = _CalenderState()
  //  String getSeletedDate() {
  //   return getSeletedDate();
  // }
}

class _CalenderState extends State<Calender> {
  CalendarController _controller;
  // ignore: non_constant_identifier_names
  final bool week_or_month;
  _CalenderState(this.week_or_month);
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      initialCalendarFormat:
          week_or_month == true ? CalendarFormat.month : CalendarFormat.week,
      calendarStyle: CalendarStyle(
          todayColor: Colors.blue,
          selectedColor: Theme.of(context).primaryColor,
          todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.white)),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonDecoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(22.0),
        ),
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: (date, events, holidays) {
        // TODO: get date from user
        print(onlyDay(date));
        setState(() {});
        selectedDate = onlyDay(date);
        // print(date);
      },
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
        todayDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
      ),
      calendarController: _controller,
    );
  }
}

String selectedDate;

class SendCalenderData {
  String getSeletedDate() {
    return selectedDate;
  }
}
