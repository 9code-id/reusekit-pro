import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaMeetingScheduleView extends StatefulWidget {
  const LcaMeetingScheduleView({super.key});

  @override
  State<LcaMeetingScheduleView> createState() => _LcaMeetingScheduleViewState();
}

class _LcaMeetingScheduleViewState extends State<LcaMeetingScheduleView> {
  String selectedFilter = "All";
  String selectedTypeFilter = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> meetings = [
    {
      "id": 1,
      "title": "Case Strategy Meeting - Smith vs. Johnson",
      "type": "Case Discussion",
      "date": "2024-12-20T10:00:00Z",
      "endTime": "2024-12-20T11:30:00Z",
      "location": "Conference Room A",
      "organizer": "Sarah Johnson, Esq.",
      "attendees": ["Michael Chen", "Emily Davis", "John Smith (Client)"],
      "status": "Scheduled",
      "priority": "High",
      "caseNumber": "2024-CV-1234",
      "agenda": [
        "Review current case status",
        "Discuss settlement options",
        "Prepare for upcoming hearing",
        "Review evidence documentation"
      ],
      "documents": ["Case Brief", "Evidence Summary", "Settlement Analysis"],
      "meetingType": "In-Person",
      "remindersSent": 1,
      "notes": "Important strategy session before court hearing",
      "isRecurring": false,
    },
    {
      "id": 2,
      "title": "Weekly Team Standup",
      "type": "Team Meeting",
      "date": "2024-12-21T09:00:00Z",
      "endTime": "2024-12-21T09:30:00Z",
      "location": "Zoom Meeting Room",
      "organizer": "Michael Chen, Esq.",
      "attendees": ["Sarah Johnson", "Emily Davis", "David Wilson", "Jennifer Martinez"],
      "status": "Confirmed",
      "priority": "Medium",
      "caseNumber": null,
      "agenda": [
        "Case updates from each attorney",
        "Upcoming deadlines review",
        "Resource allocation",
        "Client feedback discussion"
      ],
      "documents": ["Weekly Report", "Deadline Tracker"],
      "meetingType": "Video Call",
      "remindersSent": 0,
      "notes": "Regular weekly team sync meeting",
      "isRecurring": true,
    },
    {
      "id": 3,
      "title": "Client Consultation - Davis Family Matter",
      "type": "Client Meeting",
      "date": "2024-12-22T14:00:00Z",
      "endTime": "2024-12-22T15:00:00Z",
      "location": "Emily's Office",
      "organizer": "Emily Davis, Esq.",
      "attendees": ["Jennifer Davis", "Robert Davis"],
      "status": "Pending",
      "priority": "High",
      "caseNumber": "2024-FAM-9012",
      "agenda": [
        "Discuss custody arrangements",
        "Review financial obligations",
        "Explain legal procedures",
        "Answer client questions"
      ],
      "documents": ["Custody Evaluation", "Financial Statements", "Legal Options Summary"],
      "meetingType": "In-Person",
      "remindersSent": 1,
      "notes": "Sensitive family matter - both parties attending",
      "isRecurring": false,
    },
    {
      "id": 4,
      "title": "Deposition Preparation - Anderson Case",
      "type": "Case Preparation",
      "date": "2024-12-23T13:00:00Z",
      "endTime": "2024-12-23T15:00:00Z",
      "location": "Conference Room B",
      "organizer": "Michael Chen, Esq.",
      "attendees": ["Mark Anderson (Client)", "Expert Witness Dr. Thompson"],
      "status": "Confirmed",
      "priority": "Critical",
      "caseNumber": "2024-CR-5678",
      "agenda": [
        "Review key testimony points",
        "Practice difficult questions",
        "Review evidence timeline",
        "Discuss courtroom procedures"
      ],
      "documents": ["Deposition Outline", "Key Evidence", "Question Bank"],
      "meetingType": "In-Person",
      "remindersSent": 2,
      "notes": "Critical prep session before deposition",
      "isRecurring": false,
    },
    {
      "id": 5,
      "title": "Settlement Negotiation - Wilson Construction",
      "type": "Settlement Meeting",
      "date": "2024-12-24T11:00:00Z",
      "endTime": "2024-12-24T13:00:00Z",
      "location": "Neutral Venue - Mediation Center",
      "organizer": "David Wilson, Esq.",
      "attendees": ["Wilson Construction Rep", "ABC Corp Legal Team", "Mediator Johnson"],
      "status": "Rescheduled",
      "priority": "High",
      "caseNumber": "2024-CV-3456",
      "agenda": [
        "Present settlement proposal",
        "Negotiate terms and damages",
        "Discuss payment schedules",
        "Finalize agreement details"
      ],
      "documents": ["Settlement Proposal", "Damage Assessment", "Contract Terms"],
      "meetingType": "In-Person",
      "remindersSent": 1,
      "notes": "Rescheduled from December 20th - all parties confirmed",
      "isRecurring": false,
    },
  ];

