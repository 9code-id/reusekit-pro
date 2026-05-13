import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaMilestoneListView extends StatefulWidget {
  const PmaMilestoneListView({super.key});

  @override
  State<PmaMilestoneListView> createState() => _PmaMilestoneListViewState();
}

class _PmaMilestoneListViewState extends State<PmaMilestoneListView> {
  String searchQuery = "";
  String selectedFilter = "all";
  String sortBy = "dueDate";
  bool isAscending = true;

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Milestones", "value": "all"},
    {"label": "Upcoming", "value": "upcoming"},
    {"label": "Overdue", "value": "overdue"},
    {"label": "This Week", "value": "thisWeek"},
    {"label": "This Month", "value": "thisMonth"},
    {"label": "High Priority", "value": "highPriority"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Due Date", "value": "dueDate"},
    {"label": "Priority", "value": "priority"},
    {"label": "Progress", "value": "progress"},
    {"label": "Status", "value": "status"},
    {"label": "Project", "value": "project"},
  ];

  List<Map<String, dynamic>> milestones = [
    {
      "id": "1",
      "title": "Frontend Development Complete",
      "description": "Complete all frontend components and user interface",
      "project": "E-commerce Platform",
      "projectColor": Colors.blue,
      "status": "in_progress",
      "priority": "high",
      "progress": 85,
      "dueDate": "2024-06-25",
      "assignedTo": "Sarah Johnson",
      "assignedAvatar": "https://picsum.photos/40/40?random=1",
      "tasksCompleted": 12,
      "totalTasks": 15,
      "isOverdue": false,
      "daysUntilDue": 6,
    },
    {
      "id": "2",
      "title": "API Integration",
      "description": "Integrate all third-party APIs and services",
      "project": "Mobile App",
      "projectColor": Colors.green,
      "status": "not_started",
      "priority": "medium",
      "progress": 0,
      "dueDate": "2024-07-10",
      "assignedTo": "Michael Chen",
      "assignedAvatar": "https://picsum.photos/40/40?random=2",
      "tasksCompleted": 0,
      "totalTasks": 8,
      "isOverdue": false,
      "daysUntilDue": 21,
    },
    {
      "id": "3",
      "title": "Database Migration",
      "description": "Migrate legacy data to new database structure",
      "project": "CRM System",
      "projectColor": Colors.orange,
      "status": "overdue",
      "priority": "high",
      "progress": 40,
      "dueDate": "2024-06-15",
      "assignedTo": "Emma Davis",
      "assignedAvatar": "https://picsum.photos/40/40?random=3",
      "tasksCompleted": 4,
      "totalTasks": 10,
      "isOverdue": true,
      "daysUntilDue": -4,
    },
    {
      "id": "4",
      "title": "Security Audit",
      "description": "Complete security audit and vulnerability assessment",
      "project": "Website Redesign",
      "projectColor": Colors.purple,
      "status": "in_progress",
      "priority": "high",
      "progress": 60,
      "dueDate": "2024-06-30",
      "assignedTo": "David Wilson",
      "assignedAvatar": "https://picsum.photos/40/40?random=4",
      "tasksCompleted": 6,
      "totalTasks": 10,
      "isOverdue": false,
      "daysUntilDue": 11,
    },
    {
      "id": "5",
      "title": "Performance Optimization",
      "description": "Optimize application performance and loading times",
      "project": "E-commerce Platform",
      "projectColor": Colors.blue,
      "status": "completed",
      "priority": "medium",
      "progress": 100,
      "dueDate": "2024-06-10",
      "assignedTo": "Alex Thompson",
      "assignedAvatar": "https://picsum.photos/40/40?random=5",
      "tasksCompleted": 7,
      "totalTasks": 7,
      "isOverdue": false,
      "daysUntilDue": -9,
    },
    {
      "id": "6",
      "title": "User Testing Phase",
      "description": "Conduct comprehensive user testing and feedback collection",
      "project": "Mobile App",
      "projectColor": Colors.green,
      "status": "in_progress",
      "priority": "low",
      "progress": 25,
      "dueDate": "2024-07-20",
      "assignedTo": "Lisa Rodriguez",
      "assignedAvatar": "https://picsum.photos/40/40?random=6",
      "tasksCompleted": 2,
      "totalTasks": 8,
      "isOverdue": false,
      "daysUntilDue": 31,
    },
  ];

