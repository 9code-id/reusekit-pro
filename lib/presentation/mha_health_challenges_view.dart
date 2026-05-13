import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class MhaHealthChallengesView extends StatefulWidget {
  const MhaHealthChallengesView({super.key});

  @override
  State<MhaHealthChallengesView> createState() => _MhaHealthChallengesViewState();
}

class _MhaHealthChallengesViewState extends State<MhaHealthChallengesView> {
  String selectedTab = "active";
  String selectedCategory = "all";

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all"},
    {"label": "Fitness", "value": "fitness"},
    {"label": "Nutrition", "value": "nutrition"},
    {"label": "Mental Health", "value": "mental"},
    {"label": "Sleep", "value": "sleep"},
    {"label": "Habits", "value": "habits"},
  ];

  List<Map<String, dynamic>> challenges = [
    {
      "id": 1,
      "title": "10,000 Steps Daily",
      "description": "Walk 10,000 steps every day for 30 days",
      "category": "fitness",
      "duration": 30,
      "difficulty": "Medium",
      "participants": 1248,
      "reward": "Fitness Badge + 500 points",
      "startDate": "2024-06-01",
      "endDate": "2024-06-30",
      "status": "active",
      "progress": 65,
      "currentDay": 19,
      "icon": Icons.directions_walk,
      "color": 0xFF4CAF50,
      "tasks": [
        {"day": 1, "completed": true, "steps": 12000},
        {"day": 2, "completed": true, "steps": 11500},
        {"day": 3, "completed": false, "steps": 8500},
        {"day": 4, "completed": true, "steps": 10200},
      ]
    },
    {
      "id": 2,
      "title": "7-Day Water Challenge",
      "description": "Drink 8 glasses of water daily for a week",
      "category": "nutrition",
      "duration": 7,
      "difficulty": "Easy",
      "participants": 2156,
      "reward": "Hydration Badge + 200 points",
      "startDate": "2024-06-10",
      "endDate": "2024-06-16",
      "status": "completed",
      "progress": 100,
      "currentDay": 7,
      "icon": Icons.water_drop,
      "color": 0xFF2196F3,
      "tasks": [
        {"day": 1, "completed": true, "glasses": 8},
        {"day": 2, "completed": true, "glasses": 9},
        {"day": 3, "completed": true, "glasses": 8},
        {"day": 4, "completed": true, "glasses": 10},
      ]
    },
    {
      "id": 3,
      "title": "Mindful Meditation",
      "description": "Practice 10 minutes of meditation daily for 21 days",
      "category": "mental",
      "duration": 21,
      "difficulty": "Easy",
      "participants": 856,
      "reward": "Mindfulness Badge + 300 points",
      "startDate": "2024-06-15",
      "endDate": "2024-07-05",
      "status": "active",
      "progress": 30,
      "currentDay": 6,
      "icon": Icons.psychology,
      "color": 0xFF9C27B0,
      "tasks": [
        {"day": 1, "completed": true, "minutes": 10},
        {"day": 2, "completed": true, "minutes": 12},
        {"day": 3, "completed": false, "minutes": 0},
        {"day": 4, "completed": true, "minutes": 15},
      ]
    },
    {
      "id": 4,
      "title": "Early Bird Challenge",
      "description": "Wake up at 6 AM every day for 14 days",
      "category": "sleep",
      "duration": 14,
      "difficulty": "Hard",
      "participants": 623,
      "reward": "Early Bird Badge + 400 points",
      "startDate": "2024-06-20",
      "endDate": "2024-07-03",
      "status": "available",
      "progress": 0,
      "currentDay": 0,
      "icon": Icons.wb_sunny,
      "color": 0xFFFF9800,
      "tasks": []
    },
    {
      "id": 5,
      "title": "Plant-Based Week",
      "description": "Eat only plant-based meals for 7 days",
      "category": "nutrition",
      "duration": 7,
      "difficulty": "Medium",
      "participants": 945,
      "reward": "Green Eater Badge + 350 points",
      "startDate": "2024-06-25",
      "endDate": "2024-07-01",
      "status": "available",
      "progress": 0,
      "currentDay": 0,
      "icon": Icons.eco,
      "color": 0xFF4CAF50,
      "tasks": []
    },
    {
      "id": 6,
      "title": "30-Day Pushup Challenge",
      "description": "Build up to 100 pushups in 30 days",
      "category": "fitness",
      "duration": 30,
      "difficulty": "Hard",
      "participants": 789,
      "reward": "Strength Badge + 600 points",
      "startDate": "2024-07-01",
      "endDate": "2024-07-30",
      "status": "available",
      "progress": 0,
      "currentDay": 0,
      "icon": Icons.fitness_center,
      "color": 0xFFE91E63,
      "tasks": []
    },
  ];

  List<Map<String, dynamic>> get filteredChallenges {
    return challenges.where((challenge) {
      bool matchesTab = selectedTab == "all" || challenge["status"] == selectedTab;
      bool matchesCategory = selectedCategory == "all" || challenge["category"] == selectedCategory;
      return matchesTab && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Challenges"),
        actions: [
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {
              // Show leaderboard
            },
          ),
          IconButton(
            icon: Icon(Icons.emoji_events),
            onPressed: () {
              // Show achievements
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Expanded(
                  child: QCategoryPicker(
                    items: [
                      {"label": "Active", "value": "active"},
                      {"label": "Available", "value": "available"},
                      {"label": "Completed", "value": "completed"},
                      {"label": "All", "value": "all"},
                    ],
                    value: selectedTab,
                    onChanged: (index, label, value, item) {
                      selectedTab = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Statistics
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 150,
                    children: [
                      _buildStatCard(
                        "Active Challenges",
                        "${challenges.where((c) => c["status"] == "active").length}",
                        Icons.play_circle,
                        primaryColor,
                      ),
                      _buildStatCard(
                        "Completed",
                        "${challenges.where((c) => c["status"] == "completed").length}",
                        Icons.check_circle,
                        successColor,
                      ),
                      _buildStatCard(
                        "Total Points",
                        "1,250",
                        Icons.star,
                        warningColor,
                      ),
                      _buildStatCard(
                        "Streak",
                        "12 days",
                        Icons.local_fire_department,
                        dangerColor,
                      ),
                    ],
                  ),

                  // Category Filter
                  QCategoryPicker(
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (index, label, value, item) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Challenges Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${selectedTab.capitalize()} Challenges (${filteredChallenges.length})",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (selectedTab == "available")
                        GestureDetector(
                          onTap: () {
                            // Navigate to create challenge
                          },
                          child: Text(
                            "Create Challenge",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  // Challenges List
                  ...filteredChallenges.map((challenge) => _buildChallengeCard(challenge)),

                  // Motivation Section
                  if (selectedTab == "active" && challenges.where((c) => c["status"] == "active").isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spMd),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            primaryColor.withAlpha(20),
                            primaryColor.withAlpha(10),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(radiusMd),
                        border: Border.all(color: primaryColor.withAlpha(50)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.psychology,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "Daily Motivation",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "\"The groundwork for all happiness is good health.\" - Leigh Hunt",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "Keep pushing forward! You're building healthy habits that will last a lifetime.",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: selectedTab == "available" ? FloatingActionButton(
        onPressed: () {
          // Navigate to create custom challenge
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.add, color: Colors.white),
      ) : null,
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    String status = challenge["status"];
    Color statusColor = primaryColor;
    IconData statusIcon = Icons.play_circle;
    String buttonText = "Join Challenge";

    switch (status) {
      case "active":
        statusColor = successColor;
        statusIcon = Icons.play_circle;
        buttonText = "View Progress";
        break;
      case "completed":
        statusColor = primaryColor;
        statusIcon = Icons.check_circle;
        buttonText = "View Results";
        break;
      case "available":
        statusColor = infoColor;
        statusIcon = Icons.schedule;
        buttonText = "Join Challenge";
        break;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 4,
            color: Color(challenge["color"] as int),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Color(challenge["color"] as int).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  challenge["icon"] as IconData,
                  color: Color(challenge["color"] as int),
                  size: 32,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${challenge["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${challenge["description"]}",
                      style: TextStyle(
                        color: disabledBoldColor,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                statusIcon,
                                color: statusColor,
                                size: 12,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                status.capitalize(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(challenge["difficulty"]).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Text(
                            "${challenge["difficulty"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _getDifficultyColor(challenge["difficulty"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Challenge Details
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 100,
            children: [
              _buildDetailItem("Duration", "${challenge["duration"]} days", Icons.calendar_today),
              _buildDetailItem("Participants", "${challenge["participants"]}", Icons.group),
              _buildDetailItem("Reward", "${challenge["reward"]}", Icons.emoji_events),
            ],
          ),

          // Progress (for active challenges)
          if (status == "active") ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Progress: Day ${challenge["currentDay"]} of ${challenge["duration"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${challenge["progress"]}%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(challenge["color"] as int),
                  ),
                ),
              ],
            ),
            LinearProgressIndicator(
              value: (challenge["progress"] as int) / 100,
              backgroundColor: disabledColor,
              valueColor: AlwaysStoppedAnimation<Color>(Color(challenge["color"] as int)),
            ),
          ],

          // Date Information
          if (status == "available") 
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: infoColor,
                    size: 16,
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "Starts ${(DateTime.parse(challenge["startDate"] as String)).dMMMy}",
                    style: TextStyle(
                      fontSize: 12,
                      color: infoColor,
                    ),
                  ),
                ],
              ),
            ),

          // Action Button
          Container(
            width: double.infinity,
            child: QButton(
              label: buttonText,
              icon: statusIcon,
              size: bs.md,
              onPressed: () {
                _handleChallengeAction(challenge);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        spacing: spXs,
        children: [
          Icon(
            icon,
            color: primaryColor,
            size: 16,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
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
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  void _handleChallengeAction(Map<String, dynamic> challenge) {
    String status = challenge["status"];
    String title = challenge["title"];

    switch (status) {
      case "available":
        _joinChallenge(challenge);
        break;
      case "active":
        _viewProgress(challenge);
        break;
      case "completed":
        _viewResults(challenge);
        break;
    }
  }

  void _joinChallenge(Map<String, dynamic> challenge) {
    // Join challenge logic
    ss("Joined ${challenge["title"]} challenge!");
    challenge["status"] = "active";
    challenge["progress"] = 0;
    challenge["currentDay"] = 1;
    setState(() {});
  }

  void _viewProgress(Map<String, dynamic> challenge) {
    // Navigate to challenge progress view
  }

  void _viewResults(Map<String, dynamic> challenge) {
    // Navigate to challenge results view
  }
}
