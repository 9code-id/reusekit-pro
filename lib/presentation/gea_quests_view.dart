import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaQuestsView extends StatefulWidget {
  const GeaQuestsView({super.key});

  @override
  State<GeaQuestsView> createState() => _GeaQuestsViewState();
}

class _GeaQuestsViewState extends State<GeaQuestsView> {
  int selectedCategory = 0;
  
  List<String> categories = ["Main Story", "Side Quests", "Daily Quests", "Weekly"];
  
  List<Map<String, dynamic>> mainStoryQuests = [
    {
      "id": 1,
      "title": "The Awakening",
      "description": "Discover your true potential and unlock your first special ability",
      "chapter": "Chapter 1",
      "status": "completed",
      "difficulty": "Easy",
      "estimatedTime": "30 minutes",
      "rewards": [
        {"type": "xp", "amount": 500, "icon": Icons.star, "color": Colors.purple},
        {"type": "coins", "amount": 200, "icon": Icons.monetization_on, "color": Colors.amber},
        {"type": "ability", "amount": 1, "icon": Icons.flash_on, "color": Colors.orange}
      ],
      "prerequisites": [],
      "completionDate": "2024-11-20"
    },
    {
      "id": 2,
      "title": "First Contact",
      "description": "Meet the mysterious stranger who will guide your journey",
      "chapter": "Chapter 1",
      "status": "completed",
      "difficulty": "Easy",
      "estimatedTime": "25 minutes",
      "rewards": [
        {"type": "xp", "amount": 600, "icon": Icons.star, "color": Colors.purple},
        {"type": "companion", "amount": 1, "icon": Icons.person_add, "color": Colors.blue}
      ],
      "prerequisites": ["The Awakening"],
      "completionDate": "2024-11-21"
    },
    {
      "id": 3,
      "title": "Trial by Fire",
      "description": "Face your first real challenge in the ancient temple",
      "chapter": "Chapter 2",
      "status": "active",
      "difficulty": "Medium",
      "estimatedTime": "45 minutes",
      "progress": 3,
      "required": 5,
      "currentObjective": "Defeat 3 temple guardians",
      "rewards": [
        {"type": "xp", "amount": 1000, "icon": Icons.star, "color": Colors.purple},
        {"type": "coins", "amount": 400, "icon": Icons.monetization_on, "color": Colors.amber},
        {"type": "artifact", "amount": 1, "icon": Icons.auto_awesome, "color": Colors.cyan}
      ],
      "prerequisites": ["First Contact"]
    },
    {
      "id": 4,
      "title": "The Lost City",
      "description": "Explore the ruins of an ancient civilization",
      "chapter": "Chapter 2",
      "status": "locked",
      "difficulty": "Hard",
      "estimatedTime": "60 minutes",
      "rewards": [
        {"type": "xp", "amount": 1500, "icon": Icons.star, "color": Colors.purple},
        {"type": "rare_item", "amount": 1, "icon": Icons.diamond, "color": Colors.blue}
      ],
      "prerequisites": ["Trial by Fire"]
    }
  ];

  List<Map<String, dynamic>> sideQuests = [
    {
      "title": "The Merchant's Request",
      "description": "Help the traveling merchant recover his stolen goods",
      "location": "Forest Village",
      "status": "available",
      "difficulty": "Easy",
      "estimatedTime": "20 minutes",
      "rewards": [
        {"type": "coins", "amount": 150, "icon": Icons.monetization_on, "color": Colors.amber},
        {"type": "item", "amount": 3, "icon": Icons.inventory, "color": Colors.green}
      ],
      "giver": "Merchant Kane",
      "level": 5
    },
    {
      "title": "Herb Collection",
      "description": "Gather rare herbs for the village healer",
      "location": "Mystic Woods",
      "status": "active",
      "difficulty": "Easy",
      "estimatedTime": "15 minutes",
      "progress": 4,
      "required": 8,
      "currentObjective": "Collect moonflower petals (4/8)",
      "rewards": [
        {"type": "xp", "amount": 300, "icon": Icons.star, "color": Colors.purple},
        {"type": "potion", "amount": 2, "icon": Icons.local_drink, "color": Colors.red}
      ],
      "giver": "Healer Aria",
      "level": 3
    },
    {
      "title": "Ancient Runes",
      "description": "Decipher the mysterious runes found in the old library",
      "location": "Royal Library",
      "status": "completed",
      "difficulty": "Medium",
      "estimatedTime": "35 minutes",
      "rewards": ["400 XP", "Knowledge Scroll", "Scholar Badge"],
      "giver": "Librarian Eldric",
      "level": 8,
      "completionDate": "2024-11-25"
    }
  ];

