import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaPlayerProfileView extends StatefulWidget {
  const GeaPlayerProfileView({super.key});

  @override
  State<GeaPlayerProfileView> createState() => _GeaPlayerProfileViewState();
}

class _GeaPlayerProfileViewState extends State<GeaPlayerProfileView> {
  Map<String, dynamic> playerProfile = {
    "username": "ShadowHunter_92",
    "displayName": "Shadow Hunter",
    "level": 47,
    "experience": 28540,
    "experienceRequired": 35000,
    "avatar": "https://picsum.photos/120/120?random=1&keyword=avatar",
    "rank": "Diamond III",
    "rankIcon": Icons.diamond,
    "joinDate": "2023-03-15",
    "lastOnline": "2 hours ago",
    "region": "North America",
    "playtime": "234h 56m",
    "gamesPlayed": 1247,
    "winRate": 68.5,
    "favoriteMode": "Battle Royale"
  };

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Blood",
      "description": "Get your first kill",
      "icon": Icons.bloodtype,
      "unlocked": true,
      "unlockedDate": "2023-03-16",
      "rarity": "Common"
    },
    {
      "title": "Legendary Warrior",
      "description": "Reach Diamond rank",
      "icon": Icons.diamond,
      "unlocked": true,
      "unlockedDate": "2024-01-20",
      "rarity": "Legendary"
    },
    {
      "title": "Centurion",
      "description": "Win 100 matches",
      "icon": Icons.military_tech,
      "unlocked": true,
      "unlockedDate": "2023-12-05",
      "rarity": "Epic"
    },
    {
      "title": "Master Assassin",
      "description": "Get 1000 eliminations",
      "icon": Icons.api,
      "unlocked": false,
      "progress": 847,
      "required": 1000,
      "rarity": "Legendary"
    },
  ];

  List<Map<String, dynamic>> statistics = [
    {"label": "Total Kills", "value": "8,432", "icon": Icons.gps_fixed},
    {"label": "Total Deaths", "value": "3,241", "icon": Icons.clear},
    {"label": "K/D Ratio", "value": "2.60", "icon": Icons.trending_up},
    {"label": "Headshot %", "value": "34.2%", "icon": Icons.center_focus_strong},
    {"label": "Damage Dealt", "value": "2.1M", "icon": Icons.flash_on},
    {"label": "Healing Done", "value": "456K", "icon": Icons.favorite},
  ];

  List<Map<String, dynamic>> badges = [
    {"name": "Sharpshooter", "icon": Icons.gps_fixed, "color": Colors.orange},
    {"name": "Team Player", "icon": Icons.group, "color": Colors.blue},
    {"name": "Survivor", "icon": Icons.shield, "color": Colors.green},
    {"name": "Speed Demon", "icon": Icons.speed, "color": Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Profile shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildProfileHeader(),
            _buildLevelProgress(),
            _buildQuickStats(),
            _buildAchievements(),
            _buildStatistics(),
            _buildBadges(),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
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
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [shadowSm],
                ),
                child: ClipOval(
                  child: Image.network(
                    "${playerProfile["avatar"]}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${playerProfile["displayName"]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "@${playerProfile["username"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Row(
                      children: [
                        Icon(playerProfile["rankIcon"], color: Colors.amber, size: 20),
                        SizedBox(width: spXs),
                        Text(
                          "${playerProfile["rank"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    "Level",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "${playerProfile["level"]}",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              _buildProfileInfo("Joined", "${DateTime.parse(playerProfile["joinDate"]).dMMMy}"),
              SizedBox(width: spMd),
              _buildProfileInfo("Region", "${playerProfile["region"]}"),
              SizedBox(width: spMd),
              _buildProfileInfo("Playtime", "${playerProfile["playtime"]}"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelProgress() {
    double progress = (playerProfile["experience"] as int) / (playerProfile["experienceRequired"] as int);
    int remainingXP = (playerProfile["experienceRequired"] as int) - (playerProfile["experience"] as int);

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
          Row(
            children: [
              Icon(Icons.trending_up, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Level Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                "Level ${playerProfile["level"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "${playerProfile["experience"]} / ${playerProfile["experienceRequired"]} XP",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
          SizedBox(height: spSm),
          Text(
            "$remainingXP XP needed for next level",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
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
            "Quick Stats",
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
                child: _buildQuickStatCard("Games", "${playerProfile["gamesPlayed"]}", infoColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard("Win Rate", "${playerProfile["winRate"]}%", successColor),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickStatCard("Favorite", "${playerProfile["favoriteMode"]}", warningColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatCard(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
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
          Row(
            children: [
              Icon(Icons.emoji_events, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Achievements",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigate to all achievements
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: achievements.take(3).map((achievement) => _buildAchievementItem(achievement)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementItem(Map<String, dynamic> achievement) {
    bool isUnlocked = achievement["unlocked"] ?? false;
    Color rarityColor = _getRarityColor(achievement["rarity"]);

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: isUnlocked ? rarityColor.withAlpha(20) : Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: isUnlocked ? rarityColor.withAlpha(50) : Colors.grey.withAlpha(30),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: isUnlocked ? rarityColor : Colors.grey,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(
              achievement["icon"],
              size: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${achievement["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isUnlocked ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: rarityColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${achievement["rarity"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: rarityColor,
                        ),
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
                if (!isUnlocked && achievement.containsKey("progress"))
                  LinearProgressIndicator(
                    value: (achievement["progress"] as int) / (achievement["required"] as int),
                    backgroundColor: Colors.grey.withAlpha(30),
                    valueColor: AlwaysStoppedAnimation<Color>(rarityColor),
                  ),
              ],
            ),
          ),
          if (isUnlocked)
            Icon(Icons.check_circle, color: rarityColor, size: 20),
        ],
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "Common":
        return Colors.grey;
      case "Rare":
        return Colors.blue;
      case "Epic":
        return Colors.purple;
      case "Legendary":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatistics() {
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
            "Detailed Statistics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: statistics.map((stat) => _buildStatisticCard(stat)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard(Map<String, dynamic> stat) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(stat["icon"], color: primaryColor, size: 24),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${stat["value"]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${stat["label"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadges() {
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
            "Badges",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          QHorizontalScroll(
            children: badges.map((badge) => _buildBadgeItem(badge)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeItem(Map<String, dynamic> badge) {
    return Container(
      width: 80,
      margin: EdgeInsets.only(right: spSm),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: (badge["color"] as Color).withAlpha(20),
              shape: BoxShape.circle,
              border: Border.all(color: badge["color"] as Color, width: 2),
            ),
            child: Icon(
              badge["icon"],
              color: badge["color"] as Color,
              size: 30,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            "${badge["name"]}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    List<Map<String, dynamic>> activities = [
      {
        "action": "Completed Achievement",
        "detail": "Legendary Warrior",
        "time": "2 hours ago",
        "icon": Icons.emoji_events,
        "color": Colors.orange
      },
      {
        "action": "Ranked Match Victory",
        "detail": "Diamond III promotion",
        "time": "5 hours ago",
        "icon": Icons.trending_up,
        "color": Colors.green
      },
      {
        "action": "New Personal Best",
        "detail": "15 eliminations in one match",
        "time": "1 day ago",
        "icon": Icons.star,
        "color": Colors.blue
      },
    ];

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
            "Recent Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: activities.map((activity) => _buildActivityItem(activity)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spXs),
          decoration: BoxDecoration(
            color: (activity["color"] as Color).withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Icon(
            activity["icon"],
            size: 20,
            color: activity["color"] as Color,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${activity["action"]}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              Text(
                "${activity["detail"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        Text(
          "${activity["time"]}",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
