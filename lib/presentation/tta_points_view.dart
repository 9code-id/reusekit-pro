import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaPointsView extends StatefulWidget {
  const TtaPointsView({super.key});

  @override
  State<TtaPointsView> createState() => _TtaPointsViewState();
}

class _TtaPointsViewState extends State<TtaPointsView> {
  int selectedTab = 0; // 0: Earn, 1: Redeem, 2: Transfer

  final Map<String, dynamic> pointsData = {
    "currentPoints": 12580,
    "totalEarned": 45230,
    "totalRedeemed": 32650,
    "pointsExpiringSoon": 850,
    "expiryDate": "2024-09-30",
    "conversionRate": 100, // 100 points = \$1
  };

  final List<Map<String, dynamic>> earnOpportunities = [
    {
      "type": "booking",
      "title": "Hotel Bookings",
      "description": "Earn 5 points per \$1 spent on hotel reservations",
      "rate": "5 points/\$1",
      "icon": Icons.hotel,
      "color": 0xFF2196F3,
      "category": "travel"
    },
    {
      "type": "booking",
      "title": "Flight Bookings",
      "description": "Earn 3 points per \$1 spent on flight tickets",
      "rate": "3 points/\$1",
      "icon": Icons.flight_takeoff,
      "color": 0xFF4CAF50,
      "category": "travel"
    },
    {
      "type": "booking",
      "title": "Car Rentals",
      "description": "Earn 4 points per \$1 spent on car rentals",
      "rate": "4 points/\$1",
      "icon": Icons.directions_car,
      "color": 0xFFFF9800,
      "category": "travel"
    },
    {
      "type": "bonus",
      "title": "Hotel Reviews",
      "description": "Write detailed reviews after your stay",
      "rate": "50 points",
      "icon": Icons.rate_review,
      "color": 0xFF9C27B0,
      "category": "activity"
    },
    {
      "type": "bonus",
      "title": "Referral Program",
      "description": "Refer friends and earn when they book",
      "rate": "500 points",
      "icon": Icons.group_add,
      "color": 0xFFF44336,
      "category": "referral"
    },
    {
      "type": "bonus",
      "title": "Social Media Sharing",
      "description": "Share your travel photos and experiences",
      "rate": "25 points",
      "icon": Icons.share,
      "color": 0xFF795548,
      "category": "activity"
    }
  ];

  final List<Map<String, dynamic>> redeemOptions = [
    {
      "type": "travel",
      "title": "Room Upgrades",
      "description": "Upgrade to premium rooms at participating hotels",
      "cost": 2500,
      "value": "\$50 value",
      "icon": Icons.upgrade,
      "color": 0xFF2196F3,
      "availability": "Available"
    },
    {
      "type": "travel",
      "title": "Free Nights", 
      "description": "Get free hotel nights at select properties",
      "cost": 5000,
      "value": "\$100 value",
      "icon": Icons.hotel,
      "color": 0xFF4CAF50,
      "availability": "Available"
    },
    {
      "type": "travel",
      "title": "Airport Lounge Access",
      "description": "Day passes to premium airport lounges worldwide",
      "cost": 1500,
      "value": "\$35 value",
      "icon": Icons.airline_seat_recline_extra,
      "color": 0xFFFF9800,
      "availability": "Limited"
    },
    {
      "type": "service",
      "title": "Priority Check-in",
      "description": "Skip lines with priority check-in service",
      "cost": 750,
      "value": "\$15 value",
      "icon": Icons.timer,
      "color": 0xFF9C27B0,
      "availability": "Available"
    },
    {
      "type": "gift",
      "title": "Gift Cards",
      "description": "Redeem for restaurant and shopping gift cards",
      "cost": 1000,
      "value": "\$10 value",
      "icon": Icons.card_giftcard,
      "color": 0xFFF44336,
      "availability": "Available"
    },
    {
      "type": "cash",
      "title": "Statement Credit",
      "description": "Apply credits directly to your account",
      "cost": 2000,
      "value": "\$20 value",
      "icon": Icons.account_balance_wallet,
      "color": 0xFF795548,
      "availability": "Available"
    }
  ];

