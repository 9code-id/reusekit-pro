import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaProfileView extends StatefulWidget {
  const FwaProfileView({super.key});

  @override
  State<FwaProfileView> createState() => _FwaProfileViewState();
}

class _FwaProfileViewState extends State<FwaProfileView> {
  Map<String, dynamic> userProfile = {
    "name": "Alex Johnson",
    "email": "alex.johnson@email.com",
    "avatar": "https://picsum.photos/120/120?random=1&keyword=person",
    "joinDate": "2024-01-15",
    "plan": "Premium",
    "location": "San Francisco, CA",
    "bio": "Fitness enthusiast passionate about running and strength training. Always looking for new challenges!",
    "goals": ["Lose 10 lbs", "Run 5K under 25 min", "Increase bench press"],
    "achievements": 24,
    "totalWorkouts": 156,
    "totalDistance": 324.5,
    "caloriesBurned": 42850,
  };

  List<Map<String, dynamic>> stats = [
    {
      "title": "Total Workouts",
      "value": "156",
      "icon": Icons.fitness_center,
      "color": Colors.blue,
    },
    {
      "title": "Distance",
      "value": "324.5 km",
      "icon": Icons.directions_run,
      "color": Colors.green,
    },
    {
      "title": "Calories Burned",
      "value": "42,850",
      "icon": Icons.local_fire_department,
      "color": Colors.orange,
    },
    {
      "title": "Achievements",
      "value": "24",
      "icon": Icons.emoji_events,
      "color": Colors.amber,
    },
  ];

  List<Map<String, dynamic>> recentAchievements = [
    {
      "id": "1",
      "title": "5K Runner",
      "description": "Completed first 5K run",
      "icon": Icons.directions_run,
      "date": "2025-06-10",
      "color": Colors.blue,
    },
    {
      "id": "2",
      "title": "Consistency Master",
      "description": "7 days workout streak",
      "icon": Icons.calendar_today,
      "date": "2025-06-08", 
      "color": Colors.green,
    },
    {
      "id": "3",
      "title": "Calorie Burner",
      "description": "Burned 500+ calories in one session",
      "icon": Icons.local_fire_department,
      "date": "2025-06-05",
      "color": Colors.orange,
    },
  ];

  List<Map<String, dynamic>> personalBests = [
    {
      "exercise": "5K Run",
      "value": "24:35",
      "date": "2025-06-10",
      "improvement": "-1:20",
    },
    {
      "exercise": "Bench Press",
      "value": "85 kg",
      "date": "2025-06-08",
      "improvement": "+5 kg",
    },
    {
      "exercise": "Plank",
      "value": "3:45",
      "date": "2025-06-05",
      "improvement": "+0:30",
    },
    {
      "exercise": "Squat",
      "value": "120 kg",
      "date": "2025-06-03",
      "improvement": "+10 kg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          QButton(
            icon: Icons.edit,
            size: bs.sm,
            onPressed: () {
              ss("Navigate to edit profile");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spLg,
          children: [
            // Profile Header
            _buildProfileHeader(),
            
            // Quick Stats
            _buildQuickStats(),
            
            // Goals Section
            _buildGoalsSection(),
            
            // Personal Bests
            _buildPersonalBestsSection(),
            
            // Recent Achievements
            _buildAchievementsSection(),
            
            // Profile Actions
            _buildProfileActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryColor,
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "${userProfile["avatar"]}",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "${userProfile["name"]}",
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${userProfile["email"]}",
            style: TextStyle(
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spXs),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: spSm,
              vertical: spXs,
            ),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Text(
              "${userProfile["plan"]} Member",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: spSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: disabledBoldColor,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                "${userProfile["location"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${userProfile["bio"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 150,
      children: stats.map((stat) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (stat["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  stat["icon"] as IconData,
                  color: stat["color"] as Color,
                  size: 28,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "${stat["value"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "${stat["title"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGoalsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
                "Current Goals",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("Navigate to goals management");
                },
                child: Text(
                  "Manage",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...(userProfile["goals"] as List).map((goal) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.radio_button_unchecked,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "$goal",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                ],
              ),
            );
          }).toList(),
          SizedBox(height: spXs),
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Goal",
              size: bs.sm,
              onPressed: () {
                ss("Navigate to add new goal");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalBestsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
                Icons.trending_up,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Personal Bests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("View all personal bests");
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...personalBests.take(3).map((record) {
            bool isImprovement = record["improvement"].toString().startsWith("+") || 
                                record["improvement"].toString().startsWith("-");
            Color improvementColor = record["improvement"].toString().startsWith("+") ||
                                   record["improvement"].toString().startsWith("-")
                                     ? successColor
                                     : warningColor;

            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${record["exercise"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${record["date"]}",
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
                        "${record["value"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      if (isImprovement)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: improvementColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${record["improvement"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: improvementColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
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
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Recent Achievements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  ss("View all achievements");
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...recentAchievements.map((achievement) {
            return Container(
              padding: EdgeInsets.all(spSm),
              margin: EdgeInsets.only(bottom: spXs),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (achievement["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      achievement["icon"] as IconData,
                      color: achievement["color"] as Color,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${achievement["title"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${achievement["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "${achievement["date"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
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

  Widget _buildProfileActions() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Container(
            width: double.infinity,
            child: QButton(
              label: "Edit Profile",
              size: bs.md,
              onPressed: () {
                ss("Navigate to edit profile");
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Share Profile",
                  size: bs.sm,
                  onPressed: () {
                    ss("Share profile feature");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Export Data",
                  size: bs.sm,
                  onPressed: () {
                    ss("Navigate to data export");
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: QButton(
                  label: "Settings",
                  size: bs.sm,
                  onPressed: () {
                    ss("Navigate to settings");
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QButton(
                  label: "Help & Support",
                  size: bs.sm,
                  onPressed: () {
                    ss("Navigate to help center");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
