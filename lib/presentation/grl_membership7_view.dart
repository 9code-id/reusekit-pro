import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMembership7View extends StatefulWidget {
  @override
  State<GrlMembership7View> createState() => _GrlMembership7ViewState();
}

class _GrlMembership7ViewState extends State<GrlMembership7View> {
  String membershipTier = "silver";
  
  Map<String, dynamic> currentMember = {
    "name": "Alex Johnson",
    "email": "alex.johnson@email.com",
    "memberId": "MB-2024-001",
    "tier": "Silver",
    "points": 2450,
    "nextTierPoints": 5000,
    "joinDate": "2024-01-15",
    "avatar": "https://picsum.photos/80/80?random=1&keyword=person",
    "level": 2,
    "totalSpent": 1299.99,
    "badges": ["Early Adopter", "Loyal Customer", "Reviewer"],
  };

  List<Map<String, dynamic>> membershipTiers = [
    {
      "name": "Bronze",
      "pointsRequired": 0,
      "color": Color(0xFFCD7F32),
      "icon": Icons.looks_one,
      "benefits": [
        "Basic customer support",
        "Monthly newsletter",
        "Access to sales events",
      ],
      "discount": 5,
    },
    {
      "name": "Silver",
      "pointsRequired": 1000,
      "color": Color(0xFFC0C0C0),
      "icon": Icons.looks_two,
      "benefits": [
        "Priority customer support",
        "Exclusive member prices",
        "Early access to new products",
        "Free shipping on orders over \$50",
      ],
      "discount": 10,
    },
    {
      "name": "Gold",
      "pointsRequired": 5000,
      "color": Color(0xFFFFD700),
      "icon": Icons.looks_3,
      "benefits": [
        "VIP customer support",
        "Personal shopping assistant",
        "Free shipping on all orders",
        "Exclusive VIP events",
        "Birthday rewards",
      ],
      "discount": 15,
    },
    {
      "name": "Platinum",
      "pointsRequired": 10000,
      "color": Color(0xFFE5E4E2),
      "icon": Icons.looks_4,
      "benefits": [
        "Dedicated account manager",
        "Custom product recommendations",
        "White-glove service",
        "Exclusive platinum events",
        "Annual VIP gifts",
        "Priority product launches",
      ],
      "discount": 20,
    },
  ];

  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "purchase",
      "description": "Purchased Premium Wireless Headphones",
      "points": 150,
      "date": "2024-06-18",
      "icon": Icons.shopping_cart,
      "color": successColor,
    },
    {
      "type": "review",
      "description": "Left a review for Smart Watch",
      "points": 25,
      "date": "2024-06-15",
      "icon": Icons.star,
      "color": warningColor,
    },
    {
      "type": "referral",
      "description": "Referred a friend: Sarah Chen",
      "points": 200,
      "date": "2024-06-12",
      "icon": Icons.people,
      "color": infoColor,
    },
    {
      "type": "birthday",
      "description": "Birthday bonus points",
      "points": 100,
      "date": "2024-06-10",
      "icon": Icons.cake,
      "color": primaryColor,
    },
    {
      "type": "purchase",
      "description": "Purchased Fitness Tracker",
      "points": 75,
      "date": "2024-06-08",
      "icon": Icons.shopping_cart,
      "color": successColor,
    },
  ];

  List<Map<String, dynamic>> availableRewards = [
    {
      "title": "Free Shipping Voucher",
      "points": 500,
      "description": "Free shipping on your next order",
      "image": "https://picsum.photos/60/60?random=1&keyword=shipping",
      "category": "shipping",
    },
    {
      "title": "\$10 Store Credit",
      "points": 1000,
      "description": "Get \$10 credit for your next purchase",
      "image": "https://picsum.photos/60/60?random=2&keyword=money",
      "category": "credit",
    },
    {
      "title": "Premium Support",
      "points": 750,
      "description": "30 days of premium customer support",
      "image": "https://picsum.photos/60/60?random=3&keyword=support",
      "category": "support",
    },
    {
      "title": "Exclusive Product Access",
      "points": 2000,
      "description": "Early access to limited edition products",
      "image": "https://picsum.photos/60/60?random=4&keyword=exclusive",
      "category": "access",
    },
  ];

  double get progressToNextTier {
    int currentPoints = currentMember["points"] as int;
    int nextTierPoints = currentMember["nextTierPoints"] as int;
    
    // Find current tier
    int currentTierPoints = 0;
    for (var tier in membershipTiers) {
      if (tier["name"].toString().toLowerCase() == currentMember["tier"].toString().toLowerCase()) {
        currentTierPoints = tier["pointsRequired"] as int;
        break;
      }
    }
    
    return (currentPoints - currentTierPoints) / (nextTierPoints - currentTierPoints);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Membership Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share membership
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Member profile header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusLg),
                        child: Image.network(
                          "${currentMember["avatar"]}",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentMember["name"]}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${currentMember["email"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${currentMember["tier"]} Member",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Level ${currentMember["level"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Points and progress
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Points",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${currentMember["points"]}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
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
                              "Next Tier",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${currentMember["nextTierPoints"] - currentMember["points"]} points to go",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: warningColor,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spSm),
                  
                  // Progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Progress to Gold",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "${(progressToNextTier * 100).toInt()}%",
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      LinearProgressIndicator(
                        value: progressToNextTier,
                        backgroundColor: disabledColor,
                        valueColor: AlwaysStoppedAnimation<Color>(warningColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Member badges
            if ((currentMember["badges"] as List).isNotEmpty) ...[
              Text(
                "Member Badges",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              
              QHorizontalScroll(
                children: (currentMember["badges"] as List).map((badge) {
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    margin: EdgeInsets.only(right: spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: warningColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusLg),
                          ),
                          child: Icon(
                            Icons.emoji_events,
                            color: warningColor,
                            size: 24,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "$badge",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              SizedBox(height: spMd),
            ],
            
            // Membership tiers
            Text(
              "Membership Tiers",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ...List.generate(membershipTiers.length, (index) {
              final tier = membershipTiers[index];
              final isCurrentTier = tier["name"].toString().toLowerCase() == 
                  currentMember["tier"].toString().toLowerCase();
              final tierColor = tier["color"] as Color;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusSm),
                  boxShadow: [shadowSm],
                  border: isCurrentTier 
                      ? Border.all(color: tierColor, width: 2)
                      : Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: tierColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            tier["icon"] as IconData,
                            color: tierColor,
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
                                    "${tier["name"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: tierColor,
                                      fontSize: fsH6,
                                    ),
                                  ),
                                  if (isCurrentTier) ...[
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "CURRENT",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                "${tier["pointsRequired"]} points required",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: tierColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${tier["discount"]}% OFF",
                            style: TextStyle(
                              color: tierColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spSm),
                    
                    ...List.generate((tier["benefits"] as List).length, (benefitIndex) {
                      final benefit = (tier["benefits"] as List)[benefitIndex];
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: tierColor,
                              size: 14,
                            ),
                            SizedBox(width: spSm),
                            Expanded(
                              child: Text(
                                "$benefit",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              );
            }),
            
            SizedBox(height: spMd),
            
            // Available rewards
            Text(
              "Available Rewards",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: availableRewards.map((reward) {
                final canRedeem = (currentMember["points"] as int) >= (reward["points"] as int);
                
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: canRedeem ? successColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                              children: [
                                Text(
                                  "${reward["title"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${reward["points"]} points",
                                  style: TextStyle(
                                    color: warningColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${reward["description"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: canRedeem ? "Redeem" : "Not enough points",
                          size: bs.sm,
                          color: canRedeem ? primaryColor : disabledBoldColor,
                          onPressed: canRedeem ? () {
                            // Redeem reward
                          } : null,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Recent activity
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),
            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: List.generate(recentActivity.length, (index) {
                  final activity = recentActivity[index];
                  
                  return Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      border: index < recentActivity.length - 1
                          ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                          : null,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (activity["color"] as Color).withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            activity["icon"] as IconData,
                            color: activity["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${activity["description"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "${DateTime.parse(activity["date"]).dMMMy}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "+${activity["points"]} pts",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
