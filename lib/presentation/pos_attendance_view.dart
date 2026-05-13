import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PosAttendanceView extends StatefulWidget {
  const PosAttendanceView({super.key});

  @override
  State<PosAttendanceView> createState() => _PosAttendanceViewState();
}

class _PosAttendanceViewState extends State<PosAttendanceView> {
  String selectedPeriod = "This Week";
  String selectedEmployee = "All Employees";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
  ];

  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "All Employees"},
    {"label": "John Smith", "value": "john_smith"},
    {"label": "Sarah Johnson", "value": "sarah_johnson"},
    {"label": "Mike Davis", "value": "mike_davis"},
    {"label": "Emily Wilson", "value": "emily_wilson"},
  ];

  List<Map<String, dynamic>> attendanceData = [
    {
      "id": "emp_001",
      "name": "John Smith",
      "position": "Cashier",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=person",
      "status": "present",
      "clockIn": "08:00 AM",
      "clockOut": "05:00 PM",
      "totalHours": 9.0,
      "breaks": 1.0,
      "overtime": 0.0,
      "date": "2024-01-15"
    },
    {
      "id": "emp_002",
      "name": "Sarah Johnson",
      "position": "Sales Associate",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=person",
      "status": "present",
      "clockIn": "08:15 AM",
      "clockOut": "05:30 PM",
      "totalHours": 9.25,
      "breaks": 0.5,
      "overtime": 0.25,
      "date": "2024-01-15"
    },
    {
      "id": "emp_003",
      "name": "Mike Davis",
      "position": "Store Manager",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=person",
      "status": "absent",
      "clockIn": "--",
      "clockOut": "--",
      "totalHours": 0.0,
      "breaks": 0.0,
      "overtime": 0.0,
      "date": "2024-01-15"
    },
    {
      "id": "emp_004",
      "name": "Emily Wilson",
      "position": "Assistant Manager",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=person",
      "status": "late",
      "clockIn": "08:45 AM",
      "clockOut": "06:15 PM",
      "totalHours": 9.5,
      "breaks": 0.75,
      "overtime": 1.0,
      "date": "2024-01-15"
    },
  ];

  Widget _buildAttendanceSummary() {
    int presentCount = attendanceData.where((e) => e["status"] == "present").length;
    int absentCount = attendanceData.where((e) => e["status"] == "absent").length;
    int lateCount = attendanceData.where((e) => e["status"] == "late").length;
    double totalHours = attendanceData.fold(0.0, (sum, e) => sum + (e["totalHours"] as double));

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attendance Summary",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$presentCount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Present",
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
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cancel,
                        color: dangerColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$absentCount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Absent",
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
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$lateCount",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Late",
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
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: primaryColor,
                        size: 24,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${totalHours.toInt()}h",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Hours",
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
                  label: "Period",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
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
        ],
      ),
    );
  }

  Widget _buildAttendanceList() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Employee Attendance",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              QButton(
                label: "Export",
                icon: Icons.download,
                size: bs.sm,
                onPressed: () {
                  ss("Attendance data exported successfully");
                },
              ),
            ],
          ),
          SizedBox(height: spSm),
          Column(
            children: attendanceData.map((employee) {
              Color statusColor = successColor;
              IconData statusIcon = Icons.check_circle;
              
              if (employee["status"] == "absent") {
                statusColor = dangerColor;
                statusIcon = Icons.cancel;
              } else if (employee["status"] == "late") {
                statusColor = warningColor;
                statusIcon = Icons.access_time;
              }

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: statusColor,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusLg),
                      child: Image.network(
                        "${employee["avatar"]}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
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
                                  "${employee["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Icon(
                                statusIcon,
                                color: statusColor,
                                size: 20,
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${employee["position"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "In: ${employee["clockIn"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Out: ${employee["clockOut"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${(employee["totalHours"] as double).toStringAsFixed(1)}h",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if ((employee["overtime"] as double) > 0) ...[
                          SizedBox(height: spXs),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "OT: ${(employee["overtime"] as double).toStringAsFixed(1)}h",
                              style: TextStyle(
                                fontSize: 10,
                                color: warningColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(width: spSm),
                    GestureDetector(
                      onTap: () {
                        // Navigate to employee details
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: disabledBoldColor,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // Navigate to calendar view
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Navigate to attendance analytics
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildAttendanceSummary(),
            _buildFilters(),
            _buildAttendanceList(),
          ],
        ),
      ),
    );
  }
}
