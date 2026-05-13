import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaChallengesView extends StatefulWidget {
  const GeaChallengesView({super.key});

  @override
  State<GeaChallengesView> createState() => _GeaChallengesViewState();
}

class _GeaChallengesViewState extends State<GeaChallengesView> {
  String selectedCategory = "weekly";
  String selectedDifficulty = "all";
  String sortBy = "newest";

  List<Map<String, dynamic>> categories = [
    {"label": "Weekly", "value": "weekly"},
    {"label": "Monthly", "value": "monthly"},
    {"label": "Special", "value": "special"},
    {"label": "Community", "value": "community"},
  ];

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "All Levels", "value": "all"},
    {"label": "Easy", "value": "easy"},
    {"label": "Medium", "value": "medium"},
    {"label": "Hard", "value": "hard"},
    {"label": "Expert", "value": "expert"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest", "value": "newest"},
    {"label": "Ending Soon", "value": "ending"},
    {"label": "Highest Reward", "value": "reward"},
    {"label": "Most Popular", "value": "popular"},
  ];

  List<Map<String, dynamic>> challenges = [
    {
      "id": "ch_001",
      "title": "Speed Demon",
      "description": "Complete 50 races in under 2 minutes each",
      "category": "weekly",
      "difficulty": "medium",
      "progress": 32,
      "maxProgress": 50,
      "reward": 2500,
      "rewardType": "coins",
      "timeLeft": "4d 12h",
      "participants": 15420,
      "status": "active",
      "icon": Icons.speed,
      "color": Colors.orange,
      "requirements": ["Complete Tutorial", "Reach Level 10"],
      "completionRate": 64,
    },
    {
      "id": "ch_002",
      "title": "Precision Master",
      "description": "Achieve 95% accuracy in 25 shooting sessions",
      "category": "weekly",
      "difficulty": "hard",
      "progress": 18,
      "maxProgress": 25,
      "reward": 5000,
      "rewardType": "xp",
      "timeLeft": "6d 8h",
      "participants": 8932,
      "status": "active",
      "icon": Icons.gps_fixed,
      "color": Colors.red,
      "requirements": ["Unlock Precision Mode"],
      "completionRate": 72,
    },
    {
      "id": "ch_003",
      "title": "Team Player",
      "description": "Win 10 team matches with 5 different teammates",
      "category": "monthly",
      "difficulty": "easy",
      "progress": 7,
      "maxProgress": 10,
      "reward": 1000,
      "rewardType": "gems",
      "timeLeft": "22d 15h",
      "participants": 25678,
      "status": "active",
      "icon": Icons.groups,
      "color": Colors.blue,
      "requirements": ["Join Guild"],
      "completionRate": 70,
    },
    {
      "id": "ch_004",
      "title": "Legendary Hunter",
      "description": "Defeat 3 legendary bosses in epic mode",
      "category": "special",
      "difficulty": "expert",
      "progress": 1,
      "maxProgress": 3,
      "reward": 10000,
      "rewardType": "coins",
      "timeLeft": "14d 6h",
      "participants": 3247,
      "status": "active",
      "icon": Icons.military_tech,
      "color": Colors.purple,
      "requirements": ["Reach Level 50", "Complete Main Story"],
      "completionRate": 33,
    },
    {
      "id": "ch_005",
      "title": "Community Builder",
      "description": "Help 100 new players complete their first mission",
      "category": "community",
      "difficulty": "medium",
      "progress": 45,
      "maxProgress": 100,
      "reward": 3000,
      "rewardType": "reputation",
      "timeLeft": "30d 0h",
      "participants": 12456,
      "status": "active",
      "icon": Icons.volunteer_activism,
      "color": Colors.green,
      "requirements": ["Mentor Status"],
      "completionRate": 45,
    },
    {
      "id": "ch_006",
      "title": "Explorer Elite",
      "description": "Discover all hidden areas in 5 different maps",
      "category": "weekly",
      "difficulty": "hard",
      "progress": 25,
      "maxProgress": 25,
      "reward": 4000,
      "rewardType": "xp",
      "timeLeft": "Completed",
      "participants": 6754,
      "status": "completed",
      "icon": Icons.explore,
      "color": Colors.teal,
      "requirements": ["Unlock Explorer Mode"],
      "completionRate": 100,
    },
  ];

  List<Map<String, dynamic>> get filteredChallenges {
    return challenges.where((challenge) {
      bool categoryMatch = selectedCategory == "all" || challenge["category"] == selectedCategory;
      bool difficultyMatch = selectedDifficulty == "all" || challenge["difficulty"] == selectedDifficulty;
      return categoryMatch && difficultyMatch;
    }).toList();
  }

  Color getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "easy": return Colors.green;
      case "medium": return Colors.orange;
      case "hard": return Colors.red;
      case "expert": return Colors.purple;
      default: return disabledBoldColor;
    }
  }

  String getDifficultyText(String difficulty) {
    return difficulty.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Challenges"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              // Filter options
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh challenges
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Challenge Stats Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Active Challenges",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Push your limits and earn rewards",
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${challenges.where((c) => c["status"] == "active").length}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categories,
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
                    label: "Difficulty",
                    items: difficultyLevels,
                    value: selectedDifficulty,
                    onChanged: (value, label) {
                      selectedDifficulty = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spSm),

            QDropdownField(
              label: "Sort By",
              items: sortOptions,
              value: sortBy,
              onChanged: (value, label) {
                sortBy = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Challenge Categories
            QCategoryPicker(
              items: [
                {"label": "Weekly", "value": "weekly"},
                {"label": "Monthly", "value": "monthly"},
                {"label": "Special", "value": "special"},
                {"label": "Community", "value": "community"},
              ],
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),

            SizedBox(height: spLg),

            // Challenges List
            Text(
              "Available Challenges",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: filteredChallenges.map((challenge) {
                double progressPercentage = (challenge["progress"] as int) / (challenge["maxProgress"] as int);
                bool isCompleted = challenge["status"] == "completed";
                
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: isCompleted ? Border.all(color: successColor, width: 2) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Challenge Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (challenge["color"] as Color).withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              challenge["icon"] as IconData,
                              color: challenge["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${challenge["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: isCompleted ? successColor : primaryColor,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                      decoration: BoxDecoration(
                                        color: getDifficultyColor(challenge["difficulty"]).withAlpha(50),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        getDifficultyText(challenge["difficulty"]),
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: getDifficultyColor(challenge["difficulty"]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${challenge["description"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Progress Bar
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Progress: ${challenge["progress"]}/${challenge["maxProgress"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(progressPercentage * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted ? successColor : primaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progressPercentage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isCompleted ? successColor : challenge["color"] as Color,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Challenge Details
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${challenge["timeLeft"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${((challenge["participants"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: spSm),

                      // Requirements
                      if ((challenge["requirements"] as List).isNotEmpty) ...[
                        Text(
                          "Requirements:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: (challenge["requirements"] as List).map((req) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: infoColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "$req",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: infoColor,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: spSm),
                      ],

                      // Reward and Action
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: warningColor.withAlpha(50),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    challenge["rewardType"] == "coins" ? Icons.monetization_on :
                                    challenge["rewardType"] == "xp" ? Icons.star :
                                    challenge["rewardType"] == "gems" ? Icons.diamond :
                                    Icons.military_tech,
                                    color: warningColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "${((challenge["reward"] as int) / 1000).toStringAsFixed(challenge["reward"] >= 1000 ? 1 : 0)}${challenge["reward"] >= 1000 ? 'K' : ''} ${challenge["rewardType"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: warningColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          QButton(
                            label: isCompleted ? "Claimed" : "Join",
                            size: bs.sm,
                            color: isCompleted ? successColor : primaryColor,
                            onPressed: isCompleted ? null : () {
                              // Join challenge
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spLg),

            // Challenge Statistics
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Challenge Statistics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${challenges.where((c) => c["status"] == "completed").length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "Completed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: successColor,
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
                            color: warningColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: warningColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${challenges.where((c) => c["status"] == "active").length}",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: warningColor,
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
                            color: primaryColor.withAlpha(50),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: primaryColor,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${challenges.map((c) => c["reward"] as int).reduce((a, b) => a + b) ~/ 1000}K",
                                style: TextStyle(
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "Total Rewards",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
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
            ),
          ],
        ),
      ),
    );
  }
}
