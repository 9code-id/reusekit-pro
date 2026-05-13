import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaTimesheetManagementView extends StatefulWidget {
  const RhaTimesheetManagementView({super.key});

  @override
  State<RhaTimesheetManagementView> createState() => _RhaTimesheetManagementViewState();
}

class _RhaTimesheetManagementViewState extends State<RhaTimesheetManagementView> {
  int currentTab = 0;
  String selectedPeriod = "current";
  String selectedEmployee = "all";
  String searchQuery = "";
  bool showPendingOnly = false;
  String selectedStatus = "all";

  List<Map<String, dynamic>> timesheetData = [
    {
      "id": "TS001",
      "employee": "Sarah Johnson",
      "employeeId": "EMP001",
      "department": "Engineering",
      "position": "Senior Developer",
      "period": "Dec 9-15, 2024",
      "totalHours": 42.5,
      "regularHours": 40.0,
      "overtimeHours": 2.5,
      "status": "pending",
      "submittedDate": "2024-12-15",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "entries": [
        {"date": "2024-12-09", "timeIn": "09:00", "timeOut": "17:30", "breakTime": 0.5, "hours": 8.0, "project": "Mobile App"},
        {"date": "2024-12-10", "timeIn": "08:45", "timeOut": "18:00", "breakTime": 0.5, "hours": 8.75, "project": "Web Portal"},
        {"date": "2024-12-11", "timeIn": "09:15", "timeOut": "17:45", "breakTime": 0.5, "hours": 8.0, "project": "API Development"},
      ]
    },
    {
      "id": "TS002",
      "employee": "Michael Chen",
      "employeeId": "EMP002",
      "department": "Marketing",
      "position": "Marketing Manager",
      "period": "Dec 9-15, 2024",
      "totalHours": 40.0,
      "regularHours": 40.0,
      "overtimeHours": 0.0,
      "status": "approved",
      "submittedDate": "2024-12-14",
      "approvedDate": "2024-12-15",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "entries": [
        {"date": "2024-12-09", "timeIn": "09:00", "timeOut": "17:00", "breakTime": 1.0, "hours": 7.0, "project": "Campaign A"},
        {"date": "2024-12-10", "timeIn": "09:00", "timeOut": "18:00", "breakTime": 1.0, "hours": 8.0, "project": "Campaign B"},
      ]
    },
    {
      "id": "TS003",
      "employee": "Emily Rodriguez",
      "employeeId": "EMP003",
      "department": "Design",
      "position": "UI/UX Designer",
      "period": "Dec 9-15, 2024",
      "totalHours": 38.5,
      "regularHours": 38.5,
      "overtimeHours": 0.0,
      "status": "rejected",
      "submittedDate": "2024-12-13",
      "rejectedDate": "2024-12-14",
      "rejectionReason": "Missing time entries for Dec 12",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "entries": []
    }
  ];

