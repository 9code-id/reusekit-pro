import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar1View extends StatefulWidget {
  @override
  State<GrlCalendar1View> createState() => _GrlCalendar1ViewState();
}

class _GrlCalendar1ViewState extends State<GrlCalendar1View> {
  DateTime selectedDate = DateTime.now();
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Team Meeting",
      "date": DateTime.now(),
      "time": "09:00 AM",
      "type": "meeting",
      "color": Colors.blue,
    },
    {
      "id": 2,
      "title": "Project Deadline",
      "date": DateTime.now().add(Duration(days: 2)),
      "time": "11:30 AM",
      "type": "deadline",
      "color": Colors.red,
    },
    {
      "id": 3,
      "title": "Lunch with Client",
      "date": DateTime.now().add(Duration(days: 5)),
      "time": "12:00 PM",
      "type": "appointment",
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddEventView());
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Month/Year Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor,
                boxShadow: [shadowSm],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (currentMonth == 1) {
                        currentMonth = 12;
                        currentYear--;
                      } else {
                        currentMonth--;
                      }
                      setState(() {});
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  Text(
                    "${_getMonthName(currentMonth)} $currentYear",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (currentMonth == 12) {
                        currentMonth = 1;
                        currentYear++;
                      } else {
                        currentMonth++;
                      }
                      setState(() {});
                    },
                    child: Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            
            // Calendar Grid
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                children: [
                  // Day Headers
                  Row(
                    children: [
                      'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'
                    ].map((day) => Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: spSm),
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                  
                  // Calendar Days
                  ..._buildCalendarDays(),
                ],
              ),
            ),
            
            // Today's Events
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Events",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ...events.where((event) {
                    DateTime eventDate = event["date"] as DateTime;
                    return eventDate.day == selectedDate.day &&
                           eventDate.month == selectedDate.month &&
                           eventDate.year == selectedDate.year;
                  }).map((event) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                      border: Border(
                        left: BorderSide(
                          width: 4,
                          color: event["color"] as Color,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${event["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${event["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          _getEventIcon(event["type"]),
                          color: event["color"] as Color,
                          size: 20,
                        ),
                      ],
                    ),
                  )).toList(),
                  
                  if (events.where((event) {
                    DateTime eventDate = event["date"] as DateTime;
                    return eventDate.day == selectedDate.day &&
                           eventDate.month == selectedDate.month &&
                           eventDate.year == selectedDate.year;
                  }).isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: disabledColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 40,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No events for today",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AddEventView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _buildCalendarDays() {
    List<Widget> weeks = [];
    DateTime firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
    DateTime lastDayOfMonth = DateTime(currentYear, currentMonth + 1, 0);
    int firstWeekday = firstDayOfMonth.weekday % 7;
    int daysInMonth = lastDayOfMonth.day;

    List<Widget> days = [];
    
    // Empty cells for days before the first day of month
    for (int i = 0; i < firstWeekday; i++) {
      days.add(Expanded(child: Container()));
    }

    // Days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(currentYear, currentMonth, day);
      bool isSelected = date.day == selectedDate.day &&
                       date.month == selectedDate.month &&
                       date.year == selectedDate.year;
      bool isToday = date.day == DateTime.now().day &&
                    date.month == DateTime.now().month &&
                    date.year == DateTime.now().year;
      
      bool hasEvent = events.any((event) {
        DateTime eventDate = event["date"] as DateTime;
        return eventDate.day == date.day &&
               eventDate.month == date.month &&
               eventDate.year == date.year;
      });

      days.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              selectedDate = date;
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.all(2),
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : 
                       isToday ? primaryColor.withAlpha(20) : Colors.transparent,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "$day",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white :
                               isToday ? primaryColor : Colors.black,
                      ),
                    ),
                  ),
                  if (hasEvent)
                    Positioned(
                      bottom: 4,
                      right: 8,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Group days into weeks
    for (int i = 0; i < days.length; i += 7) {
      weeks.add(
        Row(
          children: days.sublist(i, (i + 7 > days.length) ? days.length : i + 7),
        ),
      );
    }

    return weeks;
  }

  String _getMonthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'meeting':
        return Icons.people;
      case 'deadline':
        return Icons.schedule;
      case 'appointment':
        return Icons.event;
      default:
        return Icons.event;
    }
  }
}
