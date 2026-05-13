import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTimeline2View extends StatefulWidget {
  @override
  State<GrlTimeline2View> createState() => _GrlTimeline2ViewState();
}

class _GrlTimeline2ViewState extends State<GrlTimeline2View> {
  String selectedYear = "2024";
  String selectedUser = "All Users";

  List<Map<String, dynamic>> userActivities = [
    {
      "userId": "U001",
      "userName": "John Doe",
      "userRole": "Project Manager",
      "userAvatar": "https://placehold.co/80x80?text=JD",
      "activities": [
        {
          "id": "A001",
          "action": "Created project",
          "description": "Initiated new mobile app development project with initial requirements gathering",
          "timestamp": "2024-12-20 08:30:00",
          "type": "Creation",
          "target": "Mobile App Project",
          "status": "Completed",
          "icon": Icons.add_circle,
          "color": successColor,
        },
        {
          "id": "A002",
          "action": "Updated timeline",
          "description": "Revised project milestones and delivery dates based on client feedback",
          "timestamp": "2024-12-21 14:20:00",
          "type": "Update",
          "target": "Project Timeline",
          "status": "Completed",
          "icon": Icons.edit,
          "color": infoColor,
        },
        {
          "id": "A003",
          "action": "Assigned tasks",
          "description": "Distributed development tasks to team members for sprint 1",
          "timestamp": "2024-12-22 10:15:00",
          "type": "Assignment",
          "target": "Development Team",
          "status": "Completed",
          "icon": Icons.assignment,
          "color": primaryColor,
        }
      ]
    },
    {
      "userId": "U002",
      "userName": "Sarah Wilson",
      "userRole": "UI/UX Designer",
      "userAvatar": "https://placehold.co/80x80?text=SW",
      "activities": [
        {
          "id": "A004",
          "action": "Uploaded designs",
          "description": "Submitted initial wireframes and design mockups for mobile app interface",
          "timestamp": "2024-12-21 16:45:00",
          "type": "Upload",
          "target": "Design Assets",
          "status": "Completed",
          "icon": Icons.upload,
          "color": successColor,
        },
        {
          "id": "A005",
          "action": "Started user research",
          "description": "Began conducting user interviews and usability testing sessions",
          "timestamp": "2024-12-22 09:00:00",
          "type": "Research",
          "target": "User Experience",
          "status": "In Progress",
          "icon": Icons.psychology,
          "color": warningColor,
        }
      ]
    },
    {
      "userId": "U003",
      "userName": "Mike Johnson",
      "userRole": "Lead Developer",
      "userAvatar": "https://placehold.co/80x80?text=MJ",
      "activities": [
        {
          "id": "A006",
          "action": "Code review completed",
          "description": "Reviewed and approved pull requests from junior developers",
          "timestamp": "2024-12-22 11:30:00",
          "type": "Review",
          "target": "Code Quality",
          "status": "Completed",
          "icon": Icons.code,
          "color": infoColor,
        },
        {
          "id": "A007",
          "action": "Deployed to staging",
          "description": "Successfully deployed latest build to staging environment for testing",
          "timestamp": "2024-12-23 15:20:00",
          "type": "Deployment",
          "target": "Staging Server",
          "status": "Completed",
          "icon": Icons.cloud_upload,
          "color": successColor,
        }
      ]
    },
    {
      "userId": "U004",
      "userName": "Lisa Chen",
      "userRole": "QA Engineer",
      "userAvatar": "https://placehold.co/80x80?text=LC",
      "activities": [
        {
          "id": "A008",
          "action": "Bug report filed",
          "description": "Identified and documented critical bugs in user authentication flow",
          "timestamp": "2024-12-23 10:45:00",
          "type": "Bug Report",
          "target": "Authentication Module",
          "status": "Open",
          "icon": Icons.bug_report,
          "color": dangerColor,
        },
        {
          "id": "A009",
          "action": "Test cases updated",
          "description": "Created comprehensive test scenarios for new feature implementation",
          "timestamp": "2024-12-23 13:15:00",
          "type": "Testing",
          "target": "Feature Testing",
          "status": "Completed",
          "icon": Icons.checklist,
          "color": successColor,
        }
      ]
    }
  ];

  List<Map<String, dynamic>> yearOptions = [
    {"label": "2024", "value": "2024"},
    {"label": "2023", "value": "2023"},
    {"label": "2022", "value": "2022"},
  ];

