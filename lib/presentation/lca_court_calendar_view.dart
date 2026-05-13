import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaCourtCalendarView extends StatefulWidget {
  const LcaCourtCalendarView({super.key});

  @override
  State<LcaCourtCalendarView> createState() => _LcaCourtCalendarViewState();
}

class _LcaCourtCalendarViewState extends State<LcaCourtCalendarView> {
  DateTime selectedDate = DateTime.now();
  String selectedCourt = "All Courts";
  String selectedStatus = "All";

  List<Map<String, dynamic>> courtEvents = [
    {
      "id": 1,
      "caseNumber": "2024-CV-1234",
      "caseName": "Smith vs. Johnson Corp",
      "courtName": "Superior Court of California",
      "judge": "Hon. Patricia Williams",
      "courtroom": "Courtroom 5A",
      "date": "2024-12-20T09:00:00Z",
      "endTime": "2024-12-20T11:00:00Z",
      "hearingType": "Motion Hearing",
      "status": "Scheduled",
      "attorney": "Sarah Johnson, Esq.",
      "plaintiff": "John Smith",
      "defendant": "Johnson Corporation",
      "notes": "Motion to dismiss hearing",
      "documents": ["Motion Brief", "Supporting Evidence"],
      "priority": "High",
    },
    {
      "id": 2,
      "caseNumber": "2024-CR-5678",
      "caseName": "People vs. Anderson",
      "courtName": "Municipal Court",
      "judge": "Hon. Robert Chen",
      "courtroom": "Courtroom 2B",
      "date": "2024-12-21T14:00:00Z",
      "endTime": "2024-12-21T16:30:00Z",
      "hearingType": "Trial",
      "status": "Confirmed",
      "attorney": "Michael Chen, Esq.",
      "plaintiff": "State of California",
      "defendant": "Mark Anderson",
      "notes": "Criminal defense trial - Day 3",
      "documents": ["Witness List", "Exhibit List", "Opening Statement"],
      "priority": "Critical",
    },
    {
      "id": 3,
      "caseNumber": "2024-FAM-9012",
      "caseName": "Davis vs. Davis",
      "courtName": "Family Court",
      "judge": "Hon. Lisa Thompson",
      "courtroom": "Courtroom 1C",
      "date": "2024-12-22T10:30:00Z",
      "endTime": "2024-12-22T12:00:00Z",
      "hearingType": "Custody Hearing",
      "status": "Rescheduled",
      "attorney": "Emily Davis, Esq.",
      "plaintiff": "Jennifer Davis",
      "defendant": "Robert Davis",
      "notes": "Child custody modification hearing",
      "documents": ["Custody Evaluation", "Financial Statements"],
      "priority": "Medium",
    },
    {
      "id": 4,
      "caseNumber": "2024-CV-3456",
      "caseName": "Wilson Construction vs. ABC Corp",
      "courtName": "Commercial Court",
      "judge": "Hon. David Park",
      "courtroom": "Courtroom 3A",
      "date": "2024-12-23T13:30:00Z",
      "endTime": "2024-12-23T15:00:00Z",
      "hearingType": "Settlement Conference",
      "status": "Pending",
      "attorney": "David Wilson, Esq.",
      "plaintiff": "Wilson Construction LLC",
      "defendant": "ABC Corporation",
      "notes": "Pre-trial settlement discussion",
      "documents": ["Settlement Proposal", "Damage Assessment"],
      "priority": "Medium",
    },
    {
      "id": 5,
      "caseNumber": "2024-APP-7890",
      "caseName": "Tech Innovations vs. Patent Office",
      "courtName": "Court of Appeals",
      "judge": "Hon. Maria Rodriguez",
      "courtroom": "Appellate Chamber A",
      "date": "2024-12-24T11:00:00Z",
      "endTime": "2024-12-24T12:30:00Z",
      "hearingType": "Appeal Hearing",
      "status": "Scheduled",
      "attorney": "Jennifer Martinez, Esq.",
      "plaintiff": "Tech Innovations Inc.",
      "defendant": "US Patent Office",
      "notes": "Patent application appeal",
      "documents": ["Appeal Brief", "Technical Specifications"],
      "priority": "High",
    },
  ];

  List<String> courtOptions = [
    "All Courts",
    "Superior Court of California",
    "Municipal Court",
    "Family Court",
    "Commercial Court",
    "Court of Appeals"
  ];

