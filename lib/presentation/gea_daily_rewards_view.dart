import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaDailyRewardsView extends StatefulWidget {
  const GeaDailyRewardsView({super.key});

  @override
  State<GeaDailyRewardsView> createState() => _GeaDailyRewardsViewState();
}

class _GeaDailyRewardsViewState extends State<GeaDailyRewardsView> {
  int currentDay = 3; // Current day in the streak
  int totalStreak = 15; // Total streak days
  bool canClaim = true; // Whether today's reward can be claimed

  List<Map<String, dynamic>> dailyRewards = [
    {
      "day": 1,
      "type": "coins",
      "amount": 100,
      "icon": Icons.monetization_on,
      "color": Colors.amber,
      "claimed": true,
      "title": "Daily Coins",
    },
    {
      "day": 2,
      "type": "gems",
      "amount": 5,
      "icon": Icons.diamond,
      "color": Colors.blue,
      "claimed": true,
      "title": "Precious Gems",
    },
    {
      "day": 3,
      "type": "coins",
      "amount": 150,
      "icon": Icons.monetization_on,
      "color": Colors.amber,
      "claimed": false,
      "title": "Extra Coins",
    },
    {
      "day": 4,
      "type": "energy",
      "amount": 10,
      "icon": Icons.battery_charging_full,
      "color": Colors.green,
      "claimed": false,
      "title": "Energy Boost",
    },
    {
      "day": 5,
      "type": "chest",
      "amount": 1,
      "icon": Icons.inbox,
      "color": Colors.brown,
      "claimed": false,
      "title": "Mystery Chest",
    },
    {
      "day": 6,
      "type": "gems",
      "amount": 10,
      "icon": Icons.diamond,
      "color": Colors.blue,
      "claimed": false,
      "title": "Gem Bonus",
    },
    {
      "day": 7,
      "type": "legendary",
      "amount": 1,
      "icon": Icons.star,
      "color": Colors.purple,
      "claimed": false,
      "title": "Legendary Reward",
    },
  ];

  List<Map<String, dynamic>> weeklyRewards = [
    {
      "week": 1,
      "type": "weapon",
      "title": "Epic Sword",
      "description": "A powerful weapon for your adventures",
      "icon": Icons.security,
      "color": Colors.red,
      "claimed": false,
      "requirement": 7,
    },
    {
      "week": 2,
      "type": "armor",
      "title": "Dragon Scale Armor",
      "description": "Legendary protection from dragon scales",
      "icon": Icons.shield,
      "color": Colors.indigo,
      "claimed": false,
      "requirement": 14,
    },
    {
      "week": 3,
      "type": "mount",
      "title": "Flying Griffin",
      "description": "Soar through the skies on this majestic creature",
      "icon": Icons.pets,
      "color": Colors.orange,
      "claimed": false,
      "requirement": 21,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Steps",
      "description": "Complete your first daily login",
      "progress": 1,
      "maxProgress": 1,
      "completed": true,
      "reward": "50 coins",
      "icon": Icons.directions_walk,
    },
    {
      "title": "Week Warrior",
      "description": "Login for 7 consecutive days",
      "progress": 3,
      "maxProgress": 7,
      "completed": false,
      "reward": "Premium Chest",
      "icon": Icons.calendar_view_week,
    },
    {
      "title": "Dedication Master",
      "description": "Login for 30 consecutive days",
      "progress": 15,
      "maxProgress": 30,
      "completed": false,
      "reward": "Legendary Item",
      "icon": Icons.emoji_events,
    },
    {
      "title": "Loyalty Legend",
      "description": "Login for 100 consecutive days",
      "progress": 15,
      "maxProgress": 100,
      "completed": false,
      "reward": "Exclusive Title + Mount",
      "icon": Icons.military_tech,
    },
  ];

