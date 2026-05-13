import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ElaCalendarView extends StatefulWidget {
  const ElaCalendarView({super.key});

  @override
  State<ElaCalendarView> createState() => _ElaCalendarViewState();
}

class _ElaCalendarViewState extends State<ElaCalendarView> {
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  String selectedView = "Month";
  
  final List<Map<String, dynamic>> viewOptions = [
    {"label": "Month", "value": "Month"},
    {"label": "Week", "value": "Week"},
    {"label": "Agenda", "value": "Agenda"},
  ];

  final Map<DateTime, List<Map<String, dynamic>>> events = {
    DateTime(2024, 6, 15): [
      {
        "title": "Mathematics Exam",
        "time": "09:00",
        "type": "Exam",
        "color": dangerColor,
        "location": "Exam Hall A",
      },
      {
        "title": "Physics Lab",
        "time": "14:00",
        "type": "Lab",
        "color": infoColor,
        "location": "Physics Lab B",
      },
    ],
    DateTime(2024, 6, 16): [
      {
        "title": "Project Submission",
        "time": "23:59",
        "type": "Assignment",
        "color": warningColor,
        "location": "Online",
      },
    ],
    DateTime(2024, 6, 18): [
      {
        "title": "Chemistry Lecture",
        "time": "10:00",
        "type": "Class",
        "color": successColor,
        "location": "Room C-105",
      },
      {
        "title": "Study Group",
        "time": "16:00",
        "type": "Study",
        "color": primaryColor,
        "location": "Library",
      },
    ],
    DateTime(2024, 6, 20): [
      {
        "title": "Computer Science Lab",
        "time": "14:00",
        "type": "Lab",
        "color": infoColor,
        "location": "Computer Lab 1",
      },
    ],
    DateTime(2024, 6, 22): [
      {
        "title": "Literature Essay Due",
        "time": "23:59",
        "type": "Assignment",
        "color": warningColor,
        "location": "Online",
      },
    ],
    DateTime(2024, 6, 25): [
      {
        "title": "Final Presentation",
        "time": "15:00",
        "type": "Presentation",
        "color": dangerColor,
        "location": "Auditorium",
      },
    ],
  };

  List<Map<String, dynamic>> get selectedDateEvents {
    DateTime dateKey = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    return events[dateKey] ?? [];
  }

  List<DateTime> get currentMonthDays {
    List<DateTime> days = [];
    DateTime firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    DateTime lastDay = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    
    // Add days from previous month to fill the first week
    int firstWeekday = firstDay.weekday;
    for (int i = firstWeekday - 1; i > 0; i--) {
      days.add(firstDay.subtract(Duration(days: i)));
    }
    
    // Add all days of current month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(currentMonth.year, currentMonth.month, i));
    }
    
    // Add days from next month to fill the last week
    while (days.length % 7 != 0) {
      days.add(lastDay.add(Duration(days: days.length - lastDay.day + 1)));
    }
    