  List<Map<String, dynamic>> get filteredAndSortedMilestones {
    List<Map<String, dynamic>> filtered = milestones;
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((milestone) =>
        (milestone["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (milestone["description"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (milestone["project"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Apply status filter
    switch (selectedFilter) {
      case "upcoming":
        filtered = filtered.where((m) => m["status"] == "not_started").toList();
        break;
      case "overdue":
        filtered = filtered.where((m) => m["isOverdue"] == true).toList();
        break;
      case "thisWeek":
        filtered = filtered.where((m) => (m["daysUntilDue"] as int) <= 7 && (m["daysUntilDue"] as int) >= 0).toList();
        break;
      case "thisMonth":
        filtered = filtered.where((m) => (m["daysUntilDue"] as int) <= 30 && (m["daysUntilDue"] as int) >= 0).toList();
        break;
      case "highPriority":
        filtered = filtered.where((m) => m["priority"] == "high").toList();
        break;
    }
    
    // Apply sorting
    filtered.sort((a, b) {
      int comparison = 0;
      
      switch (sortBy) {
        case "dueDate":
          comparison = (a["daysUntilDue"] as int).compareTo(b["daysUntilDue"] as int);
          break;
        case "priority":
          Map<String, int> priorityOrder = {"high": 3, "medium": 2, "low": 1};
          comparison = (priorityOrder[b["priority"]] ?? 0).compareTo(priorityOrder[a["priority"]] ?? 0);
          break;
        case "progress":
          comparison = (b["progress"] as int).compareTo(a["progress"] as int);
          break;
        case "status":
          comparison = (a["status"] as String).compareTo(b["status"] as String);
          break;
        case "project":
          comparison = (a["project"] as String).compareTo(b["project"] as String);
          break;
      }
      
      return isAscending ? comparison : -comparison;
    });
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Milestone List"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterOptions,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchAndFilters(),
          _buildMilestoneStats(),
          Expanded(
            child: _buildMilestonesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createMilestone,
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          QTextField(
            label: "Search Milestones",
            value: searchQuery,
            hint: "Search by title, description, or project...",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Filter",
                  items: filterOptions,
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
                  label: "Sort By",
                  items: sortOptions,
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {
                  isAscending = !isAscending;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: primaryColor),
                  ),
                  child: Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    color: primaryColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneStats() {
    int totalMilestones = filteredAndSortedMilestones.length;
    int completedMilestones = filteredAndSortedMilestones.where((m) => m["status"] == "completed").length;
    int overdueMilestones = filteredAndSortedMilestones.where((m) => m["isOverdue"] == true).length;
    int inProgressMilestones = filteredAndSortedMilestones.where((m) => m["status"] == "in_progress").length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(20),
        border: Border(
          bottom: BorderSide(color: disabledOutlineBorderColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem("Total", "$totalMilestones", Icons.flag, primaryColor),
          ),
          Expanded(
            child: _buildStatItem("Completed", "$completedMilestones", Icons.check_circle, successColor),
          ),
          Expanded(
            child: _buildStatItem("In Progress", "$inProgressMilestones", Icons.hourglass_empty, infoColor),
          ),
          Expanded(
            child: _buildStatItem("Overdue", "$overdueMilestones", Icons.warning, dangerColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
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
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildMilestonesList() {
    if (filteredAndSortedMilestones.isEmpty) {
      return Container(
        padding: EdgeInsets.all(spLg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: disabledColor,
            ),
            SizedBox(height: spSm),
            Text(
              "No milestones found",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "Try adjusting your search or filters",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: filteredAndSortedMilestones.length,
      itemBuilder: (context, index) {
        return _buildMilestoneCard(filteredAndSortedMilestones[index]);
      },
    );
  }

  Widget _buildMilestoneCard(Map<String, dynamic> milestone) {
    String status = milestone["status"];
    String priority = milestone["priority"];
    int progress = milestone["progress"] as int;
    bool isOverdue = milestone["isOverdue"] as bool;
    int daysUntilDue = milestone["daysUntilDue"] as int;
    
    Color statusColor = _getStatusColor(status);
    Color priorityColor = _getPriorityColor(priority);

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isOverdue ? Border.all(color: dangerColor, width: 2) : null,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: (milestone["projectColor"] as Color).withAlpha(20),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusMd),
                topRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 30,
                  decoration: BoxDecoration(
                    color: milestone["projectColor"] as Color,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "${milestone["project"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: milestone["projectColor"] as Color,
                    ),
                  ),
                ),
                if (isOverdue) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: dangerColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "OVERDUE",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${milestone["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${milestone["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: priorityColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: priorityColor),
                          ),
                          child: Text(
                            priority.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: priorityColor,
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$progress%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.transparent,
                    color: statusColor,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage("${milestone["assignedAvatar"]}"),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${milestone["assignedTo"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${milestone["tasksCompleted"]}/${milestone["totalTasks"]} tasks completed",
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
                          "Due: ${milestone["dueDate"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isOverdue ? dangerColor : disabledBoldColor,
                            fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                        Text(
                          _getDaysUntilDueText(daysUntilDue),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getDaysUntilDueColor(daysUntilDue),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(color: statusColor),
                      ),
                      child: Text(
                        status.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _viewMilestoneDetails(milestone),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.visibility,
                              size: 16,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () => _editMilestone(milestone),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: infoColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        GestureDetector(
                          onTap: () => _deleteMilestone(milestone["id"]),
                          child: Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.delete,
                              size: 16,
                              color: dangerColor,
                            ),
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return infoColor;
      case "not_started":
        return warningColor;
      case "overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
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

  String _getDaysUntilDueText(int days) {
    if (days < 0) {
      return "${days.abs()} days ago";
    } else if (days == 0) {
      return "Due today";
    } else if (days == 1) {
      return "Due tomorrow";
    } else {
      return "Due in $days days";
    }
  }

  Color _getDaysUntilDueColor(int days) {
    if (days < 0) {
      return dangerColor;
    } else if (days <= 3) {
      return warningColor;
    } else if (days <= 7) {
      return infoColor;
    } else {
      return successColor;
    }
  }

  void _toggleSearch() {
    si("Toggle search functionality");
  }

  void _showFilterOptions() {
    si("Show advanced filter options");
  }

  void _createMilestone() {
    si("Create new milestone");
  }

  void _viewMilestoneDetails(Map<String, dynamic> milestone) {
    si("View details for: ${milestone["title"]}");
  }

  void _editMilestone(Map<String, dynamic> milestone) {
    si("Edit milestone: ${milestone["title"]}");
  }

  void _deleteMilestone(String milestoneId) async {
    bool isConfirmed = await confirm("Are you sure you want to delete this milestone?");
    if (isConfirmed) {
      setState(() {
        milestones.removeWhere((milestone) => milestone["id"] == milestoneId);
      });
      ss("Milestone deleted successfully");
    }
  }
}
