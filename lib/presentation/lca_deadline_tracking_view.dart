import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaDeadlineTrackingView extends StatefulWidget {
  const LcaDeadlineTrackingView({super.key});

  @override
  State<LcaDeadlineTrackingView> createState() => _LcaDeadlineTrackingViewState();
}

class _LcaDeadlineTrackingViewState extends State<LcaDeadlineTrackingView> {
  String selectedFilter = "All";
  String selectedPriority = "All";
  String searchQuery = "";

  List<Map<String, dynamic>> deadlines = [
    {
      "id": 1,
      "title": "File Motion to Dismiss",
      "caseNumber": "2024-CV-1234",
      "caseName": "Smith vs. Johnson Corp",
      "deadlineDate": "2024-12-23T17:00:00Z",
      "type": "Filing Deadline",
      "priority": "Critical",
      "status": "Pending",
      "daysRemaining": 4,
      "assignedTo": "Sarah Johnson, Esq.",
      "court": "Superior Court",
      "requirements": ["Motion Brief", "Supporting Evidence", "Certificate of Service"],
      "notes": "Must be filed by 5 PM on December 23rd",
      "remindersSent": 2,
      "completionStatus": 65,
      "relatedDocuments": ["Draft Motion", "Case Law Research"],
    },
    {
      "id": 2,
      "title": "Discovery Response Due",
      "caseNumber": "2024-CR-5678",
      "caseName": "People vs. Anderson",
      "deadlineDate": "2024-12-21T23:59:59Z",
      "type": "Discovery",
      "priority": "High",
      "status": "In Progress",
      "daysRemaining": 2,
      "assignedTo": "Michael Chen, Esq.",
      "court": "Municipal Court",
      "requirements": ["Interrogatory Responses", "Document Production", "Verification"],
      "notes": "Response to prosecution's discovery request",
      "remindersSent": 1,
      "completionStatus": 80,
      "relatedDocuments": ["Client Interview Notes", "Evidence Inventory"],
    },
    {
      "id": 3,
      "title": "Appeal Brief Filing",
      "caseNumber": "2024-APP-7890",
      "caseName": "Tech Innovations vs. Patent Office",
      "deadlineDate": "2024-12-30T17:00:00Z",
      "type": "Appeal",
      "priority": "High",
      "status": "Draft Complete",
      "daysRemaining": 11,
      "assignedTo": "Jennifer Martinez, Esq.",
      "court": "Court of Appeals",
      "requirements": ["Opening Brief", "Record Citations", "Certificate of Compliance"],
      "notes": "Patent application appeal - technical brief required",
      "remindersSent": 0,
      "completionStatus": 90,
      "relatedDocuments": ["Technical Analysis", "Prior Art Search", "Expert Opinion"],
    },
    {
      "id": 4,
      "title": "Witness Disclosure",
      "caseNumber": "2024-PI-3456",
      "caseName": "Martinez vs. City Transit",
      "deadlineDate": "2024-12-25T17:00:00Z",
      "type": "Disclosure",
      "priority": "Medium",
      "status": "Not Started",
      "daysRemaining": 6,
      "assignedTo": "Emily Davis, Esq.",
      "court": "District Court",
      "requirements": ["Witness List", "Expert Witness Reports", "Exhibit List"],
      "notes": "Pre-trial witness and exhibit disclosures",
      "remindersSent": 1,
      "completionStatus": 25,
      "relatedDocuments": ["Witness Interviews", "Medical Records"],
    },
    {
      "id": 5,
      "title": "Settlement Conference Statement",
      "caseNumber": "2024-CV-2468",
      "caseName": "Wilson Construction vs. ABC Corp",
      "deadlineDate": "2024-12-20T12:00:00Z",
      "type": "Conference Prep",
      "priority": "Medium",
      "status": "Overdue",
      "daysRemaining": -1,
      "assignedTo": "David Wilson, Esq.",
      "court": "Commercial Court",
      "requirements": ["Settlement Statement", "Damage Calculations", "Authority Letter"],
      "notes": "Overdue - conference scheduled for December 23rd",
      "remindersSent": 3,
      "completionStatus": 40,
      "relatedDocuments": ["Damage Assessment", "Settlement Analysis"],
    },
    {
      "id": 6,
      "title": "Custody Evaluation Report",
      "caseNumber": "2024-FAM-9012",
      "caseName": "Davis vs. Davis",
      "deadlineDate": "2024-12-27T17:00:00Z",
      "type": "Report",
      "priority": "High",
      "status": "In Review",
      "daysRemaining": 8,
      "assignedTo": "Emily Davis, Esq.",
      "court": "Family Court",
      "requirements": ["Evaluation Report", "Recommendations", "Supporting Documentation"],
      "notes": "Court-ordered custody evaluation completion",
      "remindersSent": 1,
      "completionStatus": 75,
      "relatedDocuments": ["Evaluation Notes", "Home Study Reports"],
    },
  ];

