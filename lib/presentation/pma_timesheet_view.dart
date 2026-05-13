import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTimesheetView extends StatefulWidget {
  const PmaTimesheetView({super.key});

  @override
  State<PmaTimesheetView> createState() => _PmaTimesheetViewState();
}

class _PmaTimesheetViewState extends State<PmaTimesheetView> {
  String selectedWeek = "June 17 - June 23, 2025";
  String selectedEmployee = "All Employees";
  String selectedStatus = "All Status";
  
  List<Map<String, dynamic>> weekOptions = [
    {"label": "June 17 - June 23, 2025", "value": "June 17 - June 23, 2025"},
    {"label": "June 10 - June 16, 2025", "value": "June 10 - June 16, 2025"},
    {"label": "June 3 - June 9, 2025", "value": "June 3 - June 9, 2025"},
    {"label": "May 27 - June 2, 2025", "value": "May 27 - June 2, 2025"},
  ];
  
  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "All Employees"},
    {"label": "Alex Johnson", "value": "Alex Johnson"},
    {"label": "Sarah Chen", "value": "Sarah Chen"},
    {"label": "Mike Rodriguez", "value": "Mike Rodriguez"},
    {"label": "Emily Davis", "value": "Emily Davis"},
  ];
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "All Status"},
    {"label": "Draft", "value": "Draft"},
    {"label": "Submitted", "value": "Submitted"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
  ];
  
  List<Map<String, dynamic>> timesheets = [
    {
      "id": 1,
      "employee": "Alex Johnson",
      "role": "Senior Developer",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "weekPeriod": "June 17 - June 23, 2025",
      "totalHours": 42.5,
      "billableHours": 38.0,
      "overtimeHours": 2.5,
      "status": "submitted",
      "submittedDate": "2025-06-23",
      "dailyHours": {
        "Monday": 8.5,
        "Tuesday": 8.0,
        "Wednesday": 9.0,
        "Thursday": 8.5,
        "Friday": 8.5,
        "Saturday": 0.0,
        "Sunday": 0.0
      },
      "projects": [
        {"name": "E-commerce Platform", "hours": 28.0, "billable": true},
        {"name": "Mobile App", "hours": 10.0, "billable": true},
        {"name": "Internal Meeting", "hours": 4.5, "billable": false},
      ]
    },
    {
      "id": 2,
      "employee": "Sarah Chen",
      "role": "UX Designer",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=woman",
      "weekPeriod": "June 17 - June 23, 2025",
      "totalHours": 40.0,
      "billableHours": 40.0,
      "overtimeHours": 0.0,
      "status": "approved",
      "submittedDate": "2025-06-22",
      "approvedDate": "2025-06-23",
      "dailyHours": {
        "Monday": 8.0,
        "Tuesday": 8.0,
        "Wednesday": 8.0,
        "Thursday": 8.0,
        "Friday": 8.0,
        "Saturday": 0.0,
        "Sunday": 0.0
      },
      "projects": [
        {"name": "Design System", "hours": 25.0, "billable": true},
        {"name": "User Research", "hours": 15.0, "billable": true},
      ]
    },
    {
      "id": 3,
      "employee": "Mike Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "weekPeriod": "June 17 - June 23, 2025",
      "totalHours": 45.0,
      "billableHours": 35.0,
      "overtimeHours": 5.0,
      "status": "draft",
      "submittedDate": null,
      "dailyHours": {
        "Monday": 9.0,
        "Tuesday": 9.0,
        "Wednesday": 9.0,
        "Thursday": 9.0,
        "Friday": 9.0,
        "Saturday": 0.0,
        "Sunday": 0.0
      },
      "projects": [
        {"name": "Project Planning", "hours": 20.0, "billable": true},
        {"name": "Client Meetings", "hours": 15.0, "billable": true},
        {"name": "Team Management", "hours": 10.0, "billable": false},
      ]
    },
    {
      "id": 4,
      "employee": "Emily Davis",
      "role": "Marketing Specialist",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=girl",
      "weekPeriod": "June 17 - June 23, 2025",
      "totalHours": 38.0,
      "billableHours": 38.0,
      "overtimeHours": 0.0,
      "status": "rejected",
      "submittedDate": "2025-06-22",
      "rejectedDate": "2025-06-23",
      "rejectionReason": "Missing project details for Friday entries",
      "dailyHours": {
        "Monday": 7.5,
        "Tuesday": 8.0,
        "Wednesday": 8.0,
        "Thursday": 7.5,
        "Friday": 7.0,
        "Saturday": 0.0,
        "Sunday": 0.0
      },
      "projects": [
        {"name": "Marketing Campaign", "hours": 25.0, "billable": true},
        {"name": "Content Creation", "hours": 13.0, "billable": true},
      ]
    }
  ];
  
  List<String> weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  List<Map<String, dynamic>> get filteredTimesheets {
    return timesheets.where((timesheet) {
      bool matchEmployee = selectedEmployee == "All Employees" || timesheet["employee"] == selectedEmployee;
      bool matchStatus = selectedStatus == "All Status" || timesheet["status"] == selectedStatus;
      return matchEmployee && matchStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Timesheets"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            _buildFilters(),
            _buildSummaryCards(),
            _buildTimesheetsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QDropdownField(
            label: "Week Period",
            items: weekOptions,
            value: selectedWeek,
            onChanged: (value, label) {
              selectedWeek = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Employee",
                  items: employeeOptions,
                  value: selectedEmployee,
                  onChanged: (value, label) {
                    selectedEmployee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusOptions,
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
    );
  }

  Widget _buildSummaryCards() {
    double totalHours = filteredTimesheets.fold(0.0, (sum, ts) => sum + (ts["totalHours"] as double));
    double billableHours = filteredTimesheets.fold(0.0, (sum, ts) => sum + (ts["billableHours"] as double));
    double overtimeHours = filteredTimesheets.fold(0.0, (sum, ts) => sum + (ts["overtimeHours"] as double));
    int pendingCount = filteredTimesheets.where((ts) => ts["status"] == "submitted").length;

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            "Total Hours",
            "${totalHours.toStringAsFixed(0)}h",
            Icons.access_time,
            primaryColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Billable",
            "${billableHours.toStringAsFixed(0)}h",
            Icons.attach_money,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Overtime",
            "${overtimeHours.toStringAsFixed(0)}h",
            Icons.schedule,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Pending",
            "$pendingCount",
            Icons.pending,
            dangerColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimesheetsList() {
    return Container(
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
            child: Text(
              "Timesheet Entries",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          ...filteredTimesheets.map((timesheet) => _buildTimesheetItem(timesheet)).toList(),
        ],
      ),
    );
  }

  Widget _buildTimesheetItem(Map<String, dynamic> timesheet) {
    Color statusColor = _getStatusColor(timesheet["status"]);
    String statusLabel = _getStatusLabel(timesheet["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 4,
            color: statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusLg),
                  image: DecorationImage(
                    image: NetworkImage("${timesheet["avatar"]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${timesheet["employee"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${timesheet["role"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: spXs,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
                  Text(
                    "${(timesheet["totalHours"] as double).toStringAsFixed(1)}h",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Weekly hours breakdown
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: disabledColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "Daily Hours",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: weekDays.map((day) {
                    double hours = (timesheet["dailyHours"] as Map)[day] ?? 0.0;
                    return Expanded(
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            day.substring(0, 3),
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: hours > 0 ? primaryColor : disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              hours > 0 ? "${hours.toStringAsFixed(1)}" : "0",
                              textAlign: TextAlign.center,
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
                ),
              ],
            ),
          ),
          
          // Project breakdown
          Text(
            "Project Breakdown",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          ...(timesheet["projects"] as List).map((project) {
            return Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: project["billable"] ? successColor : disabledColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${project["name"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                    ),
                  ),
                ),
                Text(
                  "${(project["hours"] as double).toStringAsFixed(1)}h",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            );
          }).toList(),
          
          // Action buttons and additional info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "Billable: ${(timesheet["billableHours"] as double).toStringAsFixed(1)}h",
                      style: TextStyle(
                        fontSize: 12,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if ((timesheet["overtimeHours"] as double) > 0)
                      Text(
                        "Overtime: ${(timesheet["overtimeHours"] as double).toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: 12,
                          color: warningColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (timesheet["rejectionReason"] != null)
                      Text(
                        "Rejected: ${timesheet["rejectionReason"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: dangerColor,
                        ),
                      ),
                  ],
                ),
              ),
              Row(
                children: [
                  if (timesheet["status"] == "draft" || timesheet["status"] == "rejected")
                    QButton(
                      label: "Submit",
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  if (timesheet["status"] == "submitted") ...[
                    QButton(
                      label: "Approve",
                      color: successColor,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      label: "Reject",
                      color: dangerColor,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "draft":
        return disabledBoldColor;
      case "submitted":
        return warningColor;
      case "approved":
        return successColor;
      case "rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case "draft":
        return "DRAFT";
      case "submitted":
        return "SUBMITTED";
      case "approved":
        return "APPROVED";
      case "rejected":
        return "REJECTED";
      default:
        return "UNKNOWN";
    }
  }
}
