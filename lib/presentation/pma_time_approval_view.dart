import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTimeApprovalView extends StatefulWidget {
  const PmaTimeApprovalView({super.key});

  @override
  State<PmaTimeApprovalView> createState() => _PmaTimeApprovalViewState();
}

class _PmaTimeApprovalViewState extends State<PmaTimeApprovalView> {
  String selectedStatus = "Pending Approval";
  String selectedEmployee = "All Employees";
  String selectedPeriod = "This Week";
  
  List<Map<String, dynamic>> statusOptions = [
    {"label": "Pending Approval", "value": "Pending Approval"},
    {"label": "All Status", "value": "All Status"},
    {"label": "Approved", "value": "Approved"},
    {"label": "Rejected", "value": "Rejected"},
    {"label": "Draft", "value": "Draft"},
  ];
  
  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "All Employees"},
    {"label": "Alex Johnson", "value": "Alex Johnson"},
    {"label": "Sarah Chen", "value": "Sarah Chen"},
    {"label": "Mike Rodriguez", "value": "Mike Rodriguez"},
    {"label": "Emily Davis", "value": "Emily Davis"},
    {"label": "James Wilson", "value": "James Wilson"},
  ];
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "Last Week", "value": "Last Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
  ];
  
  List<Map<String, dynamic>> timeEntries = [
    {
      "id": 1,
      "employee": "Alex Johnson",
      "role": "Senior Developer",
      "avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "project": "E-commerce Platform",
      "task": "Frontend Development",
      "date": "2025-06-19",
      "startTime": "09:00",
      "endTime": "12:30",
      "duration": 3.5,
      "description": "Implemented product listing page with advanced filters and pagination. Added responsive design for mobile devices.",
      "billable": true,
      "status": "pending",
      "submittedDate": "2025-06-19T17:30:00",
      "hourlyRate": 85.0,
      "totalAmount": 297.5,
      "clientName": "TechCorp Inc.",
      "priority": "normal"
    },
    {
      "id": 2,
      "employee": "Sarah Chen",
      "role": "UX Designer",
      "avatar": "https://picsum.photos/50/50?random=2&keyword=woman",
      "project": "Mobile App Redesign",
      "task": "UI/UX Design",
      "date": "2025-06-19",
      "startTime": "13:30",
      "endTime": "16:00",
      "duration": 2.5,
      "description": "Created wireframes and mockups for the new user profile screen. Conducted user research interviews with 5 participants.",
      "billable": true,
      "status": "pending",
      "submittedDate": "2025-06-19T16:15:00",
      "hourlyRate": 75.0,
      "totalAmount": 187.5,
      "clientName": "StartupX",
      "priority": "high"
    },
    {
      "id": 3,
      "employee": "Mike Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/50/50?random=3&keyword=man",
      "project": "Website Redesign",
      "task": "Client Meeting",
      "date": "2025-06-19",
      "startTime": "15:30",
      "endTime": "17:00",
      "duration": 1.5,
      "description": "Discussed project requirements, timeline, and budget with client stakeholders. Reviewed project scope and deliverables.",
      "billable": false,
      "status": "pending",
      "submittedDate": "2025-06-19T17:30:00",
      "hourlyRate": 95.0,
      "totalAmount": 0.0,
      "clientName": "GlobalTech",
      "priority": "normal"
    },
    {
      "id": 4,
      "employee": "Emily Davis",
      "role": "Marketing Specialist",
      "avatar": "https://picsum.photos/50/50?random=4&keyword=girl",
      "project": "Marketing Campaign Q3",
      "task": "Content Creation",
      "date": "2025-06-18",
      "startTime": "10:00",
      "endTime": "13:00",
      "duration": 3.0,
      "description": "Created social media content for the upcoming product launch. Wrote blog post and prepared marketing materials.",
      "billable": true,
      "status": "approved",
      "submittedDate": "2025-06-18T13:30:00",
      "approvedDate": "2025-06-18T15:00:00",
      "approvedBy": "John Manager",
      "hourlyRate": 65.0,
      "totalAmount": 195.0,
      "clientName": "BrandCorp",
      "priority": "normal"
    },
    {
      "id": 5,
      "employee": "James Wilson",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/50/50?random=5&keyword=person",
      "project": "API Integration",
      "task": "Backend Development",
      "date": "2025-06-18",
      "startTime": "14:00",
      "endTime": "17:30",
      "duration": 3.5,
      "description": "Implemented user authentication system and API endpoints. Added input validation and error handling.",
      "billable": true,
      "status": "rejected",
      "submittedDate": "2025-06-18T17:45:00",
      "rejectedDate": "2025-06-19T09:00:00",
      "rejectedBy": "Sarah Manager",
      "rejectionReason": "Description lacks technical details. Please provide more specific information about the implemented features.",
      "hourlyRate": 80.0,
      "totalAmount": 280.0,
      "clientName": "DevCorp",
      "priority": "high"
    }
  ];

  List<Map<String, dynamic>> get filteredEntries {
    return timeEntries.where((entry) {
      bool matchStatus = selectedStatus == "All Status" || 
                        (selectedStatus == "Pending Approval" && entry["status"] == "pending") ||
                        entry["status"] == selectedStatus.toLowerCase();
      bool matchEmployee = selectedEmployee == "All Employees" || entry["employee"] == selectedEmployee;
      return matchStatus && matchEmployee;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Approval"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
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
            _buildApprovalQueue(),
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
          Row(
            children: [
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
              SizedBox(width: spSm),
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
            ],
          ),
          QDropdownField(
            label: "Period",
            items: periodOptions,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    int pendingCount = timeEntries.where((e) => e["status"] == "pending").length;
    int approvedCount = timeEntries.where((e) => e["status"] == "approved").length;
    int rejectedCount = timeEntries.where((e) => e["status"] == "rejected").length;
    double totalPendingAmount = timeEntries
        .where((e) => e["status"] == "pending" && e["billable"] == true)
        .fold(0.0, (sum, e) => sum + (e["totalAmount"] as double));

    return Row(
      children: [
        Expanded(
          child: _buildSummaryCard(
            "Pending",
            "$pendingCount",
            Icons.pending,
            warningColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Approved",
            "$approvedCount",
            Icons.check_circle,
            successColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Rejected",
            "$rejectedCount",
            Icons.cancel,
            dangerColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: _buildSummaryCard(
            "Pending Value",
            "\$${totalPendingAmount.toStringAsFixed(0)}",
            Icons.attach_money,
            primaryColor,
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

  Widget _buildApprovalQueue() {
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Time Entries",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ),
                if (filteredEntries.where((e) => e["status"] == "pending").isNotEmpty)
                  Row(
                    children: [
                      QButton(
                        label: "Approve All",
                        color: successColor,
                        size: bs.sm,
                        onPressed: _approveAll,
                      ),
                      SizedBox(width: spXs),
                      QButton(
                        label: "Reject All",
                        color: dangerColor,
                        size: bs.sm,
                        onPressed: _rejectAll,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          ...filteredEntries.map((entry) => _buildTimeEntryItem(entry)).toList(),
        ],
      ),
    );
  }

  Widget _buildTimeEntryItem(Map<String, dynamic> entry) {
    Color statusColor = _getStatusColor(entry["status"]);
    String statusLabel = _getStatusLabel(entry["status"]);
    Color priorityColor = entry["priority"] == "high" ? dangerColor : 
                         entry["priority"] == "normal" ? primaryColor : successColor;

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
                    image: NetworkImage("${entry["avatar"]}"),
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
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${entry["employee"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${entry["priority"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: priorityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${entry["role"]}",
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
                    "${(entry["duration"] as double).toStringAsFixed(1)}h",
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${entry["project"]} • ${entry["task"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    if (entry["billable"] == true)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 1),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "BILLABLE",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${entry["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Icon(
                      Icons.access_time,
                      size: 12,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${entry["startTime"]} - ${entry["endTime"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (entry["billable"] == true) ...[
                      Spacer(),
                      Text(
                        "\$${((entry["hourlyRate"] as double) * (entry["duration"] as double)).toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  "${entry["description"]}",
                  style: TextStyle(
                    fontSize: 13,
                    color: primaryColor,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          
          if (entry["rejectionReason"] != null)
            Container(
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Rejected: ${entry["rejectionReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          if (entry["status"] == "pending")
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Client: ${entry["clientName"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Submitted: ${DateTime.parse(entry["submittedDate"]).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    QButton(
                      label: "Approve",
                      color: successColor,
                      size: bs.sm,
                      onPressed: () => _approveEntry(entry),
                    ),
                    SizedBox(width: spXs),
                    QButton(
                      label: "Reject",
                      color: dangerColor,
                      size: bs.sm,
                      onPressed: () => _rejectEntry(entry),
                    ),
                  ],
                ),
              ],
            ),
          
          if (entry["status"] == "approved")
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Approved by ${entry["approvedBy"]} on ${DateTime.parse(entry["approvedDate"]).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (entry["billable"] == true)
                  Text(
                    "Amount: \$${(entry["totalAmount"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
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
      case "pending":
        return "PENDING";
      case "approved":
        return "APPROVED";
      case "rejected":
        return "REJECTED";
      default:
        return "UNKNOWN";
    }
  }

  void _approveEntry(Map<String, dynamic> entry) async {
    bool isConfirmed = await confirm("Approve this time entry?");
    if (isConfirmed) {
      ss("Time entry approved successfully");
      // Update entry status logic here
    }
  }

  void _rejectEntry(Map<String, dynamic> entry) async {
    bool isConfirmed = await confirm("Reject this time entry?");
    if (isConfirmed) {
      se("Time entry rejected");
      // Show rejection reason dialog and update entry status logic here
    }
  }

  void _approveAll() async {
    List<Map<String, dynamic>> pendingEntries = filteredEntries.where((e) => e["status"] == "pending").toList();
    if (pendingEntries.isEmpty) {
      si("No pending entries to approve");
      return;
    }
    
    bool isConfirmed = await confirm("Approve all ${pendingEntries.length} pending time entries?");
    if (isConfirmed) {
      ss("All pending entries approved successfully");
      // Bulk approve logic here
    }
  }

  void _rejectAll() async {
    List<Map<String, dynamic>> pendingEntries = filteredEntries.where((e) => e["status"] == "pending").toList();
    if (pendingEntries.isEmpty) {
      si("No pending entries to reject");
      return;
    }
    
    bool isConfirmed = await confirm("Reject all ${pendingEntries.length} pending time entries?");
    if (isConfirmed) {
      sw("All pending entries rejected");
      // Bulk reject logic here
    }
  }
}
