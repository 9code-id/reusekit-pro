import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaBattlePassView extends StatefulWidget {
  const GeaBattlePassView({super.key});

  @override
  State<GeaBattlePassView> createState() => _GeaBattlePassViewState();
}

class _GeaBattlePassViewState extends State<GeaBattlePassView> {
  int currentTier = 15;
  int currentXP = 750;
  int xpToNextTier = 1000;
  bool hasPremiumPass = true;

  List<Map<String, dynamic>> battlePassTiers = [
    {
      "tier": 1,
      "xpRequired": 100,
      "freeReward": {"type": "coins", "amount": 100, "icon": Icons.monetization_on},
      "premiumReward": {"type": "gems", "amount": 10, "icon": Icons.diamond},
      "unlocked": true,
    },
    {
      "tier": 2,
      "xpRequired": 200,
      "freeReward": {"type": "energy", "amount": 5, "icon": Icons.battery_full},
      "premiumReward": {"type": "skin", "name": "Warrior Helmet", "icon": Icons.sports_martial_arts},
      "unlocked": true,
    },
    {
      "tier": 3,
      "xpRequired": 300,
      "freeReward": {"type": "coins", "amount": 150, "icon": Icons.monetization_on},
      "premiumReward": {"type": "coins", "amount": 300, "icon": Icons.monetization_on},
      "unlocked": true,
    },
    {
      "tier": 4,
      "xpRequired": 400,
      "freeReward": {"type": "chest", "name": "Bronze Chest", "icon": Icons.inventory},
      "premiumReward": {"type": "gems", "amount": 25, "icon": Icons.diamond},
      "unlocked": true,
    },
    {
      "tier": 5,
      "xpRequired": 500,
      "freeReward": {"type": "energy", "amount": 10, "icon": Icons.battery_full},
      "premiumReward": {"type": "weapon", "name": "Fire Sword", "icon": Icons.whatshot},
      "unlocked": true,
    },
    {
      "tier": 10,
      "xpRequired": 1000,
      "freeReward": {"type": "coins", "amount": 250, "icon": Icons.monetization_on},
      "premiumReward": {"type": "skin", "name": "Elite Armor", "icon": Icons.security},
      "unlocked": true,
    },
    {
      "tier": 15,
      "xpRequired": 1500,
      "freeReward": {"type": "chest", "name": "Silver Chest", "icon": Icons.inventory},
      "premiumReward": {"type": "mount", "name": "Dragon Mount", "icon": Icons.pets},
      "unlocked": true,
    },
    {
      "tier": 20,
      "xpRequired": 2000,
      "freeReward": {"type": "gems", "amount": 30, "icon": Icons.diamond},
      "premiumReward": {"type": "emote", "name": "Victory Dance", "icon": Icons.celebration},
      "unlocked": false,
    },
    {
      "tier": 25,
      "xpRequired": 2500,
      "freeReward": {"type": "coins", "amount": 500, "icon": Icons.monetization_on},
      "premiumReward": {"type": "skin", "name": "Legendary Outfit", "icon": Icons.star},
      "unlocked": false,
    },
    {
      "tier": 30,
      "xpRequired": 3000,
      "freeReward": {"type": "chest", "name": "Gold Chest", "icon": Icons.inventory},
      "premiumReward": {"type": "weapon", "name": "Mythic Blade", "icon": Icons.flash_on},
      "unlocked": false,
    },
  ];

  Map<String, dynamic> battlePassInfo = {
    "season": "Season 5: Dragon's Ascent",
    "startDate": "2024-06-01",
    "endDate": "2024-08-31",
    "daysLeft": 45,
    "totalTiers": 100,
  };

  List<Map<String, dynamic>> weeklyMissions = [
    {
      "id": 1,
      "title": "Win 10 Matches",
      "description": "Win 10 ranked matches this week",
      "progress": 7,
      "target": 10,
      "xpReward": 500,
      "completed": false,
    },
    {
      "id": 2,
      "title": "Deal 50,000 Damage",
      "description": "Deal a total of 50,000 damage to enemies",
      "progress": 42350,
      "target": 50000,
      "xpReward": 300,
      "completed": false,
    },
    {
      "id": 3,
      "title": "Complete Daily Quests",
      "description": "Complete all daily quests for 5 days",
      "progress": 5,
      "target": 5,
      "xpReward": 400,
      "completed": true,
    },
    {
      "id": 4,
      "title": "Play With Friends",
      "description": "Play 5 matches with friends",
      "progress": 2,
      "target": 5,
      "xpReward": 200,
      "completed": false,
    },
  ];

