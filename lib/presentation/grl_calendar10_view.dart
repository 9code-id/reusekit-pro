import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCalendar10View extends StatefulWidget {
  @override
  State<GrlCalendar10View> createState() => _GrlCalendar10ViewState();
}

class _GrlCalendar10ViewState extends State<GrlCalendar10View> {
  DateTime selectedDate = DateTime.now();
  int selectedTabIndex = 0;
  String selectedProjectFilter = "all";
  String selectedStatusFilter = "all";

  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "Mobile App Development",
      "color": Colors.blue,
      "progress": 75,
      "deadline": DateTime.now().add(Duration(days: 15)),
      "team": ["John Doe", "Jane Smith", "Mike Johnson"],
      "status": "in_progress",
      "priority": "high",
    },
    {
      "id": 2,
      "name": "Website Redesign",
      "color": Colors.green,
      "progress": 40,
      "deadline": DateTime.now().add(Duration(days: 30)),
      "team": ["Sarah Wilson", "Tom Brown"],
      "status": "in_progress",
      "priority": "medium",
    },
    {
      "id": 3,
      "name": "Database Migration",
      "color": Colors.orange,
      "progress": 90,
      "deadline": DateTime.now().add(Duration(days: 5)),
      "team": ["Alex Chen", "Maria Garcia"],
      "status": "review",
      "priority": "high",
    },
    {
      "id": 4,
      "name": "API Documentation",
      "color": Colors.purple,
      "progress": 100,
      "deadline": DateTime.now().subtract(Duration(days: 2)),
      "team": ["David Lee"],
      "status": "completed",
      "priority": "low",
    },
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Design Review Meeting",
      "project": "Mobile App Development",
      "date": DateTime.now(),
      "time": "10:00 AM",
      "duration": "2 hours",
      "type": "meeting",
      "attendees": ["John Doe", "Jane Smith"],
      "status": "scheduled",
    },
    {
      "id": 2,
      "title": "Code Implementation",
      "project": "Website Redesign",
      "date": DateTime.now().add(Duration(days: 1)),
      "time": "2:00 PM",
      "duration": "4 hours",
      "type": "development",
      "attendees": ["Sarah Wilson"],
      "status": "scheduled",
    },
    {
      "id": 3,
      "title": "Testing Phase",
      "project": "Database Migration",
      "date": DateTime.now().add(Duration(days: 2)),
      "time": "9:00 AM",
      "duration": "6 hours",
      "type": "testing",
      "attendees": ["Alex Chen", "Maria Garcia"],
      "status": "scheduled",
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "id": 1,
      "title": "MVP Release",
      "project": "Mobile App Development",
      "date": DateTime.now().add(Duration(days: 7)),
      "status": "upcoming",
      "priority": "high",
    },
    {
      "id": 2,
      "title": "Beta Testing",
      "project": "Website Redesign",
      "date": DateTime.now().add(Duration(days: 14)),
      "status": "upcoming",
      "priority": "medium",
    },
    {
      "id": 3,
      "title": "Production Deploy",
      "project": "Database Migration",
      "date": DateTime.now().add(Duration(days: 3)),
      "status": "upcoming",
      "priority": "high",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Project Calendar",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Projects", icon: Icon(Icons.folder)),
        Tab(text: "Tasks", icon: Icon(Icons.task)),
        Tab(text: "Timeline", icon: Icon(Icons.timeline)),
      ],
      tabChildren: [
        _buildProjectsTab(),
        _buildTasksTab(),
        _buildTimelineTab(),
      ],
    );
  }

  Widget _buildProjectsTab() {
    List<Map<String, dynamic>> filteredProjects = projects.where((project) {
      if (selectedProjectFilter == "all") return true;
      return project["status"] == selectedProjectFilter;
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Status Filter",
                  items: [
                    {"label": "All Projects", "value": "all"},
                    {"label": "In Progress", "value": "in_progress"},
                    {"label": "Review", "value": "review"},
                    {"label": "Completed", "value": "completed"},
                  ],
                  value: selectedProjectFilter,
                  onChanged: (value, label) {
                    selectedProjectFilter = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Statistics Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "Active Projects", 
                  "${projects.where((p) => p["status"] != "completed").length}",
                  Icons.folder_open,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Completed", 
                  "${projects.where((p) => p["status"] == "completed").length}",
                  Icons.check_circle,
                  successColor,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  "High Priority", 
                  "${projects.where((p) => p["priority"] == "high").length}",
                  Icons.priority_high,
                  dangerColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard(
                  "Team Members", 
                  "${projects.expand((p) => p["team"] as List).toSet().length}",
                  Icons.people,
                  infoColor,
                ),
              ),
            ],
          ),

          // Projects List
          Text(
            "Projects (${filteredProjects.length})",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...filteredProjects.map((project) => _buildProjectCard(project)),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Calendar Header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(180)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedDate.dMMMy}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            child: Icon(Icons.chevron_left, color: Colors.white),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            child: Icon(Icons.chevron_right, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "Today's Tasks & Meetings",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),

          // Today's Tasks
          Text(
            "Today's Schedule",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...tasks.where((task) => 
            task["date"].day == DateTime.now().day &&
            task["date"].month == DateTime.now().month
          ).map((task) => _buildTaskCard(task)),

          // Upcoming Tasks
          Text(
            "Upcoming Tasks",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...tasks.where((task) => 
            task["date"].isAfter(DateTime.now()) &&
            task["date"].isBefore(DateTime.now().add(Duration(days: 7)))
          ).map((task) => _buildTaskCard(task)),
        ],
      ),
    );
  }

  Widget _buildTimelineTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Header
          Text(
            "Project Timeline & Milestones",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          // Timeline View
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spMd,
              children: [
                ...milestones.map((milestone) => _buildTimelineItem(milestone)),
              ],
            ),
          ),

          // Project Progress Overview
          Text(
            "Project Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          ...projects.map((project) => _buildProjectProgress(project)),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusLg),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(icon, color: color, size: 24),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: color,
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

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: project["color"] as Color,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${project["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getStatusColor(project["status"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${project["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(project["status"]),
                  ),
                ),
              ),
            ],
          ),

          // Progress Bar
          Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Text(
                    "${project["progress"]}%",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (project["progress"] as int) / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: project["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Team & Deadline
          Row(
            children: [
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  "${(project["team"] as List).length} members",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${(project["deadline"] as DateTime).dMMMy}",
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

  Widget _buildTaskCard(Map<String, dynamic> task) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _getTaskTypeColor(task["type"]),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${task["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${task["time"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          Text(
            "Project: ${task["project"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),

          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${task["duration"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.people, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${(task["attendees"] as List).length} attendees",
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

  Widget _buildTimelineItem(Map<String, dynamic> milestone) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: _getPriorityColor(milestone["priority"]),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 2,
              height: 40,
              color: disabledColor,
            ),
          ],
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            spacing: spXs,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${milestone["title"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Project: ${milestone["project"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${(milestone["date"] as DateTime).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectProgress(Map<String, dynamic> project) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: project["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${project["name"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${project["progress"]}%",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: project["color"] as Color,
                ),
              ),
            ],
          ),

          Container(
            height: 8,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (project["progress"] as int) / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: project["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Due: ${(project["deadline"] as DateTime).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getPriorityColor(project["priority"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${project["priority"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _getPriorityColor(project["priority"]),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "review":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTaskTypeColor(String type) {
    switch (type) {
      case "meeting":
        return infoColor;
      case "development":
        return successColor;
      case "testing":
        return warningColor;
      default:
        return primaryColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
