import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoyalty10View extends StatefulWidget {
  @override
  State<GrlLoyalty10View> createState() => _GrlLoyalty10ViewState();
}

class _GrlLoyalty10ViewState extends State<GrlLoyalty10View> {
  int currentPoints = 3450;
  String membershipTier = "Gold";
  int currentTab = 0;
  
  List<Map<String, dynamic>> recentActivity = [
    {
      "type": "earned",
      "points": 100,
      "description": "Shopping purchase",
      "merchant": "Fashion Store",
      "date": "2024-06-22",
      "time": "14:30",
      "icon": Icons.shopping_bag,
    },
    {
      "type": "redeemed",
      "points": -500,
      "description": "Free coffee reward",
      "merchant": "Bean There Coffee",
      "date": "2024-06-21",
      "time": "09:15",
      "icon": Icons.local_cafe,
    },
    {
      "type": "earned",
      "points": 50,
      "description": "Daily check-in",
      "merchant": "Loyalty App",
      "date": "2024-06-21",
      "time": "08:00",
      "icon": Icons.today,
    },
  ];

  List<Map<String, dynamic>> quickActions = [
    {
      "title": "Earn Points",
      "description": "Ways to earn more points",
      "icon": Icons.add_circle,
      "color": Colors.green,
      "action": "earn_points",
    },
    {
      "title": "Redeem Rewards",
      "description": "Browse available rewards",
      "icon": Icons.redeem,
      "color": Colors.orange,
      "action": "rewards",
    },
    {
      "title": "Refer Friends",
      "description": "Earn 500 points per friend",
      "icon": Icons.group_add,
      "color": Colors.blue,
      "action": "referrals",
    },
    {
      "title": "View Coupons",
      "description": "My available coupons",
      "icon": Icons.local_offer,
      "color": Colors.purple,
      "action": "coupons",
    },
  ];

  List<Map<String, dynamic>> featuredRewards = [
    {
      "id": 1,
      "name": "Free Coffee",
      "points": 250,
      "image": "https://picsum.photos/120/80?random=1&keyword=coffee",
      "category": "Food & Drink",
    },
    {
      "id": 2,
      "name": "Movie Ticket",
      "points": 800,
      "image": "https://picsum.photos/120/80?random=2&keyword=movie",
      "category": "Entertainment",
    },
    {
      "id": 3,
      "name": "\$10 Voucher",
      "points": 1000,
      "image": "https://picsum.photos/120/80?random=3&keyword=voucher",
      "category": "Shopping",
    },
  ];

  List<Map<String, dynamic>> specialOffers = [
    {
      "title": "Double Points Weekend",
      "description": "Earn 2x points on all purchases",
      "validUntil": "2024-06-23",
      "type": "multiplier",
      "color": Colors.orange,
      "icon": Icons.weekend,
    },
    {
      "title": "Birthday Bonus",
      "description": "500 extra points this month",
      "validUntil": "2024-06-30",
      "type": "bonus",
      "color": Colors.pink,
      "icon": Icons.cake,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QBottomBar(
      title: "Loyalty Program",
      selectedIndex: currentTab,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.redeem),
          label: "Rewards",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      children: [
        _buildHomeTab(),
        _buildRewardsTab(),
        _buildHistoryTab(),
        _buildProfileTab(),
      ],
      onTap: (index) {
        currentTab = index;
        setState(() {});
      },
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPointsCard(),
          SizedBox(height: spLg),
          _buildSpecialOffers(),
          SizedBox(height: spLg),
          _buildQuickActions(),
          SizedBox(height: spLg),
          _buildFeaturedRewards(),
          SizedBox(height: spLg),
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildPointsCard() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(180)],
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
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white.withAlpha(40),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back!",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "John Doe",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(40),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  membershipTier,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spLg),
          Text(
            "Available Points",
            style: TextStyle(
              color: Colors.white.withAlpha(200),
              fontSize: 16,
            ),
          ),
          Text(
            currentPoints.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: spMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "This Month",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "+450 points",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
                      "Next Tier",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Platinum (550 pts)",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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

  Widget _buildSpecialOffers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Special Offers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        QHorizontalScroll(
          children: specialOffers.map((offer) {
            return Container(
              width: 280,
              margin: EdgeInsets.only(right: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    offer["color"] as Color,
                    (offer["color"] as Color).withAlpha(180),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        offer["icon"] as IconData,
                        color: Colors.white,
                        size: 24,
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${offer["type"]}".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${offer["title"]}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${offer["description"]}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "Valid until ${offer["validUntil"]}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
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
            "Quick Actions",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: quickActions.map((action) {
              return GestureDetector(
                onTap: () {
                  _handleQuickAction(action["action"]);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: (action["color"] as Color).withAlpha(10),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: (action["color"] as Color).withAlpha(50),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        action["icon"] as IconData,
                        color: action["color"] as Color,
                        size: 24,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${action["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: action["color"] as Color,
                              ),
                            ),
                            Text(
                              "${action["description"]}",
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
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedRewards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Featured Rewards",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Navigate to all rewards
                ss("Viewing all rewards...");
              },
              child: Text(
                "View All",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spMd),
        QHorizontalScroll(
          children: featuredRewards.map((reward) {
            bool canRedeem = currentPoints >= (reward["points"] as int);
            
            return Container(
              width: 160,
              margin: EdgeInsets.only(right: spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                        child: Image.network(
                          "${reward["image"]}",
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: spSm,
                        right: spSm,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: canRedeem ? successColor : warningColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "${reward["points"]} pts",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(spSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${reward["name"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${reward["category"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Container(
                          width: double.infinity,
                          child: QButton(
                            label: canRedeem ? "Redeem" : "Need More",
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
    );
  }

  Widget _buildRecentActivity() {
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
          Row(
            children: [
              Text(
                "Recent Activity",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  // Navigate to history
                  ss("Viewing full history...");
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: recentActivity.map((activity) {
              bool isEarned = activity["type"] == "earned";
              int points = activity["points"] as int;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (isEarned ? successColor : dangerColor).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      activity["icon"] as IconData,
                      color: isEarned ? successColor : dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${activity["description"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${activity["merchant"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${activity["date"]} at ${activity["time"]}",
                            style: TextStyle(
                              color: disabledBoldColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "${isEarned ? '+' : ''}${points.toString()}",
                      style: TextStyle(
                        color: isEarned ? successColor : dangerColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
    return Center(
      child: Text(
        "Rewards Tab Content",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Center(
      child: Text(
        "History Tab Content",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildProfileTab() {
    return Center(
      child: Text(
        "Profile Tab Content",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  void _handleQuickAction(String action) {
    ss("Opening $action...");
  }

  void _redeemReward(Map<String, dynamic> reward) {
    ss("Redeeming ${reward["name"]}...");
  }
}
