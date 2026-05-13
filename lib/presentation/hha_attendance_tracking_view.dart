import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaAttendanceTrackingView extends StatefulWidget {
  const HhaAttendanceTrackingView({super.key});

  @override
  State<HhaAttendanceTrackingView> createState() => _HhaAttendanceTrackingViewState();
}

class _HhaAttendanceTrackingViewState extends State<HhaAttendanceTrackingView> {
  int currentTab = 0;
  String searchQuery = "";
  String departmentFilter = "all";
  String statusFilter = "all";
  String selectedDate = DateTime.now().toString().split(' ')[0];

  List<Map<String, dynamic>> attendanceData = [
    {
      "id": "AT001",
      "employeeId": "EMP001",
      "employeeName": "John Smith",
      "department": "front_desk",
      "position": "Receptionist",
      "date": "2024-01-15",
      "scheduledIn": "09:00",
      "scheduledOut": "17:00",
      "actualIn": "08:55",
      "actualOut": "17:10",
      "status": "present",
      "hoursWorked": 8.25,
      "overtimeHours": 0.25,
      "breakTime": 1.0,
      "location": "Front Desk",
      "notes": "Early arrival",
      "isApproved": true,
    },
    {
      "id": "AT002",
      "employeeId": "EMP002",
      "employeeName": "Sarah Johnson",
      "department": "housekeeping",
      "position": "Housekeeper",
      "date": "2024-01-15",
      "scheduledIn": "07:00",
      "scheduledOut": "15:00",
      "actualIn": "07:15",
      "actualOut": "14:45",
      "status": "present",
      "hoursWorked": 7.5,
      "overtimeHours": 0.0,
      "breakTime": 1.0,
      "location": "Hotel Floors",
      "notes": "Late arrival - traffic",
      "isApproved": false,
    },
    {
      "id": "AT003",
      "employeeId": "EMP003",
      "employeeName": "Maria Garcia",
      "department": "kitchen",
      "position": "Chef",
      "date": "2024-01-15",
      "scheduledIn": "06:00",
      "scheduledOut": "14:00",
      "actualIn": null,
      "actualOut": null,
      "status": "absent",
      "hoursWorked": 0.0,
      "overtimeHours": 0.0,
      "breakTime": 0.0,
      "location": "Kitchen",
      "notes": "Sick leave",
      "isApproved": true,
    },
    {
      "id": "AT004",
      "employeeId": "EMP004",
      "employeeName": "Mike Johnson",
      "department": "security",
      "position": "Security Guard",
      "date": "2024-01-15",
      "scheduledIn": "22:00",
      "scheduledOut": "06:00",
      "actualIn": "21:45",
      "actualOut": "06:15",
      "status": "present",
      "hoursWorked": 8.5,
      "overtimeHours": 0.5,
      "breakTime": 1.0,
      "location": "Lobby",
      "notes": "Night shift overtime",
      "isApproved": false,
    },
    {
      "id": "AT005",
      "employeeId": "EMP005",
      "employeeName": "David Wilson",
      "department": "maintenance",
      "position": "Maintenance Tech",
      "date": "2024-01-15",
      "scheduledIn": "08:00",
      "scheduledOut": "16:00",
      "actualIn": "08:30",
      "actualOut": null,
      "status": "partial",
      "hoursWorked": 0.0,
      "overtimeHours": 0.0,
      "breakTime": 0.0,
      "location": "Maintenance Room",
      "notes": "Left early - emergency",
      "isApproved": false,
    },
  ];

  List<Map<String, dynamic>> employeeList = [
    {"id": "EMP001", "name": "John Smith", "department": "front_desk", "position": "Receptionist"},
    {"id": "EMP002", "name": "Sarah Johnson", "department": "housekeeping", "position": "Housekeeper"},
    {"id": "EMP003", "name": "Maria Garcia", "department": "kitchen", "position": "Chef"},
    {"id": "EMP004", "name": "Mike Johnson", "department": "security", "position": "Security Guard"},
    {"id": "EMP005", "name": "David Wilson", "department": "maintenance", "position": "Maintenance Tech"},
    {"id": "EMP006", "name": "Lisa Brown", "department": "housekeeping", "position": "Supervisor"},
    {"id": "EMP007", "name": "Robert Davis", "department": "front_desk", "position": "Manager"},
  ];