  List<Map<String, dynamic>> employeeOptions = [
    {"label": "All Employees", "value": "all"},
    {"label": "Sarah Johnson", "value": "EMP001"},
    {"label": "Michael Chen", "value": "EMP002"},
    {"label": "Emily Rodriguez", "value": "EMP003"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Current Week", "value": "current"},
    {"label": "Last Week", "value": "last"},
    {"label": "Last 2 Weeks", "value": "2weeks"},
    {"label": "Current Month", "value": "month"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Pending", "value": "pending"},
    {"label": "Approved", "value": "approved"},
    {"label": "Rejected", "value": "rejected"},
  ];

  List<Map<String, dynamic>> get filteredTimesheets {
    return timesheetData.where((timesheet) {
      bool matchesEmployee = selectedEmployee == "all" || timesheet["employeeId"] == selectedEmployee;
      bool matchesStatus = selectedStatus == "all" || timesheet["status"] == selectedStatus;
      bool matchesSearch = searchQuery.isEmpty || 
                          timesheet["employee"].toLowerCase().contains(searchQuery.toLowerCase()) ||
                          timesheet["id"].toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesPending = !showPendingOnly || timesheet["status"] == "pending";
      
      return matchesEmployee && matchesStatus && matchesSearch && matchesPending;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Timesheet Management",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Timesheets", icon: Icon(Icons.access_time)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.description)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTimesheetsTab(),
        _buildAnalyticsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Stats Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildStatCard("Total Employees", "24", Icons.people, primaryColor),
              _buildStatCard("Pending Timesheets", "8", Icons.pending_actions, warningColor),
              _buildStatCard("Approved This Week", "16", Icons.check_circle, successColor),
              _buildStatCard("Total Hours (Week)", "960", Icons.schedule, infoColor),
            ],
          ),

          // Quick Actions
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
                Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Approve All Pending",
                        icon: Icons.done_all,
                        size: bs.sm,
                        onPressed: () => _approveAllPending(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Export Report",
                        icon: Icons.download,
                        size: bs.sm,
                        onPressed: () => _exportReport(),
                      ),
                    ),
                  ],
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
              spacing: spSm,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(3, (index) {
                  final activities = [
                    {"action": "Timesheet submitted", "user": "Sarah Johnson", "time": "5 min ago"},
                    {"action": "Timesheet approved", "user": "Michael Chen", "time": "1 hour ago"},
                    {"action": "Timesheet rejected", "user": "Emily Rodriguez", "time": "2 hours ago"},
                  ];
                  final activity = activities[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: disabledBoldColor,
                          size: 16,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["action"]} - ${activity["user"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${activity["time"]}",
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
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimesheetsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QTextField(
                        label: "Search timesheets...",
                        value: searchQuery,
                        hint: "Employee name or ID",
                        onChanged: (value) {
                          searchQuery = value;
                          setState(() {});
                        },
                      ),
                    ),
                    QButton(
                      icon: Icons.search,
                      size: bs.sm,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
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
                  children: [
                    Expanded(
                      child: QSwitch(
                        items: [
                          {
                            "label": "Show pending only",
                            "value": true,
                            "checked": showPendingOnly,
                          }
                        ],
                        value: [
                          if (showPendingOnly)
                            {
                              "label": "Show pending only",
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
                    QButton(
                      label: "Reset Filters",
                      size: bs.sm,
                      onPressed: () => _resetFilters(),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Timesheets List
          ...filteredTimesheets.map((timesheet) => _buildTimesheetCard(timesheet)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildAnalyticsCard("Average Hours/Week", "41.2", "+2.5% vs last week", successColor),
              _buildAnalyticsCard("Overtime Hours", "15.5", "+12% vs last week", warningColor),
              _buildAnalyticsCard("Approval Rate", "92%", "+5% vs last week", successColor),
              _buildAnalyticsCard("Late Submissions", "3", "-2 vs last week", successColor),
            ],
          ),

          // Department Analytics
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
                  "Hours by Department",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(4, (index) {
                  final departments = [
                    {"name": "Engineering", "hours": 320, "employees": 8, "color": primaryColor},
                    {"name": "Marketing", "hours": 280, "employees": 7, "color": successColor},
                    {"name": "Design", "hours": 240, "employees": 6, "color": warningColor},
                    {"name": "Sales", "hours": 200, "employees": 5, "color": infoColor},
                  ];
                  final dept = departments[index];
                  
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
                            color: (dept["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.business,
                            color: dept["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dept["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${dept["employees"]} employees",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "${dept["hours"]}h",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: dept["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
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
          // Report Generation
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
                Text(
                  "Generate Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Weekly Summary",
                        icon: Icons.calendar_view_week,
                        size: bs.sm,
                        onPressed: () => _generateWeeklyReport(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Monthly Report",
                        icon: Icons.calendar_month,
                        size: bs.sm,
                        onPressed: () => _generateMonthlyReport(),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: spSm,
                  children: [
                    Expanded(
                      child: QButton(
                        label: "Overtime Analysis",
                        icon: Icons.trending_up,
                        size: bs.sm,
                        onPressed: () => _generateOvertimeReport(),
                      ),
                    ),
                    Expanded(
                      child: QButton(
                        label: "Department Summary",
                        icon: Icons.business,
                        size: bs.sm,
                        onPressed: () => _generateDepartmentReport(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Recent Reports
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
                Text(
                  "Recent Reports",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...List.generate(5, (index) {
                  final reports = [
                    {"name": "Weekly Timesheet Summary - Dec Week 2", "date": "2024-12-15", "type": "Weekly", "size": "2.3 MB"},
                    {"name": "Monthly Overtime Report - November 2024", "date": "2024-12-01", "type": "Monthly", "size": "1.8 MB"},
                    {"name": "Department Hours Analysis - Q4 2024", "date": "2024-11-30", "type": "Quarterly", "size": "4.1 MB"},
                    {"name": "Employee Attendance Report - November", "date": "2024-11-25", "type": "Monthly", "size": "1.5 MB"},
                    {"name": "Payroll Integration Report - Nov 2024", "date": "2024-11-20", "type": "Monthly", "size": "3.2 MB"},
                  ];
                  final report = reports[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[200]!,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${report["name"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${report["type"]} • ${report["date"]} • ${report["size"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        QButton(
                          icon: Icons.download,
                          size: bs.sm,
                          onPressed: () => _downloadReport(report),
                        ),
                      ],
                    ),
                  );
                }),
              ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
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
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
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

  Widget _buildAnalyticsCard(String title, String value, String change, Color changeColor) {
    return Container(
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
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              color: changeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimesheetCard(Map<String, dynamic> timesheet) {
    Color statusColor = timesheet["status"] == "approved" 
        ? successColor 
        : timesheet["status"] == "pending" 
            ? warningColor 
            : dangerColor;

    return Container(
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
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${timesheet["avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${timesheet["employee"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${timesheet["department"]} • ${timesheet["position"]}",
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
                  "${timesheet["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
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
                      "Period",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${timesheet["period"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Hours",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${timesheet["totalHours"]}h",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overtime",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${timesheet["overtimeHours"]}h",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: (timesheet["overtimeHours"] as num) > 0 ? warningColor : successColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (timesheet["status"] == "rejected" && timesheet["rejectionReason"] != null)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: dangerColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: dangerColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: dangerColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${timesheet["rejectionReason"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                      ),
                    ),
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
                  onPressed: () => _viewTimesheetDetails(timesheet),
                ),
              ),
              if (timesheet["status"] == "pending") ...[
                QButton(
                  icon: Icons.check,
                  size: bs.sm,
                  onPressed: () => _approveTimesheet(timesheet),
                ),
                QButton(
                  icon: Icons.close,
                  size: bs.sm,
                  onPressed: () => _rejectTimesheet(timesheet),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _approveAllPending() {
    // Navigate to approve all pending timesheets
  }

  void _exportReport() {
    // Navigate to export report functionality
  }

  void _resetFilters() {
    searchQuery = "";
    selectedEmployee = "all";
    selectedStatus = "all";
    selectedPeriod = "current";
    showPendingOnly = false;
    setState(() {});
  }

  void _generateWeeklyReport() {
    // Navigate to weekly report generation
  }

  void _generateMonthlyReport() {
    // Navigate to monthly report generation
  }

  void _generateOvertimeReport() {
    // Navigate to overtime report generation
  }

  void _generateDepartmentReport() {
    // Navigate to department report generation
  }

  void _downloadReport(Map<String, dynamic> report) {
    // Navigate to download report functionality
  }

  void _viewTimesheetDetails(Map<String, dynamic> timesheet) {
    // Navigate to timesheet details view
  }

  void _approveTimesheet(Map<String, dynamic> timesheet) {
    timesheet["status"] = "approved";
    timesheet["approvedDate"] = DateTime.now().toIso8601String();
    setState(() {});
    ss("Timesheet approved successfully");
  }

  void _rejectTimesheet(Map<String, dynamic> timesheet) {
    // Navigate to rejection reason dialog
  }
}