  void _claimDailyReward() {
    if (canClaim && currentDay <= dailyRewards.length) {
      setState(() {
        dailyRewards[currentDay - 1]["claimed"] = true;
        canClaim = false;
        totalStreak++;
      });
      
      final reward = dailyRewards[currentDay - 1];
      ss("Claimed ${reward["amount"]} ${reward["type"]}!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Rewards"),
        actions: [
          QButton(
            icon: Icons.history,
            size: bs.sm,
            onPressed: () {
              si("View reward history");
            },
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Streak Counter
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(25),
                    successColor.withAlpha(25),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                        size: 24,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Current Streak",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "$totalStreak Days",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Keep it up! Your dedication is rewarded",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),

            // Daily Rewards
            Container(
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
                        Icons.card_giftcard,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Daily Rewards",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Login every day to claim amazing rewards!",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  
                  // Daily Reward Grid
                  ResponsiveGridView(
                    padding: EdgeInsets.only(top: spSm),
                    minItemWidth: 200,
                    children: List.generate(dailyRewards.length, (index) {
                      final reward = dailyRewards[index];
                      final isToday = (reward["day"] as int) == currentDay;
                      final isClaimed = reward["claimed"] as bool;
                      final isAvailable = (reward["day"] as int) <= currentDay;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isToday 
                              ? primaryColor.withAlpha(25)
                              : isClaimed 
                                  ? Colors.grey[100]
                                  : Colors.grey[50],
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isToday 
                                ? primaryColor
                                : disabledOutlineBorderColor,
                            width: isToday ? 2 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Day ${reward["day"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isToday ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                                Spacer(),
                                if (isClaimed) ...[
                                  Icon(
                                    Icons.check_circle,
                                    color: successColor,
                                    size: 16,
                                  ),
                                ] else if (isToday && canClaim) ...[
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusLg),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: (reward["color"] as Color).withAlpha(25),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                reward["icon"] as IconData,
                                color: reward["color"] as Color,
                                size: 20,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${reward["title"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${reward["amount"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: reward["color"] as Color,
                              ),
                            ),
                            SizedBox(height: spXs),
                            if (isToday && canClaim && !isClaimed) ...[
                              Container(
                                width: double.infinity,
                                child: QButton(
                                  label: "Claim",
                                  size: bs.sm,
                                  onPressed: _claimDailyReward,
                                ),
                              ),
                            ] else if (isClaimed) ...[
                              Text(
                                "Claimed",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ] else if (!isAvailable) ...[
                              Text(
                                "Locked",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ] else ...[
                              Text(
                                "Available",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Weekly Milestones
            Container(
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
                        color: warningColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Weekly Milestones",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Reach weekly goals to unlock exclusive rewards",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  ...List.generate(weeklyRewards.length, (index) {
                    final reward = weeklyRewards[index];
                    final progress = (totalStreak / (reward["requirement"] as int)).clamp(0.0, 1.0);
                    final isCompleted = totalStreak >= (reward["requirement"] as int);
                    final isClaimed = reward["claimed"] as bool;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? (reward["color"] as Color).withAlpha(25)
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isCompleted 
                              ? reward["color"] as Color
                              : disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: (reward["color"] as Color).withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              reward["icon"] as IconData,
                              color: reward["color"] as Color,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${reward["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${reward["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: progress,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: reward["color"] as Color,
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "$totalStreak/${reward["requirement"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: reward["color"] as Color,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isCompleted && !isClaimed) ...[
                            QButton(
                              label: "Claim",
                              size: bs.sm,
                              onPressed: () {
                                setState(() {
                                  weeklyRewards[index]["claimed"] = true;
                                });
                                ss("Claimed ${reward["title"]}!");
                              },
                            ),
                          ] else if (isClaimed) ...[
                            Icon(
                              Icons.check_circle,
                              color: successColor,
                              size: 24,
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Achievements
            Container(
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
                        Icons.stars,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Login Achievements",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...List.generate(achievements.length, (index) {
                    final achievement = achievements[index];
                    final progress = (achievement["progress"] as int) / (achievement["maxProgress"] as int);
                    final isCompleted = achievement["completed"] as bool;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCompleted 
                            ? successColor.withAlpha(25)
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: isCompleted 
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
                                  ? successColor.withAlpha(25)
                                  : disabledColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              achievement["icon"] as IconData,
                              color: isCompleted ? successColor : disabledBoldColor,
                              size: 20,
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
                                        "${achievement["title"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (isCompleted) ...[
                                      Icon(
                                        Icons.check_circle,
                                        color: successColor,
                                        size: 16,
                                      ),
                                    ],
                                  ],
                                ),
                                Text(
                                  "${achievement["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                if (!isCompleted) ...[
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: FractionallySizedBox(
                                            alignment: Alignment.centerLeft,
                                            widthFactor: progress,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${achievement["progress"]}/${achievement["maxProgress"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                SizedBox(height: 2),
                                Text(
                                  "Reward: ${achievement["reward"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            // Next Reward Timer
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    infoColor.withAlpha(25),
                    primaryColor.withAlpha(25),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.timer,
                    color: infoColor,
                    size: 24,
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Next Reward Available In",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    canClaim ? "Available Now!" : "18:45:32",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: canClaim ? successColor : infoColor,
                    ),
                  ),
                  if (!canClaim) ...[
                    Text(
                      "Come back tomorrow for more rewards!",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
