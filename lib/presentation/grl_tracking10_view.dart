import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTracking10View extends StatefulWidget {
  @override
  State<GrlTracking10View> createState() => _GrlTracking10ViewState();
}

class _GrlTracking10ViewState extends State<GrlTracking10View> {
  String selectedStatus = 'all';
  String selectedDepartment = 'all';
  
  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "Sarah Johnson",
      "position": "Software Engineer",
      "department": "Engineering",
      "avatar": "https://picsum.photos/60/60?random=1&keyword=woman",
      "status": "active",
      "checkInTime": "09:00",
      "checkOutTime": null,
      "hoursWorked": 6.5,
      "targetHours": 8.0,
      "location": "Office - Desk 24",
      "currentTask": "API Development",
      "productivity": 85,
      "breaks": [
        {"type": "coffee", "start": "10:30", "end": "10:45"},
        {"type": "lunch", "start": "12:30", "end": "13:30"},
      ],
    },
    {
      "id": "EMP002",
      "name": "Michael Chen",
      "position": "Product Manager",
      "department": "Product",
      "avatar": "https://picsum.photos/60/60?random=2&keyword=man",
      "status": "break",
      "checkInTime": "08:45",
      "checkOutTime": null,
      "hoursWorked": 7.0,
      "targetHours": 8.0,
      "location": "Conference Room B",
      "currentTask": "Product Planning Meeting",
      "productivity": 90,
      "breaks": [
        {"type": "coffee", "start": "10:00", "end": "10:15"},
        {"type": "meeting", "start": "15:00", "end": "15:30"},
      ],
    },
    {
      "id": "EMP003",
      "name": "Emma Davis",
      "position": "UX Designer",
      "department": "Design",
      "avatar": "https://picsum.photos/60/60?random=3&keyword=woman",
      "status": "offline",
      "checkInTime": "09:15",
      "checkOutTime": "18:00",
      "hoursWorked": 8.0,
      "targetHours": 8.0,
      "location": "Home Office",
      "currentTask": "User Interface Design",
      "productivity": 78,
      "breaks": [
        {"type": "coffee", "start": "11:00", "end": "11:15"},
        {"type": "lunch", "start": "13:00", "end": "14:00"},
      ],
    },
    {
      "id": "EMP004",
      "name": "James Wilson",
      "position": "Marketing Specialist",
      "department": "Marketing",
      "avatar": "https://picsum.photos/60/60?random=4&keyword=man",
      "status": "active",
      "checkInTime": "08:30",
      "checkOutTime": null,
      "hoursWorked": 7.5,
      "targetHours": 8.0,
      "location": "Office - Meeting Room A",
      "currentTask": "Campaign Strategy",
      "productivity": 92,
      "breaks": [
        {"type": "coffee", "start": "10:45", "end": "11:00"},
      ],
    },
    {
      "id": "EMP005",
      "name": "Lisa Rodriguez",
      "position": "HR Manager",
      "department": "Human Resources",
      "avatar": "https://picsum.photos/60/60?random=5&keyword=woman",
      "status": "meeting",
      "checkInTime": "09:00",
      "checkOutTime": null,
      "hoursWorked": 6.0,
      "targetHours": 8.0,
      "location": "HR Office",
      "currentTask": "Employee Interview",
      "productivity": 88,
      "breaks": [
        {"type": "lunch", "start": "12:00", "end": "13:00"},
      ],
    },
  ];

  Map<String, dynamic> teamStats = {
    "totalEmployees": 25,
    "activeEmployees": 18,
    "onBreak": 4,
    "inMeeting": 3,
    "avgProductivity": 87,
    "totalHoursToday": 156.5,
    "avgCheckInTime": "08:52",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () {
              // navigateTo(QRAttendanceView());
            },
          ),
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // navigateTo(AnalyticsView());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Team Overview Dashboard
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.dashboard,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Team Dashboard",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${teamStats["avgProductivity"]}% Productivity",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Quick Stats Row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${teamStats["activeEmployees"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${teamStats["onBreak"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "On Break",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${(teamStats["totalHoursToday"] as double).toStringAsFixed(1)}h",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Hours",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
          
          // Filter Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Status Filter
                QHorizontalScroll(
                  children: [
                    'all', 'active', 'break', 'meeting', 'offline'
                  ].map((status) => GestureDetector(
                    onTap: () {
                      selectedStatus = status;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedStatus == status ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedStatus == status ? primaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedStatus == status ? Colors.white : primaryColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
                
                SizedBox(height: spMd),
                
                // Department Filter
                QHorizontalScroll(
                  children: [
                    'all', 'Engineering', 'Product', 'Design', 'Marketing', 'Human Resources', 'Sales'
                  ].map((dept) => GestureDetector(
                    onTap: () {
                      selectedDepartment = dept;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(
                        horizontal: spMd,
                        vertical: spSm,
                      ),
                      decoration: BoxDecoration(
                        color: selectedDepartment == dept ? secondaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        border: Border.all(
                          color: selectedDepartment == dept ? secondaryColor : disabledOutlineBorderColor,
                        ),
                      ),
                      child: Text(
                        dept.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: selectedDepartment == dept ? Colors.white : secondaryColor,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          
          // Employee List
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Team Members",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Employee Cards
                  ...employees.where((employee) {
                    bool statusMatch = selectedStatus == 'all' || employee["status"] == selectedStatus;
                    bool deptMatch = selectedDepartment == 'all' || employee["department"] == selectedDepartment;
                    return statusMatch && deptMatch;
                  }).map((employee) => Container(
                    margin: EdgeInsets.only(bottom: spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowMd],
                    ),
                    child: Column(
                      children: [
                        // Employee Header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(spMd),
                          decoration: BoxDecoration(
                            color: _getStatusColor(employee["status"]).withAlpha(20),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Avatar
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  boxShadow: [shadowSm],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  child: Image.network(
                                    "${employee["avatar"]}",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: primaryColor,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spMd),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${employee["name"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${employee["position"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${employee["department"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(employee["status"]),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${employee["status"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: _getStatusColor(employee["status"]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${employee["id"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Employee Details
                        Padding(
                          padding: EdgeInsets.all(spMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Current Task
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(spSm),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.work,
                                      size: 16,
                                      color: infoColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Expanded(
                                      child: Text(
                                        "Current: ${employee["currentTask"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Work Hours Progress
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Hours Worked",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: disabledBoldColor,
                                              ),
                                            ),
                                            Text(
                                              "${(employee["hoursWorked"] as double).toStringAsFixed(1)}h / ${(employee["targetHours"] as double).toStringAsFixed(1)}h",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: spXs),
                                        Container(
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: disabledColor,
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: ((employee["hoursWorked"] as double) / (employee["targetHours"] as double)).clamp(0.0, 1.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusSm),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: spMd),
                                  Column(
                                    children: [
                                      Text(
                                        "${employee["productivity"]}%",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: _getProductivityColor(employee["productivity"] as int),
                                        ),
                                      ),
                                      Text(
                                        "Productivity",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Time and Location
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "In: ${employee["checkInTime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (employee["checkOutTime"] != null) ...[
                                    Text(
                                      " | Out: ${employee["checkOutTime"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                  Spacer(),
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${employee["location"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spMd),
                              
                              // Breaks Summary
                              if (employee["breaks"] != null && (employee["breaks"] as List).isNotEmpty) ...[
                                Text(
                                  "Breaks Today: ${(employee["breaks"] as List).length}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spMd),
                              ],
                              
                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: QButton(
                                      label: "View Details",
                                      size: bs.sm,
                                      onPressed: () {
                                        // navigateTo(EmployeeDetailsView());
                                      },
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.message,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: spSm),
                                  QButton(
                                    icon: Icons.more_vert,
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ],
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(AttendanceView());
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.qr_code,
          color: Colors.white,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return successColor;
      case 'break':
        return warningColor;
      case 'meeting':
        return infoColor;
      case 'offline':
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getProductivityColor(int productivity) {
    if (productivity >= 90) return successColor;
    if (productivity >= 70) return warningColor;
    if (productivity >= 50) return infoColor;
    return dangerColor;
  }
}
