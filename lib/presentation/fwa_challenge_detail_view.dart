import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaChallengeDetailView extends StatefulWidget {
  const FwaChallengeDetailView({super.key});

  @override
  State<FwaChallengeDetailView> createState() => _FwaChallengeDetailViewState();
}

class _FwaChallengeDetailViewState extends State<FwaChallengeDetailView> {
  bool isJoined = true;
  
  Map<String, dynamic> challenge = {
    "id": "1",
    "title": "10K Daily Steps Challenge",
    "description": "Walk 10,000 steps every day for 7 consecutive days. Track your progress and stay motivated with our community of walkers!",
    "longDescription": "This challenge is designed to help you build a consistent walking habit. Walking 10,000 steps daily has numerous health benefits including improved cardiovascular health, weight management, and better mood. Join thousands of participants from around the world!",
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
    "organizer": "FitnessPro Team",
    "rules": [
      "Walk at least 10,000 steps each day",
      "Steps must be recorded through the app",
      "No makeup days - consecutive days required",
      "Progress tracked automatically via connected devices"
    ],
    "tips": [
      "Take short walks throughout the day",
      "Use stairs instead of elevators",
      "Park further away from your destination",
      "Walk during phone calls when possible"
    ]
  };

  List<Map<String, dynamic>> dailyProgress = [
    {"day": 1, "date": "Dec 15", "steps": 12450, "completed": true, "percentage": 124},
    {"day": 2, "date": "Dec 16", "steps": 10230, "completed": true, "percentage": 102},
    {"day": 3, "date": "Dec 17", "steps": 9850, "completed": false, "percentage": 98},
    {"day": 4, "date": "Dec 18", "steps": 11200, "completed": true, "percentage": 112},
    {"day": 5, "date": "Dec 19", "steps": 8500, "completed": false, "percentage": 85},
    {"day": 6, "date": "Dec 20", "steps": 0, "completed": false, "percentage": 0},
    {"day": 7, "date": "Dec 21", "steps": 0, "completed": false, "percentage": 0},
  ];

  List<Map<String, dynamic>> leaderboard = [
    {"rank": 1, "name": "Sarah Johnson", "steps": 78450, "avatar": "https://picsum.photos/50/50?random=1"},
    {"rank": 2, "name": "Mike Chen", "steps": 76890, "avatar": "https://picsum.photos/50/50?random=2"},
    {"rank": 3, "name": "You", "steps": 52230, "avatar": "https://picsum.photos/50/50?random=3", "isCurrentUser": true},
    {"rank": 4, "name": "Emma Wilson", "steps": 48870, "avatar": "https://picsum.photos/50/50?random=4"},
    {"rank": 5, "name": "David Kim", "steps": 45650, "avatar": "https://picsum.photos/50/50?random=5"},
  ];

  int get completedDays => dailyProgress.where((day) => day["completed"] == true).length;
  int get totalSteps => dailyProgress.fold(0, (sum, day) => sum + (day["steps"] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Challenge Details"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Challenge shared successfully");
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
            // Challenge Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [challenge["color"] as Color, (challenge["color"] as Color).withAlpha(180)],
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
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          challenge["icon"] as IconData,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              "${challenge["title"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${challenge["difficulty"]} • ${challenge["duration"]}",
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
                  Text(
                    "${challenge["description"]}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeaderStat("Progress", "$completedDays/${challenge["target"]} days"),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat("Total Steps", "${totalSteps.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Action Button
            if (!isJoined)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Join Challenge",
                  onPressed: () {
                    isJoined = true;
                    setState(() {});
                    ss("Successfully joined the challenge!");
                  },
                ),
              ),

            // Daily Progress
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
                    "Daily Progress",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: dailyProgress.map((day) {
                      final isCompleted = day["completed"] as bool;
                      final steps = day["steps"] as int;
                      final percentage = day["percentage"] as int;
                      final isToday = day["day"] == 5; // Example: day 5 is today
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isToday 
                              ? primaryColor.withAlpha(10)
                              : isCompleted
                                  ? successColor.withAlpha(10)
                                  : disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isToday 
                                ? primaryColor
                                : isCompleted
                                    ? successColor
                                    : disabledOutlineBorderColor,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isCompleted 
                                    ? successColor
                                    : isToday
                                        ? primaryColor
                                        : disabledColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                isCompleted 
                                    ? Icons.check
                                    : isToday
                                        ? Icons.today
                                        : Icons.schedule,
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
                                      Text(
                                        "Day ${day["day"]} - ${day["date"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      if (isToday) ...[
                                        SizedBox(width: 4),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "TODAY",
                                            style: TextStyle(
                                              fontSize: 8,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  if (steps > 0) ...[
                                    Text(
                                      "${steps.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} steps",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Container(
                                      height: 4,
                                      margin: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                        color: disabledColor.withAlpha(30),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: FractionallySizedBox(
                                        widthFactor: (percentage / 100).clamp(0.0, 1.0),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isCompleted ? successColor : primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ] else
                                    Text(
                                      "Not started yet",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledColor,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (isCompleted)
                              Icon(
                                Icons.emoji_events,
                                color: warningColor,
                                size: 16,
                              )
                            else if (steps > 0)
                              Text(
                                "$percentage%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Challenge Info
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
                    "About This Challenge",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "${challenge["longDescription"]}",
                    style: TextStyle(
                      color: disabledBoldColor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.group,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${challenge["participants"]} participants",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.person,
                        size: 16,
                        color: disabledBoldColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "by ${challenge["organizer"]}",
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

            // Challenge Rules
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
                    "Challenge Rules",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: (challenge["rules"] as List<String>).map((rule) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              rule,
                              style: TextStyle(
                                color: disabledBoldColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Tips for Success
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
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Tips for Success",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: (challenge["tips"] as List<String>).map((tip) {
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: warningColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: warningColor.withAlpha(50),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.tips_and_updates,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                tip,
                                style: TextStyle(
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Leaderboard
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
                  Row(
                    children: [
                      Text(
                        "Challenge Leaderboard",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      QButton(
                        label: "View All",
                        size: bs.sm,
                        onPressed: () {
                          // navigateTo('FwaLeaderboardView')
                        },
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: leaderboard.take(5).map((user) {
                      final isCurrentUser = user["isCurrentUser"] == true;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCurrentUser 
                              ? primaryColor.withAlpha(10)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: isCurrentUser
                              ? Border.all(color: primaryColor, width: 1)
                              : null,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "#${user["rank"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: _getRankColor(user["rank"] as int),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "${user["avatar"]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "${user["name"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isCurrentUser ? primaryColor : primaryColor,
                                ),
                              ),
                            ),
                            Text(
                              "${(user["steps"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} steps",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String title, String value) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
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

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return warningColor;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return primaryColor;
    }
  }
}
