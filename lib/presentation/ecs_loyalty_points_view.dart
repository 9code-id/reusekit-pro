import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsLoyaltyPointsView extends StatefulWidget {
  const EcsLoyaltyPointsView({super.key});

  @override
  State<EcsLoyaltyPointsView> createState() => _EcsLoyaltyPointsViewState();
}

class _EcsLoyaltyPointsViewState extends State<EcsLoyaltyPointsView> {
  int currentPoints = 2450;
  int pointsToNextTier = 550;
  String currentTier = "Gold";
  String nextTier = "Platinum";

  List<Map<String, dynamic>> pointsHistory = [
    {
      "id": 1,
      "type": "earned",
      "points": 150,
      "description": "Order #ORD-2024-001",
      "date": "2024-06-14",
      "orderId": "ORD-2024-001",
    },
    {
      "id": 2,
      "type": "redeemed",
      "points": -500,
      "description": "Redeemed for \$5 discount",
      "date": "2024-06-12",
      "rewardId": "RWD-001",
    },
    {
      "id": 3,
      "type": "earned",
      "points": 200,
      "description": "Order #ORD-2024-002",
      "date": "2024-06-10",
      "orderId": "ORD-2024-002",
    },
    {
      "id": 4,
      "type": "bonus",
      "points": 300,
      "description": "Birthday bonus points",
      "date": "2024-06-08",
    },
    {
      "id": 5,
      "type": "earned",
      "points": 100,
      "description": "Order #ORD-2024-003",
      "date": "2024-06-05",
      "orderId": "ORD-2024-003",
    },
  ];

  List<Map<String, dynamic>> rewardsAvailable = [
    {
      "id": 1,
      "title": "\$5 Discount",
      "description": "Get \$5 off your next order",
      "pointsRequired": 500,
      "type": "discount",
      "value": 5.0,
      "validUntil": "2024-12-31",
    },
    {
      "id": 2,
      "title": "\$10 Discount",
      "description": "Get \$10 off your next order",
      "pointsRequired": 1000,
      "type": "discount",
      "value": 10.0,
      "validUntil": "2024-12-31",
    },
    {
      "id": 3,
      "title": "Free Shipping",
      "description": "Free shipping on your next order",
      "pointsRequired": 300,
      "type": "shipping",
      "validUntil": "2024-12-31",
    },
    {
      "id": 4,
      "title": "\$25 Discount",
      "description": "Get \$25 off your next order",
      "pointsRequired": 2500,
      "type": "discount",
      "value": 25.0,
      "validUntil": "2024-12-31",
    },
    {
      "id": 5,
      "title": "Birthday Gift",
      "description": "Special birthday surprise",
      "pointsRequired": 750,
      "type": "gift",
      "validUntil": "2024-12-31",
    },
  ];

