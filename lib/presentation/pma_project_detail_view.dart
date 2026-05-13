import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectDetailView extends StatefulWidget {
  const PmaProjectDetailView({super.key});

  @override
  State<PmaProjectDetailView> createState() => _PmaProjectDetailViewState();
}

class _PmaProjectDetailViewState extends State<PmaProjectDetailView> {
  bool loading = false;
  int currentTab = 0;

  Map<String, dynamic> project = {
    "id": "1",
    "name": "Mobile App Redesign",
    "description": "Complete redesign of the mobile application UI/UX with modern design principles and improved user experience. This project includes user research, wireframing, prototyping, and implementation of the new design system.",
    "status": "In Progress",
    "priority": "High",
    "progress": 75,
    "startDate": "2025-05-01",
    "dueDate": "2025-07-15",
    "budget": 50000.0,
    "spent": 37500.0,
    "client": "TechCorp Inc.",
    "manager": "John Doe",
    "team": [
      {"name": "Sarah Johnson", "avatar": "https://picsum.photos/50/50?random=1", "role": "UI/UX Designer", "email": "sarah@company.com"},
      {"name": "Mike Chen", "avatar": "https://picsum.photos/50/50?random=2", "role": "Frontend Developer", "email": "mike@company.com"},
      {"name": "Emily Davis", "avatar": "https://picsum.photos/50/50?random=3", "role": "Project Manager", "email": "emily@company.com"},
      {"name": "Alex Wilson", "avatar": "https://picsum.photos/50/50?random=4", "role": "Backend Developer", "email": "alex@company.com"},
    ],
    "tasks": {"total": 24, "completed": 18, "pending": 6},
    "milestones": [
      {"name": "User Research", "status": "Completed", "date": "2025-05-15"},
      {"name": "Wireframes", "status": "Completed", "date": "2025-05-30"},
      {"name": "UI Design", "status": "In Progress", "date": "2025-06-15"},
      {"name": "Development", "status": "Pending", "date": "2025-07-01"},
      {"name": "Testing", "status": "Pending", "date": "2025-07-10"},
    ],
  };

  List<Map<String, dynamic>> tasks = [
    {
      "id": "1",
      "title": "Create user personas",
      "description": "Develop detailed user personas based on research data",
      "status": "Completed",
      "priority": "High",
      "assignee": "Sarah Johnson",
      "dueDate": "2025-05-10",
      "progress": 100,
    },
    {
      "id": "2",
      "title": "Design login screen",
      "description": "Create modern login screen with improved UX",
      "status": "In Progress",
      "priority": "High",
      "assignee": "Sarah Johnson",
      "dueDate": "2025-06-20",
      "progress": 80,
    },
    {
      "id": "3",
      "title": "Implement authentication API",
      "description": "Backend API for user authentication and authorization",
      "status": "Pending",
      "priority": "Medium",
      "assignee": "Alex Wilson",
      "dueDate": "2025-06-25",
      "progress": 0,
    },
    {
      "id": "4",
      "title": "Set up testing framework",
      "description": "Implement automated testing for the application",
      "status": "Pending",
      "priority": "Medium",
      "assignee": "Mike Chen",
      "dueDate": "2025-07-05",
      "progress": 0,
    },
  ];

