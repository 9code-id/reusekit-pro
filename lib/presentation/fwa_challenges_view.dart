import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaChallengesView extends StatefulWidget {
  const FwaChallengesView({super.key});

  @override
  State<FwaChallengesView> createState() => _FwaChallengesViewState();
}

class _FwaChallengesViewState extends State<FwaChallengesView> {
  String selectedCategory = "all";
  String selectedStatus = "all";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Steps", "value": "steps"},
    {"label": "Calories", "value": "calories"},
    {"label": "Distance", "value": "distance"},
    {"label": "Workout", "value": "workout"},
    {"label": "Social", "value": "social"},
  ];

  List<Map<String, dynamic>> statusOptions = [
    {"label": "All Status", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Completed", "value": "completed"},
    {"label": "Not Started", "value": "not_started"},
  ];

  List<Map<String, dynamic>> challenges = [
    {
      "id": "1",
      "title": "10K Daily Steps",
      "description": "Walk 10,000 steps every day for 7 days straight",
      "category": "steps",
      "status": "active",
      "difficulty": "Medium",
      "duration": "7 days",
      "reward": "150 points + Step Master badge",
      "startDate": "2024-12-15",
      "endDate": "2024-12-22",
      "progress": 4,
      "target": 7,
      "participants": 1250,
      "icon": Icons.directions_walk,
      "color": primaryColor,
      "isJoined": true,
    },
    {
      "id": "2",
      "title": "Calorie Burn Challenge",
      "description": "Burn 500+ calories in a single workout session",
      "category": "calories",
      "status": "active",
      "difficulty": "Hard",
      "duration": "14 days",
      "reward": "200 points + Fire Badge",
      "startDate": "2024-12-10",
      "endDate": "2024-12-24",
      "progress": 320,
      "target": 500,
      "participants": 890,
      "icon": Icons.local_fire_department,
      "color": dangerColor,
      "isJoined": true,
    },
    {
      "id": "3",
      "title": "Weekend Warrior",
      "description": "Complete 3 workouts this weekend",
      "category": "workout",
      "status": "not_started",
      "difficulty": "Easy",
      "duration": "2 days",
      "reward": "100 points",
      "startDate": "2024-12-21",
      "endDate": "2024-12-22",
      "progress": 0,
      "target": 3,
      "participants": 2100,
      "icon": Icons.fitness_center,
      "color": successColor,
      "isJoined": false,
    },
    {
      "id": "4",
      "title": "5K Running Challenge",
      "description": "Run 5 kilometers without stopping",
      "category": "distance",
      "status": "completed",
      "difficulty": "Medium",
      "duration": "30 days",
      "reward": "180 points + Runner Badge",
      "startDate": "2024-11-15",
      "endDate": "2024-12-15",
      "progress": 5,
      "target": 5,
      "participants": 750,
      "icon": Icons.directions_run,
      "color": infoColor,
      "isJoined": true,
    },
    {
      "id": "5",
      "title": "Social Fitness",
      "description": "Work out with friends 5 times this month",
      "category": "social",
      "status": "active",
      "difficulty": "Easy",
      "duration": "30 days",
      "reward": "120 points + Social Badge",
      "startDate": "2024-12-01",
      "endDate": "2024-12-31",
      "progress": 2,
      "target": 5,
      "participants": 650,
      "icon": Icons.group,
      "color": warningColor,
      "isJoined": true,
    },
    {
      "id": "6",
      "title": "Morning Motivation",
      "description": "Complete morning workouts for 10 consecutive days",
      "category": "workout",
      "status": "not_started",
      "difficulty": "Medium",
      "duration": "10 days",
      "reward": "160 points + Early Bird Badge",
      "startDate": "2024-12-23",
      "endDate": "2025-01-01",
      "progress": 0,
      "target": 10,
      "participants": 980,
      "icon": Icons.wb_sunny,
      "color": warningColor,
      "isJoined": false,
    },
  ];

  List<Map<String, dynamic>> get filteredChallenges {
    return challenges.where((challenge) {
      final categoryMatch = selectedCategory == "all" || challenge["category"] == selectedCategory;
      final statusMatch = selectedStatus == "all" || challenge["status"] == selectedStatus;
      return categoryMatch && statusMatch;
    }).toList();
  }

  int get activeChallenges => challenges.where((c) => c["status"] == "active" && c["isJoined"] == true).length;
  int get completedChallenges => challenges.where((c) => c["status"] == "completed" && c["isJoined"] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Challenges"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // navigateTo('FwaCreateChallengeView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Challenge Summary
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              "Challenge Progress",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Push your limits and achieve new goals!",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Active",
                          "$activeChallenges",
                          Icons.play_circle,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Completed",
                          "$completedChallenges",
                          Icons.check_circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter Options
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Text(
                    "Filter Challenges",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Category",
                          items: categoryOptions,
                          value: selectedCategory,
                          onChanged: (value, label) {
                            selectedCategory = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QDropdownField(
                          label: "Status",
                          items: statusOptions,
                          value: selectedStatus,
                          onChanged: (value, label) {
                            selectedStatus = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Challenge Categories
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Challenge Categories",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QHorizontalScroll(
                    children: [
                      _buildCategoryCard("Steps", Icons.directions_walk, primaryColor, 3),
                      _buildCategoryCard("Calories", Icons.local_fire_department, dangerColor, 2),
                      _buildCategoryCard("Distance", Icons.directions_run, infoColor, 1),
                      _buildCategoryCard("Workout", Icons.fitness_center, successColor, 2),
                      _buildCategoryCard("Social", Icons.group, warningColor, 1),
                    ],
                  ),
                ],
              ),
            ),

            // Challenges List
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Available Challenges",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: filteredChallenges.map((challenge) {
                      return _buildChallengeCard(challenge);
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Featured Challenge
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [warningColor, warningColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Featured Challenge",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "New Year Fitness Resolution",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Join our biggest challenge yet! Work out 20 times in January and win exclusive rewards.",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              "Reward: 500 points + Special Badge",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Starts January 1, 2025",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                      QButton(
                        label: "Join Now",
                        size: bs.sm,
                        onPressed: () {
                          ss("Joined New Year Fitness Resolution challenge!");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color, int count) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(right: spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "$count active",
            style: TextStyle(
              fontSize: 11,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    final status = challenge["status"] as String;
    final isJoined = challenge["isJoined"] as bool;
    final color = challenge["color"] as Color;
    final progress = challenge["progress"] as int;
    final target = challenge["target"] as int;
    final progressPercentage = target > 0 ? progress / target : 0.0;

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (status) {
      case "active":
        statusColor = successColor;
        statusText = "Active";
        statusIcon = Icons.play_circle;
        break;
      case "completed":
        statusColor = primaryColor;
        statusText = "Completed";
        statusIcon = Icons.check_circle;
        break;
      case "not_started":
        statusColor = warningColor;
        statusText = "Not Started";
        statusIcon = Icons.schedule;
        break;
      default:
        statusColor = disabledColor;
        statusText = "Unknown";
        statusIcon = Icons.help;
    }

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(5),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  challenge["icon"] as IconData,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${challenge["title"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                statusIcon,
                                size: 10,
                                color: Colors.white,
                              ),
                              SizedBox(width: 2),
                              Text(
                                statusText,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${challenge["difficulty"]} • ${challenge["duration"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          Text(
            "${challenge["description"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          
          if (status == "active" && isJoined) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Row(
                  children: [
                    Text(
                      "Progress: $progress/$target",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(progressPercentage * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: color.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: progressPercentage.clamp(0.0, 1.0),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          
          Row(
            children: [
              Icon(
                Icons.people,
                size: 14,
                color: disabledBoldColor,
              ),
              SizedBox(width: 4),
              Text(
                "${challenge["participants"]} participants",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                "${challenge["reward"]}",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: warningColor,
                ),
              ),
            ],
          ),
          
          if (!isJoined && status == "not_started")
            Container(
              width: double.infinity,
              child: QButton(
                label: "Join Challenge",
                size: bs.sm,
                onPressed: () {
                  challenge["isJoined"] = true;
                  setState(() {});
                  ss("Joined ${challenge["title"]}!");
                },
              ),
            )
          else if (isJoined && status == "active")
            Container(
              width: double.infinity,
              child: QButton(
                label: "View Details",
                size: bs.sm,
                onPressed: () {
                  // navigateTo('FwaChallengeDetailView', challenge)
                },
              ),
            )
          else if (status == "completed")
            Container(
              padding: EdgeInsets.symmetric(vertical: spXs),
              decoration: BoxDecoration(
                color: successColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_events,
                    size: 16,
                    color: successColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Challenge Completed!",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
