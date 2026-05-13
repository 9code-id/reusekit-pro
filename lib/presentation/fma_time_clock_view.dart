import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaTimeClockView extends StatefulWidget {
  const FmaTimeClockView({super.key});

  @override
  State<FmaTimeClockView> createState() => _FmaTimeClockViewState();
}

class _FmaTimeClockViewState extends State<FmaTimeClockView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedDepartment = "";
  String selectedStatus = "";
  String clockInTime = "09:00";
  String clockOutTime = "17:00";
  String breakStartTime = "12:00";
  String breakEndTime = "13:00";
  String notes = "";
  bool isTracking = false;
  String currentSession = "Not Clocked In";

  List<Map<String, dynamic>> departments = [
    {"label": "All Departments", "value": ""},
    {"label": "Kitchen", "value": "kitchen"},
    {"label": "Service", "value": "service"},
    {"label": "Management", "value": "management"},
    {"label": "Cleaning", "value": "cleaning"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Clocked In", "value": "clocked_in"},
    {"label": "On Break", "value": "on_break"},
    {"label": "Clocked Out", "value": "clocked_out"},
    {"label": "Overtime", "value": "overtime"},
  ];

  List<Map<String, dynamic>> timeRecords = [
    {
      "id": 1,
      "employee": "John Smith",
      "department": "Kitchen",
      "date": "2024-01-15",
      "clockIn": "08:30",
      "clockOut": "17:15",
      "breakStart": "12:00",
      "breakEnd": "12:45",
      "totalHours": 8.25,
      "overtime": 0.25,
      "status": "Completed",
      "notes": "Late arrival due to traffic"
    },
    {
      "id": 2,
      "employee": "Sarah Johnson",
      "department": "Service",
      "date": "2024-01-15",
      "clockIn": "09:00",
      "clockOut": "",
      "breakStart": "13:00",
      "breakEnd": "13:30",
      "totalHours": 0,
      "overtime": 0,
      "status": "Clocked In",
      "notes": ""
    },
    {
      "id": 3,
      "employee": "Mike Davis",
      "department": "Kitchen",
      "date": "2024-01-15",
      "clockIn": "07:00",
      "clockOut": "16:30",
      "breakStart": "11:30",
      "breakEnd": "12:15",
      "totalHours": 8.75,
      "overtime": 0.75,
      "status": "Completed",
      "notes": "Early shift"
    },
    {
      "id": 4,
      "employee": "Emma Wilson",
      "department": "Management",
      "date": "2024-01-15",
      "clockIn": "08:00",
      "clockOut": "",
      "breakStart": "",
      "breakEnd": "",
      "totalHours": 0,
      "overtime": 0,
      "status": "On Break",
      "notes": ""
    },
  ];

  List<Map<String, dynamic>> currentSessions = [
    {
      "employee": "Sarah Johnson",
      "department": "Service",
      "status": "Clocked In",
      "clockIn": "09:00",
      "duration": "6h 45m",
      "location": "Main Counter"
    },
    {
      "employee": "Emma Wilson",
      "department": "Management",
      "status": "On Break",
      "clockIn": "08:00",
      "duration": "7h 30m",
      "location": "Office"
    },
    {
      "employee": "Tom Brown",
      "department": "Kitchen",
      "status": "Clocked In",
      "clockIn": "10:00",
      "duration": "5h 45m",
      "location": "Kitchen Station 2"
    },
  ];

  void _clockIn() {
    setState(() {
      isTracking = true;
      currentSession = "Clocked In at ${TimeOfDay.now().format(context)}";
    });
    ss("Successfully clocked in");
  }

  void _clockOut() {
    setState(() {
      isTracking = false;
      currentSession = "Not Clocked In";
    });
    ss("Successfully clocked out");
  }

  void _startBreak() {
    setState(() {
      currentSession = "On Break since ${TimeOfDay.now().format(context)}";
    });
    ss("Break started");
  }

  void _endBreak() {
    setState(() {
      currentSession = "Back from break";
    });
    ss("Break ended");
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildQuickClockCard(),
          _buildTodayStatsGrid(),
          _buildCurrentSessionsSection(),
          _buildRecentActivitySection(),
        ],
      ),
    );
  }

  Widget _buildQuickClockCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            Icons.access_time,
            color: Colors.white,
            size: 32,
          ),
          Text(
            "Quick Time Clock",
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            currentSession,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withAlpha(230),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: isTracking ? "Clock Out" : "Clock In",
                  color: isTracking ? warningColor : successColor,
                  size: bs.md,
                  onPressed: isTracking ? _clockOut : _clockIn,
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Break",
                  color: infoColor,
                  size: bs.md,
                  onPressed: _startBreak,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStatsGrid() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildStatCard("Total Employees", "24", Icons.people, primaryColor),
        _buildStatCard("Currently Working", "18", Icons.work, successColor),
        _buildStatCard("On Break", "3", Icons.coffee, warningColor),
        _buildStatCard("Total Hours Today", "192", Icons.schedule, infoColor),
        _buildStatCard("Overtime Hours", "12", Icons.access_time_filled, dangerColor),
        _buildStatCard("Late Arrivals", "2", Icons.schedule_outlined, warningColor),
      ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Icon(
                Icons.trending_up,
                color: successColor,
                size: 16,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentSessionsSection() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.group,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Current Active Sessions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${currentSessions.length} Active",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: successColor,
                  ),
                ),
              ),
            ],
          ),
          ...currentSessions.map((session) => _buildSessionCard(session)),
        ],
      ),
    );
  }

  Widget _buildSessionCard(Map<String, dynamic> session) {
    Color statusColor = session["status"] == "Clocked In" 
        ? successColor 
        : session["status"] == "On Break" 
            ? warningColor 
            : primaryColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: statusColor.withAlpha(50),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              session["status"] == "On Break" ? Icons.coffee : Icons.person,
              color: statusColor,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${session["employee"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${session["department"]} • ${session["location"]}",
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
            spacing: spXs,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${session["status"]}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "${session["duration"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
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
          Row(
            children: [
              Icon(
                Icons.history,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...timeRecords.take(3).map((record) => _buildActivityItem(record)),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> record) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 40,
            decoration: BoxDecoration(
              color: record["status"] == "Completed" ? successColor : primaryColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spXs,
              children: [
                Text(
                  "${record["employee"]} - ${record["department"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${record["clockIn"]} - ${record["clockOut"] ?? "In Progress"}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          if (record["overtime"] > 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "+${record["overtime"]}h OT",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildManagementTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildTimeRecordsTable(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
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
          QTextField(
            label: "Search employees or notes",
            value: searchQuery,
            hint: "Enter employee name or notes",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Department",
                  items: departments,
                  value: selectedDepartment,
                  onChanged: (value, label) {
                    selectedDepartment = value;
                    setState(() {});
                  },
                ),
              ),
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
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: QButton(
                  label: "Export Report",
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () => ss("Exporting time clock report"),
                ),
              ),
              Expanded(
                child: QButton(
                  label: "Add Manual Entry",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () => _showManualEntryDialog(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRecordsTable() {
    return Container(
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
            "Time Records",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(primaryColor.withAlpha(25)),
              columns: [
                DataColumn(label: Text("Employee", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Department", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Date", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Clock In", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Clock Out", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Total Hours", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Actions", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: timeRecords.map((record) {
                Color statusColor = record["status"] == "Completed" 
                    ? successColor 
                    : record["status"] == "Clocked In" 
                        ? primaryColor 
                        : warningColor;

                return DataRow(
                  cells: [
                    DataCell(Text("${record["employee"]}")),
                    DataCell(Text("${record["department"]}")),
                    DataCell(Text("${record["date"]}")),
                    DataCell(Text("${record["clockIn"]}")),
                    DataCell(Text("${record["clockOut"] ?? "In Progress"}")),
                    DataCell(Text("${record["totalHours"] > 0 ? record["totalHours"] : "--"}")),
                    DataCell(
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${record["status"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: spXs,
                        children: [
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () => _showEditDialog(record),
                          ),
                          QButton(
                            icon: Icons.delete,
                            color: dangerColor,
                            size: bs.sm,
                            onPressed: () => _deleteRecord(record["id"]),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showManualEntryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Manual Time Entry"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            QTextField(
              label: "Employee Name",
              value: "",
              onChanged: (value) {},
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Clock In Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${clockInTime}:00")),
                    onChanged: (value) {
                      clockInTime = value!.format(context);
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QTimePicker(
                    label: "Clock Out Time",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${clockOutTime}:00")),
                    onChanged: (value) {
                      clockOutTime = value!.format(context);
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            QMemoField(
              label: "Notes",
              value: notes,
              hint: "Add any additional notes",
              onChanged: (value) {
                notes = value;
                setState(() {});
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Save Entry",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Manual time entry added successfully");
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> record) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Time Record"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spMd,
          children: [
            Text(
              "Editing record for ${record["employee"]}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QTimePicker(
                    label: "Clock In",
                    value: TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${record["clockIn"]}:00")),
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: QTimePicker(
                    label: "Clock Out",
                    value: record["clockOut"] != null && record["clockOut"] != ""
                        ? TimeOfDay.fromDateTime(DateTime.parse("2024-01-01 ${record["clockOut"]}:00"))
                        : TimeOfDay.now(),
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            QMemoField(
              label: "Notes",
              value: record["notes"] ?? "",
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Update Record",
            size: bs.sm,
            onPressed: () {
              Navigator.pop(context);
              ss("Time record updated successfully");
            },
          ),
        ],
      ),
    );
  }

  void _deleteRecord(int id) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this time record?");
    if (isConfirmed) {
      setState(() {
        timeRecords.removeWhere((record) => record["id"] == id);
      });
      ss("Time record deleted successfully");
    }
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Time Clock Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Time Records", icon: Icon(Icons.schedule)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildManagementTab(),
      ],
      onInit: (tabController) {},
    );
  }
}
