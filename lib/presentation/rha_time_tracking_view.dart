import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RhaTimeTrackingView extends StatefulWidget {
  const RhaTimeTrackingView({super.key});

  @override
  State<RhaTimeTrackingView> createState() => _RhaTimeTrackingViewState();
}

class _RhaTimeTrackingViewState extends State<RhaTimeTrackingView> {
  int currentTab = 0;
  String selectedEmployee = "EMP001";
  String selectedProject = "all";
  String selectedPeriod = "this_week";
  bool isTracking = false;
  String currentActivity = "";
  DateTime trackingStartTime = DateTime.now();

  List<Map<String, dynamic>> timeEntries = [
    {
      "id": "TE001",
      "employee_id": "EMP001",
      "employee_name": "Sarah Johnson",
      "date": "2024-06-15",
      "start_time": "09:00:00",
      "end_time": "10:30:00",
      "duration": 1.5,
      "project": "Mobile App Development",
      "task": "UI Design Implementation",
      "description": "Working on user dashboard interface",
      "status": "completed",
      "billable": true,
      "category": "Development"
    },
    {
      "id": "TE002",
      "employee_id": "EMP001",
      "employee_name": "Sarah Johnson",
      "date": "2024-06-15",
      "start_time": "10:45:00",
      "end_time": "12:00:00",
      "duration": 1.25,
      "project": "Website Redesign",
      "task": "Code Review",
      "description": "Reviewing frontend components",
      "status": "completed",
      "billable": true,
      "category": "Review"
    },
    {
      "id": "TE003",
      "employee_id": "EMP002",
      "employee_name": "Michael Chen",
      "date": "2024-06-15",
      "start_time": "09:30:00",
      "end_time": "11:00:00",
      "duration": 1.5,
      "project": "Marketing Campaign",
      "task": "Content Creation",
      "description": "Writing blog posts for Q2 campaign",
      "status": "completed",
      "billable": false,
      "category": "Marketing"
    },
    {
      "id": "TE004",
      "employee_id": "EMP001",
      "employee_name": "Sarah Johnson",
      "date": "2024-06-15",
      "start_time": "14:00:00",
      "end_time": null,
      "duration": 0,
      "project": "Mobile App Development",
      "task": "Bug Fixing",
      "description": "Fixing login authentication issues",
      "status": "in_progress",
      "billable": true,
      "category": "Development"
    }
  ];

  List<Map<String, dynamic>> projects = [
    {
      "id": "PROJ001",
      "name": "Mobile App Development",
      "client": "TechCorp Inc",
      "budget_hours": 120,
      "used_hours": 45.5,
      "remaining_hours": 74.5,
      "rate_per_hour": 85.0,
      "status": "active",
      "deadline": "2024-08-15",
      "team_members": ["EMP001", "EMP004"]
    },
    {
      "id": "PROJ002",
      "name": "Website Redesign",
      "client": "StartupXYZ",
      "budget_hours": 80,
      "used_hours": 32.25,
      "remaining_hours": 47.75,
      "rate_per_hour": 75.0,
      "status": "active",
      "deadline": "2024-07-30",
      "team_members": ["EMP001", "EMP002"]
    },
    {
      "id": "PROJ003",
      "name": "Marketing Campaign",
      "client": "Internal",
      "budget_hours": 40,
      "used_hours": 28.0,
      "remaining_hours": 12.0,
      "rate_per_hour": 0.0,
      "status": "active",
      "deadline": "2024-06-30",
      "team_members": ["EMP002", "EMP003"]
    }
  ];

