import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCalendarManagementView extends StatefulWidget {
  const LcaCalendarManagementView({super.key});

  @override
  State<LcaCalendarManagementView> createState() => _LcaCalendarManagementViewState();
}

class _LcaCalendarManagementViewState extends State<LcaCalendarManagementView> {
  DateTime selectedDate = DateTime.now();
  String selectedView = "Month";
  List<String> viewOptions = ["Day", "Week", "Month", "Year"];

  List<Map<String, dynamic>> calendarEvents = [
    {
      "id": 1,
      "title": "Client Meeting - Johnson Case",
      "date": "2024-12-19T09:00:00Z",
      "endDate": "2024-12-19T10:30:00Z",
      "type": "Meeting",
      "location": "Conference Room A",
      "attendees": ["Sarah Johnson", "John Doe"],
      "priority": "High",
      "status": "Confirmed",
      "description": "Discuss case strategy and evidence review",
      "reminders": [15, 30],
      "color": "#2196F3",
    },
    {
      "id": 2,
      "title": "Court Hearing - Smith vs. Brown",
      "date": "2024-12-20T14:00:00Z",
      "endDate": "2024-12-20T16:00:00Z",
      "type": "Court Hearing",
      "location": "Courtroom 5, City Hall",
      "attendees": ["Michael Chen", "Emily Davis"],
      "priority": "Critical",
      "status": "Confirmed",
      "description": "Final hearing for contract dispute",
      "reminders": [60, 120],
      "color": "#F44336",
    },
    {
      "id": 3,
      "title": "Document Review Session",
      "date": "2024-12-21T11:00:00Z",
      "endDate": "2024-12-21T13:00:00Z",
      "type": "Work Session",
      "location": "Law Library",
      "attendees": ["David Wilson"],
      "priority": "Medium",
      "status": "Tentative",
      "description": "Review evidence documents for upcoming case",
      "reminders": [30],
      "color": "#FF9800",
    },
    {
      "id": 4,
      "title": "Deposition - Witness Thompson",
      "date": "2024-12-22T10:00:00Z",
      "endDate": "2024-12-22T12:00:00Z",
      "type": "Deposition",
      "location": "Law Office",
      "attendees": ["Sarah Johnson", "Court Reporter"],
      "priority": "High",
      "status": "Confirmed",
      "description": "Key witness deposition for personal injury case",
      "reminders": [30, 60],
      "color": "#4CAF50",
    },
    {
      "id": 5,
      "title": "Filing Deadline - Motion to Dismiss",
      "date": "2024-12-23T17:00:00Z",
      "endDate": "2024-12-23T17:00:00Z",
      "type": "Deadline",
      "location": "Court Clerk's Office",
      "attendees": ["Michael Chen"],
      "priority": "Critical",
      "status": "Pending",
      "description": "File motion to dismiss by 5 PM",
      "reminders": [60, 180, 720],
      "color": "#9C27B0",
    },
  ];

  // New event form
  String eventTitle = "";
  DateTime? eventDate;
  TimeOfDay? eventTime;
  DateTime? eventEndDate;
  TimeOfDay? eventEndTime;
  String eventType = "Meeting";
  String eventLocation = "";
  String eventDescription = "";
  String eventPriority = "Medium";
  List<String> eventTypes = ["Meeting", "Court Hearing", "Deposition", "Deadline", "Work Session", "Consultation"];
  List<String> priorityLevels = ["Low", "Medium", "High", "Critical"];

  List<Map<String, dynamic>> get todayEvents {
    DateTime today = DateTime.now();
    return calendarEvents.where((event) {
      DateTime eventDate = DateTime.parse("${event["date"]}");
      return eventDate.year == today.year &&
             eventDate.month == today.month &&
             eventDate.day == today.day;
    }).toList();
  }

