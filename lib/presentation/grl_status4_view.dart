import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlStatus4View extends StatefulWidget {
  @override
  State<GrlStatus4View> createState() => _GrlStatus4ViewState();
}

class _GrlStatus4ViewState extends State<GrlStatus4View> {
  int currentTab = 0;
  String selectedFilter = "all";
  bool showOnlyActive = false;
  
  List<Map<String, dynamic>> statusItems = [
    {
      "id": 1,
      "title": "Server Maintenance",
      "status": "in_progress",
      "type": "maintenance",
      "progress": 65,
      "priority": "high",
      "assignee": "John Smith",
      "created_at": "2024-01-15",
      "estimated_completion": "2024-01-16",
      "description": "Scheduled server maintenance and updates"
    },
    {
      "id": 2,
      "title": "Database Migration",
      "status": "completed",
      "type": "migration",
      "progress": 100,
      "priority": "critical",
      "assignee": "Sarah Johnson",
      "created_at": "2024-01-14",
      "estimated_completion": "2024-01-15",
      "description": "Migration of legacy database to new infrastructure"
    },
    {
      "id": 3,
      "title": "Security Audit",
      "status": "pending",
      "type": "security",
      "progress": 0,
      "priority": "medium",
      "assignee": "Mike Wilson",
      "created_at": "2024-01-16",
      "estimated_completion": "2024-01-20",
      "description": "Comprehensive security audit of all systems"
    },
    {
      "id": 4,
      "title": "API Performance Optimization",
      "status": "in_progress",
      "type": "optimization",
      "progress": 30,
      "priority": "high",
      "assignee": "Emily Chen",
      "created_at": "2024-01-12",
      "estimated_completion": "2024-01-18",
      "description": "Optimize API response times and reduce latency"
    },
    {
      "id": 5,
      "title": "Backup System Verification",
      "status": "completed",
      "type": "backup",
      "progress": 100,
      "priority": "medium",
      "assignee": "David Brown",
      "created_at": "2024-01-10",
      "estimated_completion": "2024-01-12",
      "description": "Verify backup system integrity and recovery procedures"
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Tasks", "value": "all"},
    {"label": "Maintenance", "value": "maintenance"},
    {"label": "Migration", "value": "migration"},
    {"label": "Security", "value": "security"},
    {"label": "Optimization", "value": "optimization"},
    {"label": "Backup", "value": "backup"},
  ];

  List<Map<String, dynamic>> get filteredItems {
    List<Map<String, dynamic>> filtered = statusItems;
    
    if (selectedFilter != "all") {
      filtered = filtered.where((item) => item["type"] == selectedFilter).toList();
    }
    
    if (showOnlyActive) {
      filtered = filtered.where((item) => item["status"] == "in_progress").toList();
    }
    
    return filtered;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return infoColor;
      default:
        return disabledColor;
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "high":
        return warningColor;
      case "medium":
        return infoColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in_progress":
        return "In Progress";
      case "pending":
        return "Pending";
      default:
        return "Unknown";
    }
  }

  Widget _buildOverviewTab() {
    int totalTasks = statusItems.length;
    int completedTasks = statusItems.where((item) => item["status"] == "completed").length;
    int inProgressTasks = statusItems.where((item) => item["status"] == "in_progress").length;
    int pendingTasks = statusItems.where((item) => item["status"] == "pending").length;

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Total Tasks",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${totalTasks}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${completedTasks}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: warningColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${inProgressTasks}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pending,
                          color: infoColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${pendingTasks}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Progress Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ...statusItems.take(3).map((item) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "${item["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: getStatusColor(item["status"]),
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: (item["progress"] as int) / 100,
                          backgroundColor: disabledColor.withAlpha(100),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            getStatusColor(item["status"]),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter by Type",
                  items: filterOptions,
                  value: selectedFilter,
                  onChanged: (value, label) {
                    selectedFilter = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              QSwitch(
                items: [
                  {
                    "label": "Active Only",
                    "value": true,
                    "checked": showOnlyActive,
                  }
                ],
                value: [
                  if (showOnlyActive)
                    {
                      "label": "Active Only",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  showOnlyActive = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ],
          ),
          ...filteredItems.map((item) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: Border(
                  left: BorderSide(
                    width: 4,
                    color: getPriorityColor(item["priority"]),
                  ),
                ),
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${item["title"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: getStatusColor(item["status"]).withAlpha(100),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          getStatusText(item["status"]),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: getStatusColor(item["status"]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${item["description"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${item["assignee"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${item["estimated_completion"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  if (item["status"] == "in_progress")
                    Column(
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${item["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: (item["progress"] as int) / 100,
                          backgroundColor: disabledColor.withAlpha(100),
                          valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: spSm),
                      QButton(
                        icon: Icons.edit,
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.pie_chart,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Task Distribution",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                ResponsiveGridView(
                  padding: EdgeInsets.zero,
                  minItemWidth: 200,
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "Completed",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "40%",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "In Progress",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "40%",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: infoColor.withAlpha(50),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spXs,
                        children: [
                          Text(
                            "Pending",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: infoColor,
                            ),
                          ),
                          Text(
                            "20%",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: infoColor,
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
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timeline,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Priority Distribution",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: dangerColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Critical",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "1 task",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "High",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "2 tasks",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Medium",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "2 tasks",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Task Status Dashboard",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Tasks", icon: Icon(Icons.assignment)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTasksTab(),
        _buildAnalyticsTab(),
      ],
      onInit: (tabController) {
        // Tab controller initialization if needed
      },
    );
  }
}
