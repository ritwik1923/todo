import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:todo/chart/bar_chart.dart';

class Progress extends StatefulWidget {
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  String onlyDay(DateTime date) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BarChartSample1(),
            TableCalendar(
              initialCalendarFormat: CalendarFormat.month,
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
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            )
          ],
        ),
      ),
    );
  }
}
