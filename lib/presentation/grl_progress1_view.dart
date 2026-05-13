import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress1View extends StatefulWidget {
  @override
  State<GrlProgress1View> createState() => _GrlProgress1ViewState();
}

class _GrlProgress1ViewState extends State<GrlProgress1View> {
  List<Map<String, dynamic>> progressItems = [
    {
      "id": "1",
      "title": "Website Development",
      "description": "Building a responsive e-commerce website",
      "progress": 75,
      "status": "in_progress",
      "startDate": "2024-01-01",
      "endDate": "2024-02-15",
      "team": [
        {"name": "Alice", "avatar": "https://picsum.photos/30/30?random=1&keyword=person"},
        {"name": "Bob", "avatar": "https://picsum.photos/30/30?random=2&keyword=person"},
        {"name": "Charlie", "avatar": "https://picsum.photos/30/30?random=3&keyword=person"}
      ],
      "tasks": {
        "total": 24,
        "completed": 18,
        "remaining": 6
      },
      "priority": "high"
    },
    {
      "id": "2",
      "title": "Mobile App Design",
      "description": "Creating UI/UX designs for mobile application",
      "progress": 90,
      "status": "near_completion",
      "startDate": "2024-01-10",
      "endDate": "2024-01-30",
      "team": [
        {"name": "Diana", "avatar": "https://picsum.photos/30/30?random=4&keyword=person"},
        {"name": "Eve", "avatar": "https://picsum.photos/30/30?random=5&keyword=person"}
      ],
      "tasks": {
        "total": 15,
        "completed": 14,
        "remaining": 1
      },
      "priority": "medium"
    },
    {
      "id": "3",
      "title": "Database Migration",
      "description": "Migrating legacy database to new system",
      "progress": 45,
      "status": "in_progress",
      "startDate": "2024-01-15",
      "endDate": "2024-03-01",
      "team": [
        {"name": "Frank", "avatar": "https://picsum.photos/30/30?random=6&keyword=person"}
      ],
      "tasks": {
        "total": 32,
        "completed": 14,
        "remaining": 18
      },
      "priority": "high"
    },
    {
      "id": "4",
      "title": "Marketing Campaign",
      "description": "Digital marketing campaign for product launch",
      "progress": 100,
      "status": "completed",
      "startDate": "2023-12-01",
      "endDate": "2024-01-15",
      "team": [
        {"name": "Grace", "avatar": "https://picsum.photos/30/30?random=7&keyword=person"},
        {"name": "Henry", "avatar": "https://picsum.photos/30/30?random=8&keyword=person"},
        {"name": "Ivy", "avatar": "https://picsum.photos/30/30?random=9&keyword=person"}
      ],
      "tasks": {
        "total": 20,
        "completed": 20,
        "remaining": 0
      },
      "priority": "medium"
    },
    {
      "id": "5",
      "title": "Quality Assurance Testing",
      "description": "Comprehensive testing of all system components",
      "progress": 25,
      "status": "in_progress",
      "startDate": "2024-01-20",
      "endDate": "2024-02-28",
      "team": [
        {"name": "Jack", "avatar": "https://picsum.photos/30/30?random=10&keyword=person"},
        {"name": "Kate", "avatar": "https://picsum.photos/30/30?random=11&keyword=person"}
      ],
      "tasks": {
        "total": 40,
        "completed": 10,
        "remaining": 30
      },
      "priority": "high"
    },
    {
      "id": "6",
      "title": "Documentation Update",
      "description": "Updating technical documentation and user guides",
      "progress": 60,
      "status": "in_progress",
      "startDate": "2024-01-05",
      "endDate": "2024-02-05",
      "team": [
        {"name": "Liam", "avatar": "https://picsum.photos/30/30?random=12&keyword=person"}
      ],
      "tasks": {
        "total": 12,
        "completed": 7,
        "remaining": 5
      },
      "priority": "low"
    }
  ];

  String selectedFilter = "all";
  List<String> filterOptions = ["all", "in_progress", "near_completion", "completed"];

  List<Map<String, dynamic>> get filteredItems {
    if (selectedFilter == "all") {
      return progressItems;
    }
    return progressItems.where((item) => item["status"] == selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "near_completion":
        return warningColor;
      case "in_progress":
        return infoColor;
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
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case "completed":
        return "Completed";
      case "near_completion":
        return "Near Completion";
      case "in_progress":
        return "In Progress";
      default:
        return "Unknown";
    }
  }

  String _formatDate(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Project Dashboard",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Monitor project progress and milestones",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Overall Progress",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(height: spXs),
                              LinearProgressIndicator(
                                value: 0.65,
                                backgroundColor: Colors.white.withAlpha(60),
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: spMd),
                      Text(
                        "65%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Progress Statistics
            Row(
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
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: warningColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "4",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          color: infoColor,
                          size: 32,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "1",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Near Done",
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

            SizedBox(height: spLg),

            // Filter Section
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter Projects",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: filterOptions.map((filter) {
                        bool isSelected = selectedFilter == filter;
                        return Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedFilter = filter;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                filter == "all" ? "All Projects" : _getStatusText(filter),
                                style: TextStyle(
                                  color: isSelected ? Colors.white : disabledBoldColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Progress List
            Text(
              "Project Progress (${filteredItems.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spMd),

            ...filteredItems.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: _getStatusColor("${item["status"]}").withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Header
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${item["description"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getStatusColor("${item["status"]}").withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                _getStatusText("${item["status"]}"),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor("${item["status"]}"),
                                ),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getPriorityColor("${item["priority"]}").withAlpha(30),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${item["priority"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: _getPriorityColor("${item["priority"]}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Progress Bar
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Progress",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${item["progress"]}%",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _getStatusColor("${item["status"]}"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: (item["progress"] as int) / 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        _getStatusColor("${item["status"]}"),
                                        _getStatusColor("${item["status"]}").withAlpha(180),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spMd),

                    // Project Details
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Start Date",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      _formatDate("${item["startDate"]}"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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
                                      "End Date",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      _formatDate("${item["endDate"]}"),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
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
                                    Text(
                                      "Tasks",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(item["tasks"] as Map)["completed"]}/${(item["tasks"] as Map)["total"]} completed",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
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
                                      "Remaining",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(item["tasks"] as Map)["remaining"]} tasks",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: warningColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: spMd),

                    // Team Members
                    Row(
                      children: [
                        Text(
                          "Team:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        ...(item["team"] as List).take(4).map((member) {
                          return Container(
                            margin: EdgeInsets.only(right: spXs),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage("${member["avatar"]}"),
                            ),
                          );
                        }).toList(),
                        if ((item["team"] as List).length > 4)
                          Container(
                            margin: EdgeInsets.only(right: spXs),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.grey.shade300,
                              child: Text(
                                "+${(item["team"] as List).length - 4}",
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        Spacer(),
                        QButton(
                          label: "View Details",
                          size: bs.sm,
                          onPressed: () {},
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
    );
  }
}