  List<String> statusOptions = ["All", "Scheduled", "Confirmed", "Pending", "Rescheduled", "Cancelled"];

  List<Map<String, dynamic>> get filteredEvents {
    List<Map<String, dynamic>> filtered = courtEvents;

    if (selectedCourt != "All Courts") {
      filtered = filtered.where((event) => event["courtName"] == selectedCourt).toList();
    }

    if (selectedStatus != "All") {
      filtered = filtered.where((event) => event["status"] == selectedStatus).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Scheduled":
      case "Confirmed":
        return successColor;
      case "Pending":
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

  String _getHearingTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case "motion hearing":
        return "⚖️";
      case "trial":
        return "🏛️";
      case "custody hearing":
        return "👨‍👩‍👧‍👦";
      case "settlement conference":
        return "🤝";
      case "appeal hearing":
        return "📋";
      default:
        return "📅";
    }
  }

  void _showEventDetails(Map<String, dynamic> event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${event["caseName"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              // Case Information
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
                    Text("Case Number: ${event["caseNumber"]}"),
                    Text("Hearing Type: ${event["hearingType"]}"),
                    Text("Attorney: ${event["attorney"]}"),
                  ],
                ),
              ),

              // Court Details
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
                      "Court Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text("Court: ${event["courtName"]}"),
                    Text("Judge: ${event["judge"]}"),
                    Text("Courtroom: ${event["courtroom"]}"),
                  ],
                ),
              ),

              // Schedule
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
                      "Schedule",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text("Date: ${DateTime.parse("${event["date"]}").dMMMy}"),
                    Text("Time: ${TimeOfDay.fromDateTime(DateTime.parse("${event["date"]}")).kkmm} - ${TimeOfDay.fromDateTime(DateTime.parse("${event["endTime"]}")).kkmm}"),
                    Row(
                      children: [
                        Text("Status: "),
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
                              fontSize: 12,
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
                    Text("Plaintiff: ${event["plaintiff"]}"),
                    Text("Defendant: ${event["defendant"]}"),
                  ],
                ),
              ),

              // Documents
              if (event["documents"] != null && (event["documents"] as List).isNotEmpty)
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(10),
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
                          color: disabledBoldColor,
                        ),
                      ),
                      ...(event["documents"] as List).map((doc) => Text("• $doc")).toList(),
                    ],
                  ),
                ),

              // Notes
              if (event["notes"] != null && "${event["notes"]}".isNotEmpty)
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
                      Text("${event["notes"]}"),
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
            label: "Add to Calendar",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Event added to calendar");
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
        title: Text("Court Calendar"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Go to today's date
              selectedDate = DateTime.now();
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () {
              // Sync court calendar
              ss("Court calendar synchronized");
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
            // Filters Section
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
                        child: QDropdownField(
                          label: "Court",
                          items: courtOptions.map((court) => {"label": court, "value": court}).toList(),
                          value: selectedCourt,
                          onChanged: (value, label) {
                            selectedCourt = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions.map((status) => {"label": status, "value": status}).toList(),
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
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
                    "Court Schedule Overview",
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
                                "${courtEvents.where((e) => e["status"] == "Scheduled" || e["status"] == "Confirmed").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Active Hearings",
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
                                "${courtEvents.where((e) => e["priority"] == "Critical").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Critical Cases",
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

            // Court Events List
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
                          "Upcoming Court Hearings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredEvents.length} hearings",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: disabledOutlineBorderColor),
                  ...filteredEvents.map((event) {
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
                        onTap: () => _showEventDetails(event),
                        child: Row(
                          children: [
                            // Hearing Type Icon
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _getPriorityColor("${event["priority"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  _getHearingTypeIcon("${event["hearingType"]}"),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Event Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${event["caseName"]}",
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
                                  Text(
                                    "${event["caseNumber"]} • ${event["hearingType"]}",
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
                                        "${DateTime.parse("${event["date"]}").dMMMy} at ${TimeOfDay.fromDateTime(DateTime.parse("${event["date"]}")).kkmm}",
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
                                          "${event["courtName"]} - ${event["courtroom"]}",
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
                                      Icon(
                                        Icons.person,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "${event["judge"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      Spacer(),
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
                          label: "Export Schedule",
                          icon: Icons.file_download,
                          size: bs.sm,
                          onPressed: () {
                            // Export court schedule
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
