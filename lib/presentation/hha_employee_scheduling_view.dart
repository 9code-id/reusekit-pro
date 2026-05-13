import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaEmployeeSchedulingView extends StatefulWidget {
  const HhaEmployeeSchedulingView({super.key});

  @override
  State<HhaEmployeeSchedulingView> createState() => _HhaEmployeeSchedulingViewState();
}

class _HhaEmployeeSchedulingViewState extends State<HhaEmployeeSchedulingView> {
  int selectedTab = 0;
  String selectedDepartment = "All";
  String selectedShift = "All";
  DateTime selectedDate = DateTime.now();
  
  List<Map<String, dynamic>> departmentOptions = [
    {"label": "All", "value": "All"},
    {"label": "Front Desk", "value": "Front Desk"},
    {"label": "Housekeeping", "value": "Housekeeping"},
    {"label": "Maintenance", "value": "Maintenance"},
    {"label": "Food & Beverage", "value": "Food & Beverage"},
    {"label": "Security", "value": "Security"},
  ];

  List<Map<String, dynamic>> shiftOptions = [
    {"label": "All", "value": "All"},
    {"label": "Morning", "value": "Morning"},
    {"label": "Afternoon", "value": "Afternoon"},
    {"label": "Evening", "value": "Evening"},
    {"label": "Night", "value": "Night"},
  ];

  List<Map<String, dynamic>> scheduleStats = [
    {
      "title": "Total Staff",
      "value": 45,
      "icon": Icons.people,
      "color": primaryColor,
    },
    {
      "title": "On Duty",
      "value": 28,
      "icon": Icons.schedule,
      "color": successColor,
    },
    {
      "title": "Absent",
      "value": 3,
      "icon": Icons.person_off,
      "color": dangerColor,
    },
    {
      "title": "Coverage",
      "value": 92,
      "icon": Icons.shield,
      "color": infoColor,
      "percentage": true,
    },
  ];

  List<Map<String, dynamic>> employees = [
    {
      "id": "EMP001",
      "name": "John Smith",
      "department": "Front Desk",
      "position": "Receptionist",
      "shift": "Morning",
      "startTime": "06:00",
      "endTime": "14:00",
      "status": "On Duty",
      "location": "Main Lobby",
      "phone": "+1 234 567 8901",
      "email": "john.smith@hotel.com",
      "experience": "3 years",
    },
    {
      "id": "EMP002",
      "name": "Sarah Johnson",
      "department": "Housekeeping",
      "position": "Housekeeper",
      "shift": "Morning",
      "startTime": "07:00",
      "endTime": "15:00",
      "status": "On Duty",
      "location": "Floor 2-3",
      "phone": "+1 234 567 8902",
      "email": "sarah.johnson@hotel.com",
      "experience": "5 years",
    },
    {
      "id": "EMP003",
      "name": "Mike Davis",
      "department": "Maintenance",
      "position": "Technician",
      "shift": "Afternoon",
      "startTime": "14:00",
      "endTime": "22:00",
      "status": "Break",
      "location": "Basement",
      "phone": "+1 234 567 8903",
      "email": "mike.davis@hotel.com",
      "experience": "7 years",
    },
    {
      "id": "EMP004",
      "name": "Emma Wilson",
      "department": "Food & Beverage",
      "position": "Server",
      "shift": "Evening",
      "startTime": "17:00",
      "endTime": "01:00",
      "status": "Absent",
      "location": "Restaurant",
      "phone": "+1 234 567 8904",
      "email": "emma.wilson@hotel.com",
      "experience": "2 years",
    },
    {
      "id": "EMP005",
      "name": "Robert Brown",
      "department": "Security",
      "position": "Security Guard",
      "shift": "Night",
      "startTime": "22:00",
      "endTime": "06:00",
      "status": "On Duty",
      "location": "Parking Lot",
      "phone": "+1 234 567 8905",
      "email": "robert.brown@hotel.com",
      "experience": "4 years",
    },
  ];

