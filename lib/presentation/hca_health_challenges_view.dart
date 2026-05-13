import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HcaHealthChallengesView extends StatefulWidget {
  const HcaHealthChallengesView({super.key});

  @override
  State<HcaHealthChallengesView> createState() => _HcaHealthChallengesViewState();
}

class _HcaHealthChallengesViewState extends State<HcaHealthChallengesView> {
  String selectedCategory = "All";
  List<String> categories = ["All", "Fitness", "Nutrition", "Mental Health", "Sleep"];
  
  List<Map<String, dynamic>> challenges = [
    {
      "id": 1,
      "title": "10,000 Steps Daily",
      "description": "Walk 10,000 steps every day for 30 days",
      "category": "Fitness",
      "duration": "30 days",
      "participants": 2453,
      "progress": 68,
      "difficulty": "Medium",
      "reward": "50 points",
      "image": "https://picsum.photos/400/200?random=1&keyword=walking",
      "isJoined": true,
      "daysLeft": 12
    },
    {
      "id": 2,
      "title": "Hydration Challenge",
      "description": "Drink 8 glasses of water daily for 21 days",
      "category": "Nutrition",
      "duration": "21 days",
      "participants": 3210,
      "progress": 0,
      "difficulty": "Easy",
      "reward": "30 points",
      "image": "https://picsum.photos/400/200?random=2&keyword=water",
      "isJoined": false,
      "daysLeft": 21
    },
    {
      "id": 3,
      "title": "Meditation Streak",
      "description": "Meditate for 10 minutes daily for 14 days",
      "category": "Mental Health",
      "duration": "14 days",
      "participants": 1876,
      "progress": 85,
      "difficulty": "Easy",
      "reward": "40 points",
      "image": "https://picsum.photos/400/200?random=3&keyword=meditation",
      "isJoined": true,
      "daysLeft": 2
    },
    {
      "id": 4,
      "title": "Sleep Optimization",
      "description": "Get 7-8 hours of sleep nightly for 30 days",
      "category": "Sleep",
      "duration": "30 days",
      "participants": 1654,
      "progress": 0,
      "difficulty": "Hard",
      "reward": "75 points",
      "image": "https://picsum.photos/400/200?random=4&keyword=sleep",
      "isJoined": false,
      "daysLeft": 30
    },
    {
      "id": 5,
      "title": "Strength Training",
      "description": "Complete 3 strength workouts per week for 4 weeks",
      "category": "Fitness",
      "duration": "28 days",
      "participants": 987,
      "progress": 25,
      "difficulty": "Hard",
      "reward": "80 points",
      "image": "https://picsum.photos/400/200?random=5&keyword=strength",
      "isJoined": true,
      "daysLeft": 21
    },
    {
      "id": 6,
      "title": "Mindful Eating",
      "description": "Practice mindful eating habits for 21 days",
      "category": "Nutrition",
      "duration": "21 days",
      "participants": 2108,
      "progress": 0,
      "difficulty": "Medium",
      "reward": "45 points",
      "image": "https://picsum.photos/400/200?random=6&keyword=healthy-food",
      "isJoined": false,
      "daysLeft": 21
    }
  ];

  List<Map<String, dynamic>> get filteredChallenges {
    if (selectedCategory == "All") {
      return challenges;
    }
    return challenges.where((challenge) => challenge["category"] == selectedCategory).toList();
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Challenges"),
        actions: [
          IconButton(
            icon: Icon(Icons.leaderboard),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Statistics
            Container(
              padding: EdgeInsets.all(spMd),
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
                  Text(
                    "Your Progress",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "3",
                              style: TextStyle(
                                fontSize: fsH1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Active Challenges",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
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
                              "285",
                              style: TextStyle(
                                fontSize: fsH1,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Points",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
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

            SizedBox(height: spLg),

            // Category Filter
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            QCategoryPicker(
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
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

            ...filteredChallenges.map((challenge) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Challenge Image
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radiusLg),
                        topRight: Radius.circular(radiusLg),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${challenge["image"]}",
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(challenge["difficulty"]),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${challenge["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (challenge["isJoined"] as bool)
                            Positioned(
                              top: spSm,
                              left: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "Joined",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Challenge Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
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
                                  color: warningColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.emoji_events,
                                      size: 16,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${challenge["reward"]}",
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
                          SizedBox(height: spXs),
                          Text(
                            "${challenge["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spSm),

                          // Challenge Stats
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${challenge["duration"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.group,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${(challenge["participants"] as int).currency} participants",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),

                          if (challenge["isJoined"] as bool) ...[
                            SizedBox(height: spSm),
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
                                      "${challenge["progress"]}%",
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
                                  value: (challenge["progress"] as int) / 100,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${challenge["daysLeft"]} days left",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          SizedBox(height: spSm),

                          // Action Button
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: challenge["isJoined"] as bool ? "View Progress" : "Join Challenge",
                              size: bs.sm,
                              onPressed: () {
                                if (!(challenge["isJoined"] as bool)) {
                                  challenge["isJoined"] = true;
                                  setState(() {});
                                  ss("Successfully joined the challenge!");
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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
