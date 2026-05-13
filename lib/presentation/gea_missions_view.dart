import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaMissionsView extends StatefulWidget {
  const GeaMissionsView({super.key});

  @override
  State<GeaMissionsView> createState() => _GeaMissionsViewState();
}

class _GeaMissionsViewState extends State<GeaMissionsView> {
  int selectedCategory = 0;
  
  List<String> categories = ["Active", "Completed", "Available"];
  
  List<Map<String, dynamic>> activeMissions = [
    {
      "id": 1,
      "title": "Elimination Master",
      "description": "Eliminate 50 enemies in any game mode",
      "category": "Combat",
      "difficulty": "Medium",
      "progress": 34,
      "required": 50,
      "timeLimit": "3 days",
      "expiry": "2024-12-10",
      "rewards": [
        {"type": "xp", "amount": 1500, "icon": Icons.star, "color": Colors.purple},
        {"type": "coins", "amount": 300, "icon": Icons.monetization_on, "color": Colors.amber},
        {"type": "weapon_skin", "amount": 1, "icon": Icons.sports_kabaddi, "color": Colors.blue}
      ],
      "priority": "High"
    },
    {
      "id": 2,
      "title": "Team Supporter",
      "description": "Assist teammates 25 times",
      "category": "Teamwork",
      "difficulty": "Easy",
      "progress": 18,
      "required": 25,
      "timeLimit": "2 days",
      "expiry": "2024-12-09",
      "rewards": [
        {"type": "xp", "amount": 800, "icon": Icons.star, "color": Colors.purple},
        {"type": "gems", "amount": 15, "icon": Icons.diamond, "color": Colors.cyan}
      ],
      "priority": "Medium"
    },
    {
      "id": 3,
      "title": "Survival Expert",
      "description": "Survive for 20 minutes in Battle Royale mode",
      "category": "Survival",
      "difficulty": "Hard",
      "progress": 12,
      "required": 20,
      "timeLimit": "5 days",
      "expiry": "2024-12-12",
      "rewards": [
        {"type": "xp", "amount": 2000, "icon": Icons.star, "color": Colors.purple},
        {"type": "coins", "amount": 500, "icon": Icons.monetization_on, "color": Colors.amber},
        {"type": "title", "amount": 1, "icon": Icons.title, "color": Colors.orange}
      ],
      "priority": "High"
    },
    {
      "id": 4,
      "title": "Precision Shooter",
      "description": "Get 15 headshots with sniper rifles",
      "category": "Combat",
      "difficulty": "Medium",
      "progress": 9,
      "required": 15,
      "timeLimit": "4 days",
      "expiry": "2024-12-11",
      "rewards": [
        {"type": "xp", "amount": 1200, "icon": Icons.star, "color": Colors.purple},
        {"type": "sniper_skin", "amount": 1, "icon": Icons.gps_fixed, "color": Colors.red}
      ],
      "priority": "Medium"
    }
  ];

  List<Map<String, dynamic>> completedMissions = [
    {
      "title": "First Blood",
      "description": "Get your first elimination",
      "category": "Combat",
      "difficulty": "Easy",
      "completedDate": "2024-12-01",
      "rewards": ["100 XP", "50 Coins"],
      "timeTaken": "5 minutes"
    },
    {
      "title": "Victory Royale",
      "description": "Win a Battle Royale match",
      "category": "Victory",
      "difficulty": "Hard",
      "completedDate": "2024-12-03",
      "rewards": ["500 XP", "200 Coins", "Victory Badge"],
      "timeTaken": "2 hours"
    },
    {
      "title": "Social Butterfly",
      "description": "Add 5 friends to your friend list",
      "category": "Social",
      "difficulty": "Easy",
      "completedDate": "2024-12-04",
      "rewards": ["200 XP", "Friend Badge"],
      "timeTaken": "1 day"
    }
  ];

