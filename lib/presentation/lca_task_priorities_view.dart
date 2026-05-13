import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class LcaTaskPrioritiesView extends StatefulWidget {
  const LcaTaskPrioritiesView({super.key});

  @override
  State<LcaTaskPrioritiesView> createState() => _LcaTaskPrioritiesViewState();
}

class _LcaTaskPrioritiesViewState extends State<LcaTaskPrioritiesView> {
  String searchQuery = "";
  String selectedPriority = "all";
  String selectedStatus = "all";
  String selectedAssignee = "all";
  bool showOverdueOnly = false;
  
  List<Map<String, dynamic>> priorityTasks = [
    {
      "id": "TSK001",
      "title": "Emergency Motion Filing",
      "description": "File emergency motion for temporary restraining order",
      "priority": "critical",
      "urgency_score": 100,
      "status": "in_progress",
      "due_date": "2024-06-20",
      "assigned_to": "Sarah Mitchell",
      "case_number": "2024-0123",
      "client_name": "Johnson & Associates",
      "estimated_hours": 6.0,
      "actual_hours": 3.5,
      "category": "motion_filing",
      "impact": "high",
      "deadline_proximity": 2, // days
      "client_importance": "high",
      "case_value": 500000.00,
      "dependencies": ["Document Review", "Client Approval"],
    },
    {
      "id": "TSK002",
      "title": "Settlement Negotiation Preparation",
      "description": "Prepare materials and strategy for settlement conference",
      "priority": "high",
      "urgency_score": 85,
      "status": "pending",
      "due_date": "2024-06-25",
      "assigned_to": "Michael Chen",
      "case_number": "2024-0124",
      "client_name": "Tech Solutions Inc",
      "estimated_hours": 8.0,
      "actual_hours": 0.0,
      "category": "negotiation",
      "impact": "high",
      "deadline_proximity": 7,
      "client_importance": "medium",
      "case_value": 250000.00,
      "dependencies": ["Financial Analysis"],
    },
    {
      "id": "TSK003",
      "title": "Deposition Transcript Review",
      "description": "Review and analyze deposition transcripts for key testimony",
      "priority": "high",
      "urgency_score": 80,
      "status": "in_progress",
      "due_date": "2024-06-28",
      "assigned_to": "David Rodriguez",
      "case_number": "2024-0125",
      "client_name": "Green Valley Medical",
      "estimated_hours": 5.0,
      "actual_hours": 2.0,
      "category": "analysis",
      "impact": "medium",
      "deadline_proximity": 10,
      "client_importance": "high",
      "case_value": 750000.00,
      "dependencies": [],
    },
    {
      "id": "TSK004",
      "title": "Contract Amendment Draft",
      "description": "Draft amendments to employment contract based on new regulations",
      "priority": "medium",
      "urgency_score": 60,
      "status": "pending",
      "due_date": "2024-07-05",
      "assigned_to": "Lisa Thompson",
      "case_number": "2024-0126",
      "client_name": "Metro Construction",
      "estimated_hours": 4.0,
      "actual_hours": 0.0,
      "category": "drafting",
      "impact": "medium",
      "deadline_proximity": 17,
      "client_importance": "medium",
      "case_value": 50000.00,
      "dependencies": ["Regulatory Research"],
    },
    {
      "id": "TSK005",
      "title": "Research IP Precedents",
      "description": "Research intellectual property case precedents for patent filing",
      "priority": "low",
      "urgency_score": 40,
      "status": "pending",
      "due_date": "2024-07-15",
      "assigned_to": "Robert Kim",
      "case_number": "2024-0127",
      "client_name": "Retail Plus Corp",
      "estimated_hours": 6.0,
      "actual_hours": 0.0,
      "category": "research",
      "impact": "low",
      "deadline_proximity": 27,
      "client_importance": "low",
      "case_value": 25000.00,
      "dependencies": [],
    },
    {
      "id": "TSK006",
      "title": "Discovery Response Filing",
      "description": "Prepare and file responses to discovery requests",
      "priority": "high",
      "urgency_score": 90,
      "status": "overdue",
      "due_date": "2024-06-15",
      "assigned_to": "Sarah Mitchell",
      "case_number": "2024-0128",
      "client_name": "Healthcare Partners",
      "estimated_hours": 7.0,
      "actual_hours": 4.0,
      "category": "discovery",
      "impact": "high",
      "deadline_proximity": -3, // overdue by 3 days
      "client_importance": "high",
      "case_value": 300000.00,
      "dependencies": ["Client Document Collection"],
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return priorityTasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${task["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["description"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["case_number"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["client_name"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority == "all" || task["priority"] == selectedPriority;
      bool matchesStatus = selectedStatus == "all" || task["status"] == selectedStatus;
      bool matchesAssignee = selectedAssignee == "all" || task["assigned_to"] == selectedAssignee;
      bool matchesOverdue = !showOverdueOnly || task["status"] == "overdue";
      
      return matchesSearch && matchesPriority && matchesStatus && matchesAssignee && matchesOverdue;
    }).toList()..sort((a, b) => (b["urgency_score"] as int).compareTo(a["urgency_score"] as int));
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return Color(0xFFD32F2F); // Darker red
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledColor;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "pending":
        return warningColor;
      case "overdue":
        return dangerColor;
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

  Widget _buildPriorityIndicator(Map<String, dynamic> task) {
    final priority = "${task["priority"]}";
    final urgencyScore = task["urgency_score"] as int;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
      decoration: BoxDecoration(
        color: _getPriorityColor(priority),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (priority == "critical") 
            Icon(
              Icons.warning,
              size: 12,
              color: Colors.white,
            ),
          if (priority == "critical") SizedBox(width: spXs),
          Text(
            "${_getPriorityLabel(priority)} ($urgencyScore)",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgencyMetrics(Map<String, dynamic> task) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: disabledColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusXs),
        border: Border.all(
          color: disabledColor.withAlpha(20),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Priority Factors",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Impact: ${task["impact"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Client: ${task["client_importance"]}".toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
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
                      "Value: \$${((task["case_value"] as double) / 1000).toStringAsFixed(0)}K",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Deadline: ${(task["deadline_proximity"] as int) >= 0 ? "${task["deadline_proximity"]} days" : "${(task["deadline_proximity"] as int).abs()} days overdue"}",
                      style: TextStyle(
                        fontSize: 11,
                        color: (task["deadline_proximity"] as int) < 0 ? dangerColor : disabledBoldColor,
                        fontWeight: (task["deadline_proximity"] as int) < 0 ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if ((task["dependencies"] as List).isNotEmpty) ...[
            SizedBox(height: spXs),
            Text(
              "Dependencies: ${(task["dependencies"] as List).join(", ")}",
              style: TextStyle(
                fontSize: 10,
                color: disabledColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final criticalTasks = priorityTasks.where((task) => task["priority"] == "critical").length;
    final highPriorityTasks = priorityTasks.where((task) => task["priority"] == "high").length;
    final overdueTasks = priorityTasks.where((task) => task["status"] == "overdue").length;
    final avgUrgencyScore = priorityTasks.fold(0, (sum, task) => sum + (task["urgency_score"] as int)) / priorityTasks.length;

    return Scaffold(
      appBar: AppBar(
        title: Text("Task Priorities"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              si("Tasks sorted by urgency score");
            },
          ),
          IconButton(
            icon: Icon(Icons.priority_high),
            onPressed: () {
              si("Showing priority management options");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            // Priority Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.warning,
                              color: Color(0xFFD32F2F),
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Critical",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$criticalTasks",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD32F2F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.priority_high,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "High Priority",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$highPriorityTasks",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.schedule,
                              color: dangerColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Overdue",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "$overdueTasks",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
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
                            Icon(
                              Icons.trending_up,
                              color: primaryColor,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Avg Urgency",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "${avgUrgencyScore.toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Filters
            Container(
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
                    "Filter & Search",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  QTextField(
                    label: "Search tasks...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Priority Level",
                          items: [
                            {"label": "All Priorities", "value": "all"},
                            {"label": "Critical", "value": "critical"},
                            {"label": "High", "value": "high"},
                            {"label": "Medium", "value": "medium"},
                            {"label": "Low", "value": "low"},
                          ],
                          value: selectedPriority,
                          onChanged: (value, label) {
                            selectedPriority = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: [
                            {"label": "All Status", "value": "all"},
                            {"label": "Pending", "value": "pending"},
                            {"label": "In Progress", "value": "in_progress"},
                            {"label": "Completed", "value": "completed"},
                            {"label": "Overdue", "value": "overdue"},
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
                  SizedBox(height: spMd),
                  QSwitch(
                    items: [
                      {
                        "label": "Show overdue tasks only",
                        "value": true,
                        "checked": showOverdueOnly,
                      }
                    ],
                    value: [if (showOverdueOnly) {"label": "Show overdue tasks only", "value": true, "checked": true}],
                    onChanged: (values, ids) {
                      setState(() {
                        showOverdueOnly = values.isNotEmpty;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Priority Tasks List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(spMd),
                    child: Row(
                      children: [
                        Text(
                          "Priority Tasks (${filteredTasks.length})",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "Sorted by Urgency Score",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredTasks.length,
                    separatorBuilder: (context, index) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      return Container(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 4,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor("${task["priority"]}"),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(width: spMd),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
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
                                          _buildPriorityIndicator(task),
                                        ],
                                      ),
                                      SizedBox(height: spSm),
                                      Text(
                                        "${task["description"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: disabledBoldColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: spMd),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${task["assigned_to"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spMd),
                                          Icon(
                                            Icons.calendar_today,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "Due: ${DateTime.parse("${task["due_date"]}").dMMMy}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: task["status"] == "overdue" ? dangerColor : disabledBoldColor,
                                              fontWeight: task["status"] == "overdue" ? FontWeight.w600 : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.folder,
                                            size: 16,
                                            color: disabledBoldColor,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${task["case_number"]} • ${task["client_name"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor("${task["status"]}").withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${task["status"]}".replaceAll("_", " ").toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor("${task["status"]}"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spMd),
                                      _buildUrgencyMetrics(task),
                                      SizedBox(height: spMd),
                                      Row(
                                        children: [
                                          Text(
                                            "${(task["actual_hours"] as double).toStringAsFixed(1)}h / ${(task["estimated_hours"] as double).toStringAsFixed(1)}h",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledColor,
                                            ),
                                          ),
                                          Spacer(),
                                          QButton(
                                            label: "Manage Priority",
                                            size: bs.sm,
                                            onPressed: () {
                                              // Navigate to priority management
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
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
            ),
          ],
        ),
      ),
    );
  }
}
