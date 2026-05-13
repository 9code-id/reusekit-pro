import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlDashboard4View extends StatefulWidget {
  @override
  State<GrlDashboard4View> createState() => _GrlDashboard4ViewState();
}

class _GrlDashboard4ViewState extends State<GrlDashboard4View> {
  bool loading = false;
  String selectedDepartment = "All";
  
  List<Map<String, dynamic>> employeeData = [
    {"name": "Sarah Johnson", "department": "Sales", "position": "Sales Manager", "salary": 85000.0, "performance": 95, "status": "Active", "avatar": "https://picsum.photos/50/50?random=1&keyword=woman"},
    {"name": "Michael Chen", "department": "Engineering", "position": "Senior Developer", "salary": 95000.0, "performance": 88, "status": "Active", "avatar": "https://picsum.photos/50/50?random=2&keyword=man"},
    {"name": "Emily Davis", "department": "Marketing", "position": "Marketing Director", "salary": 78000.0, "performance": 92, "status": "Active", "avatar": "https://picsum.photos/50/50?random=3&keyword=woman"},
    {"name": "David Wilson", "department": "HR", "position": "HR Specialist", "salary": 65000.0, "performance": 85, "status": "On Leave", "avatar": "https://picsum.photos/50/50?random=4&keyword=man"},
    {"name": "Lisa Rodriguez", "department": "Finance", "position": "Financial Analyst", "salary": 72000.0, "performance": 90, "status": "Active", "avatar": "https://picsum.photos/50/50?random=5&keyword=woman"},
  ];

  List<Map<String, dynamic>> attendanceData = [
    {"date": "2024-01-15", "present": 87, "absent": 8, "late": 5, "total": 100},
    {"date": "2024-01-14", "present": 92, "absent": 5, "late": 3, "total": 100},
    {"date": "2024-01-13", "present": 89, "absent": 7, "late": 4, "total": 100},
    {"date": "2024-01-12", "present": 94, "absent": 4, "late": 2, "total": 100},
    {"date": "2024-01-11", "present": 90, "absent": 6, "late": 4, "total": 100},
  ];

  List<Map<String, dynamic>> leaveRequests = [
    {"employee": "John Smith", "type": "Vacation", "from": "2024-01-20", "to": "2024-01-25", "days": 5, "status": "Pending", "department": "Sales"},
    {"employee": "Alice Brown", "type": "Sick Leave", "from": "2024-01-18", "to": "2024-01-19", "days": 2, "status": "Approved", "department": "Engineering"},
    {"employee": "Bob Johnson", "type": "Personal", "from": "2024-01-22", "to": "2024-01-22", "days": 1, "status": "Pending", "department": "Marketing"},
    {"employee": "Carol White", "type": "Medical", "from": "2024-01-16", "to": "2024-01-20", "days": 5, "status": "Approved", "department": "HR"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All", "value": "All"},
    {"label": "Sales", "value": "Sales"},
    {"label": "Engineering", "value": "Engineering"},
    {"label": "Marketing", "value": "Marketing"},
    {"label": "HR", "value": "HR"},
    {"label": "Finance", "value": "Finance"},
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    if (selectedDepartment == "All") return employeeData;
    return employeeData.where((emp) => emp["department"] == selectedDepartment).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("HR Dashboard"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            child: QButton(
              icon: Icons.person_add,
              size: bs.sm,
              onPressed: () {
                si("Opening employee registration form");
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Department Filter
            Row(
              children: [
                Text(
                  "Department:",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Select Department",
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

            // HR Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: [
                _buildMetricCard("Total Employees", "${employeeData.length}", Icons.people, primaryColor, "+12"),
                _buildMetricCard("Active Today", "${attendanceData.isNotEmpty ? attendanceData.first["present"] : 0}", Icons.check_circle, successColor, "87%"),
                _buildMetricCard("On Leave", "${employeeData.where((emp) => emp["status"] == "On Leave").length}", Icons.event_busy, warningColor, "8%"),
                _buildMetricCard("Avg Performance", "${(employeeData.map((emp) => emp["performance"] as int).reduce((a, b) => a + b) / employeeData.length).toStringAsFixed(1)}%", Icons.trending_up, infoColor, "+5.2%"),
              ],
            ),

            // Employee List
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Employee Directory",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening full employee directory");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: filteredEmployees.map((employee) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border(
                            left: BorderSide(
                              width: 4,
                              color: _getStatusColor(employee["status"]),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                image: DecorationImage(
                                  image: NetworkImage("${employee["avatar"]}"),
                                  fit: BoxFit.cover,
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
                                      Text(
                                        "${employee["name"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(employee["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${employee["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getStatusColor(employee["status"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${employee["position"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${employee["department"]} • Performance: ${employee["performance"]}%",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "\$${((employee["salary"] as double) / 1000).toStringAsFixed(0)}K",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Container(
                                  width: 60,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: FractionallySizedBox(
                                    widthFactor: (employee["performance"] as int) / 100,
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: _getPerformanceColor(employee["performance"] as int),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Attendance Overview
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Attendance Overview (Last 5 Days)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spXs,
                    children: attendanceData.map((attendance) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              child: Text(
                                "${attendance["date"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  _buildAttendanceBar("Present", attendance["present"] as int, successColor, attendance["total"] as int),
                                  SizedBox(width: spXs),
                                  _buildAttendanceBar("Late", attendance["late"] as int, warningColor, attendance["total"] as int),
                                  SizedBox(width: spXs),
                                  _buildAttendanceBar("Absent", attendance["absent"] as int, dangerColor, attendance["total"] as int),
                                ],
                              ),
                            ),
                            Container(
                              width: 60,
                              child: Text(
                                "${((attendance["present"] as int) / (attendance["total"] as int) * 100).toStringAsFixed(0)}%",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
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

            // Leave Requests
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Leave Requests",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          si("Opening leave management");
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: leaveRequests.map((request) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: _getLeaveStatusColor(request["status"]).withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                Icons.event_note,
                                color: _getLeaveStatusColor(request["status"]),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${request["employee"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: _getLeaveStatusColor(request["status"]).withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${request["status"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: _getLeaveStatusColor(request["status"]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${request["type"]} • ${request["days"]} day(s)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${request["from"]} to ${request["to"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (request["status"] == "Pending")
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  QButton(
                                    icon: Icons.check,
                                    size: bs.sm,
                                    onPressed: () {
                                      ss("Leave request approved");
                                    },
                                  ),
                                  SizedBox(width: spXs),
                                  QButton(
                                    icon: Icons.close,
                                    size: bs.sm,
                                    onPressed: () {
                                      se("Leave request rejected");
                                    },
                                  ),
                                ],
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Payroll Report",
                    icon: Icons.account_balance_wallet,
                    size: bs.md,
                    onPressed: () {
                      si("Generating payroll report");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Performance Review",
                    icon: Icons.assessment,
                    size: bs.md,
                    onPressed: () {
                      si("Opening performance review system");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
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

  Widget _buildAttendanceBar(String label, int count, Color color, int total) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              widthFactor: count / total,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active":
        return successColor;
      case "On Leave":
        return warningColor;
      case "Inactive":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPerformanceColor(int performance) {
    if (performance >= 90) return successColor;
    if (performance >= 75) return warningColor;
    return dangerColor;
  }

  Color _getLeaveStatusColor(String status) {
    switch (status) {
      case "Approved":
        return successColor;
      case "Pending":
        return warningColor;
      case "Rejected":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