  // New meeting form
  String meetingTitle = "";
  String selectedMeetingType = "Case Discussion";
  DateTime? meetingDate;
  TimeOfDay? meetingStartTime;
  TimeOfDay? meetingEndTime;
  String selectedLocation = "Conference Room A";
  String meetingOrganizer = "Sarah Johnson, Esq.";
  String meetingNotes = "";
  String selectedPriority = "Medium";

  List<String> meetingTypes = [
    "Case Discussion",
    "Client Meeting",
    "Team Meeting",
    "Case Preparation",
    "Settlement Meeting",
    "Court Preparation",
    "Strategy Session"
  ];

  List<String> locations = [
    "Conference Room A",
    "Conference Room B",
    "Emily's Office",
    "Michael's Office",
    "Sarah's Office",
    "David's Office",
    "Zoom Meeting Room",
    "Teams Meeting",
    "Client Location",
    "Neutral Venue"
  ];

  List<String> organizers = [
    "Sarah Johnson, Esq.",
    "Michael Chen, Esq.",
    "Emily Davis, Esq.",
    "David Wilson, Esq.",
    "Jennifer Martinez, Esq."
  ];

  List<String> priorityLevels = ["Low", "Medium", "High", "Critical"];
  List<String> statusFilters = ["All", "Scheduled", "Confirmed", "Pending", "Rescheduled", "Cancelled"];
  List<String> typeFilters = ["All", "Case Discussion", "Client Meeting", "Team Meeting", "Case Preparation", "Settlement Meeting"];

