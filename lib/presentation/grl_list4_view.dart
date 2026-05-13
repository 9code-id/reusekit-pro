import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlList4View extends StatefulWidget {
  @override
  State<GrlList4View> createState() => _GrlList4ViewState();
}

class _GrlList4ViewState extends State<GrlList4View> {
  String searchQuery = "";
  String selectedPriority = "All";
  
  List<Map<String, dynamic>> priorityOptions = [
    {"label": "All", "value": "All"},
    {"label": "High", "value": "High"},
    {"label": "Medium", "value": "Medium"},
    {"label": "Low", "value": "Low"},
  ];

  List<Map<String, dynamic>> tasks = [
    {
      "id": "TSK-001",
      "title": "Implement User Authentication",
      "description": "Develop secure login and registration system with JWT tokens",
      "assignee": "Alex Johnson",
      "priority": "High",
      "status": "In Progress",
      "dueDate": "2024-12-20",
      "completedPercentage": 75,
      "tags": ["Security", "Backend", "API"],
      "avatar": "https://picsum.photos/100/100?random=21&keyword=face",
    },
    {
      "id": "TSK-002",
      "title": "Design Mobile App UI",
      "description": "Create responsive and intuitive user interface for mobile application",
      "assignee": "Sarah Chen",
      "priority": "Medium",
      "status": "To Do",
      "dueDate": "2024-12-25",
      "completedPercentage": 0,
      "tags": ["UI/UX", "Mobile", "Design"],
      "avatar": "https://picsum.photos/100/100?random=22&keyword=face",
    },
    {
      "id": "TSK-003",
      "title": "Database Optimization",
      "description": "Optimize database queries and improve application performance",
      "assignee": "Michael Davis",
      "priority": "High",
      "status": "In Review",
      "dueDate": "2024-12-18",
      "completedPercentage": 90,
      "tags": ["Database", "Performance", "Backend"],
      "avatar": "https://picsum.photos/100/100?random=23&keyword=face",
    },
    {
      "id": "TSK-004",
      "title": "Write API Documentation",
      "description": "Create comprehensive documentation for REST API endpoints",
      "assignee": "Emma Wilson",
      "priority": "Low",
      "status": "Completed",
      "dueDate": "2024-12-15",
      "completedPercentage": 100,
      "tags": ["Documentation", "API"],
      "avatar": "https://picsum.photos/100/100?random=24&keyword=face",
    },
    {
      "id": "TSK-005",
      "title": "Setup CI/CD Pipeline",
      "description": "Configure automated testing and deployment pipeline",
      "assignee": "Robert Martinez",
      "priority": "Medium",
      "status": "In Progress",
      "dueDate": "2024-12-22",
      "completedPercentage": 45,
      "tags": ["DevOps", "Automation", "CI/CD"],
      "avatar": "https://picsum.photos/100/100?random=25&keyword=face",
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    return tasks.where((task) {
      bool matchesSearch = "${task["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${task["assignee"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${task["id"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesPriority = selectedPriority == "All" || task["priority"] == selectedPriority;
      return matchesSearch && matchesPriority;
    }).toList();
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "To Do":
        return disabledBoldColor;
      case "In Progress":
        return infoColor;
      case "In Review":
        return warningColor;
      case "Completed":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Management"),
        actions: [
          Icon(Icons.add_task),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Active Tasks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${tasks.where((t) => t["status"] != "Completed").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      color: successColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: successColor.withAlpha(30)),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                        Text(
                          "${tasks.where((t) => t["status"] == "Completed").length}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search tasks",
                    value: searchQuery,
                    hint: "Search by title, assignee, or ID...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            QDropdownField(
              label: "Priority",
              items: priorityOptions,
              value: selectedPriority,
              onChanged: (value, label) {
                selectedPriority = value;
                setState(() {});
              },
            ),

            Text(
              "Tasks (${filteredTasks.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                final priorityColor = getPriorityColor("${task["priority"]}");
                final statusColor = getStatusColor("${task["status"]}");
                final completedPercentage = task["completedPercentage"] as int;
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  child: Column(
                    spacing: spSm,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage("${task["avatar"]}"),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${task["id"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      spacing: spXs,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: priorityColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${task["priority"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: priorityColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${task["status"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: statusColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "${task["title"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Assigned to: ${task["assignee"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${task["description"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                            height: 1.4,
                          ),
                        ),
                      ),

                      Column(
                        spacing: spXs,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "$completedPercentage%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: completedPercentage == 100 ? successColor : primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(radiusLg),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: completedPercentage / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: completedPercentage == 100 ? successColor : primaryColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Text(
                                "Due Date",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${task["dueDate"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "Tags:",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Wrap(
                                  spacing: spXs,
                                  runSpacing: spXs,
                                  children: (task["tags"] as List).map((tag) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "$tag",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: infoColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
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
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            icon: Icons.edit,
                            size: bs.sm,
                            onPressed: () {},
                          ),
                          SizedBox(width: spXs),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {},
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
    );
  }
}