  List<Map<String, dynamic>> dailyQuests = [
    {
      "title": "Training Regimen",
      "description": "Complete your daily combat training",
      "status": "available",
      "progress": 0,
      "required": 1,
      "timeRemaining": "18h 32m",
      "rewards": [
        {"type": "xp", "amount": 100, "icon": Icons.star, "color": Colors.purple},
        {"type": "coins", "amount": 50, "icon": Icons.monetization_on, "color": Colors.amber}
      ]
    },
    {
      "title": "Resource Gathering",
      "description": "Collect 10 wood and 5 stone",
      "status": "active",
      "progress": 7,
      "required": 15,
      "timeRemaining": "18h 32m",
      "currentObjective": "Gather resources (7/15)",
      "rewards": [
        {"type": "xp", "amount": 80, "icon": Icons.star, "color": Colors.purple},
        {"type": "materials", "amount": 5, "icon": Icons.build, "color": Colors.brown}
      ]
    },
    {
      "title": "Monster Slaying",
      "description": "Defeat 5 monsters in any location",
      "status": "completed",
      "progress": 5,
      "required": 5,
      "timeRemaining": "18h 32m",
      "rewards": ["120 XP", "3 Health Potions"],
      "completionDate": "Today"
    }
  ];

  List<Map<String, dynamic>> weeklyQuests = [
    {
      "title": "Dungeon Explorer",
      "description": "Complete 3 different dungeons this week",
      "status": "active",
      "progress": 1,
      "required": 3,
      "timeRemaining": "4 days",
      "currentObjective": "Clear dungeons (1/3)",
      "rewards": [
        {"type": "xp", "amount": 800, "icon": Icons.star, "color": Colors.purple},
        {"type": "epic_chest", "amount": 1, "icon": Icons.inventory, "color": Colors.purple}
      ]
    },
    {
      "title": "Social Connector",
      "description": "Complete 5 quests with party members",
      "status": "available",
      "progress": 0,
      "required": 5,
      "timeRemaining": "4 days",
      "rewards": [
        {"type": "friendship_points", "amount": 100, "icon": Icons.favorite, "color": Colors.pink},
        {"type": "social_badge", "amount": 1, "icon": Icons.group, "color": Colors.blue}
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quests"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              // Navigate to quest map
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildQuestOverview(),
            _buildCategoryFilter(),
            _buildQuestContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestOverview() {
    int activeQuests = 5;
    int completedToday = 3;
    int totalCompleted = 47;
    int availableQuests = 12;

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
            "Quest Overview",
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
                child: _buildOverviewCard("Active", "$activeQuests", infoColor, Icons.assignment),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Completed Today", "$completedToday", successColor, Icons.today),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Total Completed", "$totalCompleted", primaryColor, Icons.check_circle),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildOverviewCard("Available", "$availableQuests", warningColor, Icons.assignment_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String label, String value, Color color, IconData icon) {
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
              fontSize: 16,
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

  Widget _buildQuestContent() {
    switch (selectedCategory) {
      case 0:
        return _buildMainStoryQuests();
      case 1:
        return _buildSideQuests();
      case 2:
        return _buildDailyQuests();
      case 3:
        return _buildWeeklyQuests();
      default:
        return _buildMainStoryQuests();
    }
  }

  Widget _buildMainStoryQuests() {
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
              Icon(Icons.menu_book, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Main Story Quests",
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
            children: mainStoryQuests.map((quest) => _buildMainStoryQuestCard(quest)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMainStoryQuestCard(Map<String, dynamic> quest) {
    Color statusColor = _getStatusColor(quest["status"]);
    bool isActive = quest["status"] == "active";
    bool isCompleted = quest["status"] == "completed";
    bool isLocked = quest["status"] == "locked";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
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
                          "${quest["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${quest["chapter"]}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                        SizedBox(width: spXs),
                        _buildDifficultyBadge(quest["difficulty"]),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${quest["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusIcon(quest["status"]),
            ],
          ),
          if (isActive && quest.containsKey("progress")) ...[
            SizedBox(height: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${quest["currentObjective"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Text(
                      "Progress: ${quest["progress"]}/${quest["required"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${((quest["progress"] as int) / (quest["required"] as int) * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (quest["progress"] as int) / (quest["required"] as int),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ],
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${quest["estimatedTime"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              if (isCompleted) ...[
                SizedBox(width: spMd),
                Icon(Icons.check, size: 16, color: successColor),
                SizedBox(width: spXs),
                Text(
                  "Completed ${quest["completionDate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
          if (isLocked) ...[
            SizedBox(height: spSm),
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
                      "Prerequisites: ${(quest["prerequisites"] as List<String>).join(", ")}",
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
          ],
          SizedBox(height: spMd),
          Wrap(
            spacing: spXs,
            runSpacing: spXs,
            children: (quest["rewards"] as List).map((reward) => 
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
    );
  }

  Widget _buildSideQuests() {
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
              Icon(Icons.explore, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Side Quests",
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
            children: sideQuests.map((quest) => _buildSideQuestCard(quest)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSideQuestCard(Map<String, dynamic> quest) {
    Color statusColor = _getStatusColor(quest["status"]);
    bool isActive = quest["status"] == "active";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
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
                          "${quest["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        _buildDifficultyBadge(quest["difficulty"]),
                      ],
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${quest["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusIcon(quest["status"]),
            ],
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${quest["location"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.person, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "${quest["giver"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spMd),
              Icon(Icons.trending_up, size: 16, color: disabledBoldColor),
              SizedBox(width: spXs),
              Text(
                "Lv.${quest["level"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          if (isActive && quest.containsKey("progress")) ...[
            SizedBox(height: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${quest["currentObjective"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (quest["progress"] as int) / (quest["required"] as int),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ],
          SizedBox(height: spMd),
          if (quest["status"] == "completed")
            Text(
              "Rewards: ${(quest["rewards"] as List<String>).join(", ")}",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            Wrap(
              spacing: spXs,
              children: (quest["rewards"] as List).map((reward) => 
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
    );
  }

  Widget _buildDailyQuests() {
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
              Icon(Icons.today, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Daily Quests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Resets in 18h 32m",
                  style: TextStyle(
                    fontSize: 12,
                    color: infoColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: dailyQuests.map((quest) => _buildDailyQuestCard(quest)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyQuestCard(Map<String, dynamic> quest) {
    Color statusColor = _getStatusColor(quest["status"]);
    bool isActive = quest["status"] == "active";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
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
                    Text(
                      "${quest["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${quest["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusIcon(quest["status"]),
            ],
          ),
          if (isActive && quest.containsKey("currentObjective")) ...[
            SizedBox(height: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${quest["currentObjective"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (quest["progress"] as int) / (quest["required"] as int),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ],
          SizedBox(height: spMd),
          if (quest["status"] == "completed")
            Text(
              "Rewards: ${(quest["rewards"] as List<String>).join(", ")}",
              style: TextStyle(
                fontSize: 12,
                color: successColor,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            Wrap(
              spacing: spXs,
              children: (quest["rewards"] as List).map((reward) => 
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
    );
  }

  Widget _buildWeeklyQuests() {
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
              Icon(Icons.date_range, color: primaryColor),
              SizedBox(width: spSm),
              Text(
                "Weekly Quests",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: warningColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "Resets in 4 days",
                  style: TextStyle(
                    fontSize: 12,
                    color: warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            spacing: spSm,
            children: weeklyQuests.map((quest) => _buildWeeklyQuestCard(quest)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyQuestCard(Map<String, dynamic> quest) {
    Color statusColor = _getStatusColor(quest["status"]);
    bool isActive = quest["status"] == "active";

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: statusColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: statusColor.withAlpha(30)),
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
                    Text(
                      "${quest["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${quest["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusIcon(quest["status"]),
            ],
          ),
          if (isActive && quest.containsKey("currentObjective")) ...[
            SizedBox(height: spMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${quest["currentObjective"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: (quest["progress"] as int) / (quest["required"] as int),
                  backgroundColor: disabledColor,
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ],
            ),
          ],
          SizedBox(height: spMd),
          Wrap(
            spacing: spXs,
            children: (quest["rewards"] as List).map((reward) => 
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

  Widget _buildStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icon(Icons.check_circle, color: successColor, size: 24);
      case "active":
        return Icon(Icons.play_circle, color: infoColor, size: 24);
      case "available":
        return Icon(Icons.radio_button_unchecked, color: warningColor, size: 24);
      case "locked":
        return Icon(Icons.lock, color: disabledBoldColor, size: 24);
      default:
        return Icon(Icons.help, color: disabledBoldColor, size: 24);
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return successColor;
      case "active":
        return infoColor;
      case "available":
        return warningColor;
      case "locked":
        return disabledBoldColor;
      default:
        return primaryColor;
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
      default:
        return primaryColor;
    }
  }

  String _getRewardName(String type) {
    switch (type) {
      case "xp":
        return "XP";
      case "coins":
        return "Coins";
      case "ability":
        return "Ability";
      case "companion":
        return "Companion";
      case "artifact":
        return "Artifact";
      case "rare_item":
        return "Rare Item";
      case "item":
        return "Items";
      case "potion":
        return "Potions";
      case "materials":
        return "Materials";
      case "epic_chest":
        return "Epic Chest";
      case "friendship_points":
        return "Friendship Points";
      case "social_badge":
        return "Social Badge";
      default:
        return type;
    }
  }
}