  List<Map<String, dynamic>> shifts = [
    {
      "name": "Morning Shift",
      "time": "06:00 - 14:00",
      "department": "Front Desk",
      "requiredStaff": 3,
      "assignedStaff": 2,
      "coverage": 67,
      "employees": ["John Smith", "Alice Cooper"],
    },
    {
      "name": "Afternoon Shift",
      "time": "14:00 - 22:00",
      "department": "Housekeeping",
      "requiredStaff": 5,
      "assignedStaff": 4,
      "coverage": 80,
      "employees": ["Sarah Johnson", "Mark Wilson", "Lisa Garcia", "Tom Anderson"],
    },
    {
      "name": "Evening Shift",
      "time": "17:00 - 01:00",
      "department": "Food & Beverage",
      "requiredStaff": 4,
      "assignedStaff": 3,
      "coverage": 75,
      "employees": ["David Lee", "Maria Rodriguez", "Peter Kim"],
    },
    {
      "name": "Night Shift",
      "time": "22:00 - 06:00",
      "department": "Security",
      "requiredStaff": 2,
      "assignedStaff": 2,
      "coverage": 100,
      "employees": ["Robert Brown", "James Taylor"],
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    return employees.where((employee) {
      bool departmentMatch = selectedDepartment == "All" || employee["department"] == selectedDepartment;
      bool shiftMatch = selectedShift == "All" || employee["shift"] == selectedShift;
      return departmentMatch && shiftMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Employee Scheduling",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Schedule", icon: Icon(Icons.schedule)),
        Tab(text: "Staff", icon: Icon(Icons.people)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildScheduleTab(),
        _buildStaffTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildScheduleTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Date Picker
          QDatePicker(
            label: "Schedule Date",
            value: selectedDate,
            onChanged: (value) {
              selectedDate = value;
              setState(() {});
            },
          ),
          
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: scheduleStats.map((stat) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(
                      stat["icon"] as IconData,
                      color: stat["color"] as Color,
                      size: 28,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      stat["percentage"] == true 
                          ? "${stat["value"]}%"
                          : "${stat["value"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${stat["title"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          // Shift Coverage
          Text(
            "Shift Coverage",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: shifts.map((shift) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getCoverageColor((shift["coverage"] as num).toDouble()),
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${shift["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${shift["time"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${shift["department"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${shift["assignedStaff"]}/${shift["requiredStaff"]} staff assigned",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: _getCoverageColor((shift["coverage"] as num).toDouble()).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${shift["coverage"]}%",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _getCoverageColor((shift["coverage"] as num).toDouble()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "Assigned Staff:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            (shift["employees"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Row(
                      spacing: spSm,
                      children: [
                        if ((shift["assignedStaff"] as int) < (shift["requiredStaff"] as int))
                          Expanded(
                            child: QButton(
                              label: "Assign Staff",
                              size: bs.sm,
                              onPressed: () {
                                ss("Assigning staff to ${shift["name"]}");
                              },
                            ),
                          ),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            ss("Editing ${shift["name"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for ${shift["name"]}");
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
    );
  }

  Widget _buildStaffTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentOptions,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Shift",
                  items: shiftOptions,
                  value: selectedShift,
                  onChanged: (value, label) {
                    selectedShift = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          
          // Staff List
          Row(
            children: [
              Text(
                "Staff Members",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${filteredEmployees.length} employees",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: _getStatusColor(employee["status"] as String),
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
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "${employee["id"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${employee["shift"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${employee["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${employee["position"]} • ${employee["department"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(employee["status"] as String).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${employee["status"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getStatusColor(employee["status"] as String),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(5),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Shift: ${employee["startTime"]} - ${employee["endTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Location: ${employee["location"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.work,
                                color: disabledBoldColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "Experience: ${employee["experience"]}",
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
                    
                    Row(
                      spacing: spSm,
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              ss("Viewing details for ${employee["name"]}");
                            },
                          ),
                        ),
                        QButton(
                          icon: Icons.phone,
                          size: bs.sm,
                          onPressed: () {
                            ss("Calling ${employee["name"]}");
                          },
                        ),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            ss("Editing ${employee["name"]} schedule");
                          },
                        ),
                        QButton(
                          icon: Icons.more_vert,
                          size: bs.sm,
                          onPressed: () {
                            ss("More options for ${employee["name"]}");
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
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Scheduling Reports",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusSm),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Performance Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    _buildMetricCard("Attendance Rate", "96%", Icons.check_circle, successColor),
                    _buildMetricCard("Overtime Hours", "45", Icons.timer, warningColor),
                    _buildMetricCard("Staff Utilization", "89%", Icons.people, infoColor),
                    _buildMetricCard("Coverage Rate", "92%", Icons.shield, primaryColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: spSm),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "On Duty":
        return successColor;
      case "Break":
        return warningColor;
      case "Absent":
        return dangerColor;
      case "Off Duty":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }

  Color _getCoverageColor(double coverage) {
    if (coverage >= 90) return successColor;
    if (coverage >= 70) return warningColor;
    if (coverage >= 50) return infoColor;
    return dangerColor;
  }
}
