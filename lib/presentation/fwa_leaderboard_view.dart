import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaLeaderboardView extends StatefulWidget {
  const FwaLeaderboardView({super.key});

  @override
  State<FwaLeaderboardView> createState() => _FwaLeaderboardViewState();
}

class _FwaLeaderboardViewState extends State<FwaLeaderboardView> {
  String selectedCategory = "steps";
  String selectedPeriod = "weekly";
  
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "Steps", "value": "steps"},
    {"label": "Calories Burned", "value": "calories"},
    {"label": "Distance", "value": "distance"},
    {"label": "Workout Time", "value": "workout_time"},
    {"label": "Overall Score", "value": "overall"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "weekly"},
    {"label": "This Month", "value": "monthly"},
    {"label": "All Time", "value": "all_time"},
  ];

  List<Map<String, dynamic>> leaderboardData = [
    {
      "rank": 1,
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/100/100?random=1&keyword=woman",
      "points": 48520,
      "value": "48,520 steps",
      "isCurrentUser": false,
      "change": "+2",
      "location": "New York",
    },
    {
      "rank": 2,
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/100/100?random=2&keyword=man",
      "points": 47890,
      "value": "47,890 steps",
      "isCurrentUser": false,
      "change": "-1",
      "location": "San Francisco",
    },
    {
      "rank": 3,
      "name": "You",
      "avatar": "https://picsum.photos/100/100?random=3&keyword=person",
      "points": 45230,
      "value": "45,230 steps",
      "isCurrentUser": true,
      "change": "+1",
      "location": "Los Angeles",
    },
    {
      "rank": 4,
      "name": "Emma Wilson",
      "avatar": "https://picsum.photos/100/100?random=4&keyword=woman",
      "points": 43870,
      "value": "43,870 steps",
      "isCurrentUser": false,
      "change": "-2",
      "location": "Chicago",
    },
    {
      "rank": 5,
      "name": "David Kim",
      "avatar": "https://picsum.photos/100/100?random=5&keyword=man",
      "points": 42650,
      "value": "42,650 steps",
      "isCurrentUser": false,
      "change": "0",
      "location": "Seattle",
    },
    {
      "rank": 6,
      "name": "Lisa Rodriguez",
      "avatar": "https://picsum.photos/100/100?random=6&keyword=woman",
      "points": 41230,
      "value": "41,230 steps",
      "isCurrentUser": false,
      "change": "+3",
      "location": "Miami",
    },
    {
      "rank": 7,
      "name": "James Brown",
      "avatar": "https://picsum.photos/100/100?random=7&keyword=man",
      "points": 39840,
      "value": "39,840 steps",
      "isCurrentUser": false,
      "change": "-1",
      "location": "Boston",
    },
    {
      "rank": 8,
      "name": "Anna Thompson",
      "avatar": "https://picsum.photos/100/100?random=8&keyword=woman",
      "points": 38420,
      "value": "38,420 steps",
      "isCurrentUser": false,
      "change": "+1",
      "location": "Denver",
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {"title": "Top 3 This Week", "icon": Icons.emoji_events, "color": warningColor},
    {"title": "Consistent Performer", "icon": Icons.trending_up, "color": successColor},
    {"title": "Step Champion", "icon": Icons.directions_walk, "color": primaryColor},
  ];

  @override
  Widget build(BuildContext context) {
    final currentUser = leaderboardData.firstWhere((user) => user["isCurrentUser"] == true);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              si("Leaderboard refreshed");
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
            // Your Rank Summary
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
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radiusMd),
                      child: Image.network(
                        "${currentUser["avatar"]}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(
                          "Your Current Rank",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withAlpha(200),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "#${currentUser["rank"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: spXs),
                            _buildRankChange(currentUser["change"]),
                          ],
                        ),
                        Text(
                          "${currentUser["value"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Top 10",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
                    "Leaderboard Filters",
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
                          label: "Period",
                          items: periodOptions,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Top 3 Podium
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
                    "Top Performers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // 2nd Place
                      _buildPodiumUser(leaderboardData[1], 2, 80),
                      // 1st Place
                      _buildPodiumUser(leaderboardData[0], 1, 100),
                      // 3rd Place
                      _buildPodiumUser(leaderboardData[2], 3, 60),
                    ],
                  ),
                ],
              ),
            ),

            // Full Leaderboard
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
                        "Full Rankings",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "This Week",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spSm,
                    children: leaderboardData.map((user) {
                      final isCurrentUser = user["isCurrentUser"] as bool;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCurrentUser 
                              ? primaryColor.withAlpha(10)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: isCurrentUser
                              ? Border.all(color: primaryColor, width: 2)
                              : null,
                        ),
                        child: Row(
                          children: [
                            // Rank
                            Container(
                              width: 30,
                              child: Text(
                                "#${user["rank"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getRankColor(user["rank"] as int),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            
                            // Avatar
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: isCurrentUser
                                    ? Border.all(color: primaryColor, width: 2)
                                    : null,
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
                            
                            // User Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 2,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${user["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isCurrentUser ? primaryColor : primaryColor,
                                        ),
                                      ),
                                      if (isCurrentUser) ...[
                                        SizedBox(width: 4),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "YOU",
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
                                  Text(
                                    "${user["location"]}",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Value and Change
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              spacing: 2,
                              children: [
                                Text(
                                  "${user["value"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                _buildRankChange(user["change"]),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Your Achievements
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
                    "Your Leaderboard Achievements",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: achievements.map((achievement) {
                      return Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (achievement["color"] as Color).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: achievement["color"] as Color,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                achievement["icon"] as IconData,
                                color: achievement["color"] as Color,
                                size: 24,
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${achievement["title"]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: achievement["color"] as Color,
                                ),
                              ),
                            ],
                          ),
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

  Widget _buildPodiumUser(Map<String, dynamic> user, int position, double height) {
    Color medalColor;
    IconData medalIcon;
    
    switch (position) {
      case 1:
        medalColor = warningColor;
        medalIcon = Icons.looks_one;
        break;
      case 2:
        medalColor = Colors.grey;
        medalIcon = Icons.looks_two;
        break;
      case 3:
        medalColor = Colors.brown;
        medalIcon = Icons.looks_3;
        break;
      default:
        medalColor = disabledColor;
        medalIcon = Icons.emoji_events;
    }

    final isCurrentUser = user["isCurrentUser"] as bool;
    
    return Column(
      children: [
        // Medal
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: medalColor,
            borderRadius: BorderRadius.circular(radiusMd),
          ),
          child: Icon(
            medalIcon,
            color: Colors.white,
            size: 18,
          ),
        ),
        SizedBox(height: spXs),
        
        // Avatar
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(
              color: isCurrentUser ? primaryColor : medalColor,
              width: 3,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radiusMd),
            child: Image.network(
              "${user["avatar"]}",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: spXs),
        
        // Name
        Text(
          "${user["name"]}",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isCurrentUser ? primaryColor : primaryColor,
          ),
        ),
        
        // Value
        Text(
          "${user["value"]}",
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        
        // Podium
        Container(
          width: 60,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [medalColor, medalColor.withAlpha(180)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radiusSm),
              topRight: Radius.circular(radiusSm),
            ),
          ),
          child: Center(
            child: Text(
              "#$position",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRankChange(String change) {
    Color color;
    IconData icon;
    
    if (change.startsWith("+")) {
      color = successColor;
      icon = Icons.keyboard_arrow_up;
    } else if (change.startsWith("-")) {
      color = dangerColor;
      icon = Icons.keyboard_arrow_down;
    } else {
      color = disabledBoldColor;
      icon = Icons.remove;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          Text(
            change.replaceAll("+", "").replaceAll("-", ""),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
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
