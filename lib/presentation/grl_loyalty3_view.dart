import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlLoyalty3View extends StatefulWidget {
  @override
  State<GrlLoyalty3View> createState() => _GrlLoyalty3ViewState();
}

class _GrlLoyalty3ViewState extends State<GrlLoyalty3View> {
  int currentPoints = 3250;
  
  List<Map<String, dynamic>> pointsPackages = [
    {
      "id": 1,
      "points": 100,
      "price": 0.99,
      "bonus": 0,
      "popular": false,
      "icon": Icons.star_border,
    },
    {
      "id": 2,
      "points": 500,
      "price": 4.99,
      "bonus": 50,
      "popular": false,
      "icon": Icons.star_half,
    },
    {
      "id": 3,
      "points": 1000,
      "price": 9.99,
      "bonus": 150,
      "popular": true,
      "icon": Icons.star,
    },
    {
      "id": 4,
      "points": 2500,
      "price": 19.99,
      "bonus": 500,
      "popular": false,
      "icon": Icons.stars,
    },
    {
      "id": 5,
      "points": 5000,
      "price": 39.99,
      "bonus": 1200,
      "popular": false,
      "icon": Icons.military_tech,
    },
  ];

  List<Map<String, dynamic>> earnMethods = [
    {
      "title": "Daily Check-in",
      "description": "Visit the app daily to earn points",
      "points": "5-25",
      "icon": Icons.today,
      "color": Colors.blue,
    },
    {
      "title": "Make Purchase",
      "description": "Earn 1 point for every \$1 spent",
      "points": "1 per \$1",
      "icon": Icons.shopping_cart,
      "color": Colors.green,
    },
    {
      "title": "Write Reviews",
      "description": "Share your experience with products",
      "points": "50",
      "icon": Icons.rate_review,
      "color": Colors.orange,
    },
    {
      "title": "Refer Friends",
      "description": "Invite friends to join the program",
      "points": "500",
      "icon": Icons.group_add,
      "color": Colors.purple,
    },
    {
      "title": "Social Sharing",
      "description": "Share products on social media",
      "points": "25",
      "icon": Icons.share,
      "color": Colors.red,
    },
    {
      "title": "Complete Profile",
      "description": "Fill out your complete profile",
      "points": "200",
      "icon": Icons.person,
      "color": Colors.teal,
    },
  ];

  List<Map<String, dynamic>> bonusOffers = [
    {
      "title": "Weekend Bonus",
      "description": "Double points on all purchases",
      "multiplier": "2x",
      "validUntil": "2024-06-23",
      "color": Colors.amber,
      "icon": Icons.weekend,
    },
    {
      "title": "New Member Bonus",
      "description": "Triple points for first 30 days",
      "multiplier": "3x",
      "validUntil": "2024-07-15",
      "color": Colors.green,
      "icon": Icons.new_releases,
    },
    {
      "title": "Birthday Special",
      "description": "500 bonus points on your birthday",
      "multiplier": "+500",
      "validUntil": "2024-12-31",
      "color": Colors.pink,
      "icon": Icons.cake,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Earn Points"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spMd),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_balance_wallet,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(width: spXs),
                Text(
                  "${currentPoints.toString()} pts",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPointsOverview(),
            SizedBox(height: spLg),
            _buildBonusOffers(),
            SizedBox(height: spLg),
            _buildEarnMethods(),
            SizedBox(height: spLg),
            _buildPurchasePoints(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsOverview() {
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
              Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Balance",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${currentPoints.toString()} Points",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
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
                      "Points Value",
                      style: TextStyle(
                        color: Colors.white.withAlpha(200),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "\$${(currentPoints * 0.01).toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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
                        fontSize: 18,
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

  Widget _buildBonusOffers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bonus Offers",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        QHorizontalScroll(
          children: bonusOffers.map((offer) {
            return Container(
              width: 250,
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
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${offer["multiplier"]}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
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
                  SizedBox(height: spXs),
                  Text(
                    "${offer["description"]}",
                    style: TextStyle(
                      color: Colors.white.withAlpha(200),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Colors.white.withAlpha(200),
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Until ${offer["validUntil"]}",
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 12,
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
    );
  }

  Widget _buildEarnMethods() {
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
            "Ways to Earn Points",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: earnMethods.map((method) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: (method["color"] as Color).withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusSm),
                  border: Border.all(
                    color: (method["color"] as Color).withAlpha(50),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: method["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        method["icon"] as IconData,
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
                            "${method["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: method["color"] as Color,
                            ),
                          ),
                          Text(
                            "${method["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                      decoration: BoxDecoration(
                        color: (method["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${method["points"]} pts",
                        style: TextStyle(
                          color: method["color"] as Color,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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

  Widget _buildPurchasePoints() {
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
            "Purchase Points",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Text(
            "Need more points? Purchase them instantly!",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
          SizedBox(height: spMd),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: pointsPackages.map((package) {
              bool isPopular = package["popular"] == true;
              int totalPoints = (package["points"] as int) + (package["bonus"] as int);
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: isPopular ? primaryColor.withAlpha(10) : Colors.grey.withAlpha(10),
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isPopular ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    if (isPopular)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(radiusLg),
                              bottomLeft: Radius.circular(radiusSm),
                            ),
                          ),
                          child: Text(
                            "POPULAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        children: [
                          Icon(
                            package["icon"] as IconData,
                            color: isPopular ? primaryColor : disabledBoldColor,
                            size: 32,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "${package["points"]} Points",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: isPopular ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          if ((package["bonus"] as int) > 0)
                            Text(
                              "+${package["bonus"]} Bonus",
                              style: TextStyle(
                                fontSize: 12,
                                color: successColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          SizedBox(height: spSm),
                          Text(
                            "\$${(package["price"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isPopular ? primaryColor : disabledBoldColor,
                            ),
                          ),
                          if ((package["bonus"] as int) > 0)
                            Text(
                              "Total: ${totalPoints} pts",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          SizedBox(height: spMd),
                          Container(
                            width: double.infinity,
                            child: QButton(
                              label: "Purchase",
                              size: bs.sm,
                              color: isPopular ? primaryColor : disabledBoldColor,
                              onPressed: () {
                                // Handle purchase
                                ss("Points purchased successfully!");
                              },
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
}