  List<Map<String, dynamic>> departmentItems = [
    {"label": "All Departments", "value": "all"},
    {"label": "Front Desk", "value": "front_desk"},
    {"label": "Housekeeping", "value": "housekeeping"},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Security", "value": "security"},
    {"label": "Maintenance", "value": "maintenance"},
  ];

  List<Map<String, dynamic>> statusItems = [
    {"label": "All Status", "value": "all"},
    {"label": "Present", "value": "present"},
    {"label": "Absent", "value": "absent"},
    {"label": "Partial", "value": "partial"},
    {"label": "Late", "value": "late"},
  ];

  List<Map<String, dynamic>> timeOptions = [
    {"label": "12:00 AM", "value": "00:00"},
    {"label": "01:00 AM", "value": "01:00"},
    {"label": "02:00 AM", "value": "02:00"},
    {"label": "03:00 AM", "value": "03:00"},
    {"label": "04:00 AM", "value": "04:00"},
    {"label": "05:00 AM", "value": "05:00"},
    {"label": "06:00 AM", "value": "06:00"},
    {"label": "07:00 AM", "value": "07:00"},
    {"label": "08:00 AM", "value": "08:00"},
    {"label": "09:00 AM", "value": "09:00"},
    {"label": "10:00 AM", "value": "10:00"},
    {"label": "11:00 AM", "value": "11:00"},
    {"label": "12:00 PM", "value": "12:00"},
    {"label": "01:00 PM", "value": "13:00"},
    {"label": "02:00 PM", "value": "14:00"},
    {"label": "03:00 PM", "value": "15:00"},
    {"label": "04:00 PM", "value": "16:00"},
    {"label": "05:00 PM", "value": "17:00"},
    {"label": "06:00 PM", "value": "18:00"},
    {"label": "07:00 PM", "value": "19:00"},
    {"label": "08:00 PM", "value": "20:00"},
    {"label": "09:00 PM", "value": "21:00"},
    {"label": "10:00 PM", "value": "22:00"},
    {"label": "11:00 PM", "value": "23:00"},
  ];

  // Manual entry form fields
  String selectedEmployeeId = "";
  String clockInTime = DateTime.now().toString().substring(11, 16);
  String clockOutTime = "";
  String attendanceNotes = "";