  List<Map<String, dynamic>> get upcomingEvents {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(Duration(days: 1));
    return calendarEvents.where((event) {
      DateTime eventDate = DateTime.parse("${event["date"]}");
      return eventDate.isAfter(now) && eventDate.isBefore(tomorrow.add(Duration(days: 6)));
    }).toList();
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Confirmed":
        return successColor;
      case "Tentative":
        return warningColor;
      case "Pending":
        return infoColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _showEventDialog({Map<String, dynamic>? event}) {
    if (event != null) {
      eventTitle = "${event["title"]}";
      eventDate = DateTime.parse("${event["date"]}");
      eventTime = TimeOfDay.fromDateTime(eventDate!);
      eventEndDate = DateTime.parse("${event["endDate"]}");
      eventEndTime = TimeOfDay.fromDateTime(eventEndDate!);
      eventType = "${event["type"]}";
      eventLocation = "${event["location"]}";
      eventDescription = "${event["description"]}";
      eventPriority = "${event["priority"]}";
    } else {
      // Reset form for new event
      eventTitle = "";
      eventDate = selectedDate;
      eventTime = TimeOfDay.now();
      eventEndDate = selectedDate;
      eventEndTime = TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);
      eventType = "Meeting";
      eventLocation = "";
      eventDescription = "";
      eventPriority = "Medium";
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(event != null ? "Edit Event" : "New Event"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spSm,
              children: [
                QTextField(
                  label: "Event Title",
                  value: eventTitle,
                  onChanged: (value) {
                    eventTitle = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Event Type",
                  items: eventTypes.map((type) => {"label": type, "value": type}).toList(),
                  value: eventType,
                  onChanged: (value, label) {
                    eventType = value;
                    setDialogState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "Date",
                        value: eventDate ?? DateTime.now(),
                        onChanged: (value) {
                          eventDate = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Start Time",
                        value: eventTime ?? TimeOfDay.now(),
                        onChanged: (value) {
                          eventTime = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDatePicker(
                        label: "End Date",
                        value: eventEndDate ?? DateTime.now(),
                        onChanged: (value) {
                          eventEndDate = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "End Time",
                        value: eventEndTime ?? TimeOfDay.now(),
                        onChanged: (value) {
                          eventEndTime = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QTextField(
                  label: "Location",
                  value: eventLocation,
                  onChanged: (value) {
                    eventLocation = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Priority",
                  items: priorityLevels.map((priority) => {"label": priority, "value": priority}).toList(),
                  value: eventPriority,
                  onChanged: (value, label) {
                    eventPriority = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Description",
                  value: eventDescription,
                  onChanged: (value) {
                    eventDescription = value;
                    setDialogState(() {});
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            if (event != null)
              TextButton(
                onPressed: () {
                  // Delete event
                  Navigator.pop(context);
                  ss("Event deleted successfully");
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: dangerColor),
                ),
              ),
            QButton(
              label: event != null ? "Update" : "Create",
              size: bs.sm,
              onPressed: () {
                // Save event
                Navigator.pop(context);
                ss(event != null ? "Event updated successfully" : "Event created successfully");
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar Management"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showEventDialog(),
          ),
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              // Sync calendar
              ss("Calendar synced successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Calendar View Controls
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "View",
                      items: viewOptions.map((view) => {"label": view, "value": view}).toList(),
                      value: selectedView,
                      onChanged: (value, label) {
                        selectedView = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      selectedDate = selectedDate.subtract(Duration(days: 30));
                      setState(() {});
                    },
                  ),
                  Text(
                    "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      selectedDate = selectedDate.add(Duration(days: 30));
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Today's Events
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Today's Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${todayEvents.length} events",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (todayEvents.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Text(
                        "No events scheduled for today",
                        style: TextStyle(
                          color: disabledColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  else
                    ...todayEvents.map((event) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Color(int.parse("${event["color"]}".replaceAll("#", "0xFF"))).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: Color(int.parse("${event["color"]}".replaceAll("#", "0xFF"))),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${event["title"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${TimeOfDay.fromDateTime(DateTime.parse("${event["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${event["endDate"]}")).kkmm}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      if (event["location"] != null && "${event["location"]}".isNotEmpty) ...[
                                        SizedBox(width: spSm),
                                        Icon(
                                          Icons.location_on,
                                          size: 12,
                                          color: disabledColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${event["location"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor("${event["priority"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${event["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor("${event["priority"]}"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${event["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
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
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              onPressed: () => _showEventDialog(event: event),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),

            // Upcoming Events
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.upcoming,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Upcoming Events",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${upcomingEvents.length} events",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (upcomingEvents.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Text(
                        "No upcoming events this week",
                        style: TextStyle(
                          color: disabledColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  else
                    ...upcomingEvents.take(5).map((event) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(int.parse("${event["color"]}".replaceAll("#", "0xFF"))),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Text(
                                    "${event["title"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${DateTime.parse("${event["date"]}").dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse("${event["date"]}")).kkmm}",
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
                                color: _getPriorityColor("${event["priority"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${event["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: _getPriorityColor("${event["priority"]}"),
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

            // Calendar Statistics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Calendar Summary",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${calendarEvents.where((e) => e["priority"] == "Critical").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Critical Events",
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${calendarEvents.where((e) => e["type"] == "Court Hearing").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Court Hearings",
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
                ],
              ),
            ),

            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "New Event",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: () => _showEventDialog(),
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Export Calendar",
                          icon: Icons.file_download,
                          size: bs.sm,
                          onPressed: () {
                            // Export calendar
                          },
                        ),
                      ),
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
}