  Color _getRewardColor(String type) {
    switch (type) {
      case "coins":
        return warningColor;
      case "gems":
        return primaryColor;
      case "energy":
        return infoColor;
      case "skin":
        return successColor;
      case "weapon":
        return dangerColor;
      case "chest":
        return warningColor;
      case "mount":
        return primaryColor;
      case "emote":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Battle Pass"),
        actions: [
          if (!hasPremiumPass)
            IconButton(
              icon: Icon(Icons.upgrade),
              onPressed: () {
                //navigateTo('BattlePassPurchaseView')
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Season Info Banner
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
                        Icons.military_tech,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${battlePassInfo["season"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${battlePassInfo["daysLeft"]} days remaining",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (hasPremiumPass)
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
                              fontSize: 10,
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
                        "Tier $currentTier / ${battlePassInfo["totalTiers"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "$currentXP / $xpToNextTier XP",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  LinearProgressIndicator(
                    value: currentXP / xpToNextTier,
                    backgroundColor: Colors.white.withAlpha(60),
                    valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                  ),
                ],
              ),
            ),

            // Battle Pass Rewards
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
                    "Tier Rewards",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  QHorizontalScroll(
                    children: battlePassTiers.map((tier) {
                      final isCurrentTier = tier["tier"] == currentTier;
                      final isUnlocked = tier["unlocked"] == true;
                      
                      return Container(
                        width: 200,
                        margin: EdgeInsets.only(right: spSm),
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isCurrentTier ? primaryColor.withAlpha(20) : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(radiusMd),
                          border: Border.all(
                            color: isCurrentTier ? primaryColor : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Tier ${tier["tier"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                if (isUnlocked)
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${tier["xpRequired"]} XP",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),

                            // Free Reward
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: Colors.grey.shade300,
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
                                  SizedBox(height: spXs),
                                  Icon(
                                    tier["freeReward"]["icon"],
                                    color: _getRewardColor(tier["freeReward"]["type"]),
                                    size: 24,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    tier["freeReward"]["amount"] != null
                                        ? "${tier["freeReward"]["amount"]} ${tier["freeReward"]["type"]}"
                                        : "${tier["freeReward"]["name"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: spXs),

                            // Premium Reward
                            Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: hasPremiumPass ? warningColor.withAlpha(20) : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(radiusSm),
                                border: Border.all(
                                  color: hasPremiumPass ? warningColor : Colors.grey.shade400,
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
                                          color: hasPremiumPass ? warningColor : disabledBoldColor,
                                        ),
                                      ),
                                      Spacer(),
                                      if (isUnlocked && hasPremiumPass)
                                        Icon(
                                          Icons.check,
                                          color: successColor,
                                          size: 12,
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Icon(
                                    tier["premiumReward"]["icon"],
                                    color: hasPremiumPass 
                                        ? _getRewardColor(tier["premiumReward"]["type"])
                                        : disabledBoldColor,
                                    size: 24,
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    tier["premiumReward"]["amount"] != null
                                        ? "${tier["premiumReward"]["amount"]} ${tier["premiumReward"]["type"]}"
                                        : "${tier["premiumReward"]["name"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: hasPremiumPass ? primaryColor : disabledBoldColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
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

            // Weekly Missions
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
                        "Weekly Missions",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
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
                          "Resets in 3 days",
                          style: TextStyle(
                            fontSize: 10,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  ...weeklyMissions.map((mission) {
                    final isCompleted = mission["completed"] == true;
                    final progress = mission["progress"] as num;
                    final target = mission["target"] as num;
                    final progressPercentage = progress / target;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCompleted ? successColor.withAlpha(20) : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isCompleted ? successColor : Colors.transparent,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${mission["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              if (isCompleted)
                                Icon(
                                  Icons.check_circle,
                                  color: successColor,
                                  size: 20,
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
                                    "+${mission["xpReward"]} XP",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: warningColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${mission["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
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
                              isCompleted ? successColor : primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Purchase Premium Pass (if not owned)
            if (!hasPremiumPass) ...[
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [warningColor, warningColor.withAlpha(150)],
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
                          Icons.star,
                          color: Colors.white,
                          size: 32,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upgrade to Premium",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Unlock all premium rewards and get 25% more XP",
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
                    Row(
                      children: [
                        Text(
                          "\$9.99",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: "Purchase Premium Pass",
                            size: bs.sm,
                            onPressed: () {
                              //navigateTo('BattlePassPurchaseView')
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
