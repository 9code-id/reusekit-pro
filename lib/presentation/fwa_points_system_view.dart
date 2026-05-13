import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaPointsSystemView extends StatefulWidget {
  const FwaPointsSystemView({super.key});

  @override
  State<FwaPointsSystemView> createState() => _FwaPointsSystemViewState();
}

class _FwaPointsSystemViewState extends State<FwaPointsSystemView> {
  String selectedPeriod = "This Month";
  int totalLifetimePoints = 5670;
  int currentPoints = 2450;
  int pointsThisMonth = 680;
  int pointsThisWeek = 245;
  int currentStreak = 7;
  int longestStreak = 23;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last Month", "value": "Last Month"},
    {"label": "All Time", "value": "All Time"},
  ];

  List<Map<String, dynamic>> pointsActivities = [
    {
      "activity": "Daily Workout",
      "description": "Complete any workout session",
      "points": 30,
      "icon": Icons.fitness_center,
      "color": primaryColor,
      "frequency": "Daily",
      "completed": 20,
      "total": 25,
      "category": "Workout"
    },
    {
      "activity": "Workout Streak",
      "description": "Maintain consecutive workout days",
      "points": 50,
      "icon": Icons.local_fire_department,
      "color": warningColor,
      "frequency": "Per 7 days",
      "completed": 1,
      "total": 1,
      "category": "Consistency"
    },
    {
      "activity": "Share Progress",
      "description": "Post workout progress on social feed",
      "points": 25,
      "icon": Icons.share,
      "color": infoColor,
      "frequency": "Daily limit 2",
      "completed": 8,
      "total": 10,
      "category": "Social"
    },
    {
      "activity": "Complete Challenge",
      "description": "Finish any fitness challenge",
      "points": 100,
      "icon": Icons.emoji_events,
      "color": successColor,
      "frequency": "Per challenge",
      "completed": 2,
      "total": 3,
      "category": "Challenges"
    },
    {
      "activity": "Invite Friends",
      "description": "Successfully invite a friend to join",
      "points": 200,
      "icon": Icons.person_add,
      "color": primaryColor,
      "frequency": "Per friend",
      "completed": 1,
      "total": 5,
      "category": "Referral"
    },
    {
      "activity": "Write Review",
      "description": "Review workouts, trainers, or equipment",
      "points": 15,
      "icon": Icons.star,
      "color": warningColor,
      "frequency": "Per review",
      "completed": 12,
      "total": 20,
      "category": "Community"
    },
    {
      "activity": "Track Nutrition",
      "description": "Log meals and track daily nutrition",
      "points": 20,
      "icon": Icons.restaurant,
      "color": successColor,
      "frequency": "Daily",
      "completed": 18,
      "total": 25,
      "category": "Nutrition"
    },
    {
      "activity": "Sleep Tracking",
      "description": "Track sleep for 7+ hours",
      "points": 10,
      "icon": Icons.bedtime,
      "color": infoColor,
      "frequency": "Daily",
      "completed": 22,
      "total": 25,
      "category": "Health"
    },
  ];

  List<Map<String, dynamic>> recentPointsHistory = [
    {
      "activity": "Completed Daily Workout",
      "points": 30,
      "date": "2024-06-15",
      "time": "08:30 AM",
      "type": "earned",
      "icon": Icons.fitness_center,
      "multiplier": 1
    },
    {
      "activity": "7-Day Workout Streak Bonus",
      "points": 50,
      "date": "2024-06-15",
      "time": "08:31 AM",
      "type": "earned",
      "icon": Icons.local_fire_department,
      "multiplier": 1
    },
    {
      "activity": "Shared Progress Post",
      "points": 25,
      "date": "2024-06-14",
      "time": "07:45 PM",
      "type": "earned",
      "icon": Icons.share,
      "multiplier": 1
    },
    {
      "activity": "Redeemed Protein Powder",
      "points": -500,
      "date": "2024-06-14",
      "time": "02:30 PM",
      "type": "spent",
      "icon": Icons.shopping_cart,
      "multiplier": 1
    },
    {
      "activity": "Nutrition Tracking",
      "points": 20,
      "date": "2024-06-14",
      "time": "09:15 AM",
      "type": "earned",
      "icon": Icons.restaurant,
      "multiplier": 1
    },
    {
      "activity": "Sleep Goal Achieved",
      "points": 10,
      "date": "2024-06-13",
      "time": "11:59 PM",
      "type": "earned",
      "icon": Icons.bedtime,
      "multiplier": 1
    },
    {
      "activity": "Weekend Warrior Bonus",
      "points": 75,
      "date": "2024-06-13",
      "time": "06:00 PM",
      "type": "earned",
      "icon": Icons.emoji_events,
      "multiplier": 1.5
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Steps",
      "description": "Complete your first workout",
      "points": 100,
      "icon": Icons.directions_walk,
      "achieved": true,
      "achievedDate": "2024-03-15"
    },
    {
      "title": "Week Warrior",
      "description": "Complete 7 consecutive workout days",
      "points": 250,
      "icon": Icons.local_fire_department,
      "achieved": true,
      "achievedDate": "2024-04-02"
    },
    {
      "title": "Social Butterfly",
      "description": "Share 50 progress posts",
      "points": 500,
      "icon": Icons.share,
      "achieved": false,
      "progress": 23,
      "target": 50
    },
    {
      "title": "Challenge Master",
      "description": "Complete 10 fitness challenges",
      "points": 1000,
      "icon": Icons.emoji_events,
      "achieved": false,
      "progress": 6,
      "target": 10
    },
  ];

  List<Map<String, dynamic>> leaderboard = [
    {
      "rank": 1,
      "username": "FitMaster2024",
      "points": 3450,
      "avatar": "https://picsum.photos/40/40?random=1&keyword=person",
      "streak": 45,
      "isMe": false
    },
    {
      "rank": 2,
      "username": "WorkoutQueen",
      "points": 3200,
      "avatar": "https://picsum.photos/40/40?random=2&keyword=person",
      "streak": 38,
      "isMe": false
    },
    {
      "rank": 3,
      "username": "You",
      "points": 2450,
      "avatar": "https://picsum.photos/40/40?random=3&keyword=person",
      "streak": 7,
      "isMe": true
    },
    {
      "rank": 4,
      "username": "StrengthSeeker",
      "points": 2380,
      "avatar": "https://picsum.photos/40/40?random=4&keyword=person",
      "streak": 12,
      "isMe": false
    },
    {
      "rank": 5,
      "username": "CardioKing",
      "points": 2150,
      "avatar": "https://picsum.photos/40/40?random=5&keyword=person",
      "streak": 5,
      "isMe": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Points System"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showPointsGuide();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Points Overview Card
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Current Points",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${currentPoints.toString()}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              Icons.trending_up,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Rank #3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "This Month",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "+${pointsThisMonth}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "This Week",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "+${pointsThisWeek}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Streak",
                                style: TextStyle(
                                  color: Colors.white.withAlpha(200),
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${currentStreak}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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

            SizedBox(height: spMd),

            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Lifetime Points",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "${totalLifetimePoints.toString()}",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Best Streak",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: warningColor,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${longestStreak}",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Points Activities
            Text(
              "How to Earn Points",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...pointsActivities.map((activity) {
              double progress = (activity["completed"] as int) / (activity["total"] as int);
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                            color: (activity["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            activity["icon"],
                            color: activity["color"],
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
                                      "${activity["activity"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: successColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "+${activity["points"]} pts",
                                      style: TextStyle(
                                        color: successColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Text(
                                "${activity["description"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                              
                              SizedBox(height: spXs),
                              
                              Row(
                                children: [
                                  Text(
                                    "${activity["frequency"]}",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    "${activity["completed"]}/${activity["total"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    // Progress Bar
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: disabledColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: activity["color"],
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Recent Activity
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // View full history
                  },
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),
            
            ...recentPointsHistory.take(5).map((history) {
              bool isEarned = history["type"] == "earned";
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isEarned ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isEarned ? successColor.withAlpha(20) : dangerColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        history["icon"],
                        color: isEarned ? successColor : dangerColor,
                        size: 16,
                      ),
                    ),
                    
                    SizedBox(width: spSm),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${history["activity"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${history["date"]} • ${history["time"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Text(
                      "${isEarned ? '+' : ''}${history["points"]}",
                      style: TextStyle(
                        color: isEarned ? successColor : dangerColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Leaderboard Preview
            Text(
              "Leaderboard",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: leaderboard.take(5).map((user) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: user["isMe"] as bool ? primaryColor.withAlpha(10) : Colors.transparent,
                      borderRadius: user["rank"] == 1 ? BorderRadius.vertical(top: Radius.circular(radiusMd)) : null,
                    ),
                    child: Row(
                      children: [
                        // Rank Badge
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: user["rank"] <= 3 ? warningColor : disabledColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "#${user["rank"]}",
                              style: TextStyle(
                                color: user["rank"] <= 3 ? Colors.white : disabledBoldColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Avatar
                        CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage("${user["avatar"]}"),
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Username
                        Expanded(
                          child: Text(
                            "${user["username"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: user["isMe"] as bool ? FontWeight.bold : FontWeight.w600,
                              color: user["isMe"] as bool ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ),
                        
                        // Streak
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: warningColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${user["streak"]}",
                              style: TextStyle(
                                color: warningColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(width: spSm),
                        
                        // Points
                        Text(
                          "${user["points"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spSm),

            Container(
              width: double.infinity,
              child: QButton(
                label: "View Full Leaderboard",
                size: bs.sm,
                onPressed: () {
                  // Navigate to full leaderboard
                },
              ),
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }

  void _showPointsGuide() {
    // Show detailed points system guide
  }
}
