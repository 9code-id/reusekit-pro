import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaSeasonPassView extends StatefulWidget {
  const GeaSeasonPassView({super.key});

  @override
  State<GeaSeasonPassView> createState() => _GeaSeasonPassViewState();
}

class _GeaSeasonPassViewState extends State<GeaSeasonPassView> {
  String selectedTab = "Overview";
  int currentLevel = 25;
  int currentXP = 12450;
  int xpToNextLevel = 15000;
  bool hasSeasonPass = true;

  Map<String, dynamic> seasonInfo = {
    "name": "Eternal Winter",
    "number": 8,
    "startDate": "2024-06-01",
    "endDate": "2024-08-31",
    "daysLeft": 52,
    "maxLevel": 100,
    "theme": "Ice & Snow",
    "image": "https://picsum.photos/400/200?random=1&keyword=winter",
  };

  List<Map<String, dynamic>> seasonRewards = [
    {
      "level": 1,
      "xpRequired": 100,
      "freeReward": {"type": "coins", "amount": 500, "icon": Icons.monetization_on, "rarity": "common"},
      "premiumReward": {"type": "skin", "name": "Frost Guard Helmet", "icon": Icons.security, "rarity": "rare"},
      "unlocked": true,
    },
    {
      "level": 5,
      "xpRequired": 500,
      "freeReward": {"type": "energy", "amount": 50, "icon": Icons.battery_full, "rarity": "common"},
      "premiumReward": {"type": "emote", "name": "Snowball Fight", "icon": Icons.sports_esports, "rarity": "epic"},
      "unlocked": true,
    },
    {
      "level": 10,
      "xpRequired": 1000,
      "freeReward": {"type": "chest", "name": "Winter Chest", "icon": Icons.inventory, "rarity": "rare"},
      "premiumReward": {"type": "weapon", "name": "Icicle Sword", "icon": Icons.sports_esports, "rarity": "legendary"},
      "unlocked": true,
    },
    {
      "level": 15,
      "xpRequired": 1500,
      "freeReward": {"type": "gems", "amount": 100, "icon": Icons.diamond, "rarity": "rare"},
      "premiumReward": {"type": "mount", "name": "Ice Wolf", "icon": Icons.pets, "rarity": "epic"},
      "unlocked": true,
    },
    {
      "level": 20,
      "xpRequired": 2000,
      "freeReward": {"type": "coins", "amount": 1000, "icon": Icons.monetization_on, "rarity": "common"},
      "premiumReward": {"type": "skin", "name": "Frozen Warrior Set", "icon": Icons.person, "rarity": "legendary"},
      "unlocked": true,
    },
    {
      "level": 25,
      "xpRequired": 2500,
      "freeReward": {"type": "chest", "name": "Epic Winter Chest", "icon": Icons.inventory, "rarity": "epic"},
      "premiumReward": {"type": "wings", "name": "Crystalline Wings", "icon": Icons.airplanemode_active, "rarity": "legendary"},
      "unlocked": true,
    },
    {
      "level": 30,
      "xpRequired": 3000,
      "freeReward": {"type": "energy", "amount": 100, "icon": Icons.battery_full, "rarity": "rare"},
      "premiumReward": {"type": "pet", "name": "Snow Phoenix", "icon": Icons.flutter_dash, "rarity": "mythic"},
      "unlocked": false,
    },
    {
      "level": 50,
      "xpRequired": 5000,
      "freeReward": {"type": "gems", "amount": 250, "icon": Icons.diamond, "rarity": "epic"},
      "premiumReward": {"type": "title", "name": "Winter Champion", "icon": Icons.military_tech, "rarity": "legendary"},
      "unlocked": false,
    },
    {
      "level": 75,
      "xpRequired": 7500,
      "freeReward": {"type": "chest", "name": "Legendary Winter Chest", "icon": Icons.inventory, "rarity": "legendary"},
      "premiumReward": {"type": "skin", "name": "Ice Queen/King Set", "icon": Icons.star, "rarity": "mythic"},
      "unlocked": false,
    },
    {
      "level": 100,
      "xpRequired": 10000,
      "freeReward": {"type": "mount", "name": "Frost Dragon", "icon": Icons.pets, "rarity": "legendary"},
      "premiumReward": {"type": "exclusive", "name": "Eternal Winter Crown", "icon": Icons.workspace_premium, "rarity": "mythic"},
      "unlocked": false,
    },
  ];

