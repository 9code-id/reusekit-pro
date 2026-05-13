import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar5View extends StatefulWidget {
  @override
  State<GrlCalendar5View> createState() => _GrlCalendar5ViewState();
}

class _GrlCalendar5ViewState extends State<GrlCalendar5View> {
  DateTime selectedDate = DateTime.now();
  String selectedView = 'events';
  
  List<Map<String, dynamic>> events = [
    {
      "id": 1,
      "title": "Birthday Party",
      "date": DateTime.now(),
      "time": "19:00",
      "location": "Home",
      "category": "personal",
      "attendees": 12,
      "description": "Annual birthday celebration with family and friends",
    },
    {
      "id": 2,
      "title": "Wedding Anniversary",
      "date": DateTime.now().add(Duration(days: 3)),
      "time": "18:30",
      "location": "Restaurant Le Bernardin",
      "category": "special",
      "attendees": 2,
      "description": "Romantic dinner for wedding anniversary",
    },
    {
      "id": 3,
      "title": "Family Reunion",
      "date": DateTime.now().add(Duration(days: 7)),
      "time": "14:00",
      "location": "Central Park",
      "category": "family",
      "attendees": 25,
      "description": "Annual family gathering with games and BBQ",
    },
    {
      "id": 4,
      "title": "Movie Night",
      "date": DateTime.now().add(Duration(days: 2)),
      "time": "20:00",
      "location": "Home Theater",
      "category": "entertainment",
      "attendees": 6,
      "description": "Weekly movie night with friends",
    },
  ];

  List<Map<String, dynamic>> reminders = [
    {
      "id": 1,
      "title": "Buy groceries",
      "time": "10:00",
      "priority": "medium",
      "completed": false,
    },
    {
      "id": 2,
      "title": "Call mom",
      "time": "15:30",
      "priority": "high",
      "completed": false,
    },
    {
      "id": 3,
      "title": "Water plants",
      "time": "08:00",
      "priority": "low",
      "completed": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo(AddEventView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // View Selector
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedView = 'events';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedView == 'events' ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event,
                            size: 18,
                            color: selectedView == 'events' ? primaryColor : Colors.white,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedView == 'events' ? primaryColor : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedView = 'reminders';
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedView == 'reminders' ? Colors.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications,
                            size: 18,
                            color: selectedView == 'reminders' ? primaryColor : Colors.white,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Reminders",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: selectedView == 'reminders' ? primaryColor : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: selectedView == 'events' ? _buildEventsView() : _buildRemindersView(),
          ),
        ],
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

  Widget _buildEventsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's Highlight
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [successColor, successColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Today's Special",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                if (events.any((event) {
                  DateTime eventDate = event["date"] as DateTime;
                  return eventDate.day == DateTime.now().day &&
                         eventDate.month == DateTime.now().month &&
                         eventDate.year == DateTime.now().year;
                }))
                  ...events.where((event) {
                    DateTime eventDate = event["date"] as DateTime;
                    return eventDate.day == DateTime.now().day &&
                           eventDate.month == DateTime.now().month &&
                           eventDate.year == DateTime.now().year;
                  }).map((event) => Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${event["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${event["time"]} • ${event["location"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  )).toList()
                else
                  Text(
                    "No special events today. Enjoy your free time!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
              ],
            ),
          ),
          
          SizedBox(height: spMd),
          
          // Category Filter
          QHorizontalScroll(
            children: [
              'all', 'personal', 'family', 'special', 'entertainment'
            ].map((category) => Container(
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.symmetric(
                horizontal: spMd,
                vertical: spSm,
              ),
              decoration: BoxDecoration(
                color: category == 'all' ? primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Text(
                category.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: category == 'all' ? Colors.white : primaryColor,
                ),
              ),
            )).toList(),
          ),
          
          SizedBox(height: spMd),
          
          // Upcoming Events
          Text(
            "Upcoming Events",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...events.map((event) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                // Event Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: _getCategoryColor(event["category"]).withAlpha(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusLg),
                      topRight: Radius.circular(radiusLg),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(event["category"]),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          _getCategoryIcon(event["category"]),
                          color: Colors.white,
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
                              ),
                            ),
                            Text(
                              "${event["category"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: _getCategoryColor(event["category"]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${(event["date"] as DateTime).day}/${(event["date"] as DateTime).month}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _getCategoryColor(event["category"]),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Event Details
                Padding(
                  padding: EdgeInsets.all(spMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${event["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spMd),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${event["time"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${event["location"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${event["attendees"]} attendees",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildRemindersView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reminder Stats
          Row(
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
                    children: [
                      Text(
                        "${reminders.where((r) => !(r["completed"] as bool)).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Pending",
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
                    children: [
                      Text(
                        "${reminders.where((r) => r["completed"] as bool).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Completed",
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
          ),
          
          SizedBox(height: spMd),
          
          // Today's Reminders
          Text(
            "Today's Reminders",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          ...reminders.map((reminder) => Container(
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: reminder["completed"] as bool 
                      ? successColor 
                      : _getPriorityColor(reminder["priority"]),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(spMd),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      reminder["completed"] = !(reminder["completed"] as bool);
                      setState(() {});
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: reminder["completed"] as bool 
                            ? successColor 
                            : Colors.transparent,
                        border: Border.all(
                          color: reminder["completed"] as bool 
                              ? successColor 
                              : disabledBoldColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: reminder["completed"] as bool
                          ? Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${reminder["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            decoration: reminder["completed"] as bool 
                                ? TextDecoration.lineThrough 
                                : null,
                            color: reminder["completed"] as bool 
                                ? disabledBoldColor 
                                : Colors.black,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${reminder["time"]}",
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
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(reminder["priority"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${reminder["priority"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: _getPriorityColor(reminder["priority"]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )).toList(),
          
          SizedBox(height: spMd),
          
          // Add Reminder Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Reminder",
              size: bs.md,
              icon: Icons.add,
              onPressed: () {
                // navigateTo(AddReminderView());
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'personal':
        return primaryColor;
      case 'family':
        return successColor;
      case 'special':
        return warningColor;
      case 'entertainment':
        return infoColor;
      default:
        return primaryColor;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'personal':
        return Icons.person;
      case 'family':
        return Icons.family_restroom;
      case 'special':
        return Icons.star;
      case 'entertainment':
        return Icons.movie;
      default:
        return Icons.event;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return successColor;
      default:
        return primaryColor;
    }
  }
}