  final List<Map<String, dynamic>> recentTransactions = [
    {
      "type": "earned",
      "amount": 450,
      "description": "Hotel booking - Grand Palace Paris",
      "date": "2024-06-25",
      "reference": "HTL-2024-789456"
    },
    {
      "type": "redeemed",
      "amount": -1500,
      "description": "Airport lounge access - JFK Terminal 4",
      "date": "2024-06-22",
      "reference": "RED-2024-456789"
    },
    {
      "type": "earned",
      "amount": 320,
      "description": "Flight booking - Tokyo to New York",
      "date": "2024-06-20",
      "reference": "FLT-2024-123456"
    },
    {
      "type": "bonus",
      "amount": 500,
      "description": "Friend referral bonus - John Smith",
      "date": "2024-06-18",
      "reference": "REF-2024-111222"
    },
    {
      "type": "earned",
      "amount": 280,
      "description": "Car rental - BMW X3 Munich",
      "date": "2024-06-15",
      "reference": "CAR-2024-334455"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Points & Rewards"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to full history
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPointsOverview(),
          _buildTabBar(),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsOverview() {
    return Container(
      margin: EdgeInsets.all(spMd),
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor,
            primaryColor.withAlpha(204),
          ],
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowLg],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available Points",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                    Text(
                      "${(pointsData["currentPoints"] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                      style: TextStyle(
                        fontSize: fsH2,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "≈ \$${((pointsData["currentPoints"] as int) / (pointsData["conversionRate"] as int)).toStringAsFixed(0)} value",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withAlpha(204),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Icon(
                  Icons.stars,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          
          SizedBox(height: spLg),
          
          Row(
            children: [
              Expanded(
                child: _buildPointsStat(
                  "Total Earned",
                  "${(pointsData["totalEarned"] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                  Icons.trending_up,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withAlpha(77),
              ),
              Expanded(
                child: _buildPointsStat(
                  "Total Redeemed",
                  "${(pointsData["totalRedeemed"] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}",
                  Icons.redeem,
                ),
              ),
            ],
          ),
          
          if (pointsData["pointsExpiringSoon"] > 0) ...[
            SizedBox(height: spMd),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: warningColor.withAlpha(51),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.white, size: 16),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Text(
                      "${pointsData["pointsExpiringSoon"]} points expiring on ${DateTime.parse(pointsData["expiryDate"]).dMMMy}",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPointsStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withAlpha(204), size: 20),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(204),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    final tabs = ["Earn Points", "Redeem", "Transfer"];
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedTab == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab = index;
                setState(() {});
              },
              child: Container(
                margin: EdgeInsets.only(right: index < tabs.length - 1 ? spXs : 0),
                padding: EdgeInsets.symmetric(vertical: spSm),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Text(
                  tabs[index],
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
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildEarnTab();
      case 1:
        return _buildRedeemTab();
      case 2:
        return _buildTransferTab();
      default:
        return _buildEarnTab();
    }
  }

  Widget _buildEarnTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ways to Earn Points",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          Column(
            children: earnOpportunities.map((opportunity) {
              return _buildEarnCard(opportunity);
            }).toList(),
          ),
          
          SizedBox(height: spMd),
          
          _buildRecentActivity(),
        ],
      ),
    );
  }

  Widget _buildEarnCard(Map<String, dynamic> opportunity) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Color(opportunity["color"] as int).withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              opportunity["icon"],
              color: Color(opportunity["color"] as int),
              size: 24,
            ),
          ),
          
          SizedBox(width: spMd),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${opportunity["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${opportunity["description"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Color(opportunity["color"] as int).withAlpha(25),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${opportunity["rate"]}",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(opportunity["color"] as int),
                  ),
                ),
              ),
              if (opportunity["type"] == "bonus") ...[
                SizedBox(height: spXs),
                QButton(
                  label: "Start",
                  size: bs.sm,
                  onPressed: () {
                    // Navigate to activity
                  },
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Redeem Your Points",
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
            children: redeemOptions.map((option) {
              return _buildRedeemCard(option);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemCard(Map<String, dynamic> option) {
    final canAfford = (pointsData["currentPoints"] as int) >= (option["cost"] as int);
    
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Color(option["color"] as int).withAlpha(25),
              borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
            ),
            child: Column(
              children: [
                Icon(
                  option["icon"],
                  color: Color(option["color"] as int),
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  "${(option["cost"] as int).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')} points",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(option["color"] as int),
                  ),
                ),
                Text(
                  "${option["value"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(option["color"] as int),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${option["title"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spXs),
                
                Text(
                  "${option["description"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: spSm),
                
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: option["availability"] == "Available" 
                            ? successColor.withAlpha(25) 
                            : warningColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${option["availability"]}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: option["availability"] == "Available" 
                              ? successColor 
                              : warningColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: canAfford ? "Redeem" : "Need More",
                      size: bs.sm,
                      onPressed: canAfford ? () {
                        _showRedeemConfirmation(option);
                      } : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Transfer Points",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          
          SizedBox(height: spMd),
          
          _buildTransferCard(
            "Transfer to Friend",
            "Share points with family and friends",
            Icons.person_add,
            infoColor,
          ),
          
          SizedBox(height: spMd),
          
          _buildTransferCard(
            "Convert to Miles",
            "Transfer points to airline partners",
            Icons.flight,
            successColor,
          ),
          
          SizedBox(height: spMd),
          
          _buildTransferCard(
            "Pool Points",
            "Combine points with family members",
            Icons.group,
            warningColor,
          ),
          
          SizedBox(height: spMd),
          
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: disabledOutlineBorderColor),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transfer Limits & Fees",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                
                SizedBox(height: spMd),
                
                _buildTransferInfo("Minimum transfer", "500 points"),
                _buildTransferInfo("Maximum per month", "10,000 points"),
                _buildTransferInfo("Transfer fee", "100 points per transaction"),
                _buildTransferInfo("Processing time", "1-2 business days"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(radiusMd),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          
          SizedBox(width: spMd),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          QButton(
            label: "Transfer",
            size: bs.sm,
            onPressed: () {
              // Navigate to transfer form
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransferInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: spSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            value,
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

  Widget _buildRecentActivity() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: disabledOutlineBorderColor),
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
                  // Navigate to full history
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
          
          SizedBox(height: spMd),
          
          Column(
            children: recentTransactions.take(5).map((transaction) {
              return _buildTransactionItem(transaction);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    Color getTransactionColor() {
      switch (transaction["type"]) {
        case "earned":
          return successColor;
        case "redeemed":
          return dangerColor;
        case "bonus":
          return warningColor;
        default:
          return primaryColor;
      }
    }

    IconData getTransactionIcon() {
      switch (transaction["type"]) {
        case "earned":
          return Icons.add_circle;
        case "redeemed":
          return Icons.remove_circle;
        case "bonus":
          return Icons.stars;
        default:
          return Icons.circle;
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: spSm),
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: getTransactionColor().withAlpha(13),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Icon(
            getTransactionIcon(),
            color: getTransactionColor(),
            size: 20,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${DateTime.parse(transaction["date"]).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            "${transaction["amount"] > 0 ? '+' : ''}${transaction["amount"]}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: getTransactionColor(),
            ),
          ),
        ],
      ),
    );
  }

  void _showRedeemConfirmation(Map<String, dynamic> option) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Redemption"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("You are about to redeem:"),
              SizedBox(height: spSm),
              Text(
                "${option["title"]}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text("${option["cost"]} points"),
              SizedBox(height: spSm),
              Text(
                "Remaining balance: ${(pointsData["currentPoints"] as int) - (option["cost"] as int)} points",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => back(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                back();
                ss("Points redeemed successfully!");
                // Update points balance
                pointsData["currentPoints"] = (pointsData["currentPoints"] as int) - (option["cost"] as int);
                setState(() {});
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