  List<Map<String, dynamic>> tierBenefits = [
    {
      "tier": "Bronze",
      "minPoints": 0,
      "maxPoints": 999,
      "benefits": [
        "1 point per \$1 spent",
        "Basic customer support",
        "Standard shipping rates",
      ],
      "color": Colors.brown,
    },
    {
      "tier": "Silver",
      "minPoints": 1000,
      "maxPoints": 1999,
      "benefits": [
        "1.2 points per \$1 spent",
        "Priority customer support",
        "Free shipping on orders \$75+",
        "Early access to sales",
      ],
      "color": Colors.grey,
    },
    {
      "tier": "Gold",
      "minPoints": 2000,
      "maxPoints": 2999,
      "benefits": [
        "1.5 points per \$1 spent",
        "Premium customer support",
        "Free shipping on all orders",
        "Early access to new products",
        "Birthday bonus points",
      ],
      "color": Colors.amber,
    },
    {
      "tier": "Platinum",
      "minPoints": 3000,
      "maxPoints": 4999,
      "benefits": [
        "2 points per \$1 spent",
        "24/7 customer support",
        "Free express shipping",
        "Exclusive member-only sales",
        "Personal shopping assistant",
        "Double birthday bonus",
      ],
      "color": Colors.purple,
    },
    {
      "tier": "Diamond",
      "minPoints": 5000,
      "maxPoints": 999999,
      "benefits": [
        "3 points per \$1 spent",
        "VIP customer support",
        "Free next-day delivery",
        "Access to luxury products",
        "Personal style consultant",
        "Exclusive events invitation",
        "Triple birthday bonus",
      ],
      "color": Colors.cyan,
    },
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loyalty Points"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              _showPointsInfoDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Points Summary Card
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(204)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowMd],
            ),
            child: Column(
              children: [
                // Current Points
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.stars,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "$currentPoints",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Available Points",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(230),
                  ),
                ),

                SizedBox(height: spMd),

                // Current Tier
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "$currentTier Member",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: spMd),

                // Progress to Next Tier
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "$currentTier",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "$nextTier",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: (currentPoints % 1000) / 1000,
                        backgroundColor: Colors.white.withAlpha(102),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "$pointsToNextTier points to $nextTier",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(230),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab Navigation
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            child: QCategoryPicker(
              items: [
                {"label": "Rewards", "value": "rewards"},
                {"label": "History", "value": "history"},
                {"label": "Tiers", "value": "tiers"},
              ],
              value: selectedTab == 0 ? "rewards" : selectedTab == 1 ? "history" : "tiers",
              onChanged: (index, label, value, item) {
                selectedTab = index;
                setState(() {});
              },
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: selectedTab == 0
                  ? _buildRewardsTab()
                  : selectedTab == 1
                      ? _buildHistoryTab()
                      : _buildTiersTab(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsTab() {
    return Column(
      spacing: spSm,
      children: [
        // Header
        Text(
          "Available Rewards",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        // Rewards Grid
        ...rewardsAvailable.map((reward) {
          bool canRedeem = currentPoints >= (reward["pointsRequired"] as int);
          
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: canRedeem ? primaryColor : disabledOutlineBorderColor,
                width: canRedeem ? 2 : 1,
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: _getRewardTypeColor("${reward["type"]}").withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        _getRewardTypeIcon("${reward["type"]}"),
                        color: _getRewardTypeColor("${reward["type"]}"),
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
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: canRedeem ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${reward["description"]}",
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

                SizedBox(height: spSm),

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.stars,
                            size: 16,
                            color: primaryColor,
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${reward["pointsRequired"]} pts",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: canRedeem ? "Redeem" : "Need ${(reward["pointsRequired"] as int) - currentPoints} pts",
                      size: bs.sm,
                      onPressed: canRedeem ? () {
                        _redeemReward(reward);
                      } : null,
                    ),
                  ],
                ),

                if (reward["validUntil"] != null) ...[
                  SizedBox(height: spSm),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Valid until ${reward["validUntil"]}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: warningColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildHistoryTab() {
    return Column(
      spacing: spSm,
      children: [
        // Header
        Text(
          "Points History",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        // History List
        ...pointsHistory.map((transaction) {
          bool isEarned = (transaction["points"] as int) > 0;
          
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: isEarned 
                        ? successColor.withAlpha(25) 
                        : dangerColor.withAlpha(25),
                    borderRadius: BorderRadius.circular(radiusMd),
                  ),
                  child: Icon(
                    isEarned ? Icons.add : Icons.remove,
                    color: isEarned ? successColor : dangerColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${transaction["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${transaction["date"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: spXs),
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: _getTransactionTypeColor("${transaction["type"]}").withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${transaction["type"]}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getTransactionTypeColor("${transaction["type"]}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${isEarned ? '+' : ''}${transaction["points"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isEarned ? successColor : dangerColor,
                      ),
                    ),
                    Text(
                      "points",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTiersTab() {
    return Column(
      spacing: spSm,
      children: [
        // Header
        Text(
          "Membership Tiers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        // Tiers List
        ...tierBenefits.map((tier) {
          bool isCurrentTier = tier["tier"] == currentTier;
          bool hasReached = currentPoints >= (tier["minPoints"] as int);
          
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: isCurrentTier ? primaryColor : disabledOutlineBorderColor,
                width: isCurrentTier ? 2 : 1,
              ),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (tier["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusMd),
                      ),
                      child: Icon(
                        Icons.workspace_premium,
                        color: tier["color"] as Color,
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
                              Text(
                                "${tier["tier"]} Tier",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: tier["color"] as Color,
                                ),
                              ),
                              if (isCurrentTier) ...[
                                SizedBox(width: spSm),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Text(
                                    "CURRENT",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          Text(
                            "${tier["minPoints"]} - ${tier["maxPoints"]} points",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (hasReached)
                      Icon(
                        Icons.check_circle,
                        color: successColor,
                        size: 24,
                      )
                    else
                      Icon(
                        Icons.lock,
                        color: disabledColor,
                        size: 24,
                      ),
                  ],
                ),

                SizedBox(height: spSm),

                // Benefits
                Text(
                  "Benefits:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                ...(tier["benefits"] as List).map((benefit) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: spXs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check,
                          size: 16,
                          color: hasReached ? successColor : disabledColor,
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Text(
                            "$benefit",
                            style: TextStyle(
                              fontSize: 14,
                              color: hasReached ? primaryColor : disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  IconData _getRewardTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'discount':
        return Icons.local_offer;
      case 'shipping':
        return Icons.local_shipping;
      case 'gift':
        return Icons.card_giftcard;
      default:
        return Icons.star;
    }
  }

  Color _getRewardTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'discount':
        return primaryColor;
      case 'shipping':
        return infoColor;
      case 'gift':
        return successColor;
      default:
        return primaryColor;
    }
  }

  Color _getTransactionTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'earned':
        return successColor;
      case 'redeemed':
        return dangerColor;
      case 'bonus':
        return warningColor;
      default:
        return primaryColor;
    }
  }

  void _redeemReward(Map<String, dynamic> reward) async {
    bool isConfirmed = await confirm(
      "Are you sure you want to redeem ${reward["title"]} for ${reward["pointsRequired"]} points?"
    );
    
    if (isConfirmed) {
      // Deduct points
      currentPoints -= (reward["pointsRequired"] as int);
      
      // Add to history
      pointsHistory.insert(0, {
        "id": pointsHistory.length + 1,
        "type": "redeemed",
        "points": -(reward["pointsRequired"] as int),
        "description": "Redeemed ${reward["title"]}",
        "date": DateTime.now().toString().split(' ')[0],
        "rewardId": "RWD-${reward["id"]}",
      });
      
      setState(() {});
      ss("Reward redeemed successfully!");
    }
  }

  void _showPointsInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("How Points Work"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Earn 1 point for every \$1 spent"),
            Text("• Higher tiers earn bonus points"),
            Text("• 100 points = \$1 value"),
            Text("• Points expire after 12 months"),
            Text("• Bonus points on birthdays"),
            Text("• Referral bonuses available"),
          ],
        ),
        actions: [
          QButton(
            label: "Got it",
            size: bs.sm,
            onPressed: () => back(),
          ),
        ],
      ),
    );
  }
}
