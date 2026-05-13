import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTimeTrackingView extends StatefulWidget {
  const TpmTimeTrackingView({super.key});

  @override
  State<TpmTimeTrackingView> createState() => _TpmTimeTrackingViewState();
}

class _TpmTimeTrackingViewState extends State<TpmTimeTrackingView> {
  int selectedTab = 0;
  bool isTracking = false;
  String currentProject = "";
  String currentTask = "";
  int elapsedSeconds = 0;
  
  String selectedProject = "all";
  String selectedDateRange = "today";
  
  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": "all"},
    {"label": "E-commerce Platform", "value": "ecommerce"},
    {"label": "Mobile App", "value": "mobile"},
    {"label": "Website Redesign", "value": "website"},
    {"label": "Marketing Campaign", "value": "marketing"},
  ];
  
  List<Map<String, dynamic>> dateRanges = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "Custom Range", "value": "custom"},
  ];
  
  List<Map<String, dynamic>> todayStats = [
    {
      "title": "Total Time",
      "value": "7h 35m",
      "subtitle": "Today",
      "icon": Icons.schedule,
      "color": primaryColor
    },
    {
      "title": "Billable Hours",
      "value": "6h 20m",
      "subtitle": "83% of total",
      "icon": Icons.attach_money,
      "color": successColor
    },
    {
      "title": "Projects",
      "value": "3",
      "subtitle": "Active today",
      "icon": Icons.work,
      "color": infoColor
    },
    {
      "title": "Tasks",
      "value": "8",
      "subtitle": "Completed",
      "icon": Icons.task_alt,
      "color": warningColor
    },
  ];
  
  List<Map<String, dynamic>> recentEntries = [
    {
      "project": "E-commerce Platform",
      "task": "Frontend Development",
      "duration": "2h 30m",
      "start_time": "09:00",
      "end_time": "11:30",
      "status": "completed",
      "billable": true,
      "description": "Implemented user authentication flow"
    },
    {
      "project": "Mobile App",
      "task": "UI Design Review",
      "duration": "1h 15m",
      "start_time": "11:45",
      "end_time": "13:00",
      "status": "completed",
      "billable": true,
      "description": "Reviewed and approved new dashboard design"
    },
    {
      "project": "Website Redesign",
      "task": "Content Updates",
      "duration": "45m",
      "start_time": "14:00",
      "end_time": "14:45",
      "status": "completed",
      "billable": false,
      "description": "Updated company information and team bios"
    },
    {
      "project": "E-commerce Platform",
      "task": "Code Review",
      "duration": "1h 20m",
      "start_time": "15:00",
      "end_time": "16:20",
      "status": "in_progress",
      "billable": true,
      "description": "Reviewing pull requests for payment integration"
    },
  ];
  
  List<Map<String, dynamic>> quickStartTasks = [
    {
      "project": "E-commerce Platform",
      "task": "Backend Development",
      "estimated_time": "3h",
      "priority": "High"
    },
    {
      "project": "Mobile App",
      "task": "Testing & QA",
      "estimated_time": "2h",
      "priority": "Medium"
    },
    {
      "project": "Website Redesign",
      "task": "Final Review",
      "estimated_time": "1h",
      "priority": "Low"
    },
    {
      "project": "Marketing Campaign",
      "task": "Asset Creation",
      "estimated_time": "4h",
      "priority": "High"
    },
  ];
  
  List<Map<String, dynamic>> teamActivity = [
    {
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/32/32?random=1&keyword=woman",
      "current_task": "Frontend Development",
      "project": "E-commerce Platform",
      "duration": "1h 45m",
      "status": "active"
    },
    {
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/32/32?random=2&keyword=man",
      "current_task": "API Integration",
      "project": "Mobile App",
      "duration": "2h 20m",
      "status": "active"
    },
    {
      "name": "Emily Davis",
      "avatar": "https://picsum.photos/32/32?random=3&keyword=woman",
      "current_task": "Break",
      "project": "",
      "duration": "15m",
      "status": "break"
    },
    {
      "name": "Alex Rodriguez",
      "avatar": "https://picsum.photos/32/32?random=4&keyword=man",
      "current_task": "Team Meeting",
      "project": "General",
      "duration": "30m",
      "status": "meeting"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Time Tracking",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Timer", icon: Icon(Icons.play_circle)),
        Tab(text: "Entries", icon: Icon(Icons.list)),
        Tab(text: "Team", icon: Icon(Icons.people)),
      ],
      tabChildren: [
        _buildTimerTab(),
        _buildEntriesTab(),
        _buildTeamTab(),
      ],
    );
  }

  Widget _buildTimerTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildActiveTimer(),
          _buildTodayStats(),
          _buildQuickStartTasks(),
        ],
      ),
    );
  }

  Widget _buildEntriesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildEntriesFilters(),
          _buildTimeEntries(),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildTeamSummary(),
          _buildTeamActivity(),
        ],
      ),
    );
  }

  Widget _buildActiveTimer() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isTracking ? successColor.withAlpha(20) : primaryColor.withAlpha(10),
              border: Border.all(
                color: isTracking ? successColor : primaryColor,
                width: 3,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatDuration(elapsedSeconds),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isTracking ? successColor : primaryColor,
                    ),
                  ),
                  Text(
                    isTracking ? "Running" : "Stopped",
                    style: TextStyle(
                      fontSize: 12,
                      color: isTracking ? successColor : disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isTracking) ...[
            Column(
              children: [
                Text(
                  currentProject.isNotEmpty ? currentProject : "No project selected",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  currentTask.isNotEmpty ? currentTask : "No task specified",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ],
          if (!isTracking) ...[
            Column(
              spacing: spSm,
              children: [
                QDropdownField(
                  label: "Project",
                  items: projects.where((p) => p["value"] != "all").toList(),
                  value: currentProject,
                  onChanged: (value, label) {
                    currentProject = value;
                    setState(() {});
                  },
                ),
                QTextField(
                  label: "Task Description",
                  value: currentTask,
                  hint: "What are you working on?",
                  onChanged: (value) {
                    currentTask = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
          Row(
            children: [
              if (isTracking) ...[
                Expanded(
                  child: QButton(
                    label: "Pause",
                    icon: Icons.pause,
                    size: bs.md,
                    onPressed: () {
                      // Handle pause
                    },
                  ),
                ),
                SizedBox(width: spSm),
              ],
              Expanded(
                child: QButton(
                  label: isTracking ? "Stop" : "Start",
                  icon: isTracking ? Icons.stop : Icons.play_arrow,
                  size: bs.md,
                  onPressed: () {
                    if (isTracking) {
                      _stopTimer();
                    } else {
                      _startTimer();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Today's Summary",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: todayStats.map((stat) => _buildStatCard(stat)).toList(),
        ),
      ],
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  stat["icon"],
                  color: stat["color"],
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["title"]}",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            "${stat["subtitle"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStartTasks() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Start Tasks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...quickStartTasks.map((task) => _buildQuickTaskCard(task)),
        ],
      ),
    );
  }

  Widget _buildQuickTaskCard(Map<String, dynamic> task) {
    Color priorityColor = _getPriorityColor(task["priority"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${task["project"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${task["task"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Est. ${task["estimated_time"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${task["priority"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.play_arrow,
            size: bs.sm,
            onPressed: () {
              currentProject = task["project"];
              currentTask = task["task"];
              _startTimer();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEntriesFilters() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: QDropdownField(
              label: "Project",
              items: projects,
              value: selectedProject,
              onChanged: (value, label) {
                selectedProject = value;
                setState(() {});
              },
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: QDropdownField(
              label: "Date Range",
              items: dateRanges,
              value: selectedDateRange,
              onChanged: (value, label) {
                selectedDateRange = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeEntries() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Recent Entries",
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
                onPressed: () {},
              ),
            ],
          ),
          ...recentEntries.map((entry) => _buildTimeEntryCard(entry)),
        ],
      ),
    );
  }

  Widget _buildTimeEntryCard(Map<String, dynamic> entry) {
    Color statusColor = _getEntryStatusColor(entry["status"]);
    bool isBillable = entry["billable"] as bool;
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${entry["project"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        if (isBillable)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "BILLABLE",
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${entry["task"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    if (entry["description"] != null && (entry["description"] as String).isNotEmpty)
                      Text(
                        "${entry["description"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledColor,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${entry["duration"]}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${entry["start_time"]} - ${entry["end_time"]}",
                    style: TextStyle(
                      fontSize: 11,
                      color: disabledColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${entry["status"]}".replaceAll("_", " ").toUpperCase(),
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Spacer(),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {},
              ),
              SizedBox(width: spXs),
              QButton(
                icon: Icons.delete,
                size: bs.sm,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSummary() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 200,
      children: [
        _buildTeamStatCard("Active Members", "4", "Currently tracking", Icons.people, successColor),
        _buildTeamStatCard("Total Hours", "28h 45m", "Today", Icons.schedule, primaryColor),
        _buildTeamStatCard("Productivity", "92%", "Team average", Icons.trending_up, warningColor),
        _buildTeamStatCard("Billable Rate", "85%", "Of total time", Icons.attach_money, infoColor),
      ],
    );
  }

  Widget _buildTeamStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
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
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
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
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamActivity() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Team Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...teamActivity.map((member) => _buildTeamMemberActivity(member)),
        ],
      ),
    );
  }

  Widget _buildTeamMemberActivity(Map<String, dynamic> member) {
    Color statusColor = _getActivityStatusColor(member["status"]);
    
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(3),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage("${member["avatar"]}"),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${member["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${member["current_task"]}${member["project"].isNotEmpty ? ' • ${member["project"]}' : ''}",
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
                "${member["duration"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              Text(
                "${member["status"]}".toUpperCase(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _startTimer() {
    if (currentProject.isEmpty) {
      se("Please select a project first");
      return;
    }
    
    isTracking = true;
    elapsedSeconds = 0;
    setState(() {});
    
    ss("Timer started for ${currentProject}");
  }

  void _stopTimer() {
    isTracking = false;
    setState(() {});
    
    // Add entry to recent entries
    recentEntries.insert(0, {
      "project": currentProject,
      "task": currentTask.isNotEmpty ? currentTask : "General work",
      "duration": _formatDuration(elapsedSeconds),
      "start_time": "Now",
      "end_time": "Now",
      "status": "completed",
      "billable": true,
      "description": ""
    });
    
    currentProject = "";
    currentTask = "";
    elapsedSeconds = 0;
    
    ss("Timer stopped and entry saved");
  }

  String _formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    
    if (hours > 0) {
      return "${hours}h ${minutes.toString().padLeft(2, '0')}m";
    } else {
      return "${minutes}m ${secs.toString().padLeft(2, '0')}s";
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return infoColor;
    }
  }

  Color _getEntryStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "paused":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getActivityStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "active":
        return successColor;
      case "break":
        return warningColor;
      case "meeting":
        return infoColor;
      case "offline":
        return disabledBoldColor;
      default:
        return primaryColor;
    }
  }
}
