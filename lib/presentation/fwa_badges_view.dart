import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaBadgesView extends StatefulWidget {
  const FwaBadgesView({super.key});

  @override
  State<FwaBadgesView> createState() => _FwaBadgesViewState();
}

class _FwaBadgesViewState extends State<FwaBadgesView> {
  String selectedCategory = "all";
  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Badges", "value": "all"},
    {"label": "Fitness", "value": "fitness"},
    {"label": "Nutrition", "value": "nutrition"},
    {"label": "Sleep", "value": "sleep"},
    {"label": "Social", "value": "social"},
    {"label": "Challenges", "value": "challenges"},
  ];

  List<Map<String, dynamic>> badges = [
    {
      "id": "1",
      "name": "Step Starter",
      "description": "Complete your first 1,000 steps",
      "category": "fitness",
      "tier": "Bronze",
      "isEarned": true,
      "earnedDate": "2024-12-10",
      "icon": Icons.directions_walk,
      "color": Colors.brown,
      "progress": 100,
      "maxProgress": 100,
    },
    {
      "id": "2",
      "name": "Step Master",
      "description": "Walk 10,000 steps in a single day",
      "category": "fitness", 
      "tier": "Silver",
      "isEarned": true,
      "earnedDate": "2024-12-15",
      "icon": Icons.directions_walk,
      "color": Colors.grey,
      "progress": 100,
      "maxProgress": 100,
    },
    {
      "id": "3",
      "name": "Step Legend",
      "description": "Maintain 10,000+ steps for 30 days",
      "category": "fitness",
      "tier": "Gold",
      "isEarned": false,
      "earnedDate": null,
      "icon": Icons.directions_walk,
      "color": warningColor,
      "progress": 23,
      "maxProgress": 30,
    },
    {
      "id": "4",
      "name": "Calorie Burner",
      "description": "Burn 300+ calories in one workout",
      "category": "fitness",
      "tier": "Bronze",
      "isEarned": true,
      "earnedDate": "2024-12-12",
      "icon": Icons.local_fire_department,
      "color": Colors.brown,
      "progress": 100,
      "maxProgress": 100,
    },
    {
      "id": "5",
      "name": "Calorie Crusher",
      "description": "Burn 500+ calories in one workout",
      "category": "fitness",
      "tier": "Silver",
      "isEarned": true,
      "earnedDate": "2024-12-18",
      "icon": Icons.local_fire_department,
      "color": Colors.grey,
      "progress": 100,
      "maxProgress": 100,
    },
    {
      "id": "6",
      "name": "Calorie Destroyer",
      "description": "Burn 800+ calories in one workout",
      "category": "fitness",
      "tier": "Gold",
      "isEarned": false,
      "earnedDate": null,
      "icon": Icons.local_fire_department,
      "color": warningColor,
      "progress": 650,
      "maxProgress": 800,
    },
    {
      "id": "7",
      "name": "Hydration Hero",
      "description": "Drink 8 glasses of water daily",
      "category": "nutrition",
      "tier": "Bronze",
      "isEarned": true,
      "earnedDate": "2024-12-14",
      "icon": Icons.water_drop,
      "color": Colors.brown,
      "progress": 100,
      "maxProgress": 100,
    },
    {
      "id": "8",
      "name": "Nutrition Champion",
      "description": "Log healthy meals for 7 days",
      "category": "nutrition",
      "tier": "Silver",
      "isEarned": false,
      "earnedDate": null,
      "icon": Icons.restaurant,
      "color": Colors.grey,
      "progress": 4,
      "maxProgress": 7,
    },
    {
      "id": "9",
      "name": "Sleep Well",
      "description": "Get 8+ hours of sleep for 5 nights",
      "category": "sleep",
      "tier": "Bronze",
      "isEarned": true,
      "earnedDate": "2024-12-16",
      "icon": Icons.bedtime,
      "color": Colors.brown,
      "progress": 100,
      "maxProgress": 100,
    },
    {
      "id": "10",
      "name": "Social Butterfly",
      "description": "Complete 3 group challenges",
      "category": "social",
      "tier": "Silver",
      "isEarned": false,
      "earnedDate": null,
      "icon": Icons.group,
      "color": Colors.grey,
      "progress": 1,
      "maxProgress": 3,
    },
  ];

  List<Map<String, dynamic>> get filteredBadges {
    if (selectedCategory == "all") return badges;
    return badges.where((badge) => badge["category"] == selectedCategory).toList();
  }

  int get totalEarned => badges.where((badge) => badge["isEarned"] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Badges Collection"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              si("Badge collection shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Badge Collection Summary
            Container(
              padding: EdgeInsets.all(spSm),
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
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusMd),
                        ),
                        child: Icon(
                          Icons.military_tech,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              "Badge Collection",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Earn badges by completing fitness milestones",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryCard(
                          "Earned",
                          "$totalEarned/${badges.length}",
                          Icons.emoji_events,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildSummaryCard(
                          "Progress",
                          "${((totalEarned / badges.length) * 100).toStringAsFixed(0)}%",
                          Icons.trending_up,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Badge Tiers Info
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Badge Tiers",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: _buildTierCard("Bronze", Colors.brown, Icons.looks_3),
                      ),
                      Expanded(
                        child: _buildTierCard("Silver", Colors.grey, Icons.looks_two),
                      ),
                      Expanded(
                        child: _buildTierCard("Gold", warningColor, Icons.looks_one),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category Filter
            Container(
              padding: EdgeInsets.all(spSm),
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
                    "Filter by Category",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  QDropdownField(
                    label: "Select Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Badges Grid
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Your Badges",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  ResponsiveGridView(
                    padding: EdgeInsets.zero,
                    minItemWidth: 200,
                    children: filteredBadges.map((badge) {
                      final isEarned = badge["isEarned"] as bool;
                      final color = badge["color"] as Color;
                      final progress = badge["progress"] as int;
                      final maxProgress = badge["maxProgress"] as int;
                      final progressPercentage = progress / maxProgress;
                      
                      return Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: isEarned 
                              ? color.withAlpha(10)
                              : disabledColor.withAlpha(10),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: isEarned ? color : disabledOutlineBorderColor,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: spSm,
                          children: [
                            // Badge Icon
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: isEarned ? color : disabledColor,
                                borderRadius: BorderRadius.circular(radiusMd),
                                boxShadow: isEarned ? [shadowSm] : [],
                              ),
                              child: Icon(
                                badge["icon"] as IconData,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            
                            // Badge Tier
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isEarned ? color : disabledColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${badge["tier"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            
                            // Badge Name
                            Text(
                              "${badge["name"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isEarned ? primaryColor : disabledBoldColor,
                              ),
                            ),
                            
                            // Badge Description
                            Text(
                              "${badge["description"]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: isEarned ? disabledBoldColor : disabledColor,
                              ),
                            ),
                            
                            // Progress or Earned Date
                            if (isEarned) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    size: 14,
                                    color: successColor,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Earned",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              if (badge["earnedDate"] != null)
                                Text(
                                  "${badge["earnedDate"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: disabledBoldColor,
                                  ),
                                ),
                            ] else ...[
                              Column(
                                spacing: 4,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "$progress/$maxProgress",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: disabledColor.withAlpha(50),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      widthFactor: progressPercentage,
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${(progressPercentage * 100).toStringAsFixed(0)}% complete",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Next Badge Progress
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  Text(
                    "Almost There!",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: warningColor.withAlpha(10),
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(
                        color: warningColor,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            Icons.directions_walk,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                "Step Legend (Gold)",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "23/30 days completed",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Container(
                                height: 6,
                                margin: EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  color: warningColor.withAlpha(30),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  widthFactor: 0.77,
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "77%",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
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
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(40),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierCard(String tier, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          SizedBox(height: spXs),
          Text(
            tier,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