  List<Map<String, dynamic>> get filteredAttendance {
    return attendanceData.where((attendance) {
      bool matchesSearch = attendance["employeeName"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          attendance["employeeId"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
          attendance["position"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesDepartment = departmentFilter == "all" || attendance["department"] == departmentFilter;
      bool matchesStatus = statusFilter == "all" || attendance["status"] == statusFilter;
      bool matchesDate = attendance["date"] == selectedDate;
      return matchesSearch && matchesDepartment && matchesStatus && matchesDate;
    }).toList();
  }

  int get totalEmployees => filteredAttendance.length;
  int get presentEmployees => filteredAttendance.where((a) => a["status"] == "present").length;
  int get absentEmployees => filteredAttendance.where((a) => a["status"] == "absent").length;
  int get partialEmployees => filteredAttendance.where((a) => a["status"] == "partial").length;

  double get totalHoursWorked {
    return filteredAttendance.fold(0.0, (sum, attendance) => sum + (attendance["hoursWorked"] as double));
  }

  double get totalOvertimeHours {
    return filteredAttendance.fold(0.0, (sum, attendance) => sum + (attendance["overtimeHours"] as double));
  }

  double get attendanceRate {
    if (totalEmployees == 0) return 0.0;
    return (presentEmployees / totalEmployees) * 100;
  }

  void _recordAttendance() {
    if (selectedEmployeeId.isNotEmpty && clockInTime.isNotEmpty) {
      final employee = employeeList.firstWhere((emp) => emp["id"] == selectedEmployeeId);
      
      final newAttendance = {
        "id": "AT${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}",
        "employeeId": selectedEmployeeId,
        "employeeName": employee["name"],
        "department": employee["department"],
        "position": employee["position"],
        "date": selectedDate,
        "scheduledIn": "09:00",
        "scheduledOut": "17:00",
        "actualIn": clockInTime,
        "actualOut": clockOutTime.isNotEmpty ? clockOutTime : null,
        "status": clockOutTime.isNotEmpty ? "present" : "partial",
        "hoursWorked": clockOutTime.isNotEmpty ? _calculateHours(clockInTime, clockOutTime) : 0.0,
        "overtimeHours": 0.0,
        "breakTime": 1.0,
        "location": "Manual Entry",
        "notes": attendanceNotes,
        "isApproved": false,
      };

      attendanceData.add(newAttendance);
      
      // Reset form
      selectedEmployeeId = "";
      clockInTime = DateTime.now().toString().substring(11, 16);
      clockOutTime = "";
      attendanceNotes = "";
      
      setState(() {});
      ss("Attendance recorded successfully");
    }
  }

  double _calculateHours(String start, String end) {
    if (start.isEmpty || end.isEmpty) return 0.0;
    
    final startParts = start.split(':');
    final endParts = end.split(':');
    
    final startMinutes = int.parse(startParts[0]) * 60 + int.parse(startParts[1]);
    final endMinutes = int.parse(endParts[0]) * 60 + int.parse(endParts[1]);
    
    int diffMinutes = endMinutes - startMinutes;
    if (diffMinutes < 0) {
      diffMinutes += 24 * 60; // Handle overnight shifts
    }
    
    return diffMinutes / 60.0;
  }

  void _approveAttendance(String attendanceId) {
    final index = attendanceData.indexWhere((a) => a["id"] == attendanceId);
    if (index != -1) {
      attendanceData[index]["isApproved"] = true;
      setState(() {});
      ss("Attendance approved");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Attendance Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Daily Attendance", icon: Icon(Icons.today)),
        Tab(text: "Manual Entry", icon: Icon(Icons.add_circle)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildDailyAttendanceTab(),
        _buildManualEntryTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildDailyAttendanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Present",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$presentEmployees",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Absent",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$absentEmployees",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attendance Rate",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${attendanceRate.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: attendanceRate >= 90 ? successColor : attendanceRate >= 70 ? warningColor : dangerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Hours",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${totalHoursWorked.toStringAsFixed(1)}h",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Date Selection and Filters
          QDatePicker(
            label: "Select Date",
            value: DateTime.parse(selectedDate),
            onChanged: (value) {
              selectedDate = value.toString().split(' ')[0];
              setState(() {});
            },
          ),

          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search employees...",
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
                onPressed: () {},
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departmentItems,
                  value: departmentFilter,
                  onChanged: (value, label) {
                    departmentFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: statusItems,
                  value: statusFilter,
                  onChanged: (value, label) {
                    statusFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Attendance List
          Text(
            "Attendance for ${DateTime.parse(selectedDate).toString().split(' ')[0]} (${filteredAttendance.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: filteredAttendance.length,
            itemBuilder: (context, index) {
              final attendance = filteredAttendance[index];
              Color statusColor = attendance["status"] == "present" ? successColor :
                  attendance["status"] == "absent" ? dangerColor :
                  attendance["status"] == "partial" ? warningColor : infoColor;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${attendance["employeeName"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${attendance["position"]} • ${attendance["department"]}".replaceAll('_', ' ').toUpperCase(),
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
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${attendance["status"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            if (!(attendance["isApproved"] as bool))
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "PENDING",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    if (attendance["status"] != "absent")
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (attendance["actualIn"] != null)
                                  Text("Clock In: ${attendance["actualIn"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                if (attendance["actualOut"] != null)
                                  Text("Clock Out: ${attendance["actualOut"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                Text("Hours: ${(attendance["hoursWorked"] as double).toStringAsFixed(1)}h", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                                if ((attendance["overtimeHours"] as double) > 0)
                                  Text("Overtime: ${(attendance["overtimeHours"] as double).toStringAsFixed(1)}h", style: TextStyle(fontSize: 12, color: dangerColor, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          if (!(attendance["isApproved"] as bool))
                            QButton(
                              label: "Approve",
                              size: bs.sm,
                              onPressed: () => _approveAttendance(attendance["id"]),
                            ),
                        ],
                      ),

                    if (attendance["notes"].toString().isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, size: 16, color: infoColor),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${attendance["notes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildManualEntryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Manual Attendance Entry",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
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
              spacing: spMd,
              children: [
                Text(
                  "Record Attendance",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                QDropdownField(
                  label: "Select Employee",
                  items: employeeList.map((emp) => {
                    "label": "${emp["name"]} - ${emp["position"]}",
                    "value": emp["id"],
                  }).toList(),
                  value: selectedEmployeeId.isNotEmpty ? selectedEmployeeId : employeeList.first["id"],
                  onChanged: (value, label) {
                    selectedEmployeeId = value;
                    setState(() {});
                  },
                ),

                QDatePicker(
                  label: "Date",
                  value: DateTime.parse(selectedDate),
                  onChanged: (value) {
                    selectedDate = value.toString().split(' ')[0];
                    setState(() {});
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: QTimePicker(
                        label: "Clock In Time",
                        value: TimeOfDay(
                          hour: int.parse(clockInTime.split(':')[0]),
                          minute: int.parse(clockInTime.split(':')[1]),
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            clockInTime = "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}";
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QTimePicker(
                        label: "Clock Out Time (Optional)",
                        value: clockOutTime.isNotEmpty ? TimeOfDay(
                          hour: int.parse(clockOutTime.split(':')[0]),
                          minute: int.parse(clockOutTime.split(':')[1]),
                        ) : null,
                        onChanged: (value) {
                          if (value != null) {
                            clockOutTime = "${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}";
                          } else {
                            clockOutTime = "";
                          }
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                QMemoField(
                  label: "Notes (Optional)",
                  value: attendanceNotes,
                  onChanged: (value) {
                    attendanceNotes = value;
                    setState(() {});
                  },
                ),

                // Summary
                if (clockInTime.isNotEmpty && clockOutTime.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Total Hours",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          "${_calculateHours(clockInTime, clockOutTime).toStringAsFixed(1)} hours",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Record Attendance",
                    size: bs.md,
                    onPressed: _recordAttendance,
                  ),
                ),
              ],
            ),
          ),

          // Quick Clock In/Out
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.login,
                        size: 48,
                        color: successColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Clock In",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Clock In Now",
                          size: bs.sm,
                          onPressed: () {
                            clockInTime = DateTime.now().toString().substring(11, 16);
                            setState(() {});
                            ss("Clock in time set to current time");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 48,
                        color: dangerColor,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "Clock Out",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: "Clock Out Now",
                          size: bs.sm,
                          onPressed: () {
                            clockOutTime = DateTime.now().toString().substring(11, 16);
                            setState(() {});
                            ss("Clock out time set to current time");
                          },
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

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Attendance Reports",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Weekly Summary
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
                  "Weekly Summary",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Average Attendance",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "87.5%",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Hours",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "324.5h",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: disabledOutlineBorderColor,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Overtime",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "12.5h",
                            style: TextStyle(
                              fontSize: fsH5,
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

          // Department Breakdown
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
                  "Department Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final departments = ["front_desk", "housekeeping", "kitchen", "security", "maintenance"];
                    final colors = [primaryColor, successColor, warningColor, infoColor, dangerColor];
                    final rates = [92.3, 88.7, 85.2, 94.1, 78.9];
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: colors[index].withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: colors[index],
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Text(
                              departments[index].replaceAll('_', ' ').toUpperCase(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "${rates[index]}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: colors[index],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Recent Activity
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
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final activities = [
                      {"type": "clock_in", "employee": "John Smith", "time": "08:55", "status": "early"},
                      {"type": "clock_out", "employee": "Sarah Johnson", "time": "17:10", "status": "overtime"},
                      {"type": "absence", "employee": "Maria Garcia", "time": "All Day", "status": "sick"},
                      {"type": "late", "employee": "Mike Johnson", "time": "09:15", "status": "late"},
                      {"type": "clock_in", "employee": "David Wilson", "time": "08:00", "status": "on_time"},
                    ];
                    
                    final activity = activities[index];
                    Color activityColor = activity["status"] == "early" || activity["status"] == "on_time" ? successColor :
                        activity["status"] == "late" ? warningColor :
                        activity["status"] == "overtime" ? infoColor : dangerColor;
                    
                    IconData activityIcon = activity["type"] == "clock_in" ? Icons.login :
                        activity["type"] == "clock_out" ? Icons.logout :
                        activity["type"] == "absence" ? Icons.person_off :
                        activity["type"] == "late" ? Icons.access_time : Icons.person;

                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        color: activityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: activityColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              activityIcon,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          SizedBox(width: spMd),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${activity["employee"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${activity["type"]}".replaceAll('_', ' ').toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
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
                                "${activity["time"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: activityColor,
                                ),
                              ),
                              Text(
                                "${activity["status"]}".replaceAll('_', ' ').toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
