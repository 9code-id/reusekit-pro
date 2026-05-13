import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaAttendanceTrackingView extends StatefulWidget {
  const AmaAttendanceTrackingView({super.key});

  @override
  State<AmaAttendanceTrackingView> createState() => _AmaAttendanceTrackingViewState();
}

class _AmaAttendanceTrackingViewState extends State<AmaAttendanceTrackingView> {
  int selectedTabIndex = 0;
  String selectedStatus = "All";
  String searchQuery = "";
  String selectedPeriod = "today";

  List<Map<String, dynamic>> attendanceRecords = [
    {
      "id": "ATT001",
      "worker_name": "Juan Martinez",
      "worker_id": "WRK001",
      "date": "2024-12-16",
      "check_in": "07:30",
      "check_out": "17:15",
      "hours_worked": 9.75,
      "break_time": 0.75,
      "overtime": 1.75,
      "location": "Field Block A",
      "task": "Corn Harvesting",
      "status": "Present",
      "photo_check_in": "https://picsum.photos/100/100?random=201",
    },
    {
      "id": "ATT002",
      "worker_name": "Maria Santos",
      "worker_id": "WRK002",
      "date": "2024-12-16",
      "check_in": "08:00",
      "check_out": "16:30",
      "hours_worked": 8.0,
      "break_time": 0.5,
      "overtime": 0.0,
      "location": "Greenhouse 2",
      "task": "Tomato Care",
      "status": "Present",
      "photo_check_in": "https://picsum.photos/100/100?random=202",
    },
    {
      "id": "ATT003",
      "worker_name": "Carlos Rodriguez",
      "worker_id": "WRK003",
      "date": "2024-12-16",
      "check_in": null,
      "check_out": null,
      "hours_worked": 0.0,
      "break_time": 0.0,
      "overtime": 0.0,
      "location": "Field Block B",
      "task": "Wheat Planting",
      "status": "Absent",
      "photo_check_in": null,
    },
    {
      "id": "ATT004",
      "worker_name": "Ana Lopez",
      "worker_id": "WRK004",
      "date": "2024-12-16",
      "check_in": "07:45",
      "check_out": "12:00",
      "hours_worked": 4.25,
      "break_time": 0.0,
      "overtime": 0.0,
      "location": "Storage Facility",
      "task": "Equipment Maintenance",
      "status": "Half Day",
      "photo_check_in": "https://picsum.photos/100/100?random=204",
    },
    {
      "id": "ATT005",
      "worker_name": "Roberto Silva",
      "worker_id": "WRK005",
      "date": "2024-12-16",
      "check_in": "08:15",
      "check_out": "17:30",
      "hours_worked": 9.25,
      "break_time": 1.0,
      "overtime": 1.25,
      "location": "Field Block C",
      "task": "Irrigation Setup",
      "status": "Late",
      "photo_check_in": "https://picsum.photos/100/100?random=205",
    },
  ];

  List<Map<String, dynamic>> shiftSchedules = [
    {
      "id": "SH001",
      "shift_name": "Morning Shift",
      "start_time": "07:00",
      "end_time": "15:00",
      "workers_assigned": 12,
      "workers_present": 10,
      "status": "Active",
      "supervisor": "Miguel Torres",
      "location": "Field Operations",
    },
    {
      "id": "SH002",
      "shift_name": "Afternoon Shift",
      "start_time": "15:00",
      "end_time": "23:00",
      "workers_assigned": 8,
      "workers_present": 7,
      "status": "Active",
      "supervisor": "Carmen Ruiz",
      "location": "Processing Plant",
    },
    {
      "id": "SH003",
      "shift_name": "Night Shift",
      "start_time": "23:00",
      "end_time": "07:00",
      "workers_assigned": 5,
      "workers_present": 4,
      "status": "Scheduled",
      "supervisor": "Diego Morales",
      "location": "Security & Maintenance",
    },
  ];

  List<Map<String, dynamic>> attendanceReports = [
    {
      "period": "December 2024",
      "total_workers": 25,
      "present_percentage": 88.5,
      "absent_percentage": 7.2,
      "late_percentage": 4.3,
      "total_hours": 4240.5,
      "overtime_hours": 186.25,
      "average_hours_per_worker": 169.6,
    },
    {
      "period": "November 2024",
      "total_workers": 24,
      "present_percentage": 91.2,
      "absent_percentage": 5.8,
      "late_percentage": 3.0,
      "total_hours": 4018.0,
      "overtime_hours": 142.75,
      "average_hours_per_worker": 167.4,
    },
    {
      "period": "October 2024",
      "total_workers": 26,
      "present_percentage": 89.8,
      "absent_percentage": 6.5,
      "late_percentage": 3.7,
      "total_hours": 4356.5,
      "overtime_hours": 198.25,
      "average_hours_per_worker": 167.6,
    },
  ];

