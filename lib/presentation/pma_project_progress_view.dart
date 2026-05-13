import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class PmaProjectProgressView extends StatefulWidget {
  const PmaProjectProgressView({super.key});

  @override
  State<PmaProjectProgressView> createState() => _PmaProjectProgressViewState();
}

class _PmaProjectProgressViewState extends State<PmaProjectProgressView> {
  String selectedProject = "E-commerce Platform";
  String selectedTimeframe = "Last 30 Days";
  
  Map<String, dynamic> projectData = {
    "name": "E-commerce Platform",
    "totalProgress": 75,
    "completedTasks": 45,
    "totalTasks": 60,
    "remainingTasks": 15,
    "overdueTasks": 3,
    "milestones": [
      {
        "name": "Project Kickoff",
        "date": "2024-01-15",
        "status": "completed",
        "progress": 100,
      },
      {
        "name": "Requirements Analysis",
        "date": "2024-02-01",
        "status": "completed",
        "progress": 100,
      },
      {
        "name": "System Design",
        "date": "2024-02-15",
        "status": "completed",
        "progress": 100,
      },
      {
        "name": "Development Phase 1",
        "date": "2024-04-01",
        "status": "in_progress",
        "progress": 80,
      },
      {
        "name": "Testing & QA",
        "date": "2024-05-15",
        "status": "pending",
        "progress": 0,
      },
      {
        "name": "Deployment",
        "date": "2024-06-30",
        "status": "pending",
        "progress": 0,
      },
    ],
    "taskCategories": [
      {
        "name": "Backend Development",
        "completed": 18,
        "total": 22,
        "color": Colors.blue,
      },
      {
        "name": "Frontend Development",
        "completed": 15,
        "total": 20,
        "color": Colors.green,
      },
      {
        "name": "UI/UX Design",
        "completed": 8,
        "total": 10,
        "color": Colors.purple,
      },
      {
        "name": "Testing",
        "completed": 4,
        "total": 8,
        "color": Colors.orange,
      },
    ],
    "progressHistory": [
      {"date": "2024-05-01", "progress": 45},
      {"date": "2024-05-08", "progress": 52},
      {"date": "2024-05-15", "progress": 58},
      {"date": "2024-05-22", "progress": 65},
      {"date": "2024-05-29", "progress": 70},
      {"date": "2024-06-05", "progress": 73},
      {"date": "2024-06-12", "progress": 75},
    ],
    "teamPerformance": [
      {
        "member": "John Smith",
        "role": "Backend Developer",
        "completedTasks": 12,
        "pendingTasks": 3,
        "efficiency": 85,
      },
      {
        "member": "Sarah Wilson",
        "role": "Frontend Developer",
        "completedTasks": 10,
        "pendingTasks": 2,
        "efficiency": 92,
      },
      {
        "member": "Mike Chen",
        "role": "UI/UX Designer",
        "completedTasks": 8,
        "pendingTasks": 1,
        "efficiency": 89,
      },
      {
        "member": "Emily Rodriguez",
        "role": "QA Engineer",
        "completedTasks": 6,
        "pendingTasks": 4,
        "efficiency": 78,
      },
    ]
  };

  Widget _buildProgressOverview() {
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${projectData["name"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Overall Progress",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: (projectData["totalProgress"] as int) / 100,
                        strokeWidth: 8,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${projectData["totalProgress"]}%",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              _buildStatCard("Completed", "${projectData["completedTasks"]}", "${projectData["totalTasks"]}", successColor),
              SizedBox(width: spSm),
              _buildStatCard("Remaining", "${projectData["remainingTasks"]}", "${projectData["totalTasks"]}", warningColor),
              SizedBox(width: spSm),
              _buildStatCard("Overdue", "${projectData["overdueTasks"]}", "${projectData["totalTasks"]}", dangerColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String total, Color color) {
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
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: spXs),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              "of $total",
              style: TextStyle(
                fontSize: 10,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestonesProgress() {
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
            "Milestones Progress",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...(projectData["milestones"] as List).map((milestone) => _buildMilestoneItem(milestone)),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem(Map<String, dynamic> milestone) {
    Color statusColor = _getMilestoneStatusColor(milestone["status"]);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
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
                  "${milestone["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: spXs),
              Text(
                "Due: ${DateTime.parse(milestone["date"]).dMMMy}",
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
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (milestone["progress"] as int) / 100,
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
    );
  }

  Widget _buildTaskCategoriesProgress() {
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
            "Task Categories",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...(projectData["taskCategories"] as List).map((category) => _buildCategoryItem(category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    double progress = (category["completed"] as int) / (category["total"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: category["color"] as Color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Text(
                  "${category["name"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
              ),
              Text(
                "${category["completed"]}/${category["total"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: category["color"] as Color,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: disabledColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: category["color"] as Color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
              ),
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${(progress * 100).toStringAsFixed(1)}% Complete",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPerformance() {
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
            "Team Performance",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ...(projectData["teamPerformance"] as List).map((member) => _buildTeamMemberItem(member)),
        ],
      ),
    );
  }

  Widget _buildTeamMemberItem(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: disabledOutlineBorderColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: primaryColor,
            child: Text(
              "${member["member"]}".split(" ").map((n) => n[0]).join(""),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${member["member"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${member["role"]}",
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
                "${member["completedTasks"]} completed",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: successColor,
                ),
              ),
              Text(
                "${member["pendingTasks"]} pending",
                style: TextStyle(
                  fontSize: 12,
                  color: warningColor,
                ),
              ),
              Text(
                "${member["efficiency"]}% efficiency",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getMilestoneStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "in_progress":
        return warningColor;
      case "pending":
        return disabledBoldColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project Progress"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Select Project",
                    items: [
                      {"label": "E-commerce Platform", "value": "E-commerce Platform"},
                      {"label": "Mobile Banking App", "value": "Mobile Banking App"},
                      {"label": "CRM System", "value": "CRM System"},
                      {"label": "Analytics Dashboard", "value": "Analytics Dashboard"},
                    ],
                    value: selectedProject,
                    onChanged: (value, label) {
                      selectedProject = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: [
                      {"label": "Last 7 Days", "value": "Last 7 Days"},
                      {"label": "Last 30 Days", "value": "Last 30 Days"},
                      {"label": "Last 3 Months", "value": "Last 3 Months"},
                      {"label": "All Time", "value": "All Time"},
                    ],
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),
            _buildProgressOverview(),
            SizedBox(height: spLg),
            _buildMilestonesProgress(),
            SizedBox(height: spLg),
            _buildTaskCategoriesProgress(),
            SizedBox(height: spLg),
            _buildTeamPerformance(),
          ],
        ),
      ),
    );
  }
}
