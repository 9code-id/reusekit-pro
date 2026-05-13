import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaCoinsView extends StatefulWidget {
  const GeaCoinsView({super.key});

  @override
  State<GeaCoinsView> createState() => _GeaCoinsViewState();
}

class _GeaCoinsViewState extends State<GeaCoinsView> {
  String selectedTab = "Earn";
  
  int currentCoins = 8450;
  int dailyLimit = 1000;
  int earnedToday = 350;

  List<Map<String, dynamic>> earnMethods = [
    {
      "id": 1,
      "name": "Daily Login",
      "reward": 50,
      "type": "Daily",
      "completed": true,
      "icon": Icons.login,
      "color": Color(0xFF4CAF50),
      "description": "Login daily to earn coins",
      "cooldown": 86400,
      "remaining": 0,
    },
    {
      "id": 2,
      "name": "Watch Ad",
      "reward": 25,
      "type": "Repeatable",
      "completed": false,
      "icon": Icons.play_circle,
      "color": Color(0xFF2196F3),
      "description": "Watch video ads for coins",
      "cooldown": 300,
      "remaining": 0,
      "dailyLimit": 10,
      "usedToday": 3,
    },
    {
      "id": 3,
      "name": "Complete Mission",
      "reward": 100,
      "type": "Mission",
      "completed": false,
      "icon": Icons.flag,
      "color": Color(0xFFFF9800),
      "description": "Complete daily missions",
      "cooldown": 0,
      "remaining": 0,
      "available": 5,
    },
    {
      "id": 4,
      "name": "Win Arena Battle",
      "reward": 75,
      "type": "Combat",
      "completed": false,
      "icon": Icons.sports_mma,
      "color": Color(0xFFF44336),
      "description": "Win battles in the arena",
      "cooldown": 0,
      "remaining": 0,
    },
    {
      "id": 5,
      "name": "Invite Friend",
      "reward": 200,
      "type": "Social",
      "completed": false,
      "icon": Icons.person_add,
      "color": Color(0xFF9C27B0),
      "description": "Invite friends to play",
      "cooldown": 0,
      "remaining": 0,
    },
    {
      "id": 6,
      "name": "Weekly Challenge",
      "reward": 500,
      "type": "Weekly",
      "completed": false,
      "icon": Icons.emoji_events,
      "color": Color(0xFFFFD700),
      "description": "Complete weekly challenges",
      "cooldown": 604800,
      "remaining": 345600,
    },
  ];

  List<Map<String, dynamic>> spendOptions = [
    {
      "id": 1,
      "name": "Health Potion",
      "cost": 100,
      "category": "Consumables",
      "icon": Icons.favorite,
      "color": Color(0xFFF44336),
      "description": "Restore 50 HP instantly",
      "quantity": 1,
      "maxPurchase": 10,
    },
    {
      "id": 2,
      "name": "Basic Weapon",
      "cost": 500,
      "category": "Equipment",
      "icon": Icons.sports_martial_arts,
      "color": Color(0xFF795548),
      "description": "Common tier weapon",
      "quantity": 1,
      "maxPurchase": 5,
    },
    {
      "id": 3,
      "name": "Skill Point",
      "cost": 200,
      "category": "Upgrades",
      "icon": Icons.star,
      "color": Color(0xFF9C27B0),
      "description": "Increase character skills",
      "quantity": 1,
      "maxPurchase": 20,
    },
    {
      "id": 4,
      "name": "Inventory Slot",
      "cost": 300,
      "category": "Upgrades",
      "icon": Icons.inventory,
      "color": Color(0xFF607D8B),
      "description": "Expand inventory space",
      "quantity": 1,
      "maxPurchase": 15,
    },
    {
      "id": 5,
      "name": "Arena Ticket",
      "cost": 150,
      "category": "Tickets",
      "icon": Icons.confirmation_number,
      "color": Color(0xFF3F51B5),
      "description": "Enter arena battles",
      "quantity": 1,
      "maxPurchase": 20,
    },
    {
      "id": 6,
      "name": "XP Boost",
      "cost": 250,
      "category": "Boosters",
      "icon": Icons.trending_up,
      "color": Color(0xFF4CAF50),
      "description": "Double XP for 30 minutes",
      "quantity": 1,
      "maxPurchase": 8,
    },
  ];

