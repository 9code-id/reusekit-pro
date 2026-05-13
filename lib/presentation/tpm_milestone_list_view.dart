import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmMilestoneListView extends StatefulWidget {
  const TpmMilestoneListView({super.key});

  @override
  State<TpmMilestoneListView> createState() => _TpmMilestoneListViewState();
}

class _TpmMilestoneListViewState extends State<TpmMilestoneListView> {
  String searchQuery = "";
  String statusFilter = "";
  List<Map<String, dynamic>> milestones = [
    {
      "id": 1,
      "title": "Phase 1 Completion",
      "description": "Complete all core features for phase 1",
      "status": "completed",
      "progress": 100,
      "dueDate": "2025-05-15",
      "project": "Mobile App Development",
      "assignedTo": "Development Team",
      "priority": "high",
      "tasks": 12,
      "completedTasks": 12,
      "color": successColor,
    },
    {
      "id": 2,
      "title": "UI/UX Design Review",
      "description": "Review and approve all design mockups",
      "status": "in_progress",
      "progress": 75,
      "dueDate": "2025-06-20",
      "project": "Website Redesign",
      "assignedTo": "Design Team",
      "priority": "medium",
      "tasks": 8,
      "completedTasks": 6,
      "color": warningColor,
    },
    {
      "id": 3,
      "title": "API Integration",
      "description": "Integrate all third-party APIs",
      "status": "pending",
      "progress": 0,
      "dueDate": "2025-07-10",
      "project": "Backend System",
      "assignedTo": "Backend Team",
      "priority": "high",
      "tasks": 15,
      "completedTasks": 0,
      "color": dangerColor,
    },
    {
      "id": 4,
      "title": "Testing & QA",
      "description": "Complete comprehensive testing phase",
      "status": "in_progress",
      "progress": 40,
      "dueDate": "2025-06-25",
      "project": "Mobile App Development",
      "assignedTo": "QA Team",
      "priority": "medium",
      "tasks": 20,
      "completedTasks": 8,
      "color": infoColor,
    },
    {
      "id": 5,
      "title": "Documentation",
      "description": "Create user and technical documentation",
      "status": "pending",
      "progress": 20,
      "dueDate": "2025-08-01",
      "project": "Documentation Portal",
      "assignedTo": "Tech Writers",
      "priority": "low",
      "tasks": 10,
      "completedTasks": 2,
      "color": disabledBoldColor,
    },
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": ""},
    {"label": "Completed", "value": "completed"},
    {"label": "In Progress", "value": "in_progress"},
    {"label": "Pending", "value": "pending"},
  ];

  List<Map<String, dynamic>> get filteredMilestones {
    return milestones.where((milestone) {
      bool matchesSearch = "${milestone["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${milestone["project"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesStatus = statusFilter.isEmpty || milestone["status"] == statusFilter;
      return matchesSearch && matchesStatus;
    }).toList();
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

  Color getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  String getPriorityText(String priority) {
    switch (priority) {
      case "high":
        return "High";
      case "medium":
        return "Medium";
      case "low":
        return "Low";
      default:
        return "Normal";
    }
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Milestones"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //navigateTo TpmCreateMilestoneView
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search and Filter Section
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
                  QTextField(
                    label: "Search milestones...",
                    value: searchQuery,
                    hint: "Search by title or project",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                  QDropdownField(
                    label: "Filter by Status",
                    items: statusOptions,
                    value: statusFilter,
                    onChanged: (value, label) {
                      statusFilter = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Statistics Cards
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${milestones.where((m) => m["status"] == "completed").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${milestones.where((m) => m["status"] == "in_progress").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "In Progress",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${milestones.where((m) => m["status"] == "pending").length}",
                          style: TextStyle(
                            fontSize: fsH3,
                            fontWeight: FontWeight.bold,
                            color: dangerColor,
                          ),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Milestones List
            ...filteredMilestones.map((milestone) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: milestone["color"] as Color,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${milestone["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: getStatusColor(milestone["status"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            getStatusText(milestone["status"]),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: getStatusColor(milestone["status"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${milestone["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.folder,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${milestone["project"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: getPriorityColor(milestone["priority"]).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            getPriorityText(milestone["priority"]),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: getPriorityColor(milestone["priority"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "${milestone["assignedTo"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "Due: ${DateTime.parse(milestone["dueDate"]).dMMMy}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Tasks: ${milestone["completedTasks"]}/${milestone["tasks"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${milestone["progress"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: (milestone["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            milestone["color"] as Color,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Details",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo TpmMilestoneDetailView
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.edit,
                          size: bs.sm,
                          onPressed: () {
                            //navigateTo TpmCreateMilestoneView with edit mode
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            if (filteredMilestones.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
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
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your search or filter criteria",
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
    );
  }
}
