import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaRewardsSystemView extends StatefulWidget {
  const FmaRewardsSystemView({super.key});

  @override
  State<FmaRewardsSystemView> createState() => _FmaRewardsSystemViewState();
}

class _FmaRewardsSystemViewState extends State<FmaRewardsSystemView> {
  int currentTab = 0;
  String searchQuery = "";
  String selectedCategory = "All";
  
  List<Map<String, dynamic>> rewardCategories = [
    {"label": "All", "value": "All"},
    {"label": "Discounts", "value": "Discounts"},
    {"label": "Free Items", "value": "Free Items"},
    {"label": "Services", "value": "Services"},
    {"label": "Special Offers", "value": "Special Offers"},
  ];

  List<Map<String, dynamic>> rewards = [
    {
      "id": "1",
      "title": "Free Coffee",
      "description": "Get a free coffee of your choice",
      "category": "Free Items",
      "pointsCost": 500,
      "value": 5.0,
      "validityDays": 30,
      "maxRedemptions": 100,
      "currentRedemptions": 45,
      "isActive": true,
      "image": "https://picsum.photos/80/80?random=1&keyword=coffee"
    },
    {
      "id": "2",
      "title": "10% Discount",
      "description": "10% off on your next purchase",
      "category": "Discounts",
      "pointsCost": 1000,
      "value": 0.0,
      "validityDays": 14,
      "maxRedemptions": 50,
      "currentRedemptions": 23,
      "isActive": true,
      "image": "https://picsum.photos/80/80?random=2&keyword=discount"
    },
    {
      "id": "3",
      "title": "Free Pastry",
      "description": "Any pastry from our selection",
      "category": "Free Items",
      "pointsCost": 300,
      "value": 3.5,
      "validityDays": 7,
      "maxRedemptions": 200,
      "currentRedemptions": 156,
      "isActive": true,
      "image": "https://picsum.photos/80/80?random=3&keyword=pastry"
    },
    {
      "id": "4",
      "title": "VIP Service",
      "description": "Priority queue and special treatment",
      "category": "Services",
      "pointsCost": 2000,
      "value": 0.0,
      "validityDays": 90,
      "maxRedemptions": 20,
      "currentRedemptions": 8,
      "isActive": true,
      "image": "https://picsum.photos/80/80?random=4&keyword=vip"
    },
    {
      "id": "5",
      "title": "Buy 2 Get 1 Free",
      "description": "Buy 2 items and get the 3rd free",
      "category": "Special Offers",
      "pointsCost": 1500,
      "value": 0.0,
      "validityDays": 21,
      "maxRedemptions": 30,
      "currentRedemptions": 12,
      "isActive": false,
      "image": "https://picsum.photos/80/80?random=5&keyword=offer"
    },
  ];

  List<Map<String, dynamic>> recentRedemptions = [
    {
      "id": "1",
      "rewardTitle": "Free Coffee",
      "memberName": "Sarah Johnson",
      "pointsUsed": 500,
      "redeemedAt": "2024-06-18 10:30:00",
      "status": "Used",
      "expiresAt": "2024-07-18"
    },
    {
      "id": "2",
      "rewardTitle": "10% Discount",
      "memberName": "Mike Chen",
      "pointsUsed": 1000,
      "redeemedAt": "2024-06-17 14:20:00",
      "status": "Active",
      "expiresAt": "2024-07-01"
    },
    {
      "id": "3",
      "rewardTitle": "Free Pastry",
      "memberName": "Emily Davis",
      "pointsUsed": 300,
      "redeemedAt": "2024-06-16 09:15:00",
      "status": "Active",
      "expiresAt": "2024-06-23"
    },
    {
      "id": "4",
      "rewardTitle": "VIP Service",
      "memberName": "David Wilson",
      "pointsUsed": 2000,
      "redeemedAt": "2024-06-15 16:45:00",
      "status": "Used",
      "expiresAt": "2024-09-15"
    },
  ];