  List<Map<String, dynamic>> availableMissions = [
    {
      "title": "Demolition Expert",
      "description": "Destroy 10 vehicles with explosives",
      "category": "Combat",
      "difficulty": "Medium",
      "unlockRequirement": "Reach Level 15",
      "rewards": ["1000 XP", "300 Coins", "Explosive Badge"],
      "estimatedTime": "2-3 hours"
    },
    {
      "title": "Lone Wolf",
      "description": "Win 3 solo matches without dying",
      "category": "Survival",
      "difficulty": "Extreme",
      "unlockRequirement": "Complete 'Survival Expert'",
      "rewards": ["3000 XP", "1000 Coins", "Lone Wolf Title"],
      "estimatedTime": "5-10 hours"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Missions"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Missions refreshed");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildMissionStats(),
            _buildCategoryFilter(),
            _buildMissionContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionStats() {
    int activeCount = activeMissions.length;
    int completedCount = completedMissions.length;
    int availableCount = availableMissions.length;
    int totalXP = completedMissions.fold(0, (sum, mission) => sum + 500); // Mock calculation

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
            "Mission Overview",
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
                child: _buildStatCard("Active", "$activeCount", infoColor, Icons.assignment),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Completed", "$completedCount", successColor, Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Available", "$availableCount", warningColor, Icons.assignment_outlined),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildStatCard("Total XP", "${((totalXP as int).toDouble()).currency}", primaryColor, Icons.star),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: QCategoryPicker(
        items: categories.asMap().entries.map((entry) {
          return {
            "label": entry.value,
            "value": entry.key,
          };
        }).toList(),
        value: selectedCategory,
        onChanged: (index, label, value, item) {
          selectedCategory = value;
          setState(() {});
        },
      ),
    );
  }

  Widget _buildMissionContent() {
    switch (selectedCategory) {
      case 0:
        return _buildActiveMissions();
      case 1:
        return _buildCompletedMissions();
      case 2:
        return _buildAvailableMissions();
      default:
        return _buildActiveMissions();
    }
  }

  Widget _buildActiveMissions() {
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
              Icon(Icons.assignment, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Active Missions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spMd,
            children: activeMissions.map((mission) => _buildActiveMissionCard(mission)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveMissionCard(Map<String, dynamic> mission) {
    double progress = (mission["progress"] as int) / (mission["required"] as int);
    Color priorityColor = _getPriorityColor(mission["priority"]);
    Color difficultyColor = _getDifficultyColor(mission["difficulty"]);
    bool isExpiringSoon = DateTime.parse(mission["expiry"]).difference(DateTime.now()).inHours < 24;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: priorityColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: priorityColor.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${mission["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        _buildPriorityBadge(mission["priority"]),
                        SizedBox(width: spXs),
                        _buildDifficultyBadge(mission["difficulty"]),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${mission["description"]}",
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
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.category, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${mission["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.timer, size: 16, color: isExpiringSoon ? dangerColor : disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${mission["timeLimit"]} left",
                style: TextStyle(
                  fontSize: 12,
                  color: isExpiringSoon ? dangerColor : disabledBoldColor,
                  fontWeight: isExpiringSoon ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Progress: ${mission["progress"]}/${mission["required"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(priorityColor),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rewards:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (mission["rewards"] as List).map((reward) => 
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: (reward["color"] as Color).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(reward["icon"], size: 14, color: reward["color"]),
                        SizedBox(width: spXs),
                        Text(
                          "${reward["amount"]} ${_getRewardName(reward["type"])}",
                          style: TextStyle(
                            fontSize: 12,
                            color: reward["color"],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedMissions() {
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
              Icon(Icons.check_circle, color: successColor),
              SizedBox(width: spSm),
              Text(
                "Completed Missions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: completedMissions.map((mission) => _buildCompletedMissionCard(mission)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedMissionCard(Map<String, dynamic> mission) {
    Color difficultyColor = _getDifficultyColor(mission["difficulty"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: successColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: successColor, size: 32),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${mission["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    _buildDifficultyBadge(mission["difficulty"]),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "${mission["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Icon(Icons.category, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "${mission["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Icon(Icons.schedule, size: 14, color: disabledBoldColor),
                    SizedBox(width: spXs),
                    Text(
                      "Completed in ${mission["timeTaken"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Text(
                  "Rewards: ${(mission["rewards"] as List<String>).join(", ")}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Completed",
                style: TextStyle(
                  fontSize: 12,
                  color: successColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${DateTime.parse(mission["completedDate"]).dMMMy}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableMissions() {
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
              Icon(Icons.assignment_outlined, color: warningColor),
              SizedBox(width: spSm),
              Text(
                "Available Missions",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: availableMissions.map((mission) => _buildAvailableMissionCard(mission)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableMissionCard(Map<String, dynamic> mission) {
    Color difficultyColor = _getDifficultyColor(mission["difficulty"]);

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${mission["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        _buildDifficultyBadge(mission["difficulty"]),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${mission["description"]}",
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
          SizedBox(height: spMd),
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Icon(Icons.lock, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Text(
                    "Unlock requirement: ${mission["unlockRequirement"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: warningColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Icon(Icons.category, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${mission["category"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.timer, size: 14, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Est. ${mission["estimatedTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "Rewards: ${(mission["rewards"] as List<String>).join(", ")}",
            style: TextStyle(
              fontSize: 12,
              color: infoColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = _getPriorityColor(priority);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge(String difficulty) {
    Color color = _getDifficultyColor(difficulty);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(radiusXs),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return dangerColor;
      case "Medium":
        return warningColor;
      case "Low":
        return successColor;
      default:
        return infoColor;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Easy":
        return successColor;
      case "Medium":
        return warningColor;
      case "Hard":
        return dangerColor;
      case "Extreme":
        return Colors.purple;
      default:
        return infoColor;
    }
  }

  String _getRewardName(String type) {
    switch (type) {
      case "xp":
        return "XP";
      case "coins":
        return "Coins";
      case "gems":
        return "Gems";
      case "weapon_skin":
        return "Weapon Skin";
      case "sniper_skin":
        return "Sniper Skin";
      case "title":
        return "Title";
      default:
        return type;
    }
  }
}
