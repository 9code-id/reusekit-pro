import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaLoyaltyPointsView extends StatefulWidget {
  const SpaLoyaltyPointsView({super.key});

  @override
  State<SpaLoyaltyPointsView> createState() => _SpaLoyaltyPointsViewState();
}

class _SpaLoyaltyPointsViewState extends State<SpaLoyaltyPointsView> {
  int currentPoints = 2847;
  int totalPointsEarned = 8562;
  String membershipTier = "Gold";
  int pointsToNextTier = 653;
  String nextTier = "Platinum";
  
  List<Map<String, dynamic>> pointsHistory = [
    {
      "date": "2024-02-15",
      "type": "earned",
      "points": 150,
      "description": "Deep Tissue Massage - 90 minutes",
      "icon": Icons.add_circle,
      "color": successColor,
    },
    {
      "date": "2024-02-14",
      "type": "redeemed",
      "points": -200,
      "description": "Free Aromatherapy Session",
      "icon": Icons.remove_circle,
      "color": warningColor,
    },
    {
      "date": "2024-02-12",
      "type": "earned",
      "points": 95,
      "description": "Facial Treatment - Premium",
      "icon": Icons.add_circle,
      "color": successColor,
    },
    {
      "date": "2024-02-10",
      "type": "bonus",
      "points": 100,
      "description": "Birthday Bonus Points",
      "icon": Icons.celebration,
      "color": primaryColor,
    },
    {
      "date": "2024-02-08",
      "type": "earned",
      "points": 120,
      "description": "Hot Stone Massage",
      "icon": Icons.add_circle,
      "color": successColor,
    },
    {
      "date": "2024-02-05",
      "type": "redeemed",
      "points": -300,
      "description": "Free Manicure & Pedicure",
      "icon": Icons.remove_circle,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> availableRewards = [
    {
      "id": "aromatherapy",
      "title": "Aromatherapy Session",
      "description": "30-minute relaxing aromatherapy treatment",
      "points": 200,
      "category": "Treatments",
      "image": "https://picsum.photos/200/120?random=1&keyword=aromatherapy",
      "validity": "3 months",
      "popular": true,
    },
    {
      "id": "facial",
      "title": "Express Facial",
      "description": "45-minute revitalizing facial treatment",
      "points": 350,
      "category": "Treatments",
      "image": "https://picsum.photos/200/120?random=2&keyword=facial",
      "validity": "3 months",
      "popular": false,
    },
    {
      "id": "massage_upgrade",
      "title": "Massage Upgrade",
      "description": "Upgrade any 60-min massage to 90-min",
      "points": 150,
      "category": "Upgrades",
      "image": "https://picsum.photos/200/120?random=3&keyword=massage",
      "validity": "6 months",
      "popular": true,
    },
    {
      "id": "spa_package",
      "title": "Mini Spa Package",
      "description": "30-min massage + 30-min facial combo",
      "points": 500,
      "category": "Packages",
      "image": "https://picsum.photos/200/120?random=4&keyword=spa",
      "validity": "3 months",
      "popular": false,
    },
    {
      "id": "product_discount",
      "title": "20% Product Discount",
      "description": "20% off any spa product purchase",
      "points": 100,
      "category": "Discounts",
      "image": "https://picsum.photos/200/120?random=5&keyword=products",
      "validity": "1 month",
      "popular": true,
    },
    {
      "id": "guest_pass",
      "title": "Guest Pass",
      "description": "Bring a friend for free relaxation lounge access",
      "points": 180,
      "category": "Privileges",
      "image": "https://picsum.photos/200/120?random=6&keyword=lounge",
      "validity": "2 months",
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> membershipTiers = [
    {
      "name": "Bronze",
      "minPoints": 0,
      "color": Colors.amber[800],
      "benefits": [
        "Earn 1 point per \$1 spent",
        "Birthday bonus: 50 points",
        "Basic member newsletter",
      ],
    },
    {
      "name": "Silver",
      "minPoints": 1000,
      "color": Colors.grey[600],
      "benefits": [
        "Earn 1.2 points per \$1 spent",
        "Birthday bonus: 100 points",
        "Priority booking (24 hours)",
        "5% discount on products",
      ],
    },
    {
      "name": "Gold",
      "minPoints": 2500,
      "color": Colors.amber[600],
      "benefits": [
        "Earn 1.5 points per \$1 spent",
        "Birthday bonus: 150 points",
        "Priority booking (48 hours)",
        "10% discount on products",
        "Free parking",
      ],
    },
    {
      "name": "Platinum",
      "minPoints": 5000,
      "color": Colors.blueGrey[700],
      "benefits": [
        "Earn 2 points per \$1 spent",
        "Birthday bonus: 200 points",
        "Priority booking (72 hours)",
        "15% discount on products",
        "Free parking & valet",
        "Complimentary refreshments",
        "Quarterly bonus: 100 points",
      ],
    },
  ];

  String selectedCategory = "All";
  List<String> rewardCategories = ["All", "Treatments", "Upgrades", "Packages", "Discounts", "Privileges"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loyalty Points"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Points Overview
            _buildPointsOverview(),

            // Membership Progress
            _buildMembershipProgress(),

            // Quick Actions
            _buildQuickActions(),

            // Available Rewards
            _buildAvailableRewards(),

            // Points History
            _buildPointsHistory(),

            // Membership Tiers Info
            _buildMembershipTiers(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsOverview() {
    return Container(
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
          // Header
          Container(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
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
                        "Available Points",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${currentPoints.toString()}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        membershipTier,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stats Grid
          Container(
            margin: EdgeInsets.fromLTRB(spMd, 0, spMd, spMd),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "Total Earned",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "${totalPointsEarned.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withAlpha(100),
                ),
                Expanded(
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "This Month",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "465",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withAlpha(100),
                ),
                Expanded(
                  child: Column(
                    spacing: spXs,
                    children: [
                      Text(
                        "Redeemed",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                      Text(
                        "1,280",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipProgress() {
    double progress = pointsToNextTier > 0 ? 1.0 - (pointsToNextTier / 2500) : 1.0;
    
    return Container(
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
              Icon(Icons.trending_up, color: primaryColor, size: 20),
              SizedBox(width: spSm),
              Text(
                "Membership Progress",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          Row(
            children: [
              Text(
                "Current: ",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                membershipTier,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              Text(
                "Next: ",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                nextTier,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[700],
                ),
              ),
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Progress Bar
          Column(
            spacing: spXs,
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    "${pointsToNextTier} points to go",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${((progress * 100).toInt())}% complete",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
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
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  Icons.redeem,
                  "Redeem\nRewards",
                  primaryColor,
                  () {
                    // Scroll to rewards section
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  Icons.history,
                  "Points\nHistory",
                  infoColor,
                  () {
                    // Scroll to history section
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  Icons.workspace_premium,
                  "Tier\nBenefits",
                  successColor,
                  () {
                    // Scroll to tiers section
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildQuickActionButton(
                  Icons.share,
                  "Refer\nFriends",
                  warningColor,
                  () {
                    _shareReferral();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(radiusSm),
          border: Border.all(color: color.withAlpha(100)),
        ),
        child: Column(
          spacing: spXs,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableRewards() {
    List<Map<String, dynamic>> filteredRewards = selectedCategory == "All" 
        ? availableRewards 
        : availableRewards.where((reward) => reward["category"] == selectedCategory).toList();
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(Icons.card_giftcard, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Available Rewards",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Category Filter
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: rewardCategories.length,
              itemBuilder: (context, index) {
                final category = rewardCategories[index];
                bool isSelected = selectedCategory == category;
                
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.grey[100],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: spSm),
          
          // Rewards Grid
          ResponsiveGridView(
            padding: EdgeInsets.all(spMd),
            minItemWidth: 200,
            children: filteredRewards.map((reward) {
              bool canRedeem = currentPoints >= (reward["points"] as int);
              
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: canRedeem ? primaryColor.withAlpha(100) : Colors.grey[300]!,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusSm),
                            topRight: Radius.circular(radiusSm),
                          ),
                          child: Image.network(
                            "${reward["image"]}",
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (reward["popular"] as bool)
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: successColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "POPULAR",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    // Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${reward["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${reward["category"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Text(
                            "${reward["description"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                              height: 1.3,
                            ),
                          ),
                          
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: primaryColor,
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${reward["points"]} points",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Valid ${reward["validity"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: canRedeem ? "Redeem Now" : "Not enough points",
                              color: canRedeem ? primaryColor : Colors.grey,
                              size: bs.sm,
                              onPressed: canRedeem ? () {
                                _redeemReward(reward);
                              } : null,
                            ),
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
    );
  }

  Widget _buildPointsHistory() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(Icons.history, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    ss("View full points history");
                    //navigateTo ( PointsHistoryView )
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
          ),
          
          Column(
            children: pointsHistory.take(5).map((transaction) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (transaction["color"] as Color).withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        transaction["icon"] as IconData,
                        color: transaction["color"] as Color,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${transaction["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${transaction["date"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Text(
                      "${transaction["points"] > 0 ? '+' : ''}${transaction["points"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: transaction["points"] > 0 ? successColor : warningColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipTiers() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Icon(Icons.workspace_premium, color: primaryColor, size: 20),
                SizedBox(width: spSm),
                Text(
                  "Membership Tiers",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          Column(
            children: membershipTiers.map((tier) {
              bool isCurrent = tier["name"] == membershipTier;
              
              return Container(
                margin: EdgeInsets.symmetric(horizontal: spMd, vertical: spXs),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: isCurrent ? primaryColor.withAlpha(25) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isCurrent ? primaryColor : Colors.grey[300]!,
                    width: isCurrent ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: tier["color"] as Color,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.workspace_premium,
                            color: Colors.white,
                            size: 16,
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
                                  Text(
                                    "${tier["name"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: isCurrent ? primaryColor : disabledBoldColor,
                                    ),
                                  ),
                                  if (isCurrent) ...[
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
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
                                "${tier["minPoints"]}+ points required",
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
                    
                    Column(
                      spacing: spXs,
                      children: (tier["benefits"] as List<String>).map((benefit) {
                        return Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: tier["color"] as Color,
                              size: 16,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                benefit,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: spMd),
        ],
      ),
    );
  }

  void _redeemReward(Map<String, dynamic> reward) async {
    bool isConfirmed = await confirm(
      "Redeem ${reward["title"]} for ${reward["points"]} points?"
    );
    
    if (isConfirmed) {
      setState(() {
        currentPoints -= (reward["points"] as int);
        pointsHistory.insert(0, {
          "date": DateTime.now().toString().split(' ')[0],
          "type": "redeemed",
          "points": -(reward["points"] as int),
          "description": "${reward["title"]}",
          "icon": Icons.remove_circle,
          "color": warningColor,
        });
      });
      
      ss("Reward redeemed successfully!");
      //navigateTo ( RewardConfirmationView )
    }
  }

  void _shareReferral() {
    ss("Share referral link");
    // Implement referral sharing functionality
  }
}