  List<Map<String, dynamic>> get filteredAttendance {
    List<Map<String, dynamic>> filtered = attendanceRecords;
    
    if (selectedStatus != "All") {
      filtered = filtered.where((record) => record["status"] == selectedStatus).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((record) =>
        (record["worker_name"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (record["worker_id"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (record["task"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  Widget _buildDailyAttendanceTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 160,
            children: [
              _buildStatCard("Present", "${filteredAttendance.where((r) => r["status"] == "Present").length}", Icons.check_circle, successColor),
              _buildStatCard("Absent", "${filteredAttendance.where((r) => r["status"] == "Absent").length}", Icons.cancel, dangerColor),
              _buildStatCard("Late", "${filteredAttendance.where((r) => r["status"] == "Late").length}", Icons.access_time, warningColor),
              _buildStatCard("Half Day", "${filteredAttendance.where((r) => r["status"] == "Half Day").length}", Icons.schedule, infoColor),
            ],
          ),

          // Filters
          Row(
            spacing: spSm,
            children: [
              Expanded(
                flex: 2,
                child: QTextField(
                  label: "Search workers...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: QDropdownField(
                  label: "Status",
                  items: [
                    {"label": "All", "value": "All"},
                    {"label": "Present", "value": "Present"},
                    {"label": "Absent", "value": "Absent"},
                    {"label": "Late", "value": "Late"},
                    {"label": "Half Day", "value": "Half Day"},
                  ],
                  value: selectedStatus,
                  onChanged: (value, label) {
                    selectedStatus = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Attendance Records
          ...filteredAttendance.map((record) => _buildAttendanceCard(record)),
        ],
      ),
    );
  }

  Widget _buildShiftManagementTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Quick Actions
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Start Shift",
                  icon: Icons.play_arrow,
                  onPressed: () {
                    ss("Shift started successfully");
                  },
                ),
              ),
              Expanded(
                child: QButton(
                  label: "End Shift",
                  icon: Icons.stop,
                  onPressed: () {
                    ss("Shift ended successfully");
                  },
                ),
              ),
            ],
          ),

          // Shift Cards
          ...shiftSchedules.map((shift) => _buildShiftCard(shift)),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Period Selector
          QDropdownField(
            label: "Report Period",
            items: [
              {"label": "Today", "value": "today"},
              {"label": "This Week", "value": "week"},
              {"label": "This Month", "value": "month"},
              {"label": "Last 3 Months", "value": "quarter"},
            ],
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),

          // Report Cards
          ...attendanceReports.map((report) => _buildReportCard(report)),

          // Export Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Export Report",
              icon: Icons.download,
              onPressed: () {
                ss("Report exported successfully");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(Map<String, dynamic> record) {
    Color statusColor = _getStatusColor(record["status"]);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(width: 4, color: statusColor),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              if (record["photo_check_in"] != null)
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("${record["photo_check_in"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(Icons.person, color: disabledBoldColor),
                ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${record["worker_name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "ID: ${record["worker_id"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${record["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Task", "${record["task"]}", Icons.work),
              ),
              Expanded(
                child: _buildDetailItem("Location", "${record["location"]}", Icons.location_on),
              ),
            ],
          ),
          
          if (record["check_in"] != null)
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem("Check In", "${record["check_in"]}", Icons.login),
                ),
                Expanded(
                  child: _buildDetailItem("Check Out", "${record["check_out"] ?? "Not yet"}", Icons.logout),
                ),
              ],
            ),
          
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Hours", "${(record["hours_worked"] as num).toStringAsFixed(1)}h", Icons.schedule),
              ),
              if ((record["overtime"] as num) > 0)
                Expanded(
                  child: _buildDetailItem("Overtime", "${(record["overtime"] as num).toStringAsFixed(1)}h", Icons.access_time),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(Map<String, dynamic> shift) {
    Color statusColor = shift["status"] == "Active" ? successColor : infoColor;
    double presentPercentage = ((shift["workers_present"] as int) / (shift["workers_assigned"] as int)) * 100;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${shift["shift_name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${shift["start_time"]} - ${shift["end_time"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${shift["status"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: _buildDetailItem("Supervisor", "${shift["supervisor"]}", Icons.person),
              ),
              Expanded(
                child: _buildDetailItem("Location", "${shift["location"]}", Icons.location_on),
              ),
            ],
          ),
          
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attendance",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${shift["workers_present"]}/${shift["workers_assigned"]} workers",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Present Rate",
                      style: TextStyle(fontSize: 12, color: disabledBoldColor),
                    ),
                    Text(
                      "${presentPercentage.toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: presentPercentage >= 90 ? successColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Text(
            "${report["period"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 120,
            children: [
              _buildReportStatItem("Total Workers", "${report["total_workers"]}", Icons.people),
              _buildReportStatItem("Avg Hours/Worker", "${(report["average_hours_per_worker"] as num).toStringAsFixed(1)}h", Icons.schedule),
              _buildReportStatItem("Total Hours", "${(report["total_hours"] as num).toStringAsFixed(0)}h", Icons.access_time),
              _buildReportStatItem("Overtime", "${(report["overtime_hours"] as num).toStringAsFixed(0)}h", Icons.timer),
            ],
          ),
          
          Column(
            spacing: spSm,
            children: [
              _buildPercentageBar("Present", report["present_percentage"], successColor),
              _buildPercentageBar("Absent", report["absent_percentage"], dangerColor),
              _buildPercentageBar("Late", report["late_percentage"], warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: disabledBoldColor),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10, color: disabledBoldColor),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReportStatItem(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(icon, color: primaryColor, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPercentageBar(String label, dynamic percentage, Color color) {
    double value = (percentage as num).toDouble();
    
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: disabledBoldColor),
            ),
            Spacer(),
            Text(
              "${value.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: spXs),
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: disabledColor,
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Present":
        return successColor;
      case "Absent":
        return dangerColor;
      case "Late":
        return warningColor;
      case "Half Day":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Attendance Tracking",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Daily Attendance", icon: Icon(Icons.today)),
        Tab(text: "Shift Management", icon: Icon(Icons.schedule)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildDailyAttendanceTab(),
        _buildShiftManagementTab(),
        _buildReportsTab(),
      ],
    );
  }
}
