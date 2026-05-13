import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaTaskView extends StatefulWidget {
  const PmaTaskView({super.key});

  @override
  State<PmaTaskView> createState() => _PmaTaskViewState();
}

class _PmaTaskViewState extends State<PmaTaskView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedPriority = "";
  String selectedProject = "";
  
  List<Map<String, dynamic>> tasks = [
    {
      "id": 1,
      "title": "Implement User Authentication",
      "description": "Develop secure user authentication system with JWT tokens and password encryption",
      "project": "E-commerce Platform",
      "assignee": "John Smith",
      "priority": "High",
      "status": "In Progress",
      "dueDate": "2024-06-20",
      "createdDate": "2024-06-01",
      "progress": 75,
      "estimatedHours": 40,
      "actualHours": 30,
      "category": "Backend",
      "tags": ["authentication", "security", "jwt"],
      "subtasks": [
        {"title": "Setup JWT library", "completed": true},
        {"title": "Create login endpoint", "completed": true},
        {"title": "Implement password hashing", "completed": true},
        {"title": "Add refresh token logic", "completed": false},
        {"title": "Write unit tests", "completed": false},
      ],
      "attachments": 3,
      "comments": 8,
    },
    {
      "id": 2,
      "title": "Design Product Catalog UI",
      "description": "Create responsive product catalog interface with filtering and search capabilities",
      "project": "E-commerce Platform",
      "assignee": "Sarah Wilson",
      "priority": "Medium",
      "status": "To Do",
      "dueDate": "2024-06-25",
      "createdDate": "2024-06-05",
      "progress": 0,
      "estimatedHours": 32,
      "actualHours": 0,
      "category": "Frontend",
      "tags": ["ui", "design", "catalog"],
      "subtasks": [
        {"title": "Create wireframes", "completed": false},
        {"title": "Design product cards", "completed": false},
        {"title": "Implement grid layout", "completed": false},
        {"title": "Add search functionality", "completed": false},
      ],
      "attachments": 1,
      "comments": 2,
    },
    {
      "id": 3,
      "title": "Database Schema Review",
      "description": "Review and optimize database schema for performance improvements",
      "project": "Mobile Banking App",
      "assignee": "Michael Chen",
      "priority": "High",
      "status": "Review",
      "dueDate": "2024-06-18",
      "createdDate": "2024-06-08",
      "progress": 90,
      "estimatedHours": 16,
      "actualHours": 14,
      "category": "Database",
      "tags": ["database", "optimization", "schema"],
      "subtasks": [
        {"title": "Analyze current schema", "completed": true},
        {"title": "Identify bottlenecks", "completed": true},
        {"title": "Create optimization plan", "completed": true},
        {"title": "Get stakeholder approval", "completed": false},
      ],
      "attachments": 5,
      "comments": 12,
    },
    {
      "id": 4,
      "title": "Security Testing",
      "description": "Perform comprehensive security testing on the banking module",
      "project": "Mobile Banking App",
      "assignee": "Emily Rodriguez",
      "priority": "Critical",
      "status": "Overdue",
      "dueDate": "2024-06-15",
      "createdDate": "2024-06-01",
      "progress": 60,
      "estimatedHours": 48,
      "actualHours": 35,
      "category": "Testing",
      "tags": ["security", "testing", "penetration"],
      "subtasks": [
        {"title": "Setup testing environment", "completed": true},
        {"title": "Run automated scans", "completed": true},
        {"title": "Manual penetration testing", "completed": false},
        {"title": "Document findings", "completed": false},
        {"title": "Create remediation plan", "completed": false},
      ],
      "attachments": 8,
      "comments": 15,
    },
    {
      "id": 5,
      "title": "API Documentation",
      "description": "Complete API documentation for all endpoints",
      "project": "CRM System",
      "assignee": "David Thompson",
      "priority": "Low",
      "status": "Done",
      "dueDate": "2024-06-10",
      "createdDate": "2024-05-20",
      "progress": 100,
      "estimatedHours": 24,
      "actualHours": 22,
      "category": "Documentation",
      "tags": ["api", "documentation", "endpoints"],
      "subtasks": [
        {"title": "Document user endpoints", "completed": true},
        {"title": "Document admin endpoints", "completed": true},
        {"title": "Add code examples", "completed": true},
        {"title": "Review and publish", "completed": true},
      ],
      "attachments": 2,
      "comments": 6,
    }
  ];

  List<Map<String, dynamic>> get allTasks => tasks;
  List<Map<String, dynamic>> get myTasks => tasks.where((task) => task["assignee"] == "John Smith").toList();
  List<Map<String, dynamic>> get overdueTasks => tasks.where((task) => task["status"] == "Overdue").toList();

  List<Map<String, dynamic>> get currentTasks {
    List<Map<String, dynamic>> baseTasks;
    switch (currentTab) {
      case 0:
        baseTasks = allTasks;
        break;
      case 1:
        baseTasks = myTasks;
        break;
      case 2:
        baseTasks = overdueTasks;
        break;
      default:
        baseTasks = allTasks;
    }

    return baseTasks.where((task) {
      bool matchesSearch = searchQuery.isEmpty ||
          "${task["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
          "${task["description"]}".toLowerCase().contains(searchQuery.toLowerCase());
      
      bool matchesPriority = selectedPriority.isEmpty ||
          task["priority"] == selectedPriority;
      
      bool matchesProject = selectedProject.isEmpty ||
          task["project"] == selectedProject;
      
      return matchesSearch && matchesPriority && matchesProject;
    }).toList();
  }

  Widget _buildTaskStats() {
    int totalTasks = allTasks.length;
    int completedTasks = allTasks.where((task) => task["status"] == "Done").length;
    int inProgressTasks = allTasks.where((task) => task["status"] == "In Progress").length;
    int overdueTasks = allTasks.where((task) => task["status"] == "Overdue").length;

    return Container(
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
            "Task Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildStatCard("Total", "$totalTasks", Icons.assignment, primaryColor),
              SizedBox(width: spSm),
              _buildStatCard("Completed", "$completedTasks", Icons.check_circle, successColor),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              _buildStatCard("In Progress", "$inProgressTasks", Icons.play_circle, warningColor),
              SizedBox(width: spSm),
              _buildStatCard("Overdue", "$overdueTasks", Icons.warning, dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
              textAlign: TextAlign.center,
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

  Widget _buildTaskCard(Map<String, dynamic> task) {
    Color statusColor = _getStatusColor(task["status"]);
    Color priorityColor = _getPriorityColor(task["priority"]);
    bool isOverdue = DateTime.parse(task["dueDate"]).isBefore(DateTime.now()) && task["status"] != "Done";

    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: isOverdue ? dangerColor : statusColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${task["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${task["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${task["status"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${task["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          if (task["progress"] > 0) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Progress",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (task["progress"] as int) / 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: spMd),
                Text(
                  "${task["progress"]}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),
          ],
          Row(
            children: [
              Icon(
                Icons.business,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["project"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: spMd),
              Icon(
                Icons.person,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["assignee"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: isOverdue ? dangerColor : disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Due: ${DateTime.parse(task["dueDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 12,
                  color: isOverdue ? dangerColor : disabledBoldColor,
                  fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
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
                "${task["actualHours"]}h / ${task["estimatedHours"]}h",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              if ((task["attachments"] as int) > 0) ...[
                Icon(
                  Icons.attach_file,
                  size: 16,
                  color: disabledBoldColor,
                ),
                SizedBox(width: spXs),
                Text(
                  "${task["attachments"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(width: spMd),
              ],
              Icon(
                Icons.comment,
                size: 16,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "${task["comments"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if ((task["tags"] as List).isNotEmpty) ...[
            SizedBox(height: spMd),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (task["tags"] as List).map((tag) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: spXs,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "#$tag",
                  style: TextStyle(
                    fontSize: 10,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "View Details",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo('PmaTaskDetailView')
                  },
                ),
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.edit,
                size: bs.sm,
                onPressed: () {
                  //navigateTo('PmaEditTaskView')
                },
              ),
              SizedBox(width: spSm),
              QButton(
                icon: Icons.more_vert,
                size: bs.sm,
                onPressed: () {
                  //showTaskOptions
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "To Do":
        return disabledBoldColor;
      case "In Progress":
        return warningColor;
      case "Review":
        return infoColor;
      case "Done":
        return successColor;
      case "Overdue":
        return dangerColor;
      default:
        return disabledBoldColor;
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
    return QTabBar(
      title: "Tasks",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "All Tasks", icon: Icon(Icons.list)),
        Tab(text: "My Tasks", icon: Icon(Icons.person)),
        Tab(text: "Overdue", icon: Icon(Icons.warning)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              _buildTaskStats(),
              SizedBox(height: spLg),
              _buildFiltersAndSearch(),
              SizedBox(height: spLg),
              _buildTasksList(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              _buildFiltersAndSearch(),
              SizedBox(height: spLg),
              _buildTasksList(),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            children: [
              _buildFiltersAndSearch(),
              SizedBox(height: spLg),
              _buildTasksList(),
            ],
          ),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }

  Widget _buildFiltersAndSearch() {
    return Column(
      children: [
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
                label: "Priority",
                items: [
                  {"label": "All Priorities", "value": ""},
                  {"label": "Critical", "value": "Critical"},
                  {"label": "High", "value": "High"},
                  {"label": "Medium", "value": "Medium"},
                  {"label": "Low", "value": "Low"},
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
                label: "Project",
                items: [
                  {"label": "All Projects", "value": ""},
                  {"label": "E-commerce Platform", "value": "E-commerce Platform"},
                  {"label": "Mobile Banking App", "value": "Mobile Banking App"},
                  {"label": "CRM System", "value": "CRM System"},
                ],
                value: selectedProject,
                onChanged: (value, label) {
                  selectedProject = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTasksList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Tasks (${currentTasks.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              icon: Icons.add,
              size: bs.sm,
              onPressed: () {
                //navigateTo('PmaCreateTaskView')
              },
            ),
          ],
        ),
        SizedBox(height: spMd),
        ...currentTasks.map((task) => _buildTaskCard(task)),
      ],
    );
  }
}
