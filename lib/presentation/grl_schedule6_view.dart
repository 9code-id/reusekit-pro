import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlSchedule6View extends StatefulWidget {
  @override
  State<GrlSchedule6View> createState() => _GrlSchedule6ViewState();
}

class _GrlSchedule6ViewState extends State<GrlSchedule6View> {
  int currentWeek = 0;
  String selectedView = "Week";
  
  List<Map<String, dynamic>> weeklySchedule = [
    {
      "day": "Monday",
      "date": "Dec 23",
      "events": [
        {
          "title": "Morning Standup",
          "time": "09:00 - 09:30",
          "type": "Meeting",
          "color": primaryColor,
          "priority": "High"
        },
        {
          "title": "Development Work",
          "time": "10:00 - 12:00",
          "type": "Work",
          "color": infoColor,
          "priority": "High"
        },
        {
          "title": "Lunch Break",
          "time": "12:00 - 13:00",
          "type": "Break",
          "color": successColor,
          "priority": "Low"
        },
        {
          "title": "Code Review",
          "time": "14:00 - 15:00",
          "type": "Review",
          "color": warningColor,
          "priority": "Medium"
        }
      ]
    },
    {
      "day": "Tuesday",
      "date": "Dec 24",
      "events": [
        {
          "title": "Client Call",
          "time": "10:00 - 11:00",
          "type": "Meeting",
          "color": dangerColor,
          "priority": "High"
        },
        {
          "title": "Project Planning",
          "time": "14:00 - 16:00",
          "type": "Planning",
          "color": primaryColor,
          "priority": "High"
        },
        {
          "title": "Team Training",
          "time": "16:30 - 17:30",
          "type": "Training",
          "color": infoColor,
          "priority": "Medium"
        }
      ]
    },
    {
      "day": "Wednesday",
      "date": "Dec 25",
      "events": [
        {
          "title": "Christmas Holiday",
          "time": "All Day",
          "type": "Holiday",
          "color": successColor,
          "priority": "Low"
        }
      ]
    },
    {
      "day": "Thursday",
      "date": "Dec 26",
      "events": [
        {
          "title": "System Maintenance",
          "time": "09:00 - 11:00",
          "type": "Maintenance",
          "color": warningColor,
          "priority": "High"
        },
        {
          "title": "Documentation",
          "time": "13:00 - 15:00",
          "type": "Work",
          "color": infoColor,
          "priority": "Medium"
        },
        {
          "title": "Team Retrospective",
          "time": "15:30 - 16:30",
          "type": "Meeting",
          "color": primaryColor,
          "priority": "Medium"
        }
      ]
    },
    {
      "day": "Friday",
      "date": "Dec 27",
      "events": [
        {
          "title": "Sprint Demo",
          "time": "10:00 - 11:30",
          "type": "Demo",
          "color": dangerColor,
          "priority": "High"
        },
        {
          "title": "Weekend Planning",
          "time": "14:00 - 15:00",
          "type": "Planning",
          "color": primaryColor,
          "priority": "Low"
        },
        {
          "title": "Social Hour",
          "time": "17:00 - 18:00",
          "type": "Social",
          "color": successColor,
          "priority": "Low"
        }
      ]
    },
    {
      "day": "Saturday",
      "date": "Dec 28",
      "events": [
        {
          "title": "Personal Projects",
          "time": "10:00 - 12:00",
          "type": "Personal",
          "color": infoColor,
          "priority": "Low"
        }
      ]
    },
    {
      "day": "Sunday",
      "date": "Dec 29",
      "events": [
        {
          "title": "Week Planning",
          "time": "19:00 - 20:00",
          "type": "Planning",
          "color": primaryColor,
          "priority": "Medium"
        }
      ]
    }
  ];

  List<Map<String, dynamic>> viewOptions = [
    {"label": "Day", "value": "Day"},
    {"label": "Week", "value": "Week"},
    {"label": "Month", "value": "Month"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weekly Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => _showAddEventModal(),
          ),
          IconButton(
            icon: Icon(Icons.calendar_view_week),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildWeekHeader(),
            _buildViewSelector(),
            _buildWeekNavigation(),
            _buildWeeklyOverview(),
            _buildDaySchedules(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekHeader() {
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Weekly Planner",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Dec 23 - Dec 29, 2024",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getTotalEvents()} events scheduled",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(180),
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
    );
  }

  Widget _buildViewSelector() {
    return QCategoryPicker(
      label: "View Mode",
      items: viewOptions,
      value: selectedView,
      onChanged: (index, label, value, item) {
        selectedView = value;
        setState(() {});
      },
    );
  }

  Widget _buildWeekNavigation() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              currentWeek--;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.chevron_left,
                color: primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Week ${currentWeek + 1}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "December 2024",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              currentWeek++;
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Icon(
                Icons.chevron_right,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Text(
                "Week Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spSm,
                  vertical: spXs,
                ),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${_getCompletionRate()}% Complete",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          QHorizontalScroll(
            children: weeklySchedule.map((day) => Container(
              width: 120,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: _isToday(day["day"] as String) 
                  ? primaryColor.withAlpha(30) 
                  : disabledColor.withAlpha(50),
                borderRadius: BorderRadius.circular(radiusLg),
                border: _isToday(day["day"] as String)
                  ? Border.all(color: primaryColor, width: 2)
                  : null,
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Text(
                    "${day["day"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _isToday(day["day"] as String) 
                        ? primaryColor 
                        : disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${day["date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spXs,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${(day["events"] as List).length}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySchedules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "Daily Schedules",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...weeklySchedule.map((day) => _buildDayCard(day)).toList(),
      ],
    );
  }

  Widget _buildDayCard(Map<String, dynamic> day) {
    List<Map<String, dynamic>> events = day["events"] as List<Map<String, dynamic>>;
    bool isToday = _isToday(day["day"] as String);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: isToday ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: isToday ? primaryColor.withAlpha(30) : disabledColor.withAlpha(50),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${day["day"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: isToday ? primaryColor : disabledBoldColor,
                        ),
                      ),
                      Text(
                        "${day["date"]}, 2024",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
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
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${events.length} events",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (events.isNotEmpty)
            Container(
              padding: EdgeInsets.all(spMd),
              child: Column(
                spacing: spSm,
                children: events.map((event) => _buildEventItem(event)).toList(),
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  Icon(
                    Icons.event_busy,
                    color: disabledBoldColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "No events scheduled",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: (event["color"] as Color).withAlpha(30),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border(
          left: BorderSide(
            width: 3,
            color: event["color"] as Color,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: event["color"] as Color,
              shape: BoxShape.circle,
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
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spXs,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: event["color"] as Color,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${event["type"]}",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isToday(String day) {
    // Simplified logic - would normally check actual current day
    return day == "Monday";
  }

  int _getTotalEvents() {
    return weeklySchedule.fold(0, (sum, day) => sum + (day["events"] as List).length);
  }

  int _getCompletionRate() {
    // Simplified completion rate calculation
    return 75;
  }

  void _showAddEventModal() {
    // Navigate to add event form
    //navigateTo('')
  }
}