  List<Map<String, dynamic>> weeklyTasks = [
    {
      "id": 1,
      "title": "Frostbite Victories",
      "description": "Win 15 matches in any game mode",
      "progress": 12,
      "target": 15,
      "xpReward": 1000,
      "type": "combat",
      "completed": false,
    },
    {
      "id": 2,
      "title": "Ice Breaker",
      "description": "Destroy 100 ice barriers",
      "progress": 85,
      "target": 100,
      "xpReward": 750,
      "type": "exploration",
      "completed": false,
    },
    {
      "id": 3,
      "title": "Winter Survivor",
      "description": "Survive 30 minutes in winter zones",
      "progress": 30,
      "target": 30,
      "xpReward": 800,
      "type": "survival",
      "completed": true,
    },
    {
      "id": 4,
      "title": "Seasonal Collection",
      "description": "Collect 50 winter artifacts",
      "progress": 23,
      "target": 50,
      "xpReward": 600,
      "type": "collection",
      "completed": false,
    },
  ];

  Color _getRarityColor(String rarity) {
    switch (rarity) {
      case "common":
        return disabledBoldColor;
      case "rare":
        return infoColor;
      case "epic":
        return primaryColor;
      case "legendary":
        return warningColor;
      case "mythic":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getTaskTypeColor(String type) {
    switch (type) {
      case "combat":
        return dangerColor;
      case "exploration":
        return successColor;
      case "survival":
        return warningColor;
      case "collection":
        return primaryColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Season Pass"),
        actions: [
          if (!hasSeasonPass)
            IconButton(
              icon: Icon(Icons.card_membership),
              onPressed: () {
                //navigateTo('SeasonPassPurchaseView')
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Season Header
          Container(
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("${seasonInfo["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withAlpha(180),
                    Colors.transparent,
                    Colors.black.withAlpha(180),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.all(spMd),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Season ${seasonInfo["number"]}: ${seasonInfo["name"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${seasonInfo["daysLeft"]} days remaining",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      if (hasSeasonPass)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "PREMIUM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Level $currentLevel",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "$currentXP / $xpToNextLevel XP",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: currentXP / xpToNextLevel,
                        backgroundColor: Colors.white.withAlpha(60),
                        valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tab Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: spMd),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Overview";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Overview" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Overview",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Overview" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Rewards";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Rewards" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Rewards",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Rewards" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Tasks";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selectedTab == "Tasks" ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        "Tasks",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == "Tasks" ? primaryColor : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: selectedTab == "Overview" 
                ? _buildOverviewView()
                : selectedTab == "Rewards"
                    ? _buildRewardsView()
                    : _buildTasksView(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Progress Stats
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: primaryColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$currentLevel",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Current Level",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${seasonRewards.where((r) => r["unlocked"] == true).length}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "Unlocked",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
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
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: successColor,
                        size: 32,
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${seasonInfo["daysLeft"]}",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Days Left",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Season Info
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Season Information",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
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
                            "Theme",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${seasonInfo["theme"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
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
                            "Max Level",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${seasonInfo["maxLevel"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${seasonInfo["startDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
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
                            "End Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${seasonInfo["endDate"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
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

          // Recent Rewards
          Container(
            padding: EdgeInsets.all(spSm),
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
                    Text(
                      "Recent Rewards",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        selectedTab = "Rewards";
                        setState(() {});
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QHorizontalScroll(
                  children: seasonRewards
                      .where((r) => r["unlocked"] == true)
                      .take(4)
                      .map((reward) => Container(
                            width: 120,
                            margin: EdgeInsets.only(right: spSm),
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: _getRarityColor(reward["premiumReward"]["rarity"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                              border: Border.all(
                                color: _getRarityColor(reward["premiumReward"]["rarity"]),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Icon(
                                    reward["premiumReward"]["icon"],
                                    color: _getRarityColor(reward["premiumReward"]["rarity"]),
                                    size: 24,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "Level ${reward["level"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  reward["premiumReward"]["amount"] != null
                                      ? "${reward["premiumReward"]["amount"]} ${reward["premiumReward"]["type"]}"
                                      : "${reward["premiumReward"]["name"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),

          // Purchase Season Pass (if not owned)
          if (!hasSeasonPass) ...[
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.card_membership,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Unlock Season Pass",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Get access to premium rewards and exclusive content",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Purchase for \$14.99",
                      size: bs.sm,
                      onPressed: () {
                        //navigateTo('SeasonPassPurchaseView')
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRewardsView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: seasonRewards.map((reward) {
          final isUnlocked = reward["unlocked"] == true;
          final isCurrentLevel = reward["level"] == currentLevel;
          
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: isCurrentLevel ? primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spXs),
                      decoration: BoxDecoration(
                        color: isUnlocked ? primaryColor : disabledBoldColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "LV ${reward["level"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${reward["xpRequired"]} XP Required",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    if (isUnlocked)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 20,
                      ),
                  ],
                ),
                SizedBox(height: spSm),
                Row(
                  children: [
                    // Free Reward
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getRarityColor(reward["freeReward"]["rarity"]),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "FREE",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (isUnlocked)
                                  Icon(
                                    Icons.check,
                                    color: successColor,
                                    size: 12,
                                  ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Icon(
                              reward["freeReward"]["icon"],
                              color: _getRarityColor(reward["freeReward"]["rarity"]),
                              size: 32,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              reward["freeReward"]["amount"] != null
                                  ? "${reward["freeReward"]["amount"]} ${reward["freeReward"]["type"]}"
                                  : "${reward["freeReward"]["name"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    // Premium Reward
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: hasSeasonPass 
                              ? _getRarityColor(reward["premiumReward"]["rarity"]).withAlpha(20)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: hasSeasonPass 
                                ? _getRarityColor(reward["premiumReward"]["rarity"])
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "PREMIUM",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: hasSeasonPass ? warningColor : disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (isUnlocked && hasSeasonPass)
                                  Icon(
                                    Icons.check,
                                    color: successColor,
                                    size: 12,
                                  ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Icon(
                              reward["premiumReward"]["icon"],
                              color: hasSeasonPass 
                                  ? _getRarityColor(reward["premiumReward"]["rarity"])
                                  : disabledBoldColor,
                              size: 32,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              reward["premiumReward"]["amount"] != null
                                  ? "${reward["premiumReward"]["amount"]} ${reward["premiumReward"]["type"]}"
                                  : "${reward["premiumReward"]["name"]}",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: hasSeasonPass ? primaryColor : disabledBoldColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTasksView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Weekly Tasks Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.assignment,
                  color: primaryColor,
                  size: 24,
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Weekly Tasks",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "Complete tasks to earn bonus XP",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spXs,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "Resets in 4 days",
                    style: TextStyle(
                      fontSize: 10,
                      color: infoColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tasks List
          ...weeklyTasks.map((task) {
            final isCompleted = task["completed"] == true;
            final progress = task["progress"] as num;
            final target = task["target"] as num;
            final progressPercentage = progress / target;
            
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(
                  color: isCompleted ? successColor : Colors.transparent,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spXs),
                        decoration: BoxDecoration(
                          color: _getTaskTypeColor(task["type"]).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          task["type"] == "combat" ? Icons.sports_esports :
                          task["type"] == "exploration" ? Icons.explore :
                          task["type"] == "survival" ? Icons.shield :
                          Icons.collections,
                          color: _getTaskTypeColor(task["type"]),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${task["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${task["description"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isCompleted)
                        Icon(
                          Icons.check_circle,
                          color: successColor,
                          size: 24,
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "+${task["xpReward"]} XP",
                            style: TextStyle(
                              fontSize: 10,
                              color: warningColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "$progress / $target",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${(progressPercentage * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: progressPercentage.clamp(0.0, 1.0),
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted ? successColor : _getTaskTypeColor(task["type"]),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
