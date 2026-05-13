import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaLeaveManagementView extends StatefulWidget {
  const RhaLeaveManagementView({super.key});

  @override
  State<RhaLeaveManagementView> createState() => _RhaLeaveManagementViewState();
}

class _RhaLeaveManagementViewState extends State<RhaLeaveManagementView> {
  int currentTab = 0;
  String selectedYear = "2024";
  String selectedDepartment = "All";
  String selectedLeaveType = "All";
  bool showPendingOnly = false;

  List<Map<String, dynamic>> leaveTypes = [
    {
      "name": "Annual Leave",
      "code": "AL",
      "entitlement": 21,
      "color": primaryColor,
      "description": "Annual vacation days"
    },
    {
      "name": "Sick Leave",
      "code": "SL",
      "entitlement": 10,
      "color": warningColor,
      "description": "Medical leave days"
    },
    {
      "name": "Personal Leave",
      "code": "PL",
      "entitlement": 5,
      "color": infoColor,
      "description": "Personal emergency days"
    },
    {
      "name": "Maternity/Paternity",
      "code": "MP",
      "entitlement": 90,
      "color": successColor,
      "description": "Parental leave days"
    }
  ];

  List<Map<String, dynamic>> leaveStats = [
    {
      "department": "Engineering",
      "totalEmployees": 45,
      "totalDaysTaken": 892,
      "avgDaysPerEmployee": 19.8,
      "pendingRequests": 8,
      "utilizationRate": 85.2
    },
    {
      "department": "Marketing",
      "totalEmployees": 28,
      "totalDaysTaken": 567,
      "avgDaysPerEmployee": 20.3,
      "pendingRequests": 5,
      "utilizationRate": 87.4
    },
    {
      "department": "Sales",
      "totalEmployees": 32,
      "totalDaysTaken": 623,
      "avgDaysPerEmployee": 19.5,
      "pendingRequests": 6,
      "utilizationRate": 83.9
    },
    {
      "department": "HR",
      "totalEmployees": 12,
      "totalDaysTaken": 234,
      "avgDaysPerEmployee": 19.5,
      "pendingRequests": 2,
      "utilizationRate": 82.1
    }
  ];

  List<Map<String, dynamic>> recentRequests = [
    {
      "id": "LR001",
      "employee": "Sarah Johnson",
      "position": "Software Engineer",
      "department": "Engineering",
      "leaveType": "Annual Leave",
      "startDate": "2024-07-15",
      "endDate": "2024-07-19",
      "days": 5,
      "status": "Pending",
      "reason": "Family vacation",
      "appliedDate": "2024-06-25",
      "manager": "John Smith",
      "coverage": "Mike Wilson"
    },
    {
      "id": "LR002",
      "employee": "Michael Chen",
      "position": "Marketing Manager",
      "department": "Marketing",
      "leaveType": "Sick Leave",
      "startDate": "2024-06-28",
      "endDate": "2024-06-30",
      "days": 3,
      "status": "Approved",
      "reason": "Medical treatment",
      "appliedDate": "2024-06-27",
      "manager": "Lisa Wong",
      "coverage": "David Park"
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
      "status": "Approved",
      "reason": "Personal appointment",
      "appliedDate": "2024-07-05",
      "manager": "Anna Kim",
      "coverage": "Tom Brown"
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
      "status": "Under Review",
      "reason": "Summer vacation",
      "appliedDate": "2024-06-20",
      "manager": "Rachel Green",
      "coverage": "Alex Thompson"
    }
  ];