    return days;
  }

  Color getEventTypeColor(String type) {
    switch (type) {
      case "Class": return successColor;
      case "Lab": return infoColor;
      case "Exam": return dangerColor;
      case "Assignment": return warningColor;
      case "Study": return primaryColor;
      case "Presentation": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  IconData getEventTypeIcon(String type) {
    switch (type) {
      case "Class": return Icons.school;
      case "Lab": return Icons.science;
      case "Exam": return Icons.quiz;
      case "Assignment": return Icons.assignment;
      case "Study": return Icons.groups;
      case "Presentation": return Icons.present_to_all;
      default: return Icons.event;
    }
  }

  void previousMonth() {
    currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    setState(() {});
  }

  void nextMonth() {
    currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    setState(() {});
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  bool hasEvents(DateTime date) {
    DateTime dateKey = DateTime(date.year, date.month, date.day);
    return events.containsKey(dateKey) && events[dateKey]!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Academic Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new event
            },
          ),
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () {
              selectedDate = DateTime.now();
              currentMonth = DateTime.now();
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // View Selector
            QCategoryPicker(
              label: "Calendar View",
              items: viewOptions,
              value: selectedView,
              onChanged: (index, label, value, item) {
                selectedView = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            if (selectedView == "Month") ...[
              // Month View Header
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: primaryColor.withAlpha(30)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, color: primaryColor),
                      onPressed: previousMonth,
                    ),
                    Expanded(
                      child: Text(
                        "${_getMonthName(currentMonth.month)} ${currentMonth.year}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, color: primaryColor),
                      onPressed: nextMonth,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: spMd),
              
              // Calendar Grid
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    // Weekday Headers
                    Container(
                      height: 40,
                      child: Row(
                        children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].map((day) {
                          return Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    // Calendar Days
                    ...List.generate((currentMonthDays.length / 7).ceil(), (weekIndex) {
                      return Container(
                        height: 70,
                        child: Row(
                          children: List.generate(7, (dayIndex) {
                            int index = weekIndex * 7 + dayIndex;
                            if (index >= currentMonthDays.length) return Expanded(child: Container());
                            
                            DateTime day = currentMonthDays[index];
                            bool isCurrentMonth = day.month == currentMonth.month;
                            bool isSelected = isSameDay(day, selectedDate);
                            bool isDayToday = isToday(day);
                            bool dayHasEvents = hasEvents(day);
                            
                            return Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  selectedDate = day;
                                  setState(() {});
                                },
                                child: Container(
                                  margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: isSelected 
                                      ? primaryColor.withAlpha(20)
                                      : (isDayToday ? successColor.withAlpha(10) : Colors.transparent),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                    border: Border.all(
                                      color: isSelected 
                                        ? primaryColor
                                        : (isDayToday ? successColor : Colors.transparent),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${day.day}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isSelected || isDayToday ? FontWeight.bold : FontWeight.normal,
                                          color: isCurrentMonth 
                                            ? (isSelected ? primaryColor : (isDayToday ? successColor : primaryColor))
                                            : disabledColor,
                                        ),
                                      ),
                                      if (dayHasEvents) ...[
                                        SizedBox(height: 2),
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: isCurrentMonth ? warningColor : disabledColor,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
            
            if (selectedView == "Week") ...[
              // Week View
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Week View",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Week view will be implemented here",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            if (selectedView == "Agenda") ...[
              // Agenda View
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming Events",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    
                    // List all upcoming events
                    ...events.entries.where((entry) => 
                      entry.key.isAfter(DateTime.now().subtract(Duration(days: 1)))
                    ).take(10).map((entry) {
                      DateTime date = entry.key;
                      List<Map<String, dynamic>> dayEvents = entry.value;
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: spXs),
                            child: Text(
                              "${date.dMMMy}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          ...dayEvents.map((event) {
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs, left: spSm),
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: (event["color"] as Color).withAlpha(10),
                                borderRadius: BorderRadius.circular(radiusXs),
                                border: Border.all(color: (event["color"] as Color).withAlpha(30)),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    getEventTypeIcon(event["type"]),
                                    color: event["color"],
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Expanded(
                                    child: Text(
                                      "${event["title"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: event["color"],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${event["time"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          SizedBox(height: spSm),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
            
            SizedBox(height: spLg),
            
            // Selected Date Events
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.event, color: primaryColor, size: 20),
                      SizedBox(width: spXs),
                      Text(
                        "Events for ${selectedDate.dMMMy}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Add event for selected date
                        },
                        child: Icon(Icons.add_circle, color: successColor, size: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  if (selectedDateEvents.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: disabledColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: disabledColor),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 32,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "No events scheduled",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXxs),
                          Text(
                            "Tap the + button to add an event",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...selectedDateEvents.map((event) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (event["color"] as Color).withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusXs),
                          border: Border.all(color: (event["color"] as Color).withAlpha(30)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: event["color"],
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Icon(
                                getEventTypeIcon(event["type"]),
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${event["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXxs),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time, color: disabledBoldColor, size: 12),
                                      SizedBox(width: spXxs),
                                      Text(
                                        "${event["time"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(Icons.location_on, color: disabledBoldColor, size: 12),
                                      SizedBox(width: spXxs),
                                      Text(
                                        "${event["location"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: (event["color"] as Color).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXxs),
                              ),
                              child: Text(
                                "${event["type"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: event["color"],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Event Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "This Month's Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 120,
                    children: [
                      _buildStatCard("Total Events", "${events.values.fold(0, (sum, list) => sum + list.length)}", Icons.event, primaryColor),
                      _buildStatCard("Exams", "${events.values.fold(0, (sum, list) => sum + list.where((e) => e["type"] == "Exam").length)}", Icons.quiz, dangerColor),
                      _buildStatCard("Assignments", "${events.values.fold(0, (sum, list) => sum + list.where((e) => e["type"] == "Assignment").length)}", Icons.assignment, warningColor),
                      _buildStatCard("Labs", "${events.values.fold(0, (sum, list) => sum + list.where((e) => e["type"] == "Lab").length)}", Icons.science, infoColor),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String count, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spXs),
          Text(
            count,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXxs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    List<String> months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }
}
