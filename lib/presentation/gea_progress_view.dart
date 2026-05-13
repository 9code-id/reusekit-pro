import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaProgressView extends StatefulWidget {
  const GeaProgressView({super.key});

  @override
  State<GeaProgressView> createState() => _GeaProgressViewState();
}

class _GeaProgressViewState extends State<GeaProgressView> {
  String selectedTimeframe = "This Week";

  List<Map<String, dynamic>> progressData = [
    {
      "title": "Level Progress",
      "current": 78,
      "target": 80,
      "progress": 0.9,
      "type": "level",
      "icon": Icons.star,
      "color": primaryColor,
      "description": "2 levels to next milestone",
    },
    {
      "title": "Win Streak",
      "current": 7,
      "target": 10,
      "progress": 0.7,
      "type": "streak",
      "icon": Icons.local_fire_department,
      "color": warningColor,
      "description": "3 wins to reach target",
    },
    {
      "title": "Ranked Points",
      "current": 2847,
      "target": 3000,
      "progress": 0.949,
      "type": "points",
      "icon": Icons.military_tech,
      "color": successColor,
      "description": "153 points to Diamond II",
    },
    {
      "title": "Daily Missions",
      "current": 3,
      "target": 5,
      "progress": 0.6,
      "type": "mission",
      "icon": Icons.assignment_turned_in,
      "color": infoColor,
      "description": "2 missions remaining today",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Blood",
      "description": "Get first kill in 100 matches",
      "current": 87,
      "target": 100,
      "progress": 0.87,
      "completed": false,
      "reward": "500 XP + Badge",
    },
    {
      "title": "Legendary Player",
      "description": "Reach Diamond rank",
      "current": 2847,
      "target": 3000,
      "progress": 0.949,
      "completed": false,
      "reward": "Exclusive Skin",
    },
    {
      "title": "Win Master",
      "description": "Win 1000 matches",
      "current": 892,
      "target": 1000,
      "progress": 0.892,
      "completed": false,
      "reward": "Special Title",
    },
  ];

  List<Map<String, dynamic>> weeklyGoals = [
    {
      "goal": "Play 20 matches",
      "current": 14,
      "target": 20,
      "progress": 0.7,
      "completed": false,
    },
    {
      "goal": "Win 12 matches",
      "current": 8,
      "target": 12,
      "progress": 0.667,
      "completed": false,
    },
    {
      "goal": "Complete 15 daily missions",
      "current": 15,
      "target": 15,
      "progress": 1.0,
      "completed": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              //navigateTo('ProgressHistoryView')
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Time Filter
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: [
                      {"label": "Today", "value": "Today"},
                      {"label": "This Week", "value": "This Week"},
                      {"label": "This Month", "value": "This Month"},
                      {"label": "This Season", "value": "This Season"},
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

            // Main Progress Cards
            ...progressData.map((progress) {
              return Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (progress["color"] as Color).withAlpha(25),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            progress["icon"] as IconData,
                            color: progress["color"] as Color,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${progress["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${progress["description"]}",
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
                              "${progress["current"]}/${progress["target"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${((progress["progress"] as num) * 100).toStringAsFixed(0)}%",
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
                    LinearProgressIndicator(
                      value: progress["progress"] as double,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(progress["color"] as Color),
                      minHeight: 8,
                    ),
                  ],
                ),
              );
            }),

            // Weekly Goals Section
            Container(
              width: double.infinity,
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
                  Row(
                    children: [
                      Icon(
                        Icons.flag,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Weekly Goals",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...weeklyGoals.map((goal) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      child: Row(
                        children: [
                          Icon(
                            goal["completed"] == true ? Icons.check_circle : Icons.radio_button_unchecked,
                            color: goal["completed"] == true ? successColor : disabledBoldColor,
                            size: 20,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${goal["goal"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                LinearProgressIndicator(
                                  value: goal["progress"] as double,
                                  backgroundColor: disabledColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    goal["completed"] == true ? successColor : primaryColor,
                                  ),
                                  minHeight: 4,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${goal["current"]}/${goal["target"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: goal["completed"] == true ? successColor : disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Achievements Section
            Container(
              width: double.infinity,
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
                  Row(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Achievements in Progress",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...achievements.map((achievement) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(12),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${achievement["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${achievement["current"]}/${achievement["target"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${achievement["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          LinearProgressIndicator(
                            value: achievement["progress"] as double,
                            backgroundColor: disabledColor,
                            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                            minHeight: 6,
                          ),
                          Text(
                            "Reward: ${achievement["reward"]}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Set New Goals",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('SetGoalsView')
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "View All Achievements",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('AchievementsView')
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
