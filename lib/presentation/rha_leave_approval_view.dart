import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaLeaveApprovalView extends StatefulWidget {
  const RhaLeaveApprovalView({super.key});

  @override
  State<RhaLeaveApprovalView> createState() => _RhaLeaveApprovalViewState();
}

class _RhaLeaveApprovalViewState extends State<RhaLeaveApprovalView> {
  int currentTab = 0;
  String selectedStatus = "Pending";
  String selectedDepartment = "All";
  String selectedPriority = "All";
  String searchQuery = "";
  List<String> selectedRequests = [];

  List<Map<String, dynamic>> pendingRequests = [
    {
      "id": "LR001",
      "employee": "Sarah Johnson",
      "position": "Software Engineer",
      "department": "Engineering",
      "leaveType": "Annual Leave",
      "startDate": "2024-07-15",
      "endDate": "2024-07-19",
      "days": 5,
      "reason": "Family vacation to Europe",
      "appliedDate": "2024-06-25",
      "urgency": "Normal",
      "coverage": "Mike Wilson",
      "projectImpact": "Low",
      "managerNotes": "",
      "remainingBalance": 16,
      "attachments": ["flight_booking.pdf"],
      "priority": "Medium"
    },
    {
      "id": "LR002",
      "employee": "Michael Chen",
      "position": "Marketing Manager",
      "department": "Marketing",
      "leaveType": "Sick Leave",
      "startDate": "2024-07-01",
      "endDate": "2024-07-03",
      "days": 3,
      "reason": "Medical procedure - surgery",
      "appliedDate": "2024-06-28",
      "urgency": "Urgent",
      "coverage": "David Park",
      "projectImpact": "Medium",
      "managerNotes": "",
      "remainingBalance": 7,
      "attachments": ["medical_certificate.pdf"],
      "priority": "High"
    },
    {
      "id": "LR003",
      "employee": "Emily Rodriguez",
      "position": "UX Designer",
      "department": "Design",
      "leaveType": "Personal Leave",
      "startDate": "2024-07-08",
      "endDate": "2024-07-08",
      "days": 1,
      "reason": "Personal appointment - legal matter",
      "appliedDate": "2024-07-05",
      "urgency": "Normal",
      "coverage": "Tom Brown",
      "projectImpact": "Low",
      "managerNotes": "",
      "remainingBalance": 4,
      "attachments": [],
      "priority": "Low"
    },
    {
      "id": "LR004",
      "employee": "James Wilson",
      "position": "Sales Representative",
      "department": "Sales",
      "leaveType": "Annual Leave",
      "startDate": "2024-08-01",
      "endDate": "2024-08-15",
      "days": 11,
      "reason": "Summer vacation with family",
      "appliedDate": "2024-06-20",
      "urgency": "Normal",
      "coverage": "Alex Thompson",
      "projectImpact": "High",
      "managerNotes": "Major client presentation scheduled during this period",
      "remainingBalance": 10,
      "attachments": ["vacation_plan.pdf"],
      "priority": "High"
    },
    {
      "id": "LR005",
      "employee": "Lisa Wong",
      "position": "HR Specialist",
      "department": "HR",
      "leaveType": "Maternity Leave",
      "startDate": "2024-08-15",
      "endDate": "2024-11-15",
      "days": 90,
      "reason": "Maternity leave for newborn care",
      "appliedDate": "2024-06-01",
      "urgency": "Planned",
      "coverage": "Anna Kim",
      "projectImpact": "High",
      "managerNotes": "Need to arrange long-term coverage",
      "remainingBalance": 90,
      "attachments": ["maternity_certificate.pdf"],
      "priority": "High"
    }
  ];

