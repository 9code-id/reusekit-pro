import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FsmWorkOrderPriorityView extends StatefulWidget {
  const FsmWorkOrderPriorityView({super.key});

  @override
  State<FsmWorkOrderPriorityView> createState() => _FsmWorkOrderPriorityViewState();
}

class _FsmWorkOrderPriorityViewState extends State<FsmWorkOrderPriorityView> {
  String selectedFilter = "all";
  String selectedTimeframe = "today";
  String searchQuery = "";

  List<Map<String, dynamic>> filterItems = [
    {"label": "All Priorities", "value": "all"},
    {"label": "Critical Only", "value": "critical"},
    {"label": "High Only", "value": "high"},
    {"label": "Medium Only", "value": "medium"},
    {"label": "Low Only", "value": "low"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Today", "value": "today"},
    {"label": "This Week", "value": "this_week"},
    {"label": "This Month", "value": "this_month"},
    {"label": "All Time", "value": "all_time"},
  ];

  List<Map<String, dynamic>> workOrders = [
    {
      "id": "WO-2024-001",
      "title": "HVAC System Failure - Emergency",
      "client": "City Hospital",
      "location": "Emergency Department",
      "priority": "critical",
      "status": "pending",
      "assignedTo": "John Smith",
      "dueDate": "2024-12-19",
      "dueTime": "12:00",
      "estimatedDuration": 2.0,
      "cost": 1200.00,
      "description": "Complete HVAC system failure affecting patient care areas",
      "urgencyReason": "Patient safety and comfort at risk",
      "escalationLevel": 3,
      "createdDate": "2024-12-19",
      "slaDeadline": "2024-12-19 14:00",
      "tags": ["Emergency", "HVAC", "Hospital"],
    },
    {
      "id": "WO-2024-002",
      "title": "Electrical Panel Sparking",
      "client": "Manufacturing Plant",
      "location": "Production Floor A",
      "priority": "critical",
      "status": "assigned",
      "assignedTo": "Sarah Johnson",
      "dueDate": "2024-12-19",
      "dueTime": "15:00",
      "estimatedDuration": 3.0,
      "cost": 850.00,
      "description": "Electrical panel showing sparks and unusual sounds",
      "urgencyReason": "Fire hazard and production shutdown risk",
      "escalationLevel": 2,
      "createdDate": "2024-12-19",
      "slaDeadline": "2024-12-19 16:00",
      "tags": ["Emergency", "Electrical", "Safety"],
    },
    {
      "id": "WO-2024-003",
      "title": "Water Leak in Server Room",
      "client": "Tech Startup Inc.",
      "location": "Server Room B2",
      "priority": "high",
      "status": "in_progress",
      "assignedTo": "Mike Wilson",
      "dueDate": "2024-12-20",
      "dueTime": "10:00",
      "estimatedDuration": 4.0,
      "cost": 650.00,
      "description": "Water leak detected near critical server equipment",
      "urgencyReason": "Risk of equipment damage and data loss",
      "escalationLevel": 1,
      "createdDate": "2024-12-19",
      "slaDeadline": "2024-12-20 12:00",
      "tags": ["Plumbing", "IT", "Urgent"],
    },
    {
      "id": "WO-2024-004",
      "title": "Security System Malfunction",
      "client": "Downtown Office Complex",
      "location": "Main Entrance",
      "priority": "high",
      "status": "pending",
      "assignedTo": "Lisa Brown",
      "dueDate": "2024-12-20",
      "dueTime": "09:00",
      "estimatedDuration": 2.5,
      "cost": 450.00,
      "description": "Main entrance security system not responding",
      "urgencyReason": "Building security compromised",
      "escalationLevel": 1,
      "createdDate": "2024-12-19",
      "slaDeadline": "2024-12-20 11:00",
      "tags": ["Security", "Access Control"],
    },
    {
      "id": "WO-2024-005",
      "title": "Routine HVAC Maintenance",
      "client": "School District",
      "location": "Main Building",
      "priority": "medium",
      "status": "scheduled",
      "assignedTo": "David Chen",
      "dueDate": "2024-12-22",
      "dueTime": "08:00",
      "estimatedDuration": 3.0,
      "cost": 300.00,
      "description": "Quarterly HVAC system maintenance and inspection",
      "urgencyReason": "Preventive maintenance schedule",
      "escalationLevel": 0,
      "createdDate": "2024-12-18",
      "slaDeadline": "2024-12-22 17:00",
      "tags": ["Maintenance", "HVAC", "Scheduled"],
    },
    {
      "id": "WO-2024-006",
      "title": "Office Light Bulb Replacement",
      "client": "Retail Store Chain",
      "location": "Office Area",
      "priority": "low",
      "status": "pending",
      "assignedTo": "John Smith",
      "dueDate": "2024-12-25",
      "dueTime": "14:00",
      "estimatedDuration": 1.0,
      "cost": 75.00,
      "description": "Replace burned out fluorescent lights in office area",
      "urgencyReason": "Non-critical lighting issue",
      "escalationLevel": 0,
      "createdDate": "2024-12-18",
      "slaDeadline": "2024-12-26 17:00",
      "tags": ["Maintenance", "Lighting"],
    },
  ];

  Color _getPriorityColor(String priority) {
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return warningColor;
      case "assigned":
        return infoColor;
      case "in_progress":
        return primaryColor;
      case "scheduled":
        return successColor;
      case "on_hold":
        return dangerColor;
      case "completed":
        return successColor;
      default:
        return disabledColor;
    }
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case "critical":
        return "CRITICAL";
      case "high":
        return "HIGH";
      case "medium":
        return "MEDIUM";
      case "low":
        return "LOW";
      default:
        return "UNKNOWN";
    }
  }

  IconData _getPriorityIcon(String priority) {
    switch (priority) {
      case "critical":
        return Icons.error;
      case "high":
        return Icons.warning;
      case "medium":
        return Icons.info;
      case "low":
        return Icons.check_circle;
      default:
        return Icons.help;
    }
  }

  bool _isOverdue(Map<String, dynamic> workOrder) {
    try {
      final now = DateTime.now();
      final deadline = DateTime.parse("${workOrder["slaDeadline"]}");
      return now.isAfter(deadline) && workOrder["status"] != "completed";
    } catch (e) {
      return false;
    }
  }

  bool _isApproachingDeadline(Map<String, dynamic> workOrder) {
    try {
      final now = DateTime.now();
      final deadline = DateTime.parse("${workOrder["slaDeadline"]}");
      final difference = deadline.difference(now);
      return difference.inHours <= 2 && difference.inHours > 0 && workOrder["status"] != "completed";
    } catch (e) {
      return false;
    }
  }

  List<Map<String, dynamic>> get filteredWorkOrders {
    return workOrders.where((wo) {
      bool matchesPriority = selectedFilter == "all" || wo["priority"] == selectedFilter;
      bool matchesSearch = searchQuery.isEmpty ||
          wo["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          wo["client"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          wo["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          wo["location"].toLowerCase().contains(searchQuery.toLowerCase());
      
      return matchesPriority && matchesSearch;
    }).toList()..sort((a, b) {
      // Sort by priority first (critical -> high -> medium -> low)
      const priorityOrder = {"critical": 0, "high": 1, "medium": 2, "low": 3};
      final priorityComparison = (priorityOrder[a["priority"]] ?? 4).compareTo(priorityOrder[b["priority"]] ?? 4);
      
      if (priorityComparison != 0) return priorityComparison;
      
      // Then sort by due date
      return DateTime.parse("${a["dueDate"]} ${a["dueTime"]}").compareTo(
        DateTime.parse("${b["dueDate"]} ${b["dueTime"]}")
      );
    });
  }

  Map<String, int> get priorityStats {
    return {
      "critical": workOrders.where((wo) => wo["priority"] == "critical").length,
      "high": workOrders.where((wo) => wo["priority"] == "high").length,
      "medium": workOrders.where((wo) => wo["priority"] == "medium").length,
      "low": workOrders.where((wo) => wo["priority"] == "low").length,
      "overdue": workOrders.where((wo) => _isOverdue(wo)).length,
      "approaching": workOrders.where((wo) => _isApproachingDeadline(wo)).length,
    };
  }

  void _viewWorkOrder(Map<String, dynamic> workOrder) {
    // Navigate to work order details
  }

  void _escalateWorkOrder(Map<String, dynamic> workOrder) {
    workOrder["escalationLevel"] = (workOrder["escalationLevel"] as int) + 1;
    setState(() {});
    ss("Work order ${workOrder["id"]} escalated to level ${workOrder["escalationLevel"]}");
  }

  void _assignUrgentTechnician(Map<String, dynamic> workOrder) {
    // Show urgent assignment dialog
    ss("Assigning urgent technician to ${workOrder["id"]}");
  }

  void _changePriority(Map<String, dynamic> workOrder, String newPriority) {
    workOrder["priority"] = newPriority;
    setState(() {});
    ss("Priority changed to ${newPriority.toUpperCase()} for ${workOrder["id"]}");
  }

  @override
  Widget build(BuildContext context) {
    final filtered = filteredWorkOrders;
    final stats = priorityStats;

    return Scaffold(
      appBar: AppBar(
        title: Text("Work Order Priority"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: () {
              ss("Priority queue refreshed");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Priority Statistics Dashboard
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
                    "Priority Overview",
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
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(100)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.error, size: 24, color: dangerColor),
                              SizedBox(height: spXs),
                              Text(
                                "${stats["critical"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Critical",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: warningColor.withAlpha(100)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.warning, size: 24, color: warningColor),
                              SizedBox(height: spXs),
                              Text(
                                "${stats["high"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "High",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: dangerColor.withAlpha(150)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.schedule, size: 24, color: dangerColor),
                              SizedBox(height: spXs),
                              Text(
                                "${stats["overdue"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: dangerColor,
                                ),
                              ),
                              Text(
                                "Overdue",
                                style: TextStyle(
                                  fontSize: 12,
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
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: infoColor.withAlpha(100)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.info, size: 24, color: infoColor),
                              SizedBox(height: spXs),
                              Text(
                                "${stats["medium"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: infoColor,
                                ),
                              ),
                              Text(
                                "Medium",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: infoColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: successColor.withAlpha(100)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.check_circle, size: 24, color: successColor),
                              SizedBox(height: spXs),
                              Text(
                                "${stats["low"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Low",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: warningColor.withAlpha(100)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.access_time, size: 24, color: warningColor),
                              SizedBox(height: spXs),
                              Text(
                                "${stats["approaching"]}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Due Soon",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
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
            ),

            // Search and Filters
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
                      Icon(Icons.search, color: primaryColor, size: 20),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QTextField(
                          label: "Search work orders",
                          value: searchQuery,
                          hint: "Search by ID, title, client, or location...",
                          onChanged: (value) {
                            searchQuery = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Priority Filter",
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
                          label: "Timeframe",
                          items: timeframeItems,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Priority Work Orders List
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Priority Work Orders (${filtered.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      QButton(
                        label: "Bulk Actions",
                        size: bs.sm,
                        onPressed: () {
                          // Show bulk actions menu
                        },
                      ),
                    ],
                  ),
                  ...filtered.map((wo) {
                    final isOverdue = _isOverdue(wo);
                    final isApproaching = _isApproachingDeadline(wo);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isOverdue 
                            ? dangerColor.withAlpha(10) 
                            : isApproaching 
                                ? warningColor.withAlpha(10)
                                : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(
                          color: isOverdue 
                              ? dangerColor.withAlpha(100)
                              : isApproaching 
                                  ? warningColor.withAlpha(100)
                                  : disabledColor,
                        ),
                        boxShadow: wo["priority"] == "critical" ? [shadowMd] : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(spXs),
                                      decoration: BoxDecoration(
                                        color: _getPriorityColor(wo["priority"]).withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Icon(
                                        _getPriorityIcon(wo["priority"]),
                                        size: 20,
                                        color: _getPriorityColor(wo["priority"]),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${wo["id"]}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: disabledBoldColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: spSm),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: _getPriorityColor(wo["priority"]),
                                                  borderRadius: BorderRadius.circular(radiusXs),
                                                ),
                                                child: Text(
                                                  _getPriorityLabel(wo["priority"]),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              if ((wo["escalationLevel"] as int) > 0)
                                                Container(
                                                  margin: EdgeInsets.only(left: spXs),
                                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: dangerColor,
                                                    borderRadius: BorderRadius.circular(radiusXs),
                                                  ),
                                                  child: Text(
                                                    "ESC ${wo["escalationLevel"]}",
                                                    style: TextStyle(
                                                      fontSize: 9,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Text(
                                            "${wo["title"]}",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isOverdue)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: dangerColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "OVERDUE",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              else if (isApproaching)
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "DUE SOON",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            "${wo["client"]} • ${wo["location"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${wo["description"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.priority_high, size: 16, color: warningColor),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${wo["urgencyReason"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: warningColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "${wo["assignedTo"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
                              SizedBox(width: spXs),
                              Text(
                                "Due: ${wo["dueDate"]} ${wo["dueTime"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isOverdue ? dangerColor : disabledBoldColor,
                                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "\$${(wo["cost"] as double).currency}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            spacing: spSm,
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "View Details",
                                  size: bs.sm,
                                  onPressed: () => _viewWorkOrder(wo),
                                ),
                              ),
                              if (wo["priority"] != "critical")
                                QButton(
                                  label: "Escalate",
                                  size: bs.sm,
                                  onPressed: () => _escalateWorkOrder(wo),
                                ),
                              if (wo["status"] == "pending")
                                QButton(
                                  label: "Urgent Assign",
                                  size: bs.sm,
                                  onPressed: () => _assignUrgentTechnician(wo),
                                ),
                              QButton(
                                icon: Icons.more_vert,
                                size: bs.sm,
                                onPressed: () {
                                  // Show priority options menu
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  if (filtered.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      child: Column(
                        children: [
                          Icon(
                            Icons.priority_high,
                            size: 64,
                            color: disabledColor,
                          ),
                          SizedBox(height: spMd),
                          Text(
                            "No priority work orders found",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "All work orders are under control",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
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
}
