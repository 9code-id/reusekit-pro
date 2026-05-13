import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TpmTeamWorkloadView extends StatefulWidget {
  const TpmTeamWorkloadView({super.key});

  @override
  State<TpmTeamWorkloadView> createState() => _TpmTeamWorkloadViewState();
}

class _TpmTeamWorkloadViewState extends State<TpmTeamWorkloadView> {
  int currentTab = 0;
  String selectedTimeframe = "This Week";
  String selectedMember = "";
  String selectedProject = "";
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Quarter", "value": "This Quarter"},
  ];

  List<Map<String, dynamic>> memberOptions = [
    {"label": "All Members", "value": ""},
    {"label": "Sarah Johnson", "value": "Sarah Johnson"},
    {"label": "Michael Chen", "value": "Michael Chen"},
    {"label": "Emma Rodriguez", "value": "Emma Rodriguez"},
    {"label": "David Kim", "value": "David Kim"},
    {"label": "Lisa Thompson", "value": "Lisa Thompson"},
    {"label": "James Wilson", "value": "James Wilson"},
  ];

  List<Map<String, dynamic>> projectOptions = [
    {"label": "All Projects", "value": ""},
    {"label": "Mobile App Redesign", "value": "Mobile App Redesign"},
    {"label": "E-commerce Platform", "value": "E-commerce Platform"},
    {"label": "API Integration", "value": "API Integration"},
    {"label": "Database Migration", "value": "Database Migration"},
  ];

  List<Map<String, dynamic>> teamWorkload = [
    {
      "memberId": "1",
      "memberName": "Sarah Johnson",
      "role": "Senior Developer",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "totalHours": 40,
      "allocatedHours": 32,
      "availableHours": 8,
      "utilization": 80.0,
      "status": "On Track",
      "projects": [
        {
          "projectName": "Mobile App Redesign",
          "allocatedHours": 20,
          "completedHours": 16,
          "progress": 80.0,
          "priority": "High",
          "deadline": "2024-02-15",
        },
        {
          "projectName": "API Integration",
          "allocatedHours": 12,
          "completedHours": 8,
          "progress": 66.7,
          "priority": "Medium",
          "deadline": "2024-02-20",
        }
      ],
      "weeklySchedule": [
        {"day": "Mon", "hours": 8, "tasks": 3},
        {"day": "Tue", "hours": 7, "tasks": 2},
        {"day": "Wed", "hours": 8, "tasks": 4},
        {"day": "Thu", "hours": 6, "tasks": 2},
        {"day": "Fri", "hours": 3, "tasks": 1},
        {"day": "Sat", "hours": 0, "tasks": 0},
        {"day": "Sun", "hours": 0, "tasks": 0},
      ]
    },
    {
      "memberId": "2",
      "memberName": "Michael Chen",
      "role": "UI/UX Designer",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "totalHours": 40,
      "allocatedHours": 38,
      "availableHours": 2,
      "utilization": 95.0,
      "status": "Overloaded",
      "projects": [
        {
          "projectName": "Mobile App Redesign",
          "allocatedHours": 25,
          "completedHours": 20,
          "progress": 80.0,
          "priority": "High",
          "deadline": "2024-02-15",
        },
        {
          "projectName": "E-commerce Platform",
          "allocatedHours": 13,
          "completedHours": 10,
          "progress": 76.9,
          "priority": "Medium",
          "deadline": "2024-02-25",
        }
      ],
      "weeklySchedule": [
        {"day": "Mon", "hours": 8, "tasks": 4},
        {"day": "Tue", "hours": 8, "tasks": 3},
        {"day": "Wed", "hours": 8, "tasks": 5},
        {"day": "Thu", "hours": 8, "tasks": 4},
        {"day": "Fri", "hours": 6, "tasks": 2},
        {"day": "Sat", "hours": 0, "tasks": 0},
        {"day": "Sun", "hours": 0, "tasks": 0},
      ]
    },
    {
      "memberId": "3",
      "memberName": "Emma Rodriguez",
      "role": "Project Manager",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=woman",
      "totalHours": 40,
      "allocatedHours": 28,
      "availableHours": 12,
      "utilization": 70.0,
      "status": "Under Utilized",
      "projects": [
        {
          "projectName": "Mobile App Redesign",
          "allocatedHours": 15,
          "completedHours": 12,
          "progress": 80.0,
          "priority": "High",
          "deadline": "2024-02-15",
        },
        {
          "projectName": "Database Migration",
          "allocatedHours": 13,
          "completedHours": 8,
          "progress": 61.5,
          "priority": "Low",
          "deadline": "2024-03-01",
        }
      ],
      "weeklySchedule": [
        {"day": "Mon", "hours": 6, "tasks": 2},
        {"day": "Tue", "hours": 5, "tasks": 3},
        {"day": "Wed", "hours": 6, "tasks": 2},
        {"day": "Thu", "hours": 6, "tasks": 3},
        {"day": "Fri", "hours": 5, "tasks": 2},
        {"day": "Sat", "hours": 0, "tasks": 0},
        {"day": "Sun", "hours": 0, "tasks": 0},
      ]
    },
    {
      "memberId": "4",
      "memberName": "David Kim",
      "role": "Backend Developer",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=man",
      "totalHours": 40,
      "allocatedHours": 35,
      "availableHours": 5,
      "utilization": 87.5,
      "status": "On Track",
      "projects": [
        {
          "projectName": "API Integration",
          "allocatedHours": 22,
          "completedHours": 18,
          "progress": 81.8,
          "priority": "High",
          "deadline": "2024-02-20",
        },
        {
          "projectName": "Database Migration",
          "allocatedHours": 13,
          "completedHours": 9,
          "progress": 69.2,
          "priority": "Medium",
          "deadline": "2024-03-01",
        }
      ],
      "weeklySchedule": [
        {"day": "Mon", "hours": 7, "tasks": 3},
        {"day": "Tue", "hours": 8, "tasks": 4},
        {"day": "Wed", "hours": 7, "tasks": 3},
        {"day": "Thu", "hours": 8, "tasks": 4},
        {"day": "Fri", "hours": 5, "tasks": 2},
        {"day": "Sat", "hours": 0, "tasks": 0},
        {"day": "Sun", "hours": 0, "tasks": 0},
      ]
    }
  ];

  List<Map<String, dynamic>> get filteredWorkload {
    return teamWorkload.where((member) {
      bool matchesMember = selectedMember.isEmpty || member["memberName"] == selectedMember;
      bool matchesProject = selectedProject.isEmpty || 
          (member["projects"] as List).any((project) => project["projectName"] == selectedProject);
      return matchesMember && matchesProject;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "On Track":
        return successColor;
      case "Overloaded":
        return dangerColor;
      case "Under Utilized":
        return warningColor;
      default:
        return disabledColor;
    }
  }

  Color _getUtilizationColor(double utilization) {
    if (utilization >= 90) return dangerColor;
    if (utilization >= 80) return successColor;
    if (utilization >= 60) return warningColor;
    return infoColor;
  }

  Widget _buildWorkloadOverview() {
    int totalMembers = teamWorkload.length;
    int onTrack = teamWorkload.where((m) => m["status"] == "On Track").length;
    int overloaded = teamWorkload.where((m) => m["status"] == "Overloaded").length;
    int underUtilized = teamWorkload.where((m) => m["status"] == "Under Utilized").length;
    
    double avgUtilization = teamWorkload.fold(0.0, (sum, member) => 
        sum + (member["utilization"] as double)) / totalMembers;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.dashboard,
                color: primaryColor,
                size: 24,
              ),
              SizedBox(width: spSm),
              Text(
                "Workload Overview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Stats Grid
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$totalMembers",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Total Members",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                    color: successColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$onTrack",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "On Track",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                    color: dangerColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$overloaded",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: dangerColor,
                        ),
                      ),
                      Text(
                        "Overloaded",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
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
                    color: warningColor.withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$underUtilized",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Under Utilized",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          
          // Average Utilization
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: _getUtilizationColor(avgUtilization).withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
              border: Border.all(
                color: _getUtilizationColor(avgUtilization).withAlpha(30),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: _getUtilizationColor(avgUtilization),
                  size: 20,
                ),
                SizedBox(width: spSm),
                Text(
                  "Average Team Utilization:",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Text(
                  "${avgUtilization.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: _getUtilizationColor(avgUtilization),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberWorkloadCard(Map<String, dynamic> member) {
    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Member Header
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusLg),
                        image: DecorationImage(
                          image: NetworkImage("${member["avatar"]}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${member["memberName"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(member["status"] as String).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${member["status"]}",
                        style: TextStyle(
                          fontSize: 11,
                          color: _getStatusColor(member["status"] as String),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Utilization Progress
                Row(
                  children: [
                    Text(
                      "Utilization:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(member["utilization"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getUtilizationColor(member["utilization"] as double),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (member["utilization"] as double) / 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _getUtilizationColor(member["utilization"] as double),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spMd),
                
                // Hours Summary
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${member["allocatedHours"]}h",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Allocated",
                              style: TextStyle(
                                fontSize: 10,
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
                          color: successColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${member["availableHours"]}h",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: successColor,
                              ),
                            ),
                            Text(
                              "Available",
                              style: TextStyle(
                                fontSize: 10,
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
                          color: infoColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${member["totalHours"]}h",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: infoColor,
                              ),
                            ),
                            Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                
                // Active Projects
                Text(
                  "Active Projects:",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                ...(member["projects"] as List).map((project) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(5),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: disabledOutlineBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${project["projectName"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: project["priority"] == "High" 
                                    ? dangerColor.withAlpha(20)
                                    : project["priority"] == "Medium"
                                        ? warningColor.withAlpha(20)
                                        : infoColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${project["priority"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: project["priority"] == "High"
                                      ? dangerColor
                                      : project["priority"] == "Medium"
                                          ? warningColor
                                          : infoColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Text(
                              "${project["completedHours"]}h / ${project["allocatedHours"]}h",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(project["progress"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 11,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: (project["progress"] as double) / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(radiusMd),
                bottomRight: Radius.circular(radiusMd),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to member schedule
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Schedule",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: disabledOutlineBorderColor,
                ),
                GestureDetector(
                  onTap: () {
                    // Assign new task
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_task,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Assign Task",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  color: disabledOutlineBorderColor,
                ),
                GestureDetector(
                  onTap: () {
                    // View workload details
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.analytics,
                        size: 16,
                        color: primaryColor,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklySchedule() {
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
            "Weekly Schedule Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          
          ...filteredWorkload.map((member) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiusLg),
                          image: DecorationImage(
                            image: NetworkImage("${member["avatar"]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${member["memberName"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 60,
                    child: Row(
                      children: (member["weeklySchedule"] as List).map((day) {
                        double maxHours = 8.0;
                        double dayHours = (day["hours"] as int).toDouble();
                        double heightRatio = dayHours / maxHours;
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: spXs),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (dayHours > 0)
                                  Text(
                                    "${dayHours.toInt()}h",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                SizedBox(height: spXs),
                                Container(
                                  width: double.infinity,
                                  height: 30 * heightRatio,
                                  decoration: BoxDecoration(
                                    color: dayHours > 7 
                                        ? dangerColor
                                        : dayHours > 5
                                            ? successColor
                                            : dayHours > 0
                                                ? warningColor
                                                : disabledColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${day["day"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Workload"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Timeframe",
                          items: timeframeOptions,
                          value: selectedTimeframe,
                          onChanged: (value, label) {
                            selectedTimeframe = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Member",
                          items: memberOptions,
                          value: selectedMember,
                          onChanged: (value, label) {
                            selectedMember = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  QDropdownField(
                    label: "Project",
                    items: projectOptions,
                    value: selectedProject,
                    onChanged: (value, label) {
                      selectedProject = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Workload Overview
            _buildWorkloadOverview(),
            SizedBox(height: spMd),
            
            // Tab Navigation
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(spXs),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              currentTab = 0;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              decoration: BoxDecoration(
                                color: currentTab == 0 
                                    ? primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Member Workload",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: currentTab == 0 
                                      ? Colors.white
                                      : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              currentTab = 1;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: spSm),
                              decoration: BoxDecoration(
                                color: currentTab == 1 
                                    ? primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "Weekly Schedule",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: currentTab == 1 
                                      ? Colors.white
                                      : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),
            
            // Tab Content
            if (currentTab == 0) ...[
              ...filteredWorkload.map((member) => _buildMemberWorkloadCard(member)).toList(),
            ] else ...[
              _buildWeeklySchedule(),
            ],
          ],
        ),
      ),
    );
  }
}
