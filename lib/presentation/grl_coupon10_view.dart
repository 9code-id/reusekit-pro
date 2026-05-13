import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCoupon10View extends StatefulWidget {
  @override
  State<GrlCoupon10View> createState() => _GrlCoupon10ViewState();
}

class _GrlCoupon10ViewState extends State<GrlCoupon10View> {
  String selectedPeriod = "This Month";
  
  Map<String, dynamic> analytics = {
    "totalCouponsUsed": 45,
    "totalSaved": 567.89,
    "averageSavings": 12.62,
    "topCategory": "Electronics",
    "favoriteStore": "TechWorld",
    "savingsGoal": 1000.0,
    "monthlyData": [
      {"month": "Jan", "saved": 120.50, "coupons": 8},
      {"month": "Feb", "saved": 89.30, "coupons": 6},
      {"month": "Mar", "saved": 156.75, "coupons": 12},
      {"month": "Apr", "saved": 201.34, "coupons": 19},
    ],
    "categoryBreakdown": [
      {"category": "Electronics", "amount": 245.50, "percentage": 43, "color": primaryColor},
      {"category": "Fashion", "amount": 156.30, "percentage": 28, "color": warningColor},
      {"category": "Food", "amount": 98.45, "percentage": 17, "color": successColor},
      {"category": "Travel", "amount": 67.64, "percentage": 12, "color": infoColor},
    ],
    "achievements": [
      {"title": "Big Saver", "description": "Saved over \$500", "icon": Icons.star, "earned": true},
      {"title": "Coupon Master", "description": "Used 50+ coupons", "icon": Icons.local_offer, "earned": false},
      {"title": "Smart Shopper", "description": "Avg savings > \$15", "icon": Icons.trending_up, "earned": false},
      {"title": "Deal Hunter", "description": "Found 10 exclusive deals", "icon": Icons.search, "earned": true},
    ],
  };

  @override
  Widget build(BuildContext context) {
    double savingsProgress = (analytics["totalSaved"] as double) / (analytics["savingsGoal"] as double);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Savings Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Savings Goal Progress
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.savings,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Savings Goal",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "\$${(analytics["totalSaved"] as double).toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "of \$${(analytics["savingsGoal"] as double).toStringAsFixed(0)} goal",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spMd),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: LinearProgressIndicator(
                      value: savingsProgress,
                      backgroundColor: Colors.white.withAlpha(50),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 8,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${(savingsProgress * 100).toInt()}% of goal achieved",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Quick Stats
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${analytics["totalCouponsUsed"]}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Coupons Used",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "\$${(analytics["averageSavings"] as double).toStringAsFixed(0)}",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Avg. Savings",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${analytics["topCategory"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Top Category",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Monthly Savings Chart
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Monthly Savings",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    // Simple Bar Chart
                    Container(
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: (analytics["monthlyData"] as List).map<Widget>((data) {
                          double maxAmount = 250.0;
                          double barHeight = ((data["saved"] as double) / maxAmount) * 100;
                          
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${(data["saved"] as double).toInt()}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    height: barHeight,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(radiusXs),
                                        topRight: Radius.circular(radiusXs),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${data["month"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Category Breakdown
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.pie_chart,
                          color: primaryColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Savings by Category",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    ...(analytics["categoryBreakdown"] as List).map<Widget>((category) => Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: category["color"] as Color,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "\$${(category["amount"] as double).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: category["color"] as Color,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${category["percentage"]}%",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Achievements
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Padding(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_events,
                          color: warningColor,
                          size: 24,
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "Achievements",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spMd),
                    
                    ResponsiveGridView(
                      minItemWidth: 200,
                      children: (analytics["achievements"] as List).map<Widget>((achievement) => Container(
                        margin: EdgeInsets.only(bottom: spSm),
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: achievement["earned"] as bool 
                              ? warningColor.withAlpha(20) 
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: achievement["earned"] as bool 
                              ? Border.all(color: warningColor) 
                              : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: achievement["earned"] as bool 
                                    ? warningColor 
                                    : disabledColor,
                                borderRadius: BorderRadius.circular(radiusLg),
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: achievement["earned"] as bool 
                                          ? Colors.black 
                                          : disabledBoldColor,
                                    ),
                                  ),
                                  Text(
                                    "${achievement["description"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (achievement["earned"] as bool)
                              Icon(
                                Icons.check_circle,
                                color: successColor,
                                size: 20,
                              ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Insights
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [successColor, successColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Smart Insights",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "💡 You save the most on ${analytics["topCategory"]} purchases",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "🏆 Your favorite store is ${analytics["favoriteStore"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "📈 You're ${((analytics["savingsGoal"] as double) - (analytics["totalSaved"] as double)).toStringAsFixed(0)} away from your savings goal!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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
}