  @override
  Widget build(BuildContext context) {
    List<String> userOptions = ["All Users"];
    userOptions.addAll(userActivities.map((user) => user["userName"] as String).toList());

    return Scaffold(
      appBar: AppBar(
        title: Text("User Activity Timeline"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterModal(),
          ),
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () => _exportTimeline(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildActivityHeader(),
            _buildFilters(),
            _buildActivityStats(),
            _buildUserActivityList(),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusLg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Activity Timeline",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Track team member activities and contributions",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${_getTotalActivities()} activities recorded",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(180),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Icon(
              Icons.people_alt,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    List<Map<String, dynamic>> userFilterOptions = [
      {"label": "All Users", "value": "All Users"},
      ...userActivities.map((user) => 
        {"label": user["userName"], "value": user["userName"]}).toList(),
    ];

    return Row(
      children: [
        Expanded(
          child: QDropdownField(
            label: "Year",
            items: yearOptions,
            value: selectedYear,
            onChanged: (value, label) {
              selectedYear = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QDropdownField(
            label: "User",
            items: userFilterOptions,
            value: selectedUser,
            onChanged: (value, label) {
              selectedUser = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityStats() {
    List<Map<String, dynamic>> filteredUsers = _getFilteredUsers();
    int totalActivities = _getTotalActivities();
    int activeUsers = filteredUsers.length;
    int completedActivities = _getCompletedActivities();

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.sports,
                  color: primaryColor,
                  size: 24,
                ),
                Text(
                  "$totalActivities",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Activities",
                  textAlign: TextAlign.center,
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.people,
                  color: infoColor,
                  size: 24,
                ),
                Text(
                  "$activeUsers",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Active Users",
                  textAlign: TextAlign.center,
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
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Column(
              spacing: spSm,
              children: [
                Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 24,
                ),
                Text(
                  "$completedActivities",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Completed",
                  textAlign: TextAlign.center,
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
    );
  }

  Widget _buildUserActivityList() {
    List<Map<String, dynamic>> filteredUsers = _getFilteredUsers();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spMd,
      children: [
        Text(
          "User Activities",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        if (filteredUsers.isEmpty)
          Container(
            padding: EdgeInsets.all(spXl),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.person_search,
                    size: 48,
                    color: disabledBoldColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "No user activities found",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Try adjusting your filters",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...filteredUsers.map((user) => _buildUserActivityCard(user)).toList(),
      ],
    );
  }

  Widget _buildUserActivityCard(Map<String, dynamic> user) {
    List<Map<String, dynamic>> activities = user["activities"] as List<Map<String, dynamic>>;
    
    // Sort activities by timestamp (newest first)
    activities.sort((a, b) => 
      DateTime.parse(b["timestamp"] as String).compareTo(DateTime.parse(a["timestamp"] as String)));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // User header
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(30),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radiusLg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("${user["userAvatar"]}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user["userName"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${user["userRole"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spSm,
                    vertical: spXs,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Text(
                    "${activities.length} activities",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Activities timeline
          Container(
            padding: EdgeInsets.all(spMd),
            child: Column(
              children: activities.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> activity = entry.value;
                bool isLast = index == activities.length - 1;
                
                return _buildActivityItem(activity, isLast);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity, bool isLast) {
    DateTime activityDate = DateTime.parse(activity["timestamp"] as String);
    String formattedDate = activityDate.dMMMy;
    String formattedTime = "${activityDate.hour.toString().padLeft(2, '0')}:${activityDate.minute.toString().padLeft(2, '0')}";

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline connector
          Container(
            width: 40,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: (activity["color"] as Color).withAlpha(30),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: activity["color"] as Color,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    activity["icon"] as IconData,
                    color: activity["color"] as Color,
                    size: 16,
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 50,
                    color: disabledColor,
                  ),
              ],
            ),
          ),
          // Activity content
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: spSm,
                bottom: isLast ? 0 : spMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spXs,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${activity["action"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(activity["status"] as String).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${activity["status"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: _getStatusColor(activity["status"] as String),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${activity["description"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "$formattedDate at $formattedTime",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: (activity["color"] as Color).withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${activity["type"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: activity["color"] as Color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        size: 12,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${activity["target"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredUsers() {
    if (selectedUser == "All Users") {
      return userActivities;
    } else {
      return userActivities.where((user) => user["userName"] == selectedUser).toList();
    }
  }

  int _getTotalActivities() {
    return userActivities.fold(0, (sum, user) => sum + (user["activities"] as List).length);
  }

  int _getCompletedActivities() {
    int completed = 0;
    for (var user in userActivities) {
      for (var activity in user["activities"] as List) {
        if (activity["status"] == "Completed") completed++;
      }
    }
    return completed;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return successColor;
      case "In Progress":
        return warningColor;
      case "Open":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _showFilterModal() {
    // Show advanced filter modal
    //navigateTo('')
  }

  void _exportTimeline() {
    // Export timeline data
    ss("Timeline exported successfully!");
  }
}
