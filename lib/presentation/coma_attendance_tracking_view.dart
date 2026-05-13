import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ComaAttendanceTrackingView extends StatefulWidget {
  const ComaAttendanceTrackingView({Key? key}) : super(key: key);

  @override
  State<ComaAttendanceTrackingView> createState() => _ComaAttendanceTrackingViewState();
}

class _ComaAttendanceTrackingViewState extends State<ComaAttendanceTrackingView> {
  String selectedDate = "today";
  String selectedProject = "all";
  String selectedShift = "all";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> dateFilters = [
    {"label": "Today", "value": "today"},
    {"label": "Yesterday", "value": "yesterday"},
    {"label": "This Week", "value": "this_week"},
    {"label": "Last Week", "value": "last_week"},
    {"label": "This Month", "value": "this_month"},
  ];

  List<Map<String, dynamic>> projectFilters = [
    {"label": "All Projects", "value": "all"},
    {"label": "Metro Downtown Complex", "value": "metro_downtown"},
    {"label": "Riverside Office Park", "value": "riverside_office"},
    {"label": "Healthcare Facility", "value": "healthcare_facility"},
    {"label": "Residential Tower A", "value": "residential_tower"},
  ];

  List<Map<String, dynamic>> shiftFilters = [
    {"label": "All Shifts", "value": "all"},
    {"label": "Day Shift (7AM-3PM)", "value": "day"},
    {"label": "Evening Shift (3PM-11PM)", "value": "evening"},
    {"label": "Night Shift (11PM-7AM)", "value": "night"},
    {"label": "Overtime", "value": "overtime"},
  ];