  List<String> filterOptions = ["All", "Pending", "In Progress", "Draft Complete", "Not Started", "Overdue"];
  List<String> priorityOptions = ["All", "Critical", "High", "Medium", "Low"];

  List<Map<String, dynamic>> get filteredDeadlines {
    List<Map<String, dynamic>> filtered = deadlines;

    if (selectedFilter != "All") {
      filtered = filtered.where((deadline) => deadline["status"] == selectedFilter).toList();
    }

    if (selectedPriority != "All") {
      filtered = filtered.where((deadline) => deadline["priority"] == selectedPriority).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((deadline) =>
          "${deadline["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${deadline["caseName"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${deadline["caseNumber"]}".toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  List<Map<String, dynamic>> get urgentDeadlines {
    return deadlines.where((deadline) => 
        (deadline["daysRemaining"] as int) <= 3 || deadline["status"] == "Overdue").toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Draft Complete":
        return successColor;
      case "In Progress":
      case "In Review":
        return infoColor;
      case "Pending":
        return warningColor;
      case "Not Started":
        return disabledColor;
      case "Overdue":
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

  Color _getDaysRemainingColor(int days) {
    if (days < 0) return dangerColor;
    if (days <= 1) return dangerColor;
    if (days <= 3) return warningColor;
    if (days <= 7) return infoColor;
    return successColor;
  }

  void _showDeadlineDetails(Map<String, dynamic> deadline) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("${deadline["title"]}"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: spSm,
            children: [
              // Deadline Info
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: _getDaysRemainingColor(deadline["daysRemaining"] as int).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Deadline Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _getDaysRemainingColor(deadline["daysRemaining"] as int),
                      ),
                    ),
                    Text("Due: ${DateTime.parse("${deadline["deadlineDate"]}").dMMMykkss}"),
                    Text("Days Remaining: ${deadline["daysRemaining"]} days"),
                    Text("Type: ${deadline["type"]}"),
                    Text("Priority: ${deadline["priority"]}"),
                    Text("Status: ${deadline["status"]}"),
                  ],
                ),
              ),

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
                    Text("Case: ${deadline["caseNumber"]}"),
                    Text("Name: ${deadline["caseName"]}"),
                    Text("Court: ${deadline["court"]}"),
                    Text("Assigned to: ${deadline["assignedTo"]}"),
                  ],
                ),
              ),

              // Progress
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
                      "Progress",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text("Completion: "),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: (deadline["completionStatus"] as int) / 100.0,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Text("${deadline["completionStatus"]}%"),
                      ],
                    ),
                    Text("Reminders Sent: ${deadline["remindersSent"]}"),
                  ],
                ),
              ),

              // Requirements
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
                      "Requirements",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    ...(deadline["requirements"] as List).map((req) => Text("• $req")).toList(),
                  ],
                ),
              ),

              // Related Documents
              if (deadline["relatedDocuments"] != null)
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
                        "Related Documents",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      ...(deadline["relatedDocuments"] as List).map((doc) => Text("• $doc")).toList(),
                    ],
                  ),
                ),

              // Notes
              if (deadline["notes"] != null && "${deadline["notes"]}".isNotEmpty)
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
                      Text("${deadline["notes"]}"),
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
            label: "Update Status",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              // Update deadline status
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
        title: Text("Deadline Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add new deadline
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // View reminders
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
            // Urgent Deadlines Alert
            if (urgentDeadlines.isNotEmpty)
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: dangerColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: dangerColor, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: dangerColor,
                          size: 20,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Urgent Deadlines",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${urgentDeadlines.length} urgent",
                          style: TextStyle(
                            fontSize: 12,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                    ...urgentDeadlines.take(3).map((deadline) {
                      return Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(150),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Text(
                                    "${deadline["title"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(
                                    "${deadline["caseName"]}",
                                    style: TextStyle(
                                      fontSize: 11,
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
                                color: _getDaysRemainingColor(deadline["daysRemaining"] as int),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${deadline["daysRemaining"] < 0 ? "OVERDUE" : "${deadline["daysRemaining"]}d"}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                          label: "Search deadlines...",
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
                          items: filterOptions.map((status) => {"label": status, "value": status}).toList(),
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
                          label: "Priority",
                          items: priorityOptions.map((priority) => {"label": priority, "value": priority}).toList(),
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Deadline Statistics
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
                    "Deadline Overview",
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
                                "${urgentDeadlines.length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Urgent",
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
                                "${deadlines.where((d) => d["status"] == "In Progress").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "In Progress",
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
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${deadlines.where((d) => d["status"] == "Draft Complete").length}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Complete",
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

            // Deadlines List
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
                          "All Deadlines",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "${filteredDeadlines.length} deadlines",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: disabledOutlineBorderColor),
                  ...filteredDeadlines.map((deadline) {
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
                        onTap: () => _showDeadlineDetails(deadline),
                        child: Row(
                          children: [
                            // Days Remaining Indicator
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _getDaysRemainingColor(deadline["daysRemaining"] as int).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${deadline["daysRemaining"] < 0 ? "!" : "${deadline["daysRemaining"]}"}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: _getDaysRemainingColor(deadline["daysRemaining"] as int),
                                    ),
                                  ),
                                  Text(
                                    "${deadline["daysRemaining"] < 0 ? "OVER" : "days"}",
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: _getDaysRemainingColor(deadline["daysRemaining"] as int),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Deadline Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: spXs,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${deadline["title"]}",
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
                                          color: _getStatusColor("${deadline["status"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${deadline["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor("${deadline["status"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${deadline["caseNumber"]} • ${deadline["caseName"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule,
                                        size: 12,
                                        color: disabledColor,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Due: ${DateTime.parse("${deadline["deadlineDate"]}").dMMMy}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledColor,
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${deadline["type"]}",
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
                                          "${deadline["assignedTo"]}",
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
                                          color: _getPriorityColor("${deadline["priority"]}").withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${deadline["priority"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getPriorityColor("${deadline["priority"]}"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Progress Bar
                                  Row(
                                    children: [
                                      Expanded(
                                        child: LinearProgressIndicator(
                                          value: (deadline["completionStatus"] as int) / 100.0,
                                          backgroundColor: disabledColor.withAlpha(50),
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                              _getStatusColor("${deadline["status"]}")),
                                          minHeight: 4,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${deadline["completionStatus"]}%",
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
                          label: "Add Deadline",
                          icon: Icons.add_circle_outline,
                          size: bs.sm,
                          onPressed: () {
                            // Add new deadline
                          },
                        ),
                      ),
                      Expanded(
                        child: QButton(
                          label: "Send Reminders",
                          icon: Icons.notification_add,
                          size: bs.sm,
                          onPressed: () {
                            // Send deadline reminders
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
