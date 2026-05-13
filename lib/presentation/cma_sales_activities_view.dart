import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CmaSalesActivitiesView extends StatefulWidget {
  const CmaSalesActivitiesView({super.key});

  @override
  State<CmaSalesActivitiesView> createState() => _CmaSalesActivitiesViewState();
}

class _CmaSalesActivitiesViewState extends State<CmaSalesActivitiesView> {
  String selectedFilter = "All Activities";
  String selectedType = "All Types";
  String selectedDate = "This Week";
  
  List<Map<String, dynamic>> filterItems = [
    {"label": "All Activities", "value": "All Activities"},
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Overdue", "value": "Overdue"},
    {"label": "Completed", "value": "Completed"},
  ];
  
  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "All Types"},
    {"label": "Call", "value": "Call"},
    {"label": "Email", "value": "Email"},
    {"label": "Meeting", "value": "Meeting"},
    {"label": "Demo", "value": "Demo"},
    {"label": "Follow-up", "value": "Follow-up"},
    {"label": "Proposal", "value": "Proposal"},
  ];
  
  List<Map<String, dynamic>> dateItems = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "Next Week", "value": "Next Week"},
    {"label": "This Month", "value": "This Month"},
  ];
  
  Map<String, dynamic> activityStats = {
    "totalActivities": 156,
    "completedToday": 12,
    "pendingToday": 8,
    "overdueActivities": 5,
    "averageDaily": 18,
    "completionRate": 85.2,
  };
  
  List<Map<String, dynamic>> activities = [
    {
      "id": "ACT-001",
      "type": "Call",
      "title": "Follow-up call with TechCorp",
      "description": "Discuss contract terms and pricing",
      "opportunity": "Enterprise Software Solution",
      "account": "TechCorp Inc.",
      "assignedTo": "John Smith",
      "dueDate": "2024-01-21",
      "dueTime": "10:00 AM",
      "priority": "High",
      "status": "Pending",
      "createdDate": "2024-01-20",
      "estimatedDuration": 60,
      "outcome": null,
      "notes": "Prepare pricing comparison sheet",
    },
    {
      "id": "ACT-002",
      "type": "Meeting",
      "title": "Product demo for Global Industries",
      "description": "Showcase digital transformation capabilities",
      "opportunity": "Digital Transformation Project",
      "account": "Global Industries",
      "assignedTo": "Sarah Johnson",
      "dueDate": "2024-01-21",
      "dueTime": "2:00 PM",
      "priority": "Critical",
      "status": "Pending",
      "createdDate": "2024-01-19",
      "estimatedDuration": 90,
      "outcome": null,
      "notes": "Include ROI calculator in presentation",
    },
    {
      "id": "ACT-003",
      "type": "Email",
      "title": "Send proposal to StartupXYZ",
      "description": "Cloud migration services proposal",
      "opportunity": "Cloud Migration Services",
      "account": "StartupXYZ",
      "assignedTo": "Mike Wilson",
      "dueDate": "2024-01-20",
      "dueTime": "5:00 PM",
      "priority": "Medium",
      "status": "Completed",
      "createdDate": "2024-01-18",
      "estimatedDuration": 30,
      "outcome": "Sent comprehensive proposal with timeline",
      "notes": "Client requested implementation timeline",
    },
    {
      "id": "ACT-004",
      "type": "Follow-up",
      "title": "Security assessment review",
      "description": "Review findings with SecureBank team",
      "opportunity": "Security Audit Package",
      "account": "SecureBank Ltd",
      "assignedTo": "Lisa Chen",
      "dueDate": "2024-01-22",
      "dueTime": "11:00 AM",
      "priority": "High",
      "status": "Pending",
      "createdDate": "2024-01-17",
      "estimatedDuration": 45,
      "outcome": null,
      "notes": "Prepare security compliance checklist",
    },
    {
      "id": "ACT-005",
      "type": "Call",
      "title": "Initial discovery call",
      "description": "Understand requirements for retail solution",
      "opportunity": "Retail Management System",
      "account": "RetailChain Co",
      "assignedTo": "David Brown",
      "dueDate": "2024-01-19",
      "dueTime": "3:00 PM",
      "priority": "Medium",
      "status": "Overdue",
      "createdDate": "2024-01-15",
      "estimatedDuration": 45,
      "outcome": null,
      "notes": "Research their current POS system",
    },
    {
      "id": "ACT-006",
      "type": "Demo",
      "title": "Platform demonstration",
      "description": "Show integration capabilities",
      "opportunity": "Platform Integration Project",
      "account": "Manufacturing Corp",
      "assignedTo": "Emily Davis",
      "dueDate": "2024-01-23",
      "dueTime": "9:00 AM",
      "priority": "High",
      "status": "Pending",
      "createdDate": "2024-01-20",
      "estimatedDuration": 120,
      "outcome": null,
      "notes": "Focus on API integration features",
    },
  ];
  
  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Schedule Call",
      "description": "Schedule a follow-up call",
      "icon": Icons.phone,
      "color": primaryColor,
    },
    {
      "title": "Send Email",
      "description": "Send email to prospect",
      "icon": Icons.email,
      "color": infoColor,
    },
    {
      "title": "Book Meeting",
      "description": "Schedule a meeting",
      "icon": Icons.event,
      "color": successColor,
    },
    {
      "title": "Create Task",
      "description": "Add a follow-up task",
      "icon": Icons.task,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredActivities = _getFilteredActivities();
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Activities"),
        actions: [
          QButton(
            icon: Icons.add,
            size: bs.sm,
            onPressed: () => _addActivity(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Activity Statistics
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Activity Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Total Activities",
                          "${activityStats["totalActivities"]}",
                          Icons.assignment,
                          primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Completed Today",
                          "${activityStats["completedToday"]}",
                          Icons.check_circle,
                          successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Pending Today",
                          "${activityStats["pendingToday"]}",
                          Icons.pending,
                          warningColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Overdue",
                          "${activityStats["overdueActivities"]}",
                          Icons.warning,
                          dangerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Quick Actions
            Container(
              padding: EdgeInsets.all(spSm),
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
                    children: quickActions.map((action) {
                      int index = quickActions.indexOf(action);
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: index < quickActions.length - 1 ? spSm : 0),
                          child: _buildQuickActionCard(action),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Filters
            Container(
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
                      Expanded(
                        child: QDropdownField(
                          label: "Filter",
                          items: filterItems,
                          value: selectedFilter,
                          onChanged: (value, label) {
                            selectedFilter = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Type",
                          items: typeItems,
                          value: selectedType,
                          onChanged: (value, label) {
                            selectedType = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Activities List
            Container(
              padding: EdgeInsets.all(spSm),
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
                      Expanded(
                        child: Text(
                          "Activities (${filteredActivities.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () => _viewAllActivities(),
                      ),
                    ],
                  ),
                  if (filteredActivities.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(Icons.event_busy, size: 48, color: disabledBoldColor),
                          SizedBox(height: spSm),
                          Text(
                            "No activities found",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Try adjusting your filters",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredActivities.take(10).map((activity) => _buildActivityCard(activity)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  List<Map<String, dynamic>> _getFilteredActivities() {
    List<Map<String, dynamic>> filtered = List.from(activities);
    
    // Filter by type
    if (selectedType != "All Types") {
      filtered = filtered.where((activity) => activity["type"] == selectedType).toList();
    }
    
    // Apply special filters
    switch (selectedFilter) {
      case "Today":
        filtered = filtered.where((activity) {
          DateTime dueDate = DateTime.parse(activity["dueDate"] as String);
          DateTime today = DateTime.now();
          return dueDate.year == today.year && 
                 dueDate.month == today.month && 
                 dueDate.day == today.day;
        }).toList();
        break;
      case "This Week":
        filtered = filtered.where((activity) {
          DateTime dueDate = DateTime.parse(activity["dueDate"] as String);
          DateTime now = DateTime.now();
          DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
          DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
          return dueDate.isAfter(startOfWeek.subtract(Duration(days: 1))) && 
                 dueDate.isBefore(endOfWeek.add(Duration(days: 1)));
        }).toList();
        break;
      case "Overdue":
        filtered = filtered.where((activity) {
          DateTime dueDate = DateTime.parse(activity["dueDate"] as String);
          return dueDate.isBefore(DateTime.now()) && activity["status"] != "Completed";
        }).toList();
        break;
      case "Completed":
        filtered = filtered.where((activity) => activity["status"] == "Completed").toList();
        break;
    }
    
    return filtered;
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionCard(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () => _performQuickAction(action["title"] as String),
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: (action["color"] as Color).withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: (action["color"] as Color).withAlpha(100)),
        ),
        child: Column(
          children: [
            Icon(
              action["icon"] as IconData,
              color: action["color"] as Color,
              size: 24,
            ),
            SizedBox(height: spXs),
            Text(
              "${action["title"]}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: action["color"] as Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildActivityCard(Map<String, dynamic> activity) {
    Color priorityColor = _getPriorityColor(activity["priority"] as String);
    Color statusColor = _getStatusColor(activity["status"] as String);
    Color typeColor = _getTypeColor(activity["type"] as String);
    bool isOverdue = DateTime.parse(activity["dueDate"] as String).isBefore(DateTime.now()) 
        && activity["status"] != "Completed";
    
    return GestureDetector(
      onTap: () => _viewActivityDetails(activity),
      child: Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(
            color: isOverdue ? dangerColor : disabledOutlineBorderColor,
            width: isOverdue ? 2 : 1,
          ),
          boxShadow: [shadowXs],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spXs,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: typeColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${activity["type"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: typeColor,
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: priorityColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${activity["priority"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "${activity["status"]}",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "${activity["title"]}",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Text(
              "${activity["description"]}",
              style: TextStyle(
                fontSize: 13,
                color: disabledBoldColor,
              ),
            ),
            Row(
              children: [
                Icon(Icons.business, size: 12, color: disabledBoldColor),
                SizedBox(width: 4),
                Text(
                  "${activity["account"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Text(" • ", style: TextStyle(color: disabledBoldColor)),
                Text(
                  "${activity["opportunity"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.person, size: 12, color: disabledBoldColor),
                SizedBox(width: 4),
                Text(
                  "${activity["assignedTo"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.schedule,
                  size: 12,
                  color: isOverdue ? dangerColor : disabledBoldColor,
                ),
                SizedBox(width: 4),
                Text(
                  "${activity["dueDate"]} ${activity["dueTime"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: isOverdue ? dangerColor : disabledBoldColor,
                    fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
            if (activity["notes"] != null && (activity["notes"] as String).isNotEmpty)
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  children: [
                    Icon(Icons.note, size: 12, color: infoColor),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${activity["notes"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: infoColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
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
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "Pending":
        return warningColor;
      case "Overdue":
        return dangerColor;
      case "In Progress":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getTypeColor(String type) {
    switch (type) {
      case "Call":
        return Colors.blue;
      case "Email":
        return Colors.orange;
      case "Meeting":
        return Colors.purple;
      case "Demo":
        return Colors.green;
      case "Follow-up":
        return Colors.indigo;
      case "Proposal":
        return Colors.teal;
      default:
        return disabledBoldColor;
    }
  }
  
  void _addActivity() {
    ss("Navigate to add activity");
  }
  
  void _viewAllActivities() {
    ss("Navigate to all activities list");
  }
  
  void _performQuickAction(String action) {
    ss("Perform quick action: $action");
  }
  
  void _viewActivityDetails(Map<String, dynamic> activity) {
    ss("View details for ${activity["title"]}");
  }
}
