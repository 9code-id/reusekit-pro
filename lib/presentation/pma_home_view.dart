import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaHomeView extends StatefulWidget {
  const PmaHomeView({super.key});

  @override
  State<PmaHomeView> createState() => _PmaHomeViewState();
}

class _PmaHomeViewState extends State<PmaHomeView> {
  bool loading = false;
  String searchQuery = "";
  int selectedFilter = 0;

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "New Project",
      "icon": Icons.add_circle,
      "color": primaryColor,
      "route": "create_project",
    },
    {
      "title": "My Tasks",
      "icon": Icons.task_alt,
      "color": successColor,
      "route": "tasks",
    },
    {
      "title": "Team Chat",
      "icon": Icons.chat,
      "color": infoColor,
      "route": "chat",
    },
    {
      "title": "Calendar",
      "icon": Icons.calendar_today,
      "color": warningColor,
      "route": "calendar",
    },
  ];

  List<Map<String, dynamic>> recentProjects = [
    {
      "id": "1",
      "name": "Mobile App Redesign",
      "description": "Complete redesign of the mobile application UI/UX",
      "progress": 75,
      "status": "In Progress",
      "dueDate": "2025-07-15",
      "team": [
        "https://picsum.photos/40/40?random=1",
        "https://picsum.photos/40/40?random=2",
        "https://picsum.photos/40/40?random=3",
      ],
      "priority": "High",
    },
    {
      "id": "2",
      "name": "Website Migration",
      "description": "Migrate existing website to new hosting platform",
      "progress": 45,
      "status": "In Progress",
      "dueDate": "2025-06-30",
      "team": [
        "https://picsum.photos/40/40?random=4",
        "https://picsum.photos/40/40?random=5",
      ],
      "priority": "Medium",
    },
    {
      "id": "3",
      "name": "Marketing Campaign",
      "description": "Q3 digital marketing campaign planning and execution",
      "progress": 90,
      "status": "Review",
      "dueDate": "2025-06-25",
      "team": [
        "https://picsum.photos/40/40?random=6",
        "https://picsum.photos/40/40?random=7",
        "https://picsum.photos/40/40?random=8",
        "https://picsum.photos/40/40?random=9",
      ],
      "priority": "High",
    },
  ];

  List<Map<String, dynamic>> upcomingTasks = [
    {
      "title": "Design Review Meeting",
      "project": "Mobile App Redesign",
      "time": "10:00 AM",
      "priority": "High",
    },
    {
      "title": "Code Review",
      "project": "Website Migration",
      "time": "2:00 PM",
      "priority": "Medium",
    },
    {
      "title": "Client Presentation",
      "project": "Marketing Campaign",
      "time": "4:30 PM",
      "priority": "High",
    },
  ];

  Widget _buildHeader() {
    return Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning, John!",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "You have 5 tasks due today",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("https://picsum.photos/100/100?random=1"),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "12",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Active Projects",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
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
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "23",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Tasks This Week",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
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
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "8",
                        style: TextStyle(
                          fontSize: fsH3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Team Members",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
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
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: quickActions.map((action) {
            return Container(
              width: 120,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: (action["color"] as Color).withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      action["icon"] as IconData,
                      color: action["color"] as Color,
                      size: 24,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${action["title"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecentProjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Recent Projects",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //navigateTo('PmaProjectListView')
              },
              child: Text(
                "View All",
                style: TextStyle(
                  fontSize: 14,
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ...recentProjects.map((project) {
          Color statusColor = primaryColor;
          if ("${project["status"]}" == "Completed") statusColor = successColor;
          if ("${project["status"]}" == "On Hold") statusColor = warningColor;
          if ("${project["status"]}" == "Review") statusColor = infoColor;

          Color priorityColor = primaryColor;
          if ("${project["priority"]}" == "High") priorityColor = dangerColor;
          if ("${project["priority"]}" == "Medium") priorityColor = warningColor;
          if ("${project["priority"]}" == "Low") priorityColor = successColor;

          return Container(
            margin: EdgeInsets.only(bottom: spSm),
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
                        "${project["name"]}",
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
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: priorityColor.withAlpha(50),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "${project["priority"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${project["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Due: ${DateTime.parse(project["dueDate"] as String).dMMMy}",
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
                        color: statusColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${project["status"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Progress: ${project["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${project["progress"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          LinearProgressIndicator(
                            value: (project["progress"] as int) / 100,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: spMd),
                    Row(
                      children: [
                        ...(project["team"] as List).take(3).map((avatar) {
                          return Container(
                            margin: EdgeInsets.only(right: spXs),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage("$avatar"),
                            ),
                          );
                        }).toList(),
                        if ((project["team"] as List).length > 3)
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "+${(project["team"] as List).length - 3}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
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

  Widget _buildUpcomingTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Tasks",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ...upcomingTasks.map((task) {
          Color priorityColor = primaryColor;
          if ("${task["priority"]}" == "High") priorityColor = dangerColor;
          if ("${task["priority"]}" == "Medium") priorityColor = warningColor;
          if ("${task["priority"]}" == "Low") priorityColor = successColor;

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
                  width: 4,
                  height: 50,
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${task["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${task["project"]}",
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
                      "${task["time"]}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              //navigateTo('NotificationsView')
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //navigateTo('SettingsView')
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  _buildHeader(),
                  _buildQuickActions(),
                  _buildRecentProjects(),
                  _buildUpcomingTasks(),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo('PmaCreateProjectView')
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