  List<Map<String, dynamic>> attendanceRecords = [
    {
      "id": "ATT-001",
      "employee_id": "EMP-001",
      "employee_name": "Michael Rodriguez",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "date": "2024-06-17",
      "shift": "day",
      "scheduled_start": "07:00",
      "scheduled_end": "15:00",
      "actual_clock_in": "06:58",
      "actual_clock_out": "15:05",
      "break_times": [
        {"start": "10:15", "end": "10:30", "duration": 15},
        {"start": "12:00", "end": "12:30", "duration": 30},
      ],
      "total_hours": 8.12,
      "regular_hours": 8.0,
      "overtime_hours": 0.12,
      "status": "present",
      "location": "Building A - Level 3",
      "supervisor": "Sarah Johnson",
      "check_in_method": "rfid_card",
      "check_out_method": "rfid_card",
      "notes": "Early arrival for equipment preparation",
      "weather_conditions": "Clear",
      "temperature": 72,
      "productivity_rating": 95,
      "punctuality_score": 100,
      "break_compliance": true,
      "safety_incidents": 0,
      "equipment_assigned": ["Hard hat", "Safety vest", "Tool belt"],
      "tasks_completed": ["Electrical installation", "Outlet testing", "Panel wiring"],
      "photo_verification": true,
      "gps_location": {
        "latitude": 47.6062,
        "longitude": -122.3321,
        "accuracy": 5
      },
    },
    {
      "id": "ATT-002",
      "employee_id": "EMP-002",
      "employee_name": "Jennifer Park",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "date": "2024-06-17",
      "shift": "day",
      "scheduled_start": "07:30",
      "scheduled_end": "15:30",
      "actual_clock_in": "07:35",
      "actual_clock_out": "15:28",
      "break_times": [
        {"start": "10:00", "end": "10:15", "duration": 15},
        {"start": "12:30", "end": "13:00", "duration": 30},
      ],
      "total_hours": 7.88,
      "regular_hours": 7.88,
      "overtime_hours": 0.0,
      "status": "present",
      "location": "Conference Room B",
      "supervisor": "David Wilson",
      "check_in_method": "mobile_app",
      "check_out_method": "mobile_app",
      "notes": "Traffic delay caused late arrival",
      "weather_conditions": "Partly cloudy",
      "temperature": 68,
      "productivity_rating": 92,
      "punctuality_score": 85,
      "break_compliance": true,
      "safety_incidents": 0,
      "equipment_assigned": ["Plumbing tools", "Safety glasses", "Knee pads"],
      "tasks_completed": ["Water line installation", "Pressure testing", "Documentation"],
      "photo_verification": true,
      "gps_location": {
        "latitude": 45.5152,
        "longitude": -122.6784,
        "accuracy": 8
      },
    },
    {
      "id": "ATT-003",
      "employee_id": "EMP-003",
      "employee_name": "Carlos Rivera",
      "project_id": "PRJ-003",
      "project_name": "Healthcare Facility",
      "date": "2024-06-17",
      "shift": "night",
      "scheduled_start": "23:00",
      "scheduled_end": "07:00",
      "actual_clock_in": "22:55",
      "actual_clock_out": "07:10",
      "break_times": [
        {"start": "02:00", "end": "02:30", "duration": 30},
        {"start": "05:00", "end": "05:15", "duration": 15},
      ],
      "total_hours": 8.25,
      "regular_hours": 8.0,
      "overtime_hours": 0.25,
      "status": "present",
      "location": "Patient Wing - Mechanical Room",
      "supervisor": "James Wilson",
      "check_in_method": "biometric",
      "check_out_method": "biometric",
      "notes": "Night shift HVAC maintenance completed successfully",
      "weather_conditions": "Clear",
      "temperature": 65,
      "productivity_rating": 88,
      "punctuality_score": 98,
      "break_compliance": true,
      "safety_incidents": 0,
      "equipment_assigned": ["HVAC tools", "Flashlight", "Safety harness"],
      "tasks_completed": ["Ductwork installation", "System testing", "Calibration"],
      "photo_verification": true,
      "gps_location": {
        "latitude": 37.7749,
        "longitude": -122.4194,
        "accuracy": 3
      },
    },
    {
      "id": "ATT-004",
      "employee_id": "EMP-004",
      "employee_name": "Robert Garcia",
      "project_id": "PRJ-004",
      "project_name": "Residential Tower A",
      "date": "2024-06-17",
      "shift": "day",
      "scheduled_start": "08:00",
      "scheduled_end": "16:00",
      "actual_clock_in": null,
      "actual_clock_out": null,
      "break_times": [],
      "total_hours": 0.0,
      "regular_hours": 0.0,
      "overtime_hours": 0.0,
      "status": "absent",
      "location": null,
      "supervisor": "Maria Gonzalez",
      "check_in_method": null,
      "check_out_method": null,
      "notes": "Called in sick - doctor's appointment",
      "weather_conditions": "Sunny",
      "temperature": 75,
      "productivity_rating": 0,
      "punctuality_score": 0,
      "break_compliance": null,
      "safety_incidents": 0,
      "equipment_assigned": [],
      "tasks_completed": [],
      "photo_verification": false,
      "gps_location": null,
      "absence_reason": "sick_leave",
      "absence_approved": true,
      "replacement_worker": "John Smith",
    },
    {
      "id": "ATT-005",
      "employee_id": "EMP-005",
      "employee_name": "Antonio Martinez",
      "project_id": "PRJ-001",
      "project_name": "Metro Downtown Complex",
      "date": "2024-06-17",
      "shift": "day",
      "scheduled_start": "06:00",
      "scheduled_end": "14:00",
      "actual_clock_in": "06:15",
      "actual_clock_out": "14:30",
      "break_times": [
        {"start": "09:30", "end": "09:45", "duration": 15},
        {"start": "12:00", "end": "12:30", "duration": 30},
      ],
      "total_hours": 8.25,
      "regular_hours": 8.0,
      "overtime_hours": 0.25,
      "status": "late",
      "location": "Foundation Area",
      "supervisor": "Thomas Anderson",
      "check_in_method": "rfid_card",
      "check_out_method": "rfid_card",
      "notes": "Late arrival due to equipment pickup delay",
      "weather_conditions": "Overcast",
      "temperature": 70,
      "productivity_rating": 85,
      "punctuality_score": 75,
      "break_compliance": true,
      "safety_incidents": 0,
      "equipment_assigned": ["Concrete tools", "Level", "Float"],
      "tasks_completed": ["Concrete pouring", "Surface finishing", "Cleanup"],
      "photo_verification": true,
      "gps_location": {
        "latitude": 47.6062,
        "longitude": -122.3321,
        "accuracy": 4
      },
      "late_reason": "equipment_delay",
    },
    {
      "id": "ATT-006",
      "employee_id": "EMP-006",
      "employee_name": "David Kim",
      "project_id": "PRJ-002",
      "project_name": "Riverside Office Park",
      "date": "2024-06-17",
      "shift": "overtime",
      "scheduled_start": "16:00",
      "scheduled_end": "20:00",
      "actual_clock_in": "15:58",
      "actual_clock_out": "20:15",
      "break_times": [
        {"start": "18:00", "end": "18:15", "duration": 15},
      ],
      "total_hours": 4.28,
      "regular_hours": 0.0,
      "overtime_hours": 4.28,
      "status": "present",
      "location": "Site cleanup area",
      "supervisor": "Emily Rodriguez",
      "check_in_method": "mobile_app",
      "check_out_method": "mobile_app",
      "notes": "Overtime shift for site organization and cleanup",
      "weather_conditions": "Clear",
      "temperature": 68,
      "productivity_rating": 90,
      "punctuality_score": 100,
      "break_compliance": true,
      "safety_incidents": 0,
      "equipment_assigned": ["Cleaning supplies", "Organization tools"],
      "tasks_completed": ["Site cleanup", "Material organization", "Tool inventory"],
      "photo_verification": true,
      "gps_location": {
        "latitude": 45.5152,
        "longitude": -122.6784,
        "accuracy": 6
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Tracking"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _markAttendance(),
          ),
          SizedBox(width: spSm),
          QButton(
            icon: Icons.analytics,
            size: bs.sm,
            onPressed: () => _showAttendanceAnalytics(),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildAttendanceOverview(),
                  _buildFilters(),
                  _buildAttendanceMetrics(),
                  _buildAttendanceList(),
                ],
              ),
            ),
    );
  }

  Widget _buildAttendanceOverview() {
    int totalEmployees = attendanceRecords.length;
    int presentEmployees = attendanceRecords.where((r) => r["status"] == "present").length;
    int absentEmployees = attendanceRecords.where((r) => r["status"] == "absent").length;
    int lateEmployees = attendanceRecords.where((r) => r["status"] == "late").length;
    double attendanceRate = totalEmployees > 0 ? (presentEmployees + lateEmployees) / totalEmployees * 100 : 0;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: primaryColor.withAlpha(50)),
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
                  color: primaryColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(Icons.fact_check, color: primaryColor, size: 24),
              ),
              SizedBox(width: spMd),
              Text(
                "Attendance Overview - Today",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildOverviewCard("Total", "$totalEmployees", Icons.group, primaryColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Present", "$presentEmployees", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Late", "$lateEmployees", Icons.schedule, warningColor),
              SizedBox(width: spSm),
              _buildOverviewCard("Absent", "$absentEmployees", Icons.cancel, dangerColor),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(Icons.analytics, color: successColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Attendance Rate: ${attendanceRate.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusMd),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Icon(Icons.search, color: disabledBoldColor, size: 20),
              SizedBox(width: spSm),
              Expanded(
                child: QTextField(
                  label: "Search attendance...",
                  value: searchQuery,
                  hint: "Search by employee name or project",
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.filter_list,
                size: bs.sm,
                onPressed: () => _showAdvancedFilters(),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Date Range",
                  items: dateFilters,
                  value: selectedDate,
                  onChanged: (value, label) {
                    selectedDate = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: projectFilters,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: QDropdownField(
                  label: "Shift",
                  items: shiftFilters,
                  value: selectedShift,
                  onChanged: (value, label) {
                    selectedShift = value;
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

  Widget _buildAttendanceMetrics() {
    double avgPunctuality = attendanceRecords.where((r) => r["status"] != "absent")
        .fold(0.0, (sum, r) => sum + (r["punctuality_score"] as int)) / 
        attendanceRecords.where((r) => r["status"] != "absent").length;
    double avgProductivity = attendanceRecords.where((r) => r["status"] != "absent")
        .fold(0.0, (sum, r) => sum + (r["productivity_rating"] as int)) / 
        attendanceRecords.where((r) => r["status"] != "absent").length;
    double totalHours = attendanceRecords.fold(0.0, (sum, r) => sum + (r["total_hours"] as double));
    int breakCompliance = attendanceRecords.where((r) => r["break_compliance"] == true).length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: infoColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: infoColor.withAlpha(30)),
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
              color: infoColor,
            ),
          ),
          Row(
            children: [
              _buildMetricCard("Punctuality", "${avgPunctuality.toInt()}%", Icons.schedule, primaryColor),
              SizedBox(width: spSm),
              _buildMetricCard("Productivity", "${avgProductivity.toInt()}%", Icons.trending_up, successColor),
              SizedBox(width: spSm),
              _buildMetricCard("Total Hours", "${totalHours.toStringAsFixed(1)}", Icons.access_time, infoColor),
              SizedBox(width: spSm),
              _buildMetricCard("Break Compliance", "$breakCompliance", Icons.check, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusMd),
          boxShadow: [shadowSm],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceList() {
    List<Map<String, dynamic>> filteredRecords = _getFilteredRecords();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Row(
          children: [
            Text(
              "Attendance Records (${filteredRecords.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.sort,
              size: bs.sm,
              onPressed: () => _showSortOptions(),
            ),
          ],
        ),
        ...filteredRecords.map((record) => _buildAttendanceCard(record)),
      ],
    );
  }

  Widget _buildAttendanceCard(Map<String, dynamic> record) {
    Color statusColor = _getStatusColor(record["status"]);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            color: statusColor,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${record["employee_name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${record["date"]} - ${record["shift"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${record["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Project: ${record["project_name"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (record["location"] != null)
            Row(
              children: [
                Icon(Icons.location_on, color: disabledBoldColor, size: 16),
                SizedBox(width: spXs),
                Expanded(
                  child: Text(
                    "${record["location"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ),
              ],
            ),
          if (record["status"] != "absent")
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Time Details",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Scheduled: ${record["scheduled_start"]} - ${record["scheduled_end"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "Actual: ${record["actual_clock_in"]} - ${record["actual_clock_out"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Total Hours: ${record["total_hours"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spMd),
                      if ((record["overtime_hours"] as double) > 0)
                        Text(
                          "Overtime: ${record["overtime_hours"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: warningColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          if (record["status"] == "absent")
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cancel, color: dangerColor, size: 16),
                      SizedBox(width: spXs),
                      Text(
                        "Absence Reason: ${record["absence_reason"] ?? "Not specified"}",
                        style: TextStyle(
                          fontSize: 11,
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  if (record["replacement_worker"] != null)
                    Text(
                      "Replacement Worker: ${record["replacement_worker"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: dangerColor,
                      ),
                    ),
                  if (record["absence_approved"] == true)
                    Text(
                      "Status: Approved absence",
                      style: TextStyle(
                        fontSize: 11,
                        color: successColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          if ((record["break_times"] as List).isNotEmpty)
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
                    "Breaks:",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: infoColor,
                    ),
                  ),
                  ...(record["break_times"] as List).map((breakTime) => Text(
                    "${breakTime["start"]} - ${breakTime["end"]} (${breakTime["duration"]} min)",
                    style: TextStyle(
                      fontSize: 11,
                      color: infoColor,
                    ),
                  )),
                ],
              ),
            ),
          if (record["status"] != "absent")
            Row(
              children: [
                _buildScoreIndicator("Punctuality", record["punctuality_score"], primaryColor),
                SizedBox(width: spSm),
                _buildScoreIndicator("Productivity", record["productivity_rating"], successColor),
                SizedBox(width: spSm),
                _buildComplianceIndicator(record["break_compliance"]),
                SizedBox(width: spSm),
                _buildSafetyIndicator(record["safety_incidents"]),
              ],
            ),
          if ((record["equipment_assigned"] as List).isNotEmpty)
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
                    "Equipment: ${(record["equipment_assigned"] as List).join(", ")}",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                    ),
                  ),
                  if ((record["tasks_completed"] as List).isNotEmpty)
                    Text(
                      "Tasks: ${(record["tasks_completed"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 11,
                        color: primaryColor,
                      ),
                    ),
                ],
              ),
            ),
          Row(
            children: [
              if (record["check_in_method"] != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${record["check_in_method"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (record["photo_verification"] == true)
                Container(
                  margin: EdgeInsets.only(left: spSm),
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "PHOTO VERIFIED",
                    style: TextStyle(
                      fontSize: 9,
                      color: successColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              Spacer(),
              if (record["gps_location"] != null)
                Icon(Icons.location_on, color: successColor, size: 16),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person, color: disabledBoldColor, size: 16),
              SizedBox(width: spXs),
              Text(
                "Supervisor: ${record["supervisor"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "Weather: ${record["weather_conditions"]} ${record["temperature"]}°F",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (record["notes"] != null && record["notes"].toString().isNotEmpty)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.grey.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.note, color: disabledBoldColor, size: 16),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${record["notes"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Employee ID: ${record["employee_id"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.visibility,
                size: bs.sm,
                onPressed: () => _viewAttendanceDetails(record["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () => _editAttendanceRecord(record["id"]),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () => _showAttendanceOptions(record),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreIndicator(String label, int score, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (score as num) / 100,
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
            "$score%",
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceIndicator(bool? compliant) {
    Color color = compliant == true ? successColor : compliant == false ? dangerColor : disabledBoldColor;
    
    return Expanded(
      child: Column(
        children: [
          Icon(compliant == true ? Icons.check_circle : compliant == false ? Icons.cancel : Icons.help, 
               color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            compliant == true ? "Yes" : compliant == false ? "No" : "N/A",
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Break Compliance",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyIndicator(int incidents) {
    Color color = incidents == 0 ? successColor : dangerColor;
    
    return Expanded(
      child: Column(
        children: [
          Icon(incidents == 0 ? Icons.security : Icons.warning, color: color, size: 16),
          SizedBox(height: spXs),
          Text(
            "$incidents",
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Safety Incidents",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredRecords() {
    List<Map<String, dynamic>> filtered = attendanceRecords;

    if (selectedProject != "all") {
      filtered = filtered.where((record) => 
          record["project_name"].toString().toLowerCase().contains(selectedProject)).toList();
    }

    if (selectedShift != "all") {
      filtered = filtered.where((record) => record["shift"] == selectedShift).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((record) =>
          record["employee_name"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          record["project_name"].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return successColor;
      case 'late':
        return warningColor;
      case 'absent':
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _markAttendance() {
    ss("Mark attendance manually");
  }

  void _showAttendanceAnalytics() {
    ss("Attendance analytics");
  }

  void _showAdvancedFilters() {
    ss("Advanced attendance filters");
  }

  void _showSortOptions() {
    ss("Attendance sort options");
  }

  void _viewAttendanceDetails(String recordId) {
    ss("View attendance details $recordId");
  }

  void _editAttendanceRecord(String recordId) {
    ss("Edit attendance record $recordId");
  }

  void _showAttendanceOptions(Map<String, dynamic> record) {
    ss("Attendance options for ${record["employee_name"]}");
  }
}
