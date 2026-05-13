import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectTimelineView extends StatefulWidget {
  const PmaProjectTimelineView({super.key});

  @override
  State<PmaProjectTimelineView> createState() => _PmaProjectTimelineViewState();
}

class _PmaProjectTimelineViewState extends State<PmaProjectTimelineView> {
  String selectedPeriod = "This Month";
  String selectedProject = "";
  
  List<Map<String, dynamic>> timelineEvents = [
    {
      "id": 1,
      "type": "milestone",
      "title": "Backend API Development Complete",
      "description": "All backend APIs for user management and payment processing completed",
      "date": "2024-06-15",
      "time": "14:30",
      "project": "E-commerce Platform",
      "priority": "High",
      "status": "completed",
      "assignee": "John Smith",
      "color": Colors.green,
    },
    {
      "id": 2,
      "type": "task",
      "title": "UI/UX Design Review",
      "description": "Review and approve final designs for mobile banking interface",
      "date": "2024-06-14",
      "time": "10:00",
      "project": "Mobile Banking App",
      "priority": "High",
      "status": "in_progress",
      "assignee": "Sarah Wilson",
      "color": Colors.blue,
    },
    {
      "id": 3,
      "type": "meeting",
      "title": "Sprint Planning Meeting",
      "description": "Planning session for next sprint deliverables and resource allocation",
      "date": "2024-06-13",
      "time": "09:00",
      "project": "CRM System",
      "priority": "Medium",
      "status": "completed",
      "assignee": "Team Lead",
      "color": Colors.purple,
    },
    {
      "id": 4,
      "type": "deadline",
      "title": "Security Testing Deadline",
      "description": "Complete security penetration testing for banking module",
      "date": "2024-06-12",
      "time": "17:00",
      "project": "Mobile Banking App",
      "priority": "Critical",
      "status": "overdue",
      "assignee": "Security Team",
      "color": Colors.red,
    },
    {
      "id": 5,
      "type": "task",
      "title": "Database Migration",
      "description": "Migrate legacy customer data to new CRM database structure",
      "date": "2024-06-11",
      "time": "08:00",
      "project": "CRM System",
      "priority": "High",
      "status": "completed",
      "assignee": "Michael Chen",
      "color": Colors.orange,
    },
    {
      "id": 6,
      "type": "milestone",
      "title": "Alpha Version Release",
      "description": "Initial alpha version ready for internal testing",
      "date": "2024-06-10",
      "time": "16:00",
      "project": "Analytics Dashboard",
      "priority": "High",
      "status": "completed",
      "assignee": "Development Team",
      "color": Colors.teal,
    },
    {
      "id": 7,
      "type": "meeting",
      "title": "Client Presentation",
      "description": "Present project progress and demo to stakeholders",
      "date": "2024-06-08",
      "time": "14:00",
      "project": "E-commerce Platform",
      "priority": "High",
      "status": "completed",
      "assignee": "Project Manager",
      "color": Colors.indigo,
    }
  ];

  List<Map<String, dynamic>> projects = [
    {"label": "All Projects", "value": ""},
    {"label": "E-commerce Platform", "value": "E-commerce Platform"},
    {"label": "Mobile Banking App", "value": "Mobile Banking App"},
    {"label": "CRM System", "value": "CRM System"},
    {"label": "Analytics Dashboard", "value": "Analytics Dashboard"},
  ];

  List<Map<String, dynamic>> get filteredEvents {
    if (selectedProject.isEmpty) {
      return timelineEvents;
    }
    return timelineEvents.where((event) => event["project"] == selectedProject).toList();
  }

  Widget _buildTimelineHeader() {
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
              Expanded(
                child: QDropdownField(
                  label: "Time Period",
                  items: [
                    {"label": "This Week", "value": "This Week"},
                    {"label": "This Month", "value": "This Month"},
                    {"label": "Last 3 Months", "value": "Last 3 Months"},
                    {"label": "This Year", "value": "This Year"},
                  ],
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Project Filter",
                  items: projects,
                  value: selectedProject,
                  onChanged: (value, label) {
                    selectedProject = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildTimelineStats("Total Events", "${filteredEvents.length}", Icons.event, primaryColor),
              SizedBox(width: spSm),
              _buildTimelineStats("Completed", "${filteredEvents.where((e) => e["status"] == "completed").length}", Icons.check_circle, successColor),
              SizedBox(width: spSm),
              _buildTimelineStats("Overdue", "${filteredEvents.where((e) => e["status"] == "overdue").length}", Icons.warning, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStats(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(10),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(30)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
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
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(Map<String, dynamic> event, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: event["color"] as Color,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: disabledColor,
              ),
          ],
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0 : spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowXs],
              border: Border.all(
                color: _getStatusBorderColor(event["status"]),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getTypeColor(event["type"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getTypeIcon(event["type"]),
                            size: 14,
                            color: _getTypeColor(event["type"]),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${event["type"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _getTypeColor(event["type"]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(event["status"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${event["status"]}".replaceAll("_", " ").toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(event["status"]),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${event["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${event["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${DateTime.parse(event["date"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (event["priority"] != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getPriorityColor(event["priority"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${event["priority"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getPriorityColor(event["priority"]),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.business,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["project"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.person,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${event["assignee"]}",
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
        ),
      ],
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "milestone":
        return Icons.flag;
      case "task":
        return Icons.assignment;
      case "meeting":
        return Icons.group;
      case "deadline":
        return Icons.schedule;
      default:
        return Icons.event;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "milestone":
        return successColor;
      case "task":
        return primaryColor;
      case "meeting":
        return warningColor;
      case "deadline":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getStatusBorderColor(String status) {
    switch (status) {
      case "completed":
        return successColor.withAlpha(50);
      case "in_progress":
        return warningColor.withAlpha(50);
      case "overdue":
        return dangerColor.withAlpha(50);
      default:
        return disabledColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "Critical":
        return dangerColor;
      case "High":
        return warningColor;
      case "Medium":
        return infoColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              //navigateTo('PmaCreateEventView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimelineHeader(),
            SizedBox(height: spLg),
            Text(
              "Recent Activities",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  ...filteredEvents.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> event = entry.value;
                    bool isLast = index == filteredEvents.length - 1;
                    return _buildTimelineItem(event, isLast);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
