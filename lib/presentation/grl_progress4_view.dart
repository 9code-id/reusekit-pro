import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlProgress4View extends StatefulWidget {
  @override
  State<GrlProgress4View> createState() => _GrlProgress4ViewState();
}

class _GrlProgress4ViewState extends State<GrlProgress4View> {
  String selectedPeriod = "This Week";
  int selectedProjectIndex = 0;

  List<Map<String, dynamic>> periods = [
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
    {"label": "This Quarter", "value": "quarter"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> projects = [
    {
      "id": 1,
      "name": "Mobile App Development",
      "progress": 75,
      "totalTasks": 24,
      "completedTasks": 18,
      "status": "On Track",
      "team": ["John", "Sarah", "Mike"],
      "deadline": "2024-02-15",
      "milestones": [
        {"name": "Design Phase", "completed": true, "date": "2024-01-05"},
        {"name": "Development", "completed": false, "date": "2024-02-10"},
        {"name": "Testing", "completed": false, "date": "2024-02-15"},
      ]
    },
    {
      "id": 2,
      "name": "Website Redesign",
      "progress": 45,
      "totalTasks": 16,
      "completedTasks": 7,
      "status": "Behind",
      "team": ["Alice", "Bob"],
      "deadline": "2024-02-20",
      "milestones": [
        {"name": "Research", "completed": true, "date": "2024-01-02"},
        {"name": "Wireframes", "completed": false, "date": "2024-02-08"},
        {"name": "Development", "completed": false, "date": "2024-02-20"},
      ]
    },
    {
      "id": 3,
      "name": "API Integration",
      "progress": 90,
      "totalTasks": 12,
      "completedTasks": 11,
      "status": "Ahead",
      "team": ["David", "Emma"],
      "deadline": "2024-02-25",
      "milestones": [
        {"name": "Planning", "completed": true, "date": "2024-01-08"},
        {"name": "Development", "completed": true, "date": "2024-02-18"},
        {"name": "Testing", "completed": false, "date": "2024-02-25"},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedProject = projects[selectedProjectIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Project Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Period Filter
            QDropdownField(
              label: "Time Period",
              items: periods,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            // Project Selection Tabs
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  final isSelected = index == selectedProjectIndex;
                  
                  return Container(
                    margin: EdgeInsets.only(right: spSm),
                    child: GestureDetector(
                      onTap: () {
                        selectedProjectIndex = index;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                        decoration: BoxDecoration(
                          color: isSelected ? primaryColor : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: isSelected ? primaryColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Text(
                          "${project["name"]}",
                          style: TextStyle(
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Progress Overview Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${selectedProject["name"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getStatusColor(selectedProject["status"]),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${selectedProject["status"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Progress Circle
                  Container(
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(
                            value: (selectedProject["progress"] as num) / 100,
                            strokeWidth: 8,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _getStatusColor(selectedProject["status"]),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${selectedProject["progress"]}%",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Complete",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          "Completed", 
                          "${selectedProject["completedTasks"]}", 
                          "${selectedProject["totalTasks"]} Total",
                          successColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Team Size", 
                          "${(selectedProject["team"] as List).length}", 
                          "Members",
                          infoColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildStatCard(
                          "Deadline", 
                          "${DateTime.parse(selectedProject["deadline"]).day}", 
                          "Feb 2024",
                          warningColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Milestones
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Project Milestones",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  Column(
                    spacing: spSm,
                    children: List.generate(
                      (selectedProject["milestones"] as List).length,
                      (index) {
                        final milestone = (selectedProject["milestones"] as List)[index];
                        return _buildMilestoneItem(milestone, index);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Team Members
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Team Members",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  
                  QHorizontalScroll(
                    children: List.generate(
                      (selectedProject["team"] as List).length,
                      (index) {
                        final member = (selectedProject["team"] as List)[index];
                        return Container(
                          width: 80,
                          child: Column(
                            spacing: spXs,
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: primaryColor,
                                child: Text(
                                  "${member}".substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                "${member}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "Update Progress",
                    icon: Icons.update,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "View Details",
                    icon: Icons.visibility,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(Map<String, dynamic> milestone, int index) {
    final isCompleted = milestone["completed"] as bool;
    
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: isCompleted ? successColor : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.circle,
            size: 16,
            color: isCompleted ? Colors.white : disabledBoldColor,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${milestone["name"]}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isCompleted ? disabledBoldColor : primaryColor,
                ),
              ),
              Text(
                "Due: ${DateTime.parse(milestone["date"]).day}/${DateTime.parse(milestone["date"]).month}/${DateTime.parse(milestone["date"]).year}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        if (isCompleted)
          Icon(
            Icons.check_circle,
            color: successColor,
            size: 20,
          ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "On Track":
        return successColor;
      case "Behind":
        return dangerColor;
      case "Ahead":
        return infoColor;
      default:
        return warningColor;
    }
  }
}