  List<Map<String, dynamic>> files = [
    {
      "name": "User Research Report.pdf",
      "size": "2.4 MB",
      "uploadedBy": "Sarah Johnson",
      "uploadedAt": "2025-05-16",
      "type": "document",
    },
    {
      "name": "Wireframes_v2.fig",
      "size": "15.8 MB",
      "uploadedBy": "Sarah Johnson",
      "uploadedAt": "2025-05-30",
      "type": "design",
    },
    {
      "name": "App_Screenshots.zip",
      "size": "8.2 MB",
      "uploadedBy": "Mike Chen",
      "uploadedAt": "2025-06-10",
      "type": "archive",
    },
    {
      "name": "Technical_Spec.docx",
      "size": "1.1 MB",
      "uploadedBy": "Alex Wilson",
      "uploadedAt": "2025-06-12",
      "type": "document",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Pending":
        return infoColor;
      case "On Hold":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
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

  IconData _getFileIcon(String type) {
    switch (type) {
      case "document":
        return Icons.description;
      case "design":
        return Icons.design_services;
      case "archive":
        return Icons.archive;
      default:
        return Icons.insert_drive_file;
    }
  }

  Widget _buildOverviewTab() {
    Color statusColor = _getStatusColor("${project["status"]}");
    Color priorityColor = _getPriorityColor("${project["priority"]}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spLg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withAlpha(180)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${project["name"]}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spMd,
                      vertical: spSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Text(
                      "${project["progress"]}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spSm),
              Text(
                "${project["description"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(230),
                ),
              ),
              SizedBox(height: spLg),
              LinearProgressIndicator(
                value: (project["progress"] as int) / 100,
                backgroundColor: Colors.white.withAlpha(30),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: [
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
                  Row(
                    children: [
                      Icon(
                        Icons.flag,
                        color: priorityColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Priority",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
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
                      "${project["priority"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: priorityColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: statusColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
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
                      "${project["status"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Budget",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "\$${((project["budget"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Spent: \$${((project["spent"] as double).toDouble()).currency}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
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
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Timeline",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Due: ${DateTime.parse(project["dueDate"] as String).dMMMy}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Started: ${DateTime.parse(project["startDate"] as String).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                "Milestones",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              ...(project["milestones"] as List).map((milestone) {
                Color milestoneColor = _getStatusColor("${milestone["status"]}");
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: milestoneColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: milestoneColor.withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: milestoneColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "${milestone["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${DateTime.parse(milestone["date"] as String).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: milestoneColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${milestone["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: milestoneColor,
                            fontWeight: FontWeight.w600,
                          ),
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
    );
  }

  Widget _buildTeamTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Team Members",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  QButton(
                    icon: Icons.person_add,
                    size: bs.sm,
                    onPressed: () {
                      // Add team member
                    },
                  ),
                ],
              ),
              SizedBox(height: spMd),
              ...(project["team"] as List).map((member) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusMd),
                    border: Border.all(
                      color: primaryColor.withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage("${member["avatar"]}"),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${member["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${member["role"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${member["email"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          QButton(
                            icon: Icons.message,
                            size: bs.sm,
                            onPressed: () {
                              // Message member
                            },
                          ),
                          SizedBox(height: spSm),
                          QButton(
                            icon: Icons.more_vert,
                            size: bs.sm,
                            onPressed: () {
                              // More options
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTasksTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Tasks",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.add_task,
                size: bs.sm,
                onPressed: () {
                  // Add new task
                },
              ),
            ],
          ),
        ),
        ...tasks.map((task) {
          Color taskStatusColor = _getStatusColor("${task["status"]}");
          Color taskPriorityColor = _getPriorityColor("${task["priority"]}");

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
                  color: taskStatusColor,
                ),
              ),
            ),
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: taskPriorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${task["priority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: taskPriorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "${task["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
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
                    Spacer(),
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Due: ${DateTime.parse(task["dueDate"] as String).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                if ((task["progress"] as int) > 0) ...[
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (task["progress"] as int) / 100,
                          backgroundColor: disabledColor,
                          valueColor: AlwaysStoppedAnimation<Color>(taskStatusColor),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${task["progress"]}%",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: taskStatusColor,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: spSm),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: taskStatusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${task["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: taskStatusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    QButton(
                      icon: Icons.edit,
                      size: bs.sm,
                      onPressed: () {
                        // Edit task
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildFilesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Project Files",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              QButton(
                icon: Icons.upload_file,
                size: bs.sm,
                onPressed: () {
                  // Upload file
                },
              ),
            ],
          ),
        ),
        ...files.map((file) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    _getFileIcon("${file["type"]}"),
                    color: primaryColor,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${file["name"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Size: ${file["size"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "Uploaded by ${file["uploadedBy"]} on ${DateTime.parse(file["uploadedAt"] as String).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                QButton(
                  icon: Icons.download,
                  size: bs.sm,
                  onPressed: () {
                    // Download file
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Project Details",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.info)),
        Tab(text: "Team", icon: Icon(Icons.group)),
        Tab(text: "Tasks", icon: Icon(Icons.task)),
        Tab(text: "Files", icon: Icon(Icons.folder)),
      ],
      tabChildren: [
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildOverviewTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTeamTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildTasksTab(),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: _buildFilesTab(),
        ),
      ],
      actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            //navigateTo('PmaEditProjectView')
          },
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // More options
          },
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
