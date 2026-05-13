import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoyalty2View extends StatefulWidget {
  @override
  State<GrlLoyalty2View> createState() => _GrlLoyalty2ViewState();
}

class _GrlLoyalty2ViewState extends State<GrlLoyalty2View> {
  int currentPoints = 2850;
  int pointsToNextTier = 1150;
  String currentTier = "Gold";
  String nextTier = "Platinum";
  
  List<Map<String, dynamic>> tiers = [
    {
      "name": "Bronze",
      "minPoints": 0,
      "maxPoints": 999,
      "benefits": ["Basic rewards", "Birthday discount"],
      "color": Colors.orange,
      "completed": true,
    },
    {
      "name": "Silver",
      "minPoints": 1000,
      "maxPoints": 2499,
      "benefits": ["Priority support", "Free shipping", "Exclusive offers"],
      "color": Colors.grey,
      "completed": true,
    },
    {
      "name": "Gold",
      "minPoints": 2500,
      "maxPoints": 3999,
      "benefits": ["Premium rewards", "VIP events", "Personal shopper"],
      "color": Colors.amber,
      "completed": false,
      "current": true,
    },
    {
      "name": "Platinum",
      "minPoints": 4000,
      "maxPoints": 7499,
      "benefits": ["Luxury rewards", "Concierge service", "Early access"],
      "color": Colors.indigo,
      "completed": false,
    },
    {
      "name": "Diamond",
      "minPoints": 7500,
      "maxPoints": 999999,
      "benefits": ["Exclusive rewards", "Personal assistant", "VIP treatment"],
      "color": Colors.purple,
      "completed": false,
    },
  ];

  List<Map<String, dynamic>> achievements = [
    {
      "title": "First Purchase",
      "description": "Make your first purchase",
      "points": 100,
      "completed": true,
      "icon": Icons.shopping_cart,
    },
    {
      "title": "Social Butterfly",
      "description": "Share 5 products on social media",
      "points": 200,
      "completed": true,
      "icon": Icons.share,
    },
    {
      "title": "Loyal Customer",
      "description": "Make 10 purchases",
      "points": 500,
      "completed": false,
      "progress": 7,
      "total": 10,
      "icon": Icons.favorite,
    },
    {
      "title": "Review Master",
      "description": "Write 20 product reviews",
      "points": 300,
      "completed": false,
      "progress": 15,
      "total": 20,
      "icon": Icons.rate_review,
    },
    {
      "title": "Referral Champion",
      "description": "Refer 5 friends",
      "points": 1000,
      "completed": false,
      "progress": 2,
      "total": 5,
      "icon": Icons.group_add,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loyalty Program"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentStatusCard(),
            SizedBox(height: spLg),
            _buildProgressSection(),
            SizedBox(height: spLg),
            _buildTierBenefits(),
            SizedBox(height: spLg),
            _buildAchievements(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStatusCard() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber, Colors.orange],
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
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  Icons.military_tech,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Tier",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      currentTier,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Points",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      currentPoints.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
                      "Points to $nextTier",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      pointsToNextTier.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    double progress = currentPoints / (currentPoints + pointsToNextTier);
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Progress to $nextTier",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Text(
                currentTier,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Spacer(),
              Text(
                nextTier,
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: disabledColor,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            minHeight: 8,
          ),
          SizedBox(height: spSm),
          Text(
            "${(progress * 100).toInt()}% Complete",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierBenefits() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tier Benefits",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: tiers.map((tier) {
              bool isCurrent = tier["current"] == true;
              bool isCompleted = tier["completed"] == true;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isCurrent ? (tier["color"] as Color).withAlpha(20) : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isCurrent ? (tier["color"] as Color) : Colors.transparent,
                    width: 2,
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
                            color: (tier["color"] as Color).withAlpha(isCompleted ? 255 : 100),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : Icons.lock,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${tier["name"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                  color: isCurrent ? (tier["color"] as Color) : disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${tier["minPoints"]} - ${tier["maxPoints"]} points",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isCurrent)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (tier["color"] as Color),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "CURRENT",
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
                    Column(
                      children: (tier["benefits"] as List<String>).map((benefit) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: spXs),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: (tier["color"] as Color).withAlpha(isCompleted ? 255 : 100),
                                size: 16,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                benefit,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isCompleted ? primaryColor : disabledBoldColor,
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
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Achievements",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: achievements.map((achievement) {
              bool isCompleted = achievement["completed"] == true;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: isCompleted ? successColor.withAlpha(20) : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: isCompleted ? successColor : Colors.transparent,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: isCompleted ? successColor : disabledColor,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        achievement["icon"] as IconData,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${achievement["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isCompleted ? successColor : disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${achievement["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          if (!isCompleted && achievement["progress"] != null)
                            Padding(
                              padding: EdgeInsets.only(top: spXs),
                              child: LinearProgressIndicator(
                                value: (achievement["progress"] as int) / (achievement["total"] as int),
                                backgroundColor: disabledColor,
                                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                minHeight: 4,
                              ),
                            ),
                          if (!isCompleted && achievement["progress"] != null)
                            Padding(
                              padding: EdgeInsets.only(top: spXs),
                              child: Text(
                                "${achievement["progress"]}/${achievement["total"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "+${achievement["points"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isCompleted ? successColor : disabledBoldColor,
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
          ),
        ],
      ),
    );
  }
}