  List<Map<String, dynamic>> get filteredTimeEntries {
    List<Map<String, dynamic>> filtered = timeEntries;
    
    if (selectedEmployee != "all") {
      filtered = filtered.where((entry) => entry["employee_id"] == selectedEmployee).toList();
    }
    
    if (selectedProject != "all") {
      filtered = filtered.where((entry) => entry["project"] == selectedProject).toList();
    }
    
    return filtered;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed": return successColor;
      case "in_progress": return warningColor;
      case "paused": return infoColor;
      case "cancelled": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  Color _getProjectStatusColor(String status) {
    switch (status) {
      case "active": return successColor;
      case "on_hold": return warningColor;
      case "completed": return primaryColor;
      case "cancelled": return dangerColor;
      default: return disabledBoldColor;
    }
  }

  String _formatDuration(double hours) {
    int wholeHours = hours.floor();
    int minutes = ((hours - wholeHours) * 60).round();
    return "${wholeHours}h ${minutes}m";
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Time Tracking",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Time Tracker", icon: Icon(Icons.play_arrow)),
        Tab(text: "Time Entries", icon: Icon(Icons.access_time)),
        Tab(text: "Project Hours", icon: Icon(Icons.folder)),
        Tab(text: "Reports", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildTimeTrackerTab(),
        _buildTimeEntriesTab(),
        _buildProjectHoursTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildTimeTrackerTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCurrentTrackingCard(),
          _buildQuickStartOptions(),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildCurrentTrackingCard() {
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: isTracking ? successColor.withAlpha(20) : disabledColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  isTracking ? Icons.play_arrow : Icons.pause,
                  color: isTracking ? successColor : disabledBoldColor,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isTracking ? "Currently Tracking" : "Time Tracker",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    if (isTracking)
                      Text(
                        currentActivity,
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (isTracking)
                Text(
                  "02:15:30",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
            ],
          ),
          if (!isTracking) ...[
            QDropdownField(
              label: "Select Project",
              items: projects.map((p) => {
                "label": "${p["name"]}",
                "value": p["name"]
              }).toList(),
              value: projects.isNotEmpty ? projects[0]["name"] : "",
              onChanged: (value, label) {},
            ),
            QTextField(
              label: "Task Description",
              value: currentActivity,
              hint: "What are you working on?",
              onChanged: (value) {
                currentActivity = value;
                setState(() {});
              },
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Start Tracking",
                    icon: Icons.play_arrow,
                    size: bs.md,
                    onPressed: () {
                      if (currentActivity.isNotEmpty) {
                        isTracking = true;
                        trackingStartTime = DateTime.now();
                        setState(() {});
                        ss("Time tracking started");
                      } else {
                        se("Please enter task description");
                      }
                    },
                  ),
                ),
              ],
            ),
          ] else ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: successColor.withAlpha(30)),
              ),
              child: Column(
                children: [
                  Text(
                    currentActivity,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Started at ${trackingStartTime.dMMMy} ${trackingStartTime.kkmm}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Pause",
                    icon: Icons.pause,
                    size: bs.md,
                    onPressed: () {
                      si("Timer paused");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Stop",
                    icon: Icons.stop,
                    size: bs.md,
                    onPressed: () {
                      isTracking = false;
                      currentActivity = "";
                      setState(() {});
                      ss("Time tracking stopped and saved");
                    },
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuickStartOptions() {
    List<Map<String, dynamic>> quickOptions = [
      {"title": "Development", "icon": Icons.code, "color": primaryColor, "project": "Mobile App Development"},
      {"title": "Review", "icon": Icons.rate_review, "color": infoColor, "project": "Website Redesign"},
      {"title": "Meeting", "icon": Icons.meeting_room, "color": warningColor, "project": "General"},
      {"title": "Research", "icon": Icons.search, "color": successColor, "project": "Mobile App Development"},
    ];

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
            children: [
              Icon(Icons.flash_on, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Quick Start",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickOptions.map((option) {
              return GestureDetector(
                onTap: () {
                  if (!isTracking) {
                    currentActivity = "${option["title"]} - ${option["project"]}";
                    isTracking = true;
                    trackingStartTime = DateTime.now();
                    setState(() {});
                    ss("Quick tracking started for ${option["title"]}");
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isTracking ? disabledColor.withAlpha(20) : (option["color"] as Color).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: (option["color"] as Color).withAlpha(30)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: (option["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(option["icon"] as IconData, color: option["color"] as Color, size: 24),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${option["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isTracking ? disabledBoldColor : primaryColor,
                        ),
                      ),
                      Text(
                        "${option["project"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    List<Map<String, dynamic>> recentEntries = timeEntries.take(3).toList();

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
            children: [
              Icon(Icons.history, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Recent Activities",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recentEntries.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final entry = recentEntries[index];
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getStatusColor("${entry["status"]}"),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${entry["task"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${entry["project"]}",
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
                          _formatDuration(entry["duration"] as double),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _getStatusColor("${entry["status"]}"),
                          ),
                        ),
                        Text(
                          "${entry["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
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
    );
  }

  Widget _buildTimeEntriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTimeEntriesFilters(),
          _buildTimeEntriesSummary(),
          _buildTimeEntriesList(),
        ],
      ),
    );
  }

  Widget _buildTimeEntriesFilters() {
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
              Icon(Icons.filter_list, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Filter Time Entries",
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
              Expanded(
                child: QDropdownField(
                  label: "Employee",
                  items: [
                    {"label": "All Employees", "value": "all"},
                    {"label": "Sarah Johnson", "value": "EMP001"},
                    {"label": "Michael Chen", "value": "EMP002"},
                    {"label": "Emily Rodriguez", "value": "EMP003"},
                    {"label": "David Kim", "value": "EMP004"},
                  ],
                  value: selectedEmployee,
                  onChanged: (value, label) {
                    selectedEmployee = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Project",
                  items: [
                    {"label": "All Projects", "value": "all"},
                    ...projects.map((p) => {
                      "label": "${p["name"]}",
                      "value": p["name"]
                    }),
                  ],
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Period",
            items: [
              {"label": "This Week", "value": "this_week"},
              {"label": "Last Week", "value": "last_week"},
              {"label": "This Month", "value": "this_month"},
              {"label": "Last Month", "value": "last_month"},
              {"label": "Custom Range", "value": "custom"},
            ],
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEntriesSummary() {
    double totalHours = filteredTimeEntries.where((e) => e["status"] == "completed")
        .map((e) => e["duration"] as double).fold(0.0, (a, b) => a + b);
    double billableHours = filteredTimeEntries.where((e) => e["billable"] == true && e["status"] == "completed")
        .map((e) => e["duration"] as double).fold(0.0, (a, b) => a + b);
    double nonBillableHours = totalHours - billableHours;
    int totalEntries = filteredTimeEntries.length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildSummaryCard("Total Hours", _formatDuration(totalHours), primaryColor, Icons.schedule),
        _buildSummaryCard("Billable Hours", _formatDuration(billableHours), successColor, Icons.attach_money),
        _buildSummaryCard("Non-Billable", _formatDuration(nonBillableHours), warningColor, Icons.work),
        _buildSummaryCard("Total Entries", "$totalEntries", infoColor, Icons.list),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color, IconData icon) {
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
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEntriesList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Icon(Icons.access_time, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Time Entries",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Add Entry",
                  icon: Icons.add,
                  size: bs.sm,
                  onPressed: () {
                    si("Add new time entry");
                  },
                ),
              ],
            ),
          ),
          Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(spSm),
            itemCount: filteredTimeEntries.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final entry = filteredTimeEntries[index];
              return _buildTimeEntryCard(entry);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEntryCard(Map<String, dynamic> entry) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 50,
                decoration: BoxDecoration(
                  color: _getStatusColor("${entry["status"]}"),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${entry["task"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${entry["project"]} • ${entry["category"]}",
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
                  Row(
                    children: [
                      if (entry["billable"] == true)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "BILLABLE",
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      SizedBox(width: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor("${entry["status"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${entry["status"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if ((entry["description"] as String).isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spXs),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusXs),
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Text(
                "${entry["description"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          Row(
            children: [
              Text(
                "${DateTime.parse(entry["date"] as String).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              if (entry["start_time"] != null)
                Text(
                  "${(entry["start_time"] as String).substring(0, 5)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              if (entry["end_time"] != null)
                Text(
                  " - ${(entry["end_time"] as String).substring(0, 5)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              Spacer(),
              Text(
                _formatDuration(entry["duration"] as double),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _getStatusColor("${entry["status"]}"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectHoursTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildProjectOverview(),
          _buildProjectsList(),
        ],
      ),
    );
  }

  Widget _buildProjectOverview() {
    double totalBudgetHours = projects.map((p) => p["budget_hours"] as int).fold(0, (a, b) => a + b).toDouble();
    double totalUsedHours = projects.map((p) => p["used_hours"] as double).fold(0.0, (a, b) => a + b);
    double utilizationRate = totalBudgetHours > 0 ? (totalUsedHours / totalBudgetHours) * 100 : 0;
    int activeProjects = projects.where((p) => p["status"] == "active").length;

    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildOverviewMetricCard("Active Projects", "$activeProjects", primaryColor, Icons.folder),
        _buildOverviewMetricCard("Budget Hours", _formatDuration(totalBudgetHours), infoColor, Icons.schedule),
        _buildOverviewMetricCard("Used Hours", _formatDuration(totalUsedHours), warningColor, Icons.hourglass_bottom),
        _buildOverviewMetricCard("Utilization", "${utilizationRate.toStringAsFixed(1)}%", successColor, Icons.analytics),
      ],
    );
  }

  Widget _buildOverviewMetricCard(String title, String value, Color color, IconData icon) {
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
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                Icon(Icons.folder, color: primaryColor, size: 20),
                SizedBox(width: spXs),
                Text(
                  "Project Hours Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(spSm),
            itemCount: projects.length,
            separatorBuilder: (context, index) => SizedBox(height: spSm),
            itemBuilder: (context, index) {
              final project = projects[index];
              return _buildProjectCard(project);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    int budgetHours = project["budget_hours"] as int;
    double usedHours = project["used_hours"] as double;
    double remainingHours = project["remaining_hours"] as double;
    double utilizationRate = (usedHours / budgetHours) * 100;
    double hourlyRate = project["rate_per_hour"] as double;
    double totalValue = usedHours * hourlyRate;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 50,
                decoration: BoxDecoration(
                  color: _getProjectStatusColor("${project["status"]}"),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${project["name"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${project["client"]} • Due: ${DateTime.parse(project["deadline"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getProjectStatusColor("${project["status"]}"),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${project["status"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildProjectMetric("Budget", _formatDuration(budgetHours.toDouble()), Icons.schedule),
              _buildProjectMetric("Used", _formatDuration(usedHours), Icons.hourglass_bottom),
              _buildProjectMetric("Remaining", _formatDuration(remainingHours), Icons.hourglass_top),
              _buildProjectMetric("Utilization", "${utilizationRate.toStringAsFixed(1)}%", Icons.analytics),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: utilizationRate / 100,
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation(
                    utilizationRate >= 90 ? dangerColor :
                    utilizationRate >= 75 ? warningColor : successColor
                  ),
                ),
              ),
              SizedBox(width: spSm),
              if (hourlyRate > 0)
                Text(
                  "\$${totalValue.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
            ],
          ),
          Row(
            children: [
              Text(
                "Team: ${(project["team_members"] as List).length} members",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if (hourlyRate > 0)
                Text(
                  "\$${hourlyRate.toStringAsFixed(0)}/hr",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectMetric(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 16),
          SizedBox(width: spXs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
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
          _buildReportSummary(),
          _buildTimeReports(),
          _buildProductivityMetrics(),
        ],
      ),
    );
  }

  Widget _buildReportSummary() {
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
              Icon(Icons.analytics, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Time Reports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          QDropdownField(
            label: "Report Period",
            items: [
              {"label": "This Week", "value": "this_week"},
              {"label": "This Month", "value": "this_month"},
              {"label": "This Quarter", "value": "this_quarter"},
              {"label": "This Year", "value": "this_year"},
            ],
            value: "this_month",
            onChanged: (value, label) {},
          ),
        ],
      ),
    );
  }

  Widget _buildTimeReports() {
    List<Map<String, dynamic>> reports = [
      {
        "title": "Employee Time Summary",
        "description": "Detailed time tracking report by employee",
        "icon": Icons.person,
        "color": primaryColor,
        "format": "PDF"
      },
      {
        "title": "Project Time Analysis",
        "description": "Time allocation and budget analysis by project",
        "icon": Icons.folder,
        "color": infoColor,
        "format": "Excel"
      },
      {
        "title": "Billable Hours Report",
        "description": "Billable vs non-billable hours breakdown",
        "icon": Icons.attach_money,
        "color": successColor,
        "format": "PDF"
      },
      {
        "title": "Productivity Metrics",
        "description": "Team productivity and efficiency metrics",
        "icon": Icons.trending_up,
        "color": warningColor,
        "format": "Dashboard"
      },
    ];

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
            children: [
              Icon(Icons.description, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Available Reports",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: reports.map((report) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (report["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(report["icon"] as IconData, color: report["color"] as Color, size: 20),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${report["format"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "${report["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${report["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Generate",
                        size: bs.sm,
                        onPressed: () {
                          ss("${report["title"]} generated successfully");
                        },
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

  Widget _buildProductivityMetrics() {
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
            children: [
              Icon(Icons.speed, color: primaryColor, size: 20),
              SizedBox(width: spXs),
              Text(
                "Productivity Metrics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildProductivityCard("Avg Daily Hours", "8.2h", "+5% from last month", successColor),
              _buildProductivityCard("Focus Time", "6.5h", "80% of work time", infoColor),
              _buildProductivityCard("Task Completion", "92%", "Above target", successColor),
              _buildProductivityCard("Overtime Rate", "12%", "Within limits", warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductivityCard(String title, String value, String trend, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            trend,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
