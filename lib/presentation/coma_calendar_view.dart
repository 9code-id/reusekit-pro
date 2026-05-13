import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaCalendarView extends StatefulWidget {
  const ComaCalendarView({super.key});

  @override
  State<ComaCalendarView> createState() => _ComaCalendarViewState();
}

class _ComaCalendarViewState extends State<ComaCalendarView> {
  String searchQuery = "";
  String selectedProject = "All";
  String selectedType = "All";
  DateTime selectedDate = DateTime.now();
  String selectedView = "Month";

  List<Map<String, dynamic>> projectItems = [
    {"label": "All Projects", "value": "All"},
    {"label": "Downtown Office", "value": "Downtown Office"},
    {"label": "Residential Complex", "value": "Residential Complex"},
    {"label": "Shopping Mall", "value": "Shopping Mall"},
    {"label": "Hospital Wing", "value": "Hospital Wing"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All"},
    {"label": "Task", "value": "Task"},
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Deadline", "value": "Deadline"},
    {"label": "Milestone", "value": "Milestone"},
    {"label": "Inspection", "value": "Inspection"},
  ];

  List<Map<String, dynamic>> viewItems = [
    {"label": "Month", "value": "Month"},
    {"label": "Week", "value": "Week"},
    {"label": "Day", "value": "Day"},
  ];

  List<Map<String, dynamic>> events = [
    {
      "id": "EVT001",
      "title": "Foundation Inspection",
      "description": "Quality inspection of foundation work for Building A",
      "type": "Inspection",
      "project": "Downtown Office",
      "date": "2024-01-20",
      "startTime": "09:00",
      "endTime": "11:00",
      "location": "Building A Site",
      "assignee": "John Smith",
      "status": "Scheduled",
      "priority": "High",
      "color": dangerColor,
    },
    {
      "id": "EVT002",
      "title": "Client Meeting",
      "description": "Project progress review with client stakeholders",
      "type": "Meeting",
      "project": "Residential Complex",
      "date": "2024-01-20",
      "startTime": "14:00",
      "endTime": "15:30",
      "location": "Conference Room B",
      "assignee": "Sarah Johnson",
      "status": "Confirmed",
      "priority": "Medium",
      "color": primaryColor,
    },
    {
      "id": "EVT003",
      "title": "Concrete Pour - Phase 1",
      "description": "First floor concrete pouring for west wing",
      "type": "Task",
      "project": "Shopping Mall",
      "date": "2024-01-21",
      "startTime": "06:00",
      "endTime": "14:00",
      "location": "West Wing Site",
      "assignee": "Mike Davis",
      "status": "Scheduled",
      "priority": "High",
      "color": warningColor,
    },
    {
      "id": "EVT004",
      "title": "Safety Training Session",
      "description": "Monthly safety training for all site personnel",
      "type": "Meeting",
      "project": "All Projects",
      "date": "2024-01-22",
      "startTime": "08:00",
      "endTime": "10:00",
      "location": "Training Center",
      "assignee": "Lisa Brown",
      "status": "Scheduled",
      "priority": "Medium",
      "color": successColor,
    },
    {
      "id": "EVT005",
      "title": "Equipment Delivery",
      "description": "Delivery of new excavator and construction materials",
      "type": "Milestone",
      "project": "Hospital Wing",
      "date": "2024-01-23",
      "startTime": "10:00",
      "endTime": "12:00",
      "location": "Equipment Yard",
      "assignee": "Robert Wilson",
      "status": "Confirmed",
      "priority": "Medium",
      "color": infoColor,
    },
    {
      "id": "EVT006",
      "title": "Project Deadline",
      "description": "Final completion deadline for Phase 1",
      "type": "Deadline",
      "project": "Downtown Office",
      "date": "2024-01-25",
      "startTime": "23:59",
      "endTime": "23:59",
      "location": "Project Site",
      "assignee": "Project Team",
      "status": "Critical",
      "priority": "Critical",
      "color": dangerColor,
    },
  ];

  List<Map<String, dynamic>> get filteredEvents {
    return events.where((event) {
      bool matchesSearch = event["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          event["description"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          event["assignee"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesProject = selectedProject == "All" || event["project"] == selectedProject;
      bool matchesType = selectedType == "All" || event["type"] == selectedType;
      
      // For now, show all events regardless of date (in a real app, this would filter by selected date range)
      return matchesSearch && matchesProject && matchesType;
    }).toList();
  }

  List<Map<String, dynamic>> get todayEvents {
    String today = DateTime.now().toString().split(' ')[0];
    return filteredEvents.where((event) => event["date"] == today).toList();
  }

  List<Map<String, dynamic>> get upcomingEvents {
    DateTime now = DateTime.now();
    return filteredEvents.where((event) {
      DateTime eventDate = DateTime.parse(event["date"]);
      return eventDate.isAfter(now) && eventDate.isBefore(now.add(Duration(days: 7)));
    }).toList()..sort((a, b) => DateTime.parse(a["date"]).compareTo(DateTime.parse(b["date"])));
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Task":
        return warningColor;
      case "Meeting":
        return primaryColor;
      case "Deadline":
        return dangerColor;
      case "Milestone":
        return successColor;
      case "Inspection":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
        return infoColor;
      case "Confirmed":
        return successColor;
      case "Critical":
        return dangerColor;
      case "Completed":
        return successColor;
      case "Cancelled":
        return disabledColor;
      default:
        return disabledColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Task":
        return Icons.assignment;
      case "Meeting":
        return Icons.meeting_room;
      case "Deadline":
        return Icons.flag;
      case "Milestone":
        return Icons.stars;
      case "Inspection":
        return Icons.search;
      default:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalEvents = events.length;
    int todayEventsCount = todayEvents.length;
    int upcomingEventsCount = upcomingEvents.length;
    int criticalEvents = events.where((e) => e["priority"] == "Critical").length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Add new event functionality would open here");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Summary Statistics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
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
                          Icon(Icons.event, color: primaryColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Total Events",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$totalEvents",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                          Icon(Icons.today, color: infoColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Today's Events",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$todayEventsCount",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                          Icon(Icons.schedule, color: warningColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Upcoming (7 days)",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$upcomingEventsCount",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                    ],
                  ),
                ),
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
                          Icon(Icons.priority_high, color: dangerColor, size: 24),
                          SizedBox(width: spXs),
                          Text(
                            "Critical Events",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$criticalEvents",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Filters and Search
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  QTextField(
                    label: "Search Events",
                    value: searchQuery,
                    hint: "Search by title, description, or assignee",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Project",
                          items: projectItems,
                          value: selectedProject,
                          onChanged: (value, label) {
                            selectedProject = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Event Type",
                          items: typeItems,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "View",
                          items: viewItems,
                          value: selectedView,
                          onChanged: (value, label) {
                            selectedView = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Calendar Grid (Simple Month View)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Month Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.chevron_left),
                        onPressed: () {
                          selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
                          setState(() {});
                        },
                      ),
                      Text(
                        "${_getMonthName(selectedDate.month)} ${selectedDate.year}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  
                  // Days of Week Header
                  Row(
                    children: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"].map((day) {
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: spXs),
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
                      );
                    }).toList(),
                  ),
                  
                  // Calendar Days Grid
                  ...List.generate(6, (weekIndex) {
                    return Row(
                      children: List.generate(7, (dayIndex) {
                        int dayNumber = weekIndex * 7 + dayIndex + 1;
                        DateTime dayDate = DateTime(selectedDate.year, selectedDate.month, dayNumber);
                        bool isCurrentMonth = dayDate.month == selectedDate.month;
                        bool isToday = dayDate.day == DateTime.now().day && 
                                      dayDate.month == DateTime.now().month && 
                                      dayDate.year == DateTime.now().year;
                        
                        List<Map<String, dynamic>> dayEvents = events.where((event) {
                          DateTime eventDate = DateTime.parse(event["date"]);
                          return eventDate.day == dayDate.day && 
                                 eventDate.month == dayDate.month && 
                                 eventDate.year == dayDate.year;
                        }).toList();

                        return Expanded(
                          child: Container(
                            height: 80,
                            margin: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: isToday ? primaryColor.withValues(alpha: 0.1) : 
                                     isCurrentMonth ? Colors.white : Colors.grey[100],
                              borderRadius: BorderRadius.circular(radiusXs),
                              border: isToday ? Border.all(color: primaryColor, width: 2) : null,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    "${dayDate.day}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                      color: isCurrentMonth ? (isToday ? primaryColor : Colors.black) : disabledColor,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2),
                                    child: Column(
                                      children: dayEvents.take(3).map((event) {
                                        return Container(
                                          width: double.infinity,
                                          height: 12,
                                          margin: EdgeInsets.only(bottom: 1),
                                          decoration: BoxDecoration(
                                            color: event["color"] as Color,
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${event["title"]}",
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                if (dayEvents.length > 3)
                                  Text(
                                    "+${dayEvents.length - 3} more",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ],
              ),
            ),

            // Events List
            Text(
              "Events (${filteredEvents.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ...filteredEvents.map((event) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
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
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: _getTypeColor("${event["type"]}").withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            _getTypeIcon("${event["type"]}"),
                            size: 20,
                            color: _getTypeColor("${event["type"]}"),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${event["project"]}",
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
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor("${event["status"]}").withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(
                              color: _getStatusColor("${event["status"]}"),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${event["status"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor("${event["status"]}"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusXs),
                        border: Border.all(color: disabledOutlineBorderColor),
                      ),
                      child: Text(
                        "${event["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: spSm),
                    ResponsiveGridView(
                      padding: EdgeInsets.zero,
                      minItemWidth: 200,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${event["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${event["startTime"]} - ${event["endTime"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${event["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.person, size: 14, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "${event["assignee"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit Event",
                            size: bs.sm,
                            onPressed: () {
                              ss("Edit event ${event["title"]}");
                            },
                          ),
                        ),
                        QButton(
                          icon: Icons.notifications,
                          size: bs.sm,
                          onPressed: () {
                            ss("Set reminder for ${event["title"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for ${event["title"]}");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return months[month - 1];
  }
}
