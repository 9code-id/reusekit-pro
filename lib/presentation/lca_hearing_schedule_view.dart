import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaHearingScheduleView extends StatefulWidget {
  const LcaHearingScheduleView({super.key});

  @override
  State<LcaHearingScheduleView> createState() => _LcaHearingScheduleViewState();
}

class _LcaHearingScheduleViewState extends State<LcaHearingScheduleView> {
  String selectedTimeFilter = "This Week";
  String selectedStatusFilter = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> hearings = [
    {
      "id": 1,
      "caseNumber": "2024-CV-1234",
      "caseName": "Smith vs. Johnson Corp",
      "hearingType": "Motion to Dismiss",
      "date": "2024-12-20T09:00:00Z",
      "endTime": "2024-12-20T11:00:00Z",
      "courtName": "Superior Court",
      "courtroom": "Room 5A",
      "judge": "Hon. Patricia Williams",
      "attorney": "Sarah Johnson, Esq.",
      "status": "Scheduled",
      "priority": "High",
      "client": "John Smith",
      "opposing": "Johnson Corporation",
      "preparationStatus": "In Progress",
      "documentsReady": true,
      "witnessesConfirmed": false,
      "estimatedDuration": "2 hours",
      "notes": "Motion hearing regarding contract dispute",
      "reminders": [
        {"time": 60, "sent": false},
        {"time": 30, "sent": false},
        {"time": 15, "sent": false}
      ],
    },
    {
      "id": 2,
      "caseNumber": "2024-CR-5678",
      "caseName": "People vs. Anderson",
      "hearingType": "Criminal Trial",
      "date": "2024-12-21T10:30:00Z",
      "endTime": "2024-12-21T16:00:00Z",
      "courtName": "Municipal Court",
      "courtroom": "Room 2B",
      "judge": "Hon. Robert Chen",
      "attorney": "Michael Chen, Esq.",
      "status": "Confirmed",
      "priority": "Critical",
      "client": "Mark Anderson",
      "opposing": "State of California",
      "preparationStatus": "Complete",
      "documentsReady": true,
      "witnessesConfirmed": true,
      "estimatedDuration": "5.5 hours",
      "notes": "Day 3 of criminal defense trial",
      "reminders": [
        {"time": 120, "sent": false},
        {"time": 60, "sent": false},
        {"time": 30, "sent": false}
      ],
    },
    {
      "id": 3,
      "caseNumber": "2024-FAM-9012",
      "caseName": "Davis vs. Davis",
      "hearingType": "Custody Hearing",
      "date": "2024-12-22T14:00:00Z",
      "endTime": "2024-12-22T15:30:00Z",
      "courtName": "Family Court",
      "courtroom": "Room 1C",
      "judge": "Hon. Lisa Thompson",
      "attorney": "Emily Davis, Esq.",
      "status": "Rescheduled",
      "priority": "Medium",
      "client": "Jennifer Davis",
      "opposing": "Robert Davis",
      "preparationStatus": "Needs Review",
      "documentsReady": false,
      "witnessesConfirmed": false,
      "estimatedDuration": "1.5 hours",
      "notes": "Child custody modification - rescheduled from Dec 19",
      "reminders": [
        {"time": 60, "sent": false},
        {"time": 30, "sent": false}
      ],
    },
    {
      "id": 4,
      "caseNumber": "2024-CV-3456",
      "caseName": "Wilson Construction vs. ABC Corp",
      "hearingType": "Settlement Conference",
      "date": "2024-12-23T11:00:00Z",
      "endTime": "2024-12-23T13:00:00Z",
      "courtName": "Commercial Court",
      "courtroom": "Room 3A",
      "judge": "Hon. David Park",
      "attorney": "David Wilson, Esq.",
      "status": "Tentative",
      "priority": "Medium",
      "client": "Wilson Construction LLC",
      "opposing": "ABC Corporation",
      "preparationStatus": "In Progress",
      "documentsReady": true,
      "witnessesConfirmed": true,
      "estimatedDuration": "2 hours",
      "notes": "Pre-trial settlement conference",
      "reminders": [
        {"time": 60, "sent": false}
      ],
    },
    {
      "id": 5,
      "caseNumber": "2024-PI-7890",
      "caseName": "Martinez vs. City Transit",
      "hearingType": "Deposition",
      "date": "2024-12-24T13:30:00Z",
      "endTime": "2024-12-24T16:30:00Z",
      "courtName": "Law Office Conference Room",
      "courtroom": "Conference Room A",
      "judge": "Court Reporter: Jane Smith",
      "attorney": "Jennifer Martinez, Esq.",
      "status": "Scheduled",
      "priority": "High",
      "client": "Carlos Martinez",
      "opposing": "City Transit Authority",
      "preparationStatus": "Complete",
      "documentsReady": true,
      "witnessesConfirmed": true,
      "estimatedDuration": "3 hours",
      "notes": "Key witness deposition for personal injury case",
      "reminders": [
        {"time": 120, "sent": false},
        {"time": 60, "sent": false}
      ],
    },
  ];