  List<Map<String, dynamic>> approvalHistory = [
    {
      "id": "LR101",
      "employee": "David Park",
      "department": "Marketing",
      "leaveType": "Annual Leave",
      "days": 3,
      "status": "Approved",
      "approvedDate": "2024-06-20",
      "approvedBy": "John Smith",
      "reason": "Weekend getaway"
    },
    {
      "id": "LR102",
      "employee": "Tom Brown",
      "department": "Design",
      "leaveType": "Sick Leave",
      "days": 2,
      "status": "Approved",
      "approvedDate": "2024-06-18",
      "approvedBy": "John Smith",
      "reason": "Flu symptoms"
    },
    {
      "id": "LR103",
      "employee": "Anna Kim",
      "department": "HR",
      "leaveType": "Personal Leave",
      "days": 1,
      "status": "Rejected",
      "approvedDate": "2024-06-15",
      "approvedBy": "John Smith",
      "reason": "Insufficient notice period"
    }
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "Pending", "value": "Pending"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "All", "value": "All"}
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Design", "value": "Design"},
    {"label": "Sales", "value": "Sales"},
    {"label": "HR", "value": "HR"}
  ];

  List<Map<String, dynamic>> priorityItems = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Rejected":
        return dangerColor;
      case "Under Review":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case "Urgent":
        return dangerColor;
      case "Normal":
        return primaryColor;
      case "Planned":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _approveRequest(Map<String, dynamic> request) {
    ss("Approved leave request for ${request["employee"]}");
    // Remove from pending list
    pendingRequests.removeWhere((r) => r["id"] == request["id"]);
    setState(() {});
  }

  void _rejectRequest(Map<String, dynamic> request) {
    se("Rejected leave request for ${request["employee"]}");
    // Remove from pending list
    pendingRequests.removeWhere((r) => r["id"] == request["id"]);
    setState(() {});
  }

  void _bulkApprove() {
    if (selectedRequests.isEmpty) {
      sw("Please select requests to approve");
      return;
    }
    ss("Approved ${selectedRequests.length} leave requests");
    pendingRequests.removeWhere((r) => selectedRequests.contains(r["id"]));
    selectedRequests.clear();
    setState(() {});
  }

  Widget _buildPendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.pending_actions,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pending Approval",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${pendingRequests.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.priority_high,
                            color: dangerColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Urgent Requests",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${pendingRequests.where((r) => r["urgency"] == "Urgent").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: infoColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Days",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${pendingRequests.fold(0, (sum, r) => sum + (r["days"] as int))}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Search and Bulk Actions
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QTextField(
                  label: "Search employees",
                  value: searchQuery,
                  hint: "Enter employee name",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              QButton(
                label: "Bulk Approve",
                size: bs.sm,
                onPressed: _bulkApprove,
              ),
            ],
          ),

          // Pending Requests List
          ...pendingRequests.map((request) => Container(
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: selectedRequests.contains(request["id"])
                  ? Border.all(color: primaryColor, width: 2)
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                // Header with Selection
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (selectedRequests.contains(request["id"])) {
                          selectedRequests.remove(request["id"]);
                        } else {
                          selectedRequests.add("${request["id"]}");
                        }
                        setState(() {});
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: selectedRequests.contains(request["id"])
                              ? primaryColor
                              : Colors.transparent,
                          border: Border.all(
                            color: selectedRequests.contains(request["id"])
                                ? primaryColor
                                : disabledBoldColor,
                          ),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: selectedRequests.contains(request["id"])
                            ? Icon(Icons.check, color: Colors.white, size: 16)
                            : null,
                      ),
                    ),
                    SizedBox(width: spSm),
                    CircleAvatar(
                      backgroundColor: _getPriorityColor("${request["priority"]}").withAlpha(20),
                      child: Text(
                        "${request["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getPriorityColor("${request["priority"]}"),
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${request["employee"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getUrgencyColor("${request["urgency"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${request["urgency"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getUrgencyColor("${request["urgency"]}"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${request["position"]} • ${request["department"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Leave Details
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor.withAlpha(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${request["leaveType"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${request["days"]} day${(request["days"] as int) > 1 ? 's' : ''}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Text(
                            "${DateTime.parse("${request["startDate"]}").dMMMy} - ${DateTime.parse("${request["endDate"]}").dMMMy}",
                            style: TextStyle(fontSize: 14, color: disabledBoldColor),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.notes, size: 16, color: disabledBoldColor),
                          SizedBox(width: spXs),
                          Expanded(
                            child: Text(
                              "${request["reason"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Impact Assessment
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Coverage: ${request["coverage"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.assessment, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Impact: ",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getImpactColor("${request["projectImpact"]}").withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${request["projectImpact"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getImpactColor("${request["projectImpact"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.account_balance_wallet, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Remaining: ${request["remainingBalance"]} days",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Applied: ${DateTime.parse("${request["appliedDate"]}").dMMMy}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Manager Notes
                if (request["managerNotes"] != null && "${request["managerNotes"]}".isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: warningColor.withAlpha(30)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning, size: 16, color: warningColor),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            "Note: ${request["managerNotes"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: warningColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Attachments
                if ((request["attachments"] as List).isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Attachments:",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Wrap(
                        spacing: spXs,
                        children: (request["attachments"] as List).map((attachment) => Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(30)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.attach_file, size: 14, color: infoColor),
                              SizedBox(width: spXs),
                              Text(
                                "$attachment",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                    ],
                  ),

                // Action Buttons
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Approve",
                        size: bs.sm,
                        onPressed: () => _approveRequest(request),
                      ),
                    ),
                    QButton(
                      label: "Reject",
                      size: bs.sm,
                      onPressed: () => _rejectRequest(request),
                    ),
                    QButton(
                      icon: Icons.more_vert,
                      size: bs.sm,
                      onPressed: () {
                        ss("View more details for ${request["employee"]}");
                      },
                    ),
                  ],
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Summary Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: successColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Approved Today",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${approvalHistory.where((h) => h["status"] == "Approved").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.cancel,
                            color: dangerColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Rejected",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${approvalHistory.where((h) => h["status"] == "Rejected").length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
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
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.assessment,
                            color: primaryColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Processed",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${approvalHistory.length}",
                                style: TextStyle(
                                  fontSize: fsH4,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Approval History
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Recent Approval History",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...approvalHistory.map((history) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: _getStatusColor("${history["status"]}").withAlpha(20),
                        child: Icon(
                          history["status"] == "Approved" ? Icons.check : Icons.close,
                          color: _getStatusColor("${history["status"]}"),
                          size: 16,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${history["employee"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor("${history["status"]}").withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${history["status"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: _getStatusColor("${history["status"]}"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${history["department"]} • ${history["leaveType"]} • ${history["days"]} days",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "Processed on ${DateTime.parse("${history["approvedDate"]}").dMMMy}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Leave Approval",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Pending", icon: Icon(Icons.pending_actions)),
        Tab(text: "History", icon: Icon(Icons.history)),
      ],
      tabChildren: [
        _buildPendingTab(),
        _buildHistoryTab(),
      ],
    );
  }
}
