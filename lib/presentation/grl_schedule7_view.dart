import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule7View extends StatefulWidget {
  @override
  State<GrlSchedule7View> createState() => _GrlSchedule7ViewState();
}

class _GrlSchedule7ViewState extends State<GrlSchedule7View> {
  String selectedMonth = "December 2024";
  String selectedFilter = "All";
  
  List<Map<String, dynamic>> monthlyCalendar = List.generate(31, (index) {
    int day = index + 1;
    return {
      "day": day,
      "isToday": day == 23,
      "isWeekend": [6, 7, 13, 14, 20, 21, 27, 28].contains(day),
      "events": _getEventsForDay(day),
    };
  });

  List<Map<String, dynamic>> eventCategories = [
    {"label": "All", "value": "All", "color": primaryColor},
    {"label": "Meetings", "value": "Meeting", "color": dangerColor},
    {"label": "Development", "value": "Development", "color": infoColor},
    {"label": "Planning", "value": "Planning", "color": primaryColor},
    {"label": "Personal", "value": "Personal", "color": successColor},
    {"label": "Holidays", "value": "Holiday", "color": warningColor},
  ];

  List<Map<String, dynamic>> upcomingEvents = [
    {
      "title": "Christmas Day",
      "date": "Dec 25",
      "time": "All Day",
      "category": "Holiday",
      "priority": "High",
      "color": warningColor,
      "attendees": 0,
    },
    {
      "title": "Boxing Day Meeting",
      "date": "Dec 26",
      "time": "10:00 AM",
      "category": "Meeting",
      "priority": "Medium",
      "color": dangerColor,
      "attendees": 8,
    },
    {
      "title": "Year End Review",
      "date": "Dec 31",
      "time": "2:00 PM",
      "category": "Planning",
      "priority": "High",
      "color": primaryColor,
      "attendees": 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.today),
            onPressed: () => _goToToday(),
          ),
          IconButton(
            icon: Icon(Icons.event_note),
            onPressed: () => _showCreateEvent(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildMonthHeader(),
            _buildEventFilters(),
            _buildCalendarGrid(),
            _buildMonthlyStats(),
            _buildUpcomingEvents(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedMonth,
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${_getTotalMonthlyEvents()} events this month",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusLg),
                ),
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => _previousMonth(),
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "December 2024",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _nextMonth(),
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventFilters() {
    return QCategoryPicker(
      label: "Event Categories",
      items: eventCategories,
      value: selectedFilter,
      onChanged: (index, label, value, item) {
        selectedFilter = value;
        setState(() {});
      },
    );
  }

  Widget _buildCalendarGrid() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          // Day headers
          Row(
            children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Container(
            height: 1,
            color: disabledColor,
          ),
          // Calendar grid
          ...List.generate(5, (weekIndex) {
            return Row(
              children: List.generate(7, (dayIndex) {
                int dayNumber = weekIndex * 7 + dayIndex + 1;
                if (dayNumber > 31) return Expanded(child: Container());
                
                Map<String, dynamic> dayData = monthlyCalendar[dayNumber - 1];
                return Expanded(child: _buildCalendarDay(dayData));
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCalendarDay(Map<String, dynamic> dayData) {
    int day = dayData["day"] as int;
    bool isToday = dayData["isToday"] as bool;
    bool isWeekend = dayData["isWeekend"] as bool;
    List<Map<String, dynamic>> events = dayData["events"] as List<Map<String, dynamic>>;
    
    List<Map<String, dynamic>> filteredEvents = selectedFilter == "All" 
      ? events 
      : events.where((event) => event["category"] == selectedFilter).toList();

    return GestureDetector(
      onTap: () => _showDayEvents(day, events),
      child: Container(
        height: 70,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(spXs),
        decoration: BoxDecoration(
          color: isToday 
            ? primaryColor.withAlpha(30)
            : isWeekend 
              ? disabledColor.withAlpha(30)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(radiusSm),
          border: isToday 
            ? Border.all(color: primaryColor, width: 2)
            : null,
        ),
        child: Column(
          children: [
            Text(
              "$day",
              style: TextStyle(
                fontSize: 14,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday 
                  ? primaryColor
                  : isWeekend 
                    ? disabledBoldColor
                    : primaryColor,
              ),
            ),
            Expanded(
              child: Column(
                children: filteredEvents.take(2).map((event) => Container(
                  width: double.infinity,
                  height: 4,
                  margin: EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: event["color"] as Color,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                )).toList(),
              ),
            ),
            if (filteredEvents.length > 2)
              Text(
                "+${filteredEvents.length - 2}",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.event,
                  color: primaryColor,
                  size: 24,
                ),
                Text(
                  "${_getTotalMonthlyEvents()}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Events",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.work,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "${_getWorkDays()}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Work Days",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.weekend,
                  color: successColor,
                  size: 24,
                ),
                Text(
                  "${_getWeekends()}",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Weekends",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingEvents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Upcoming Events",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        ...upcomingEvents.map((event) => _buildUpcomingEventCard(event)).toList(),
      ],
    );
  }

  Widget _buildUpcomingEventCard(Map<String, dynamic> event) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (event["color"] as Color).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getCategoryIcon(event["category"] as String),
              color: event["color"] as Color,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["date"]} at ${event["time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if ((event["attendees"] as int) > 0)
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        size: 14,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${event["attendees"]} attendees",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: _getPriorityColor(event["priority"] as String).withAlpha(30),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${event["priority"]}",
              style: TextStyle(
                fontSize: 12,
                color: _getPriorityColor(event["priority"] as String),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static List<Map<String, dynamic>> _getEventsForDay(int day) {
    Map<int, List<Map<String, dynamic>>> eventsByDay = {
      23: [
        {"title": "Team Meeting", "category": "Meeting", "color": dangerColor},
        {"title": "Code Review", "category": "Development", "color": infoColor},
      ],
      24: [
        {"title": "Christmas Eve", "category": "Holiday", "color": warningColor},
      ],
      25: [
        {"title": "Christmas Day", "category": "Holiday", "color": warningColor},
      ],
      26: [
        {"title": "Boxing Day Meeting", "category": "Meeting", "color": dangerColor},
        {"title": "System Maintenance", "category": "Development", "color": infoColor},
      ],
      31: [
        {"title": "Year End Review", "category": "Planning", "color": primaryColor},
        {"title": "New Year Prep", "category": "Personal", "color": successColor},
      ],
    };
    
    return eventsByDay[day] ?? [];
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Meeting":
        return Icons.people;
      case "Development":
        return Icons.code;
      case "Planning":
        return Icons.schedule;
      case "Personal":
        return Icons.person;
      case "Holiday":
        return Icons.celebration;
      default:
        return Icons.event;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  int _getTotalMonthlyEvents() {
    return monthlyCalendar.fold(0, (sum, day) => sum + (day["events"] as List).length);
  }

  int _getWorkDays() {
    return 22; // Simplified calculation
  }

  int _getWeekends() {
    return 8; // Simplified calculation
  }

  void _goToToday() {
    // Navigate to today's date
    setState(() {});
  }

  void _showCreateEvent() {
    // Navigate to create event form
    //navigateTo('')
  }

  void _previousMonth() {
    // Navigate to previous month
    setState(() {});
  }

  void _nextMonth() {
    // Navigate to next month
    setState(() {});
  }

  void _showDayEvents(int day, List<Map<String, dynamic>> events) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: disabledColor,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Events for December $day",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: events.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 48,
                          color: disabledBoldColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No events for this day",
                          style: TextStyle(
                            fontSize: 16,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(spMd),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: (event["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: event["color"] as Color,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${event["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Icon(
                                  _getCategoryIcon(event["category"] as String),
                                  size: 16,
                                  color: event["color"] as Color,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${event["category"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