  List<Map<String, dynamic>> get filteredRewards {
    return rewards.where((reward) {
      bool matchesSearch = reward["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                          reward["description"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || reward["category"] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Active": return successColor;
      case "Used": return disabledBoldColor;
      case "Expired": return dangerColor;
      default: return primaryColor;
    }
  }

  double _getRedemptionPercentage(Map<String, dynamic> reward) {
    int current = reward["currentRedemptions"] as int;
    int max = reward["maxRedemptions"] as int;
    return current / max;
  }

  Widget _buildOverviewTab() {
    int totalRewards = rewards.length;
    int activeRewards = rewards.where((r) => r["isActive"] == true).length;
    int totalRedemptions = rewards.map((r) => r["currentRedemptions"] as int).reduce((a, b) => a + b);
    double totalPointsRedeemed = recentRedemptions.map((r) => r["pointsUsed"] as int).reduce((a, b) => a + b).toDouble();

    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          // Stats Cards Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.card_giftcard, color: primaryColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalRewards",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Total Rewards",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: successColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$activeRewards",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Active Rewards",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.redeem, color: warningColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "$totalRedemptions",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                    Text(
                      "Total Redemptions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  children: [
                    Icon(Icons.stars, color: infoColor, size: 32),
                    SizedBox(height: spSm),
                    Text(
                      "${(totalPointsRedeemed / 1000).toStringAsFixed(1)}K",
                      style: TextStyle(
                        fontSize: fsH3,
                        fontWeight: FontWeight.bold,
                        color: infoColor,
                      ),
                    ),
                    Text(
                      "Points Redeemed",
                      textAlign: TextAlign.center,
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

          // Popular Rewards
          Text(
            "Popular Rewards",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: rewards.take(3).map((reward) {
              double percentage = _getRedemptionPercentage(reward);
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${reward["image"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
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
                                  "${reward["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: reward["isActive"] == true 
                                      ? successColor.withAlpha(51) 
                                      : disabledColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  reward["isActive"] == true ? "Active" : "Inactive",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: reward["isActive"] == true ? successColor : disabledBoldColor,
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
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${reward["pointsCost"]} points",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: warningColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${reward["currentRedemptions"]}/${reward["maxRedemptions"]} used",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: disabledColor.withAlpha(102),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: percentage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: percentage > 0.8 ? dangerColor : 
                                         percentage > 0.6 ? warningColor : successColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                              ),
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

          // Recent Redemptions
          Text(
            "Recent Redemptions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          Column(
            spacing: spSm,
            children: recentRedemptions.take(5).map((redemption) {
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
                        color: _getStatusColor(redemption["status"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        redemption["status"] == "Used" ? Icons.check_circle : Icons.access_time,
                        color: _getStatusColor(redemption["status"]),
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${redemption["rewardTitle"]}",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${redemption["memberName"]} • ${redemption["pointsUsed"]} pts",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "Expires: ${redemption["expiresAt"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: _getStatusColor(redemption["status"]).withAlpha(51),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${redemption["status"]}",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(redemption["status"]),
                        ),
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

  Widget _buildRewardsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Search rewards...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Container(
                width: 140,
                child: QDropdownField(
                  label: "Category",
                  items: rewardCategories,
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),

          // Add New Reward Button
          Container(
            width: double.infinity,
            child: QButton(
              label: "Add New Reward",
              icon: Icons.add,
              size: bs.md,
              onPressed: () {
                ss("Add new reward feature");
              },
            ),
          ),

          // Rewards List
          Column(
            spacing: spSm,
            children: filteredRewards.map((reward) {
              double percentage = _getRedemptionPercentage(reward);
              
              return Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(radiusSm),
                          child: Image.network(
                            "${reward["image"]}",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
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
                                      "${reward["title"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: reward["isActive"] == true 
                                          ? successColor.withAlpha(51) 
                                          : disabledColor.withAlpha(51),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      reward["isActive"] == true ? "Active" : "Inactive",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: reward["isActive"] == true ? successColor : disabledBoldColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${reward["description"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${reward["category"]}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
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
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: warningColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${reward["pointsCost"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Points Cost",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: warningColor,
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
                              color: infoColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${reward["validityDays"]} days",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Validity",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if ((reward["value"] as double) > 0) ...[
                          SizedBox(width: spSm),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "\$${((reward["value"] as double)).currency}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Value",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: spXs,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Usage: ${reward["currentRedemptions"]}/${reward["maxRedemptions"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${(percentage * 100).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledColor,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: disabledColor.withAlpha(102),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: percentage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: percentage > 0.8 ? dangerColor : 
                                       percentage > 0.6 ? warningColor : successColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "Edit",
                            size: bs.sm,
                            onPressed: () {
                              ss("Editing ${reward["title"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: QButton(
                            label: reward["isActive"] == true ? "Deactivate" : "Activate",
                            size: bs.sm,
                            onPressed: () {
                              String action = reward["isActive"] == true ? "deactivated" : "activated";
                              ss("${reward["title"]} $action");
                            },
                          ),
                        ),
                      ],
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

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Rewards System",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Manage Rewards", icon: Icon(Icons.card_giftcard)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildRewardsTab(),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }
}