  List<String> timeFilters = ["Today", "This Week", "This Month", "All"];
  List<String> statusFilters = ["All", "Scheduled", "Confirmed", "Tentative", "Rescheduled", "Cancelled"];

  List<Map<String, dynamic>> get filteredHearings {
    List<Map<String, dynamic>> filtered = hearings;

    // Time filter
    DateTime now = DateTime.now();
    if (selectedTimeFilter == "Today") {
      filtered = filtered.where((hearing) {
        DateTime hearingDate = DateTime.parse("${hearing["date"]}");
        return hearingDate.year == now.year &&
               hearingDate.month == now.month &&
               hearingDate.day == now.day;
      }).toList();
    } else if (selectedTimeFilter == "This Week") {
      DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
      DateTime weekEnd = weekStart.add(Duration(days: 6));
      filtered = filtered.where((hearing) {
        DateTime hearingDate = DateTime.parse("${hearing["date"]}");
        return hearingDate.isAfter(weekStart.subtract(Duration(days: 1))) &&
               hearingDate.isBefore(weekEnd.add(Duration(days: 1)));
      }).toList();
    } else if (selectedTimeFilter == "This Month") {
      filtered = filtered.where((hearing) {
        DateTime hearingDate = DateTime.parse("${hearing["date"]}");
        return hearingDate.year == now.year && hearingDate.month == now.month;
      }).toList();
    }

    // Status filter
    if (selectedStatusFilter != "All") {
      filtered = filtered.where((hearing) => hearing["status"] == selectedStatusFilter).toList();
    }

    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((hearing) =>
          "${hearing["caseName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${hearing["caseNumber"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${hearing["client"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
      case "Confirmed":
        return successColor;
      case "Tentative":
        return infoColor;
      case "Rescheduled":
        return warningColor;
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

  Color _getPreparationColor(String status) {
    switch (status) {
      case "Complete":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Needs Review":
        return dangerColor;
      default:
        return disabledColor;
    }
  }

  void _showHearingDetails(Map<String, dynamic> hearing) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${hearing["caseName"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              // Case Info
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Case Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text("Case: ${hearing["caseNumber"]}"),
                    Text("Hearing: ${hearing["hearingType"]}"),
                    Text("Attorney: ${hearing["attorney"]}"),
                    Text("Duration: ${hearing["estimatedDuration"]}"),
                  ],
                ),
              ),

              // Schedule Info
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
                      "Schedule Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text("Date: ${DateTime.parse("${hearing["date"]}").dMMMy}"),
                    Text("Time: ${TimeOfDay.fromDateTime(DateTime.parse("${hearing["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${hearing["endTime"]}")).kkmm}"),
                    Text("Court: ${hearing["courtName"]}"),
                    Text("Courtroom: ${hearing["courtroom"]}"),
                    Text("Judge: ${hearing["judge"]}"),
                  ],
                ),
              ),

              // Parties
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
                      "Parties",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text("Client: ${hearing["client"]}"),
                    Text("Opposing: ${hearing["opposing"]}"),
                  ],
                ),
              ),

              // Preparation Status
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getPreparationColor("${hearing["preparationStatus"]}").withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Preparation Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getPreparationColor("${hearing["preparationStatus"]}"),
                      ),
                    ),
                    Text("Status: ${hearing["preparationStatus"]}"),
                    Text("Documents Ready: ${hearing["documentsReady"] ? "Yes" : "No"}"),
                    Text("Witnesses Confirmed: ${hearing["witnessesConfirmed"] ? "Yes" : "No"}"),
                  ],
                ),
              ),

              // Notes
              if (hearing["notes"] != null && "${hearing["notes"]}".isNotEmpty)
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
                      Text("${hearing["notes"]}"),
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
            label: "Edit Hearing",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              // Edit hearing
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hearing Schedule"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new hearing
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // View calendar
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
                          label: "Search hearings...",
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
                          label: "Time Period",
                          items: timeFilters.map((filter) => {"label": filter, "value": filter}).toList(),
                          value: selectedTimeFilter,
                          onChanged: (value, label) {
                            selectedTimeFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusFilters.map((status) => {"label": status, "value": status}).toList(),
                          value: selectedStatusFilter,
                          onChanged: (value, label) {
                            selectedStatusFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Schedule Overview
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
                    "Schedule Overview",
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
                                "${hearings.where((h) => h["status"] == "Confirmed" || h["status"] == "Scheduled").length}",
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${hearings.where((h) => h["preparationStatus"] == "In Progress").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "In Prep",
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
                                "${hearings.where((h) => h["priority"] == "Critical").length}",
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
                    ],
                  ),
                ],
              ),
            ),

            // Hearings List
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
                          "Upcoming Hearings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredHearings.length} hearings",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: disabledOutlineBorderColor),
                  ...filteredHearings.map((hearing) {
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
                        onTap: () => _showHearingDetails(hearing),
                        child: Row(
                          children: [
                            // Priority and Status Indicator
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _getPriorityColor("${hearing["priority"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateTime.parse("${hearing["date"]}").day}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: _getPriorityColor("${hearing["priority"]}"),
                                    ),
                                  ),
                                  Text(
                                    "${DateTime.parse("${hearing["date"]}").month.toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: _getPriorityColor("${hearing["priority"]}"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Hearing Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${hearing["caseName"]}",
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
                                          color: _getStatusColor("${hearing["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${hearing["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${hearing["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${hearing["caseNumber"]} • ${hearing["hearingType"]}",
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
                                        "${TimeOfDay.fromDateTime(DateTime.parse("${hearing["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${hearing["endTime"]}")).kkmm}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${hearing["estimatedDuration"]}",
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
                                        Icons.location_on,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          "${hearing["courtName"]} - ${hearing["courtroom"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: disabledColor,
                                          ),
                                        ),
                                      ),
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
                                          color: _getPreparationColor("${hearing["preparationStatus"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${hearing["preparationStatus"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPreparationColor("${hearing["preparationStatus"]}"),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      if (hearing["documentsReady"] == true)
                                        Icon(
                                          Icons.check_circle,
                                          size: 12,
                                          color: successColor,
                                        )
                                      else
                                        Icon(
                                          Icons.pending,
                                          size: 12,
                                          color: warningColor,
                                        ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Docs",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      if (hearing["witnessesConfirmed"] == true)
                                        Icon(
                                          Icons.check_circle,
                                          size: 12,
                                          color: successColor,
                                        )
                                      else
                                        Icon(
                                          Icons.pending,
                                          size: 12,
                                          color: warningColor,
                                        ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Witnesses",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledColor,
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
                          label: "Schedule New",
                          icon: Icons.add_circle_outline,
                          size: bs.sm,
                          onPressed: () {
                            // Schedule new hearing
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Set Reminders",
                          icon: Icons.notification_add,
                          size: bs.sm,
                          onPressed: () {
                            // Set hearing reminders
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