  List<Map<String, dynamic>> yearItems = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"}
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Design", "value": "Design"},
    {"label": "HR", "value": "HR"}
  ];

  List<Map<String, dynamic>> leaveTypeItems = [
    {"label": "All", "value": "All"},
    {"label": "Annual Leave", "value": "Annual Leave"},
    {"label": "Sick Leave", "value": "Sick Leave"},
    {"label": "Personal Leave", "value": "Personal Leave"},
    {"label": "Maternity/Paternity", "value": "Maternity/Paternity"}
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Under Review":
        return infoColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getLeaveTypeColor(String leaveType) {
    switch (leaveType) {
      case "Annual Leave":
        return primaryColor;
      case "Sick Leave":
        return warningColor;
      case "Personal Leave":
        return infoColor;
      case "Maternity/Paternity":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Widget _buildOverviewTab() {
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
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.pending_actions,
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
                                "Pending Requests",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "21",
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
                                "8",
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
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.calendar_today,
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
                                "On Leave Today",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "15",
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
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.trending_up,
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
                                "Avg Days/Employee",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "19.8",
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

          // Leave Types Overview
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
                  "Leave Types Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: leaveTypes.map((leaveType) => Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: (leaveType["color"] as Color).withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: (leaveType["color"] as Color).withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spSm,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: leaveType["color"] as Color,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${leaveType["code"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${leaveType["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${leaveType["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Entitlement",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${leaveType["entitlement"]} days",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: leaveType["color"] as Color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

          // Department Statistics
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
                  "Department Statistics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...leaveStats.map((stat) => Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${stat["department"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${(stat["utilizationRate"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ResponsiveGridView(
                        padding: EdgeInsets.zero,
                        minItemWidth: 200,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Employees: ${stat["totalEmployees"]}",
                                style: TextStyle(fontSize: 14, color: disabledBoldColor),
                              ),
                              Text(
                                "Days Taken: ${stat["totalDaysTaken"]}",
                                style: TextStyle(fontSize: 14, color: disabledBoldColor),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Avg/Employee: ${(stat["avgDaysPerEmployee"] as num).toStringAsFixed(1)}",
                                style: TextStyle(fontSize: 14, color: disabledBoldColor),
                              ),
                              Text(
                                "Pending: ${stat["pendingRequests"]}",
                                style: TextStyle(fontSize: 14, color: warningColor),
                              ),
                            ],
                          ),
                        ],
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

  Widget _buildRequestsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Year",
                  items: yearItems,
                  value: selectedYear,
                  onChanged: (value, label) {
                    selectedYear = value;
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

          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Leave Type",
                  items: leaveTypeItems,
                  value: selectedLeaveType,
                  onChanged: (value, label) {
                    selectedLeaveType = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QSwitch(
                  items: [
                    {
                      "label": "Pending Only",
                      "value": true,
                      "checked": showPendingOnly,
                    }
                  ],
                  value: [
                    if (showPendingOnly)
                      {
                        "label": "Pending Only",
                        "value": true,
                        "checked": true
                      }
                  ],
                  onChanged: (values, ids) {
                    showPendingOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Quick Actions
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Bulk Approve",
                  icon: Icons.check,
                  onPressed: () {
                    ss("Bulk approve selected requests");
                  },
                ),
              ),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () {
                  ss("Advanced filters clicked");
                },
              ),
            ],
          ),

          // Leave Requests
          ...recentRequests.map((request) => Container(
            padding: EdgeInsets.all(spMd),
            margin: EdgeInsets.only(bottom: spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                // Header
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _getStatusColor("${request["status"]}").withAlpha(20),
                      child: Text(
                        "${request["employee"]}".split(" ").map((e) => e[0]).join("").toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor("${request["status"]}"),
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
                                  color: _getStatusColor("${request["status"]}").withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${request["status"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor("${request["status"]}"),
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
                    color: _getLeaveTypeColor("${request["leaveType"]}").withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: _getLeaveTypeColor("${request["leaveType"]}").withAlpha(30)),
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
                              color: _getLeaveTypeColor("${request["leaveType"]}"),
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
                              color: _getLeaveTypeColor("${request["leaveType"]}"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: disabledBoldColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${DateTime.parse("${request["startDate"]}").dMMMy} - ${DateTime.parse("${request["endDate"]}").dMMMy}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      if (request["reason"] != null && "${request["reason"]}".isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.notes,
                              size: 16,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: spXs),
                            Expanded(
                              child: Text(
                                "${request["reason"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // Additional Details
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
                              "Manager: ${request["manager"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.backup, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Coverage: ${request["coverage"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
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
                            Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "Applied: ${DateTime.parse("${request["appliedDate"]}").dMMMy}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.confirmation_number, size: 16, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text(
                              "ID: ${request["id"]}",
                              style: TextStyle(fontSize: 14, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Actions
                if (request["status"] == "Pending" || request["status"] == "Under Review")
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Approve",
                          size: bs.sm,
                          onPressed: () {
                            ss("Approved leave for ${request["employee"]}");
                          },
                        ),
                      ),
                      QButton(
                        label: "Reject",
                        size: bs.sm,
                        onPressed: () {
                          se("Rejected leave for ${request["employee"]}");
                        },
                      ),
                    ],
                  )
                else
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "View Details",
                      size: bs.sm,
                      onPressed: () {
                        ss("View details for ${request["employee"]}");
                      },
                    ),
                  ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildPoliciesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Policy Management Actions
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Update Policies",
                  icon: Icons.edit,
                  onPressed: () {
                    ss("Update leave policies clicked");
                  },
                ),
              ),
              QButton(
                icon: Icons.settings,
                size: bs.sm,
                onPressed: () {
                  ss("Policy settings clicked");
                },
              ),
            ],
          ),

          // Leave Policies
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
                  "Leave Policies & Entitlements",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...leaveTypes.map((policy) => Container(
                  padding: EdgeInsets.all(spMd),
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: (policy["color"] as Color).withAlpha(5),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: (policy["color"] as Color).withAlpha(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spMd,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: policy["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${policy["code"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${policy["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "${policy["entitlement"]} days/year",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: policy["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${policy["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      // Policy Rules
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Policy Rules:",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "• Advance notice required: ${policy["name"] == "Sick Leave" ? "Not required" : "14 days"}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            Text(
                              "• Maximum consecutive days: ${policy["name"] == "Maternity/Paternity" ? "90" : policy["name"] == "Sick Leave" ? "5" : "10"}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                            Text(
                              "• Carry over: ${policy["name"] == "Annual Leave" ? "5 days max" : "Not allowed"}",
                              style: TextStyle(fontSize: 12, color: disabledBoldColor),
                            ),
                          ],
                        ),
                      ),
                      // Action Button
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Edit Policy",
                          size: bs.sm,
                          onPressed: () {
                            ss("Edit ${policy["name"]} policy");
                          },
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),

          // Additional Settings
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
                  "Leave Management Settings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: Border.all(color: disabledOutlineBorderColor),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Auto-Approval Settings",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "• Single day leaves: Auto-approved for personal leave",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      Text(
                        "• Sick leave: Auto-approved up to 3 consecutive days",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                      Text(
                        "• Weekend extensions: Auto-approved if justified",
                        style: TextStyle(fontSize: 14, color: disabledBoldColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Configure Settings",
                    size: bs.sm,
                    onPressed: () {
                      ss("Configure leave management settings");
                    },
                  ),
                ),
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
      title: "Leave Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Requests", icon: Icon(Icons.assignment)),
        Tab(text: "Policies", icon: Icon(Icons.policy)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRequestsTab(),
        _buildPoliciesTab(),
      ],
    );
  }
}
