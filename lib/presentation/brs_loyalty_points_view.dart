import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsLoyaltyPointsView extends StatefulWidget {
  const BrsLoyaltyPointsView({super.key});

  @override
  State<BrsLoyaltyPointsView> createState() => _BrsLoyaltyPointsViewState();
}

class _BrsLoyaltyPointsViewState extends State<BrsLoyaltyPointsView> {
  int currentPoints = 2450;
  String selectedTab = "Earn";
  
  List<String> tabs = ["Earn", "Redeem", "History"];
  
  List<Map<String, dynamic>> earnWays = [
    {
      "id": 1,
      "title": "Book Any Service",
      "description": "Earn 5 points for every dollar spent",
      "points": 5,
      "icon": Icons.content_cut,
      "color": primaryColor,
      "multiplier": "per \$1",
    },
    {
      "id": 2,
      "title": "Write a Review",
      "description": "Share your experience and earn bonus points",
      "points": 50,
      "icon": Icons.star,
      "color": warningColor,
      "multiplier": "per review",
    },
    {
      "id": 3,
      "title": "Refer a Friend",
      "description": "Invite friends and both get points",
      "points": 200,
      "icon": Icons.people,
      "color": successColor,
      "multiplier": "per referral",
    },
    {
      "id": 4,
      "title": "Birthday Bonus",
      "description": "Special points on your birthday month",
      "points": 100,
      "icon": Icons.cake,
      "color": dangerColor,
      "multiplier": "yearly",
    },
    {
      "id": 5,
      "title": "Social Media Share",
      "description": "Share our posts on social media",
      "points": 25,
      "icon": Icons.share,
      "color": infoColor,
      "multiplier": "per share",
    },
  ];

  List<Map<String, dynamic>> redeemOptions = [
    {
      "id": 1,
      "title": "Free Haircut",
      "description": "Get a complimentary classic haircut",
      "pointsCost": 500,
      "value": "\$25",
      "image": "https://picsum.photos/150/100?random=1&keyword=haircut",
      "available": true,
      "popular": true,
    },
    {
      "id": 2,
      "title": "Beard Trim Discount",
      "description": "50% off on any beard trimming service",
      "pointsCost": 300,
      "value": "\$15",
      "image": "https://picsum.photos/150/100?random=2&keyword=beard",
      "available": true,
      "popular": false,
    },
    {
      "id": 3,
      "title": "Hot Towel Treatment",
      "description": "Complimentary hot towel relaxation",
      "pointsCost": 200,
      "value": "\$10",
      "image": "https://picsum.photos/150/100?random=3&keyword=towel",
      "available": true,
      "popular": false,
    },
    {
      "id": 4,
      "title": "Premium Package",
      "description": "Full grooming package with all services",
      "pointsCost": 1000,
      "value": "\$60",
      "image": "https://picsum.photos/150/100?random=4&keyword=grooming",
      "available": false,
      "popular": true,
    },
    {
      "id": 5,
      "title": "Gift Card \$20",
      "description": "Digital gift card for friends or family",
      "pointsCost": 400,
      "value": "\$20",
      "image": "https://picsum.photos/150/100?random=5&keyword=gift",
      "available": true,
      "popular": false,
    },
  ];

  List<Map<String, dynamic>> pointsHistory = [
    {
      "id": 1,
      "type": "earned",
      "title": "Service Booking",
      "description": "Classic Haircut at Elite Cuts",
      "points": 125,
      "date": "Mar 15, 2024",
      "time": "2:30 PM",
    },
    {
      "id": 2,
      "type": "redeemed",
      "title": "Free Beard Trim",
      "description": "Redeemed discount coupon",
      "points": -300,
      "date": "Mar 12, 2024",
      "time": "11:15 AM",
    },
    {
      "id": 3,
      "type": "earned",
      "title": "Review Bonus",
      "description": "5-star review for Modern Grooming",
      "points": 50,
      "date": "Mar 10, 2024",
      "time": "4:45 PM",
    },
    {
      "id": 4,
      "type": "earned",
      "title": "Referral Bonus",
      "description": "Friend John signed up",
      "points": 200,
      "date": "Mar 8, 2024",
      "time": "9:20 AM",
    },
    {
      "id": 5,
      "type": "earned",
      "title": "Service Booking",
      "description": "Hot Towel Shave at Premium Cuts",
      "points": 160,
      "date": "Mar 5, 2024",
      "time": "3:00 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loyalty Points"),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showHelpSheet();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Points Balance Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withAlpha(200)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Your Balance",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "$currentPoints",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Points",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
                
                SizedBox(height: spMd),
                
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "15",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Services",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
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
                          color: Colors.white.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Gold",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Member",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withAlpha(200),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab Navigation
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: tabs.map((tab) {
                bool isSelected = selectedTab == tab;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedTab = tab;
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: spSm),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        tab,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : disabledBoldColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Content based on selected tab
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case "Earn":
        return _buildEarnTab();
      case "Redeem":
        return _buildRedeemTab();
      case "History":
        return _buildHistoryTab();
      default:
        return _buildEarnTab();
    }
  }

  Widget _buildEarnTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: earnWays.length,
      itemBuilder: (context, index) {
        final way = earnWays[index];
        return Container(
          margin: EdgeInsets.only(bottom: spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Padding(
            padding: EdgeInsets.all(spMd),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: (way["color"] as Color).withAlpha(50),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Icon(
                    way["icon"] as IconData,
                    color: way["color"] as Color,
                    size: 24,
                  ),
                ),
                SizedBox(width: spMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${way["title"]}",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${way["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "+${way["points"]}",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "${way["multiplier"]}",
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
        );
      },
    );
  }

  Widget _buildRedeemTab() {
    return ResponsiveGridView(
      padding: EdgeInsets.all(spMd),
      minItemWidth: 160,
      children: redeemOptions.map((option) {
        bool canAfford = currentPoints >= (option["pointsCost"] as int);
        bool isAvailable = option["available"] as bool;
        
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radiusMd),
                      topRight: Radius.circular(radiusMd),
                    ),
                    child: Image.network(
                      "${option["image"]}",
                      width: double.infinity,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (option["popular"] as bool)
                    Positioned(
                      top: spXs,
                      left: spXs,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "Popular",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  if (!isAvailable)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(100),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(radiusMd),
                            topRight: Radius.circular(radiusMd),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Coming Soon",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${option["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${option["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "${option["pointsCost"]} pts",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${option["value"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                child: QButton(
                  label: isAvailable ? (canAfford ? "Redeem" : "Not Enough") : "Unavailable",
                  size: bs.sm,
                  onPressed: isAvailable && canAfford ? () {
                    si("Redeeming ${option["title"]}");
                  } : null,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHistoryTab() {
    return ListView.builder(
      padding: EdgeInsets.all(spMd),
      itemCount: pointsHistory.length,
      itemBuilder: (context, index) {
        final history = pointsHistory[index];
        bool isEarned = history["type"] == "earned";
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusSm),
            border: Border.all(color: disabledOutlineBorderColor),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isEarned ? successColor.withAlpha(50) : dangerColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusLg),
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
                      "${history["title"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${history["description"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${history["date"]} • ${history["time"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${isEarned ? '+' : ''}${history["points"]}",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: isEarned ? successColor : dangerColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showHelpSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "How Loyalty Points Work",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Earning Points",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "• Earn 5 points for every \$1 spent on services\n• Get bonus points for reviews and referrals\n• Special birthday and anniversary bonuses",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Text(
                "Redeeming Points",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "• 100 points = \$5 value\n• Points never expire\n• Redeem for services, discounts, or gift cards",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: spMd),
              
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Got It",
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
