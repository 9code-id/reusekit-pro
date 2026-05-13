import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaRewardsView extends StatefulWidget {
  const SpaRewardsView({super.key});

  @override
  State<SpaRewardsView> createState() => _SpaRewardsViewState();
}

class _SpaRewardsViewState extends State<SpaRewardsView> {
  int currentPoints = 2450;
  int tier = 2;
  String tierName = "Silver";
  int nextTierPoints = 3000;
  
  List<Map<String, dynamic>> rewardHistory = [
    {
      "date": "2024-12-15",
      "type": "earned",
      "points": 150,
      "description": "Deep Tissue Massage",
      "icon": Icons.add_circle,
      "color": Colors.green,
    },
    {
      "date": "2024-12-10",
      "type": "redeemed",
      "points": -200,
      "description": "Free Aromatherapy Session",
      "icon": Icons.remove_circle,
      "color": Colors.red,
    },
    {
      "date": "2024-12-05",
      "type": "earned",
      "points": 250,
      "description": "Full Body Spa Package",
      "icon": Icons.add_circle,
      "color": Colors.green,
    },
    {
      "date": "2024-12-01",
      "type": "earned",
      "points": 100,
      "description": "Facial Treatment",
      "icon": Icons.add_circle,
      "color": Colors.green,
    },
  ];

  List<Map<String, dynamic>> availableRewards = [
    {
      "title": "Free 30-min Massage",
      "points": 500,
      "description": "Choose from Swedish, Deep Tissue, or Hot Stone",
      "image": "https://picsum.photos/300/200?random=1&keyword=massage",
      "category": "Massage",
    },
    {
      "title": "Complimentary Facial",
      "points": 400,
      "description": "Rejuvenating facial with premium products",
      "image": "https://picsum.photos/300/200?random=2&keyword=facial",
      "category": "Skincare",
    },
    {
      "title": "Aromatherapy Session",
      "points": 300,
      "description": "60-minute relaxation therapy",
      "image": "https://picsum.photos/300/200?random=3&keyword=aromatherapy",
      "category": "Wellness",
    },
    {
      "title": "Spa Day Package",
      "points": 1200,
      "description": "Full day spa experience with all treatments",
      "image": "https://picsum.photos/300/200?random=4&keyword=spa",
      "category": "Package",
    },
    {
      "title": "Manicure & Pedicure",
      "points": 350,
      "description": "Professional nail care service",
      "image": "https://picsum.photos/300/200?random=5&keyword=manicure",
      "category": "Beauty",
    },
    {
      "title": "Couples Massage",
      "points": 800,
      "description": "Romantic spa experience for two",
      "image": "https://picsum.photos/300/200?random=6&keyword=couples",
      "category": "Couples",
    },
  ];

  int selectedTab = 0;
  String selectedCategory = "All";

  List<String> categories = ["All", "Massage", "Skincare", "Wellness", "Package", "Beauty", "Couples"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spa Rewards"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            margin: EdgeInsets.only(right: spMd),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: spXs),
                Text(
                  "${currentPoints.currency}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Points Overview Card
          Container(
            margin: EdgeInsets.all(spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(150)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowMd],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.workspace_premium,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentPoints.currency} Points",
                            style: TextStyle(
                              fontSize: fsH3,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "$tierName Member",
                            style: TextStyle(
                              color: Colors.white.withAlpha(200),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                Text(
                  "Progress to Gold",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: spXs),
                LinearProgressIndicator(
                  value: currentPoints / nextTierPoints,
                  backgroundColor: Colors.white.withAlpha(100),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: spXs),
                Text(
                  "${nextTierPoints - currentPoints} points to next tier",
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: spMd),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 0;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 0 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "Available Rewards",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == 0 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = 1;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: selectedTab == 1 ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusLg),
                      ),
                      child: Text(
                        "History",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedTab == 1 ? Colors.white : disabledBoldColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: spMd),

          // Content
          Expanded(
            child: selectedTab == 0 ? _buildRewardsTab() : _buildHistoryTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsTab() {
    List<Map<String, dynamic>> filteredRewards = selectedCategory == "All"
        ? availableRewards
        : availableRewards.where((reward) => reward["category"] == selectedCategory).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Filter
          QCategoryPicker(
            items: categories.map((category) => {
              "label": category,
              "value": category,
            }).toList(),
            value: selectedCategory,
            onChanged: (index, label, value, item) {
              selectedCategory = value;
              setState(() {});
            },
          ),

          SizedBox(height: spMd),

          // Rewards Grid
          ResponsiveGridView(
            minItemWidth: 200,
            children: filteredRewards.map((reward) {
              bool canRedeem = currentPoints >= (reward["points"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: canRedeem ? primaryColor.withAlpha(100) : disabledOutlineBorderColor,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                      child: Image.network(
                        "${reward["image"]}",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${reward["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: canRedeem ? primaryColor : disabledBoldColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: canRedeem ? primaryColor : disabledColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${(reward["points"] as int).currency} pts",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${reward["description"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: spSm),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: canRedeem ? "Redeem Now" : "Insufficient Points",
                              size: bs.sm,
                              color: canRedeem ? primaryColor : disabledColor,
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

  Widget _buildHistoryTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: spMd),
      child: Column(
        children: rewardHistory.map((history) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(spXs),
                  decoration: BoxDecoration(
                    color: (history["color"] as Color).withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Icon(
                    history["icon"],
                    color: history["color"],
                    size: 20,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${history["description"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${DateTime.parse(history["date"]).dMMMy}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${(history["points"] as int) > 0 ? '+' : ''}${(history["points"] as int).currency}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: history["color"],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  void _redeemReward(Map<String, dynamic> reward) async {
    bool isConfirmed = await confirm("Redeem ${reward["title"]} for ${(reward["points"] as int).currency} points?");
    if (isConfirmed) {
      currentPoints -= (reward["points"] as int);
      rewardHistory.insert(0, {
        "date": DateTime.now().toIso8601String(),
        "type": "redeemed",
        "points": -(reward["points"] as int),
        "description": "${reward["title"]}",
        "icon": Icons.remove_circle,
        "color": Colors.red,
      });
      setState(() {});
      ss("Reward redeemed successfully!");
    }
  }
}