  List<Map<String, dynamic>> transactions = [
    {
      "id": 1,
      "type": "Earned",
      "amount": 50,
      "source": "Daily Login",
      "timestamp": "2024-06-16 08:00:00",
      "icon": Icons.add,
      "color": Color(0xFF4CAF50),
    },
    {
      "id": 2,
      "type": "Spent",
      "amount": -100,
      "source": "Health Potion",
      "timestamp": "2024-06-16 10:30:00",
      "icon": Icons.remove,
      "color": Color(0xFFF44336),
    },
    {
      "id": 3,
      "type": "Earned",
      "amount": 75,
      "source": "Arena Victory",
      "timestamp": "2024-06-16 14:15:00",
      "icon": Icons.add,
      "color": Color(0xFF4CAF50),
    },
    {
      "id": 4,
      "type": "Earned",
      "amount": 25,
      "source": "Watch Ad",
      "timestamp": "2024-06-16 16:45:00",
      "icon": Icons.add,
      "color": Color(0xFF4CAF50),
    },
    {
      "id": 5,
      "type": "Spent",
      "amount": -200,
      "source": "Skill Point",
      "timestamp": "2024-06-16 18:20:00",
      "icon": Icons.remove,
      "color": Color(0xFFF44336),
    },
  ];

  String _formatTime(int seconds) {
    if (seconds == 0) return "Available now";
    
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    
    if (hours > 0) {
      return "${hours}h ${minutes}m";
    } else {
      return "${minutes}m";
    }
  }

  Widget _buildEarnTab() {
    return Column(
      spacing: spSm,
      children: [
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
            children: [
              Text(
                "Daily Earnings Progress",
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
                    child: LinearProgressIndicator(
                      value: earnedToday / dailyLimit,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(successColor),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Text(
                    "$earnedToday/$dailyLimit",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: successColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Earn Methods
        ...earnMethods.map((method) {
          final isCompleted = method["completed"] == true;
          final hasRemaining = (method["remaining"] as int) > 0;
          final canUse = !isCompleted && !hasRemaining;
          
          return Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: isCompleted 
                  ? Border.all(color: successColor, width: 1)
                  : null,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: (method["color"] as Color).withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    method["icon"] as IconData,
                    color: method["color"] as Color,
                    size: 28,
                  ),
                ),
                
                SizedBox(width: spSm),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${method["name"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: method["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${method["type"]}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      Text(
                        "${method["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            size: 16,
                            color: warningColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "+${method["reward"]} coins",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          if (method.containsKey("dailyLimit"))
                            Text(
                              " (${method["usedToday"]}/${method["dailyLimit"]} today)",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                        ],
                      ),
                      
                      if (hasRemaining)
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: 14,
                              color: disabledBoldColor,
                            ),
                            SizedBox(width: 4),
                            Text(
                              "Available in ${_formatTime(method["remaining"] as int)}",
                              style: TextStyle(
                                fontSize: 11,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                
                SizedBox(width: spSm),
                
                if (isCompleted)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                else
                  QButton(
                    label: "Claim",
                    size: bs.sm,
                    onPressed: canUse ? () {
                      //navigateTo('ClaimCoinsView', arguments: method)
                    } : null,
                  ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSpendTab() {
    return Column(
      spacing: spSm,
      children: spendOptions.map((item) {
        final canAfford = currentCoins >= (item["cost"] as int);
        
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
            border: Border.all(
              color: canAfford ? disabledColor : disabledBoldColor,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (item["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["color"] as Color,
                  size: 28,
                ),
              ),
              
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${item["name"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: canAfford ? primaryColor : disabledBoldColor,
                      ),
                    ),
                    
                    Text(
                      "${item["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 16,
                          color: canAfford ? warningColor : disabledBoldColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "${item["cost"]} coins",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: canAfford ? warningColor : disabledBoldColor,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Max: ${item["maxPurchase"]}",
                          style: TextStyle(
                            fontSize: 11,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              QButton(
                label: "Buy",
                size: bs.sm,
                onPressed: canAfford ? () {
                  //navigateTo('PurchaseWithCoinsView', arguments: item)
                } : null,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      spacing: spSm,
      children: transactions.map((transaction) {
        final isEarned = transaction["type"] == "Earned";
        
        return Container(
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (transaction["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  transaction["icon"] as IconData,
                  color: transaction["color"] as Color,
                  size: 24,
                ),
              ),
              
              SizedBox(width: spSm),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${transaction["source"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "${transaction["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              
              Text(
                "${isEarned ? '+' : ''}${transaction["amount"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: transaction["color"] as Color,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coins Manager"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spSm),
            decoration: BoxDecoration(
              color: warningColor.withAlpha(30),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: warningColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.monetization_on,
                  color: warningColor,
                  size: 20,
                ),
                SizedBox(width: 4),
                Text(
                  "$currentCoins",
                  style: TextStyle(
                    color: warningColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            margin: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Earn";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "Earn" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Earn Coins",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == "Earn" ? Colors.white : primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "Spend";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "Spend" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "Spend Coins",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == "Spend" ? Colors.white : primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = "History";
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == "History" ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == "History" ? Colors.white : primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: spMd),
              child: selectedTab == "Earn" 
                  ? _buildEarnTab()
                  : selectedTab == "Spend"
                      ? _buildSpendTab()
                      : _buildHistoryTab(),
            ),
          ),
        ],
      ),
    );
  }
}