  List<Map<String, dynamic>> get filteredMeetings {
    List<Map<String, dynamic>> filtered = meetings;

    if (selectedFilter != "All") {
      filtered = filtered.where((meeting) => meeting["status"] == selectedFilter).toList();
    }

    if (selectedTypeFilter != "All") {
      filtered = filtered.where((meeting) => meeting["type"] == selectedTypeFilter).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((meeting) =>
          "${meeting["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${meeting["organizer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          (meeting["caseNumber"] != null && "${meeting["caseNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()))).toList();
    }

    return filtered;
  }

  List<Map<String, dynamic>> get todayMeetings {
    DateTime today = DateTime.now();
    return meetings.where((meeting) {
      DateTime meetingDate = DateTime.parse("${meeting["date"]}");
      return meetingDate.year == today.year &&
             meetingDate.month == today.month &&
             meetingDate.day == today.day &&
             meeting["status"] != "Cancelled";
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
      case "Confirmed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Rescheduled":
        return infoColor;
      case "Cancelled":
        return dangerColor;
      default:
        return disabledColor;
    }
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

  Color _getTypeColor(String type) {
    switch (type) {
      case "Case Discussion":
        return primaryColor;
      case "Client Meeting":
        return infoColor;
      case "Team Meeting":
        return successColor;
      case "Case Preparation":
        return warningColor;
      case "Settlement Meeting":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _showMeetingDetails(Map<String, dynamic> meeting) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${meeting["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              // Meeting Information
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getTypeColor("${meeting["type"]}").withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Meeting Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getTypeColor("${meeting["type"]}"),
                      ),
                    ),
                    Text("Type: ${meeting["type"]}"),
                    Text("Date: ${DateTime.parse("${meeting["date"]}").dMMMy}"),
                    Text("Time: ${TimeOfDay.fromDateTime(DateTime.parse("${meeting["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${meeting["endTime"]}")).kkmm}"),
                    Text("Location: ${meeting["location"]}"),
                    Text("Organizer: ${meeting["organizer"]}"),
                    if (meeting["caseNumber"] != null)
                      Text("Case: ${meeting["caseNumber"]}"),
                  ],
                ),
              ),

              // Status and Priority
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getStatusColor("${meeting["status"]}").withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Status & Priority",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor("${meeting["status"]}"),
                      ),
                    ),
                    Text("Status: ${meeting["status"]}"),
                    Text("Priority: ${meeting["priority"]}"),
                    Text("Meeting Type: ${meeting["meetingType"]}"),
                    Text("Recurring: ${meeting["isRecurring"] ? "Yes" : "No"}"),
                    Text("Reminders Sent: ${meeting["remindersSent"]}"),
                  ],
                ),
              ),

              // Attendees
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Attendees",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    ...(meeting["attendees"] as List).map((attendee) => Text("• $attendee")).toList(),
                  ],
                ),
              ),

              // Agenda
              if (meeting["agenda"] != null && (meeting["agenda"] as List).isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Agenda",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      ...(meeting["agenda"] as List).asMap().entries.map((entry) => 
                        Text("${entry.key + 1}. ${entry.value}")).toList(),
                    ],
                  ),
                ),

              // Documents
              if (meeting["documents"] != null && (meeting["documents"] as List).isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Required Documents",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      ...(meeting["documents"] as List).map((doc) => Text("• $doc")).toList(),
                    ],
                  ),
                ),

              // Notes
              if (meeting["notes"] != null && "${meeting["notes"]}".isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Notes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text("${meeting["notes"]}"),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
          QButton(
            label: "Edit Meeting",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              // Edit meeting
            },
          ),
        ],
      ),
    );
  }

  void _showScheduleForm() {
    // Reset form
    meetingTitle = "";
    selectedMeetingType = "Case Discussion";
    meetingDate = DateTime.now().add(Duration(days: 1));
    meetingStartTime = TimeOfDay(hour: 10, minute: 0);
    meetingEndTime = TimeOfDay(hour: 11, minute: 0);
    selectedLocation = "Conference Room A";
    meetingOrganizer = "Sarah Johnson, Esq.";
    meetingNotes = "";
    selectedPriority = "Medium";

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text("Schedule Meeting"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spSm,
              children: [
                QTextField(
                  label: "Meeting Title",
                  value: meetingTitle,
                  onChanged: (value) {
                    meetingTitle = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Meeting Type",
                  items: meetingTypes.map((type) => {"label": type, "value": type}).toList(),
                  value: selectedMeetingType,
                  onChanged: (value, label) {
                    selectedMeetingType = value;
                    setDialogState(() {});
                  },
                ),
                QDatePicker(
                  label: "Date",
                  value: meetingDate ?? DateTime.now(),
                  onChanged: (value) {
                    meetingDate = value;
                    setDialogState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QTimePicker(
                        label: "Start Time",
                        value: meetingStartTime ?? TimeOfDay.now(),
                        onChanged: (value) {
                          meetingStartTime = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "End Time",
                        value: meetingEndTime ?? TimeOfDay.now(),
                        onChanged: (value) {
                          meetingEndTime = value;
                          setDialogState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QDropdownField(
                  label: "Location",
                  items: locations.map((location) => {"label": location, "value": location}).toList(),
                  value: selectedLocation,
                  onChanged: (value, label) {
                    selectedLocation = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Organizer",
                  items: organizers.map((organizer) => {"label": organizer, "value": organizer}).toList(),
                  value: meetingOrganizer,
                  onChanged: (value, label) {
                    meetingOrganizer = value;
                    setDialogState(() {});
                  },
                ),
                QDropdownField(
                  label: "Priority",
                  items: priorityLevels.map((priority) => {"label": priority, "value": priority}).toList(),
                  value: selectedPriority,
                  onChanged: (value, label) {
                    selectedPriority = value;
                    setDialogState(() {});
                  },
                ),
                QMemoField(
                  label: "Notes",
                  value: meetingNotes,
                  onChanged: (value) {
                    meetingNotes = value;
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
            QButton(
              label: "Schedule",
              size: bs.sm,
              onPressed: () {
                Navigator.pop(context);
                ss("Meeting scheduled successfully");
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
        title: Text("Meeting Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showScheduleForm,
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              // Start video meeting
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
            // Today's Meetings
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
                        "Today's Meetings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${todayMeetings.length} meetings",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (todayMeetings.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spMd),
                      child: Text(
                        "No meetings scheduled for today",
                        style: TextStyle(
                          color: disabledColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  else
                    ...todayMeetings.map((meeting) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: _getTypeColor("${meeting["type"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getTypeColor("${meeting["type"]}"),
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${meeting["title"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor("${meeting["priority"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${meeting["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor("${meeting["priority"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${meeting["type"]} • ${meeting["attendees"].length} attendees",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
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
                                        "${TimeOfDay.fromDateTime(DateTime.parse("${meeting["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${meeting["endTime"]}")).kkmm}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${meeting["location"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
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
                                Icons.info_outline,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              onPressed: () => _showMeetingDetails(meeting),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                ],
              ),
            ),

            // Search and Filters
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QTextField(
                          label: "Search meetings...",
                          value: searchQuery,
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.search,
                        size: bs.sm,
                        onPressed: () {
                          // Perform search
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilters.map((status) => {"label": status, "value": status}).toList(),
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeFilters.map((type) => {"label": type, "value": type}).toList(),
                          value: selectedTypeFilter,
                          onChanged: (value, label) {
                            selectedTypeFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Meeting Statistics
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
                    "Meeting Overview",
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${meetings.where((m) => m["status"] == "Confirmed" || m["status"] == "Scheduled").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Confirmed",
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
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${meetings.where((m) => m["priority"] == "Critical").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Critical",
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
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${meetings.where((m) => m["type"] == "Client Meeting").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Client Meetings",
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

            // All Meetings List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Row(
                      children: [
                        Text(
                          "All Meetings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        QButton(
                          label: "Schedule New",
                          icon: Icons.add,
                          size: bs.sm,
                          onPressed: _showScheduleForm,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: disabledOutlineBorderColor),
                  ...filteredMeetings.map((meeting) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: disabledOutlineBorderColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () => _showMeetingDetails(meeting),
                        child: Row(
                          children: [
                            // Meeting Type Icon
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _getTypeColor("${meeting["type"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                meeting["type"] == "Client Meeting" ? Icons.person :
                                meeting["type"] == "Team Meeting" ? Icons.group :
                                meeting["type"] == "Case Discussion" ? Icons.gavel :
                                meeting["type"] == "Settlement Meeting" ? Icons.handshake :
                                Icons.meeting_room,
                                color: _getTypeColor("${meeting["type"]}"),
                                size: 24,
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Meeting Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${meeting["title"]}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor("${meeting["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${meeting["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${meeting["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${meeting["type"]} • ${meeting["attendees"].length} attendees",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
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
                                        "${DateTime.parse("${meeting["date"]}").dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse("${meeting["date"]}")).kkmm}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${meeting["organizer"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spXs,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getPriorityColor("${meeting["priority"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${meeting["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor("${meeting["priority"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Arrow Icon
                            Icon(
                              Icons.chevron_right,
                              color: disabledColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
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
                          label: "Schedule Meeting",
                          icon: Icons.add_circle_outline,
                          size: bs.sm,
                          onPressed: _showScheduleForm,
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Join Video Call",
                          icon: Icons.videocam,
                          size: bs.sm,
                          onPressed: () {
                            // Join video call
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
