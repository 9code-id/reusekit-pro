import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlCategory8View extends StatefulWidget {
  @override
  State<GrlCategory8View> createState() => _GrlCategory8ViewState();
}

class _GrlCategory8ViewState extends State<GrlCategory8View> {
  String selectedTimeframe = 'week';
  String selectedMetric = 'downloads';
  
  List<Map<String, dynamic>> categoryAnalytics = [
    {
      "id": 1,
      "name": "Social Media",
      "shortName": "Social",
      "icon": Icons.share,
      "color": 0xFF2196F3,
      "currentRank": 1,
      "previousRank": 1,
      "totalApps": 567,
      "activeUsers": "2.8B",
      "avgRating": 4.2,
      "downloadGrowth": "+15.2%",
      "revenueGrowth": "+8.4%",
      "userEngagement": 87,
      "marketShare": 23.5,
      "trendData": [45, 52, 48, 61, 58, 69, 72],
      "topPerformers": ["Instagram", "TikTok", "Twitter", "LinkedIn"],
      "insights": "Strong growth in video-first platforms",
    },
    {
      "id": 2,
      "name": "E-commerce",
      "shortName": "Shopping",
      "icon": Icons.shopping_cart,
      "color": 0xFF4CAF50,
      "currentRank": 2,
      "previousRank": 3,
      "totalApps": 342,
      "activeUsers": "1.9B",
      "avgRating": 4.4,
      "downloadGrowth": "+22.8%",
      "revenueGrowth": "+18.2%",
      "userEngagement": 92,
      "marketShare": 18.2,
      "trendData": [32, 38, 42, 48, 55, 62, 68],
      "topPerformers": ["Amazon", "Shopify", "eBay", "Wish"],
      "insights": "Mobile commerce driving significant growth",
    },
    {
      "id": 3,
      "name": "Entertainment",
      "shortName": "Media",
      "icon": Icons.movie,
      "color": 0xFFE91E63,
      "currentRank": 3,
      "previousRank": 2,
      "totalApps": 789,
      "activeUsers": "3.2B",
      "avgRating": 4.1,
      "downloadGrowth": "+7.3%",
      "revenueGrowth": "+12.1%",
      "userEngagement": 94,
      "marketShare": 21.8,
      "trendData": [78, 82, 85, 88, 86, 89, 91],
      "topPerformers": ["Netflix", "Disney+", "YouTube", "Spotify"],
      "insights": "Subscription models showing strong retention",
    },
    {
      "id": 4,
      "name": "Finance",
      "shortName": "FinTech",
      "icon": Icons.account_balance,
      "color": 0xFF795548,
      "currentRank": 4,
      "previousRank": 5,
      "totalApps": 234,
      "activeUsers": "890M",
      "avgRating": 4.6,
      "downloadGrowth": "+28.5%",
      "revenueGrowth": "+31.2%",
      "userEngagement": 78,
      "marketShare": 8.7,
      "trendData": [18, 22, 28, 35, 42, 48, 55],
      "topPerformers": ["PayPal", "Venmo", "CashApp", "Robinhood"],
      "insights": "Digital payments and investment apps surging",
    },
    {
      "id": 5,
      "name": "Health & Fitness",
      "shortName": "Health",
      "icon": Icons.fitness_center,
      "color": 0xFFFF9800,
      "currentRank": 5,
      "previousRank": 4,
      "totalApps": 445,
      "activeUsers": "1.2B",
      "avgRating": 4.5,
      "downloadGrowth": "+19.7%",
      "revenueGrowth": "+16.3%",
      "userEngagement": 85,
      "marketShare": 12.4,
      "trendData": [28, 32, 35, 38, 42, 45, 48],
      "topPerformers": ["MyFitnessPal", "Strava", "Headspace", "Calm"],
      "insights": "Mental health and wellness apps trending",
    },
    {
      "id": 6,
      "name": "Education",
      "shortName": "Learning",
      "icon": Icons.school,
      "color": 0xFF9C27B0,
      "currentRank": 6,
      "previousRank": 6,
      "totalApps": 298,
      "activeUsers": "756M",
      "avgRating": 4.7,
      "downloadGrowth": "+25.1%",
      "revenueGrowth": "+22.8%",
      "userEngagement": 89,
      "marketShare": 9.3,
      "trendData": [22, 26, 30, 34, 38, 42, 46],
      "topPerformers": ["Duolingo", "Khan Academy", "Coursera", "Udemy"],
      "insights": "Online learning adoption accelerating",
    },
  ];

  List<String> timeframes = ['day', 'week', 'month', 'quarter'];
  List<String> metrics = ['downloads', 'revenue', 'users', 'engagement'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Control Panel
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Timeframe Selection
                Row(
                  children: [
                    Text(
                      "Timeframe:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QHorizontalScroll(
                        children: timeframes.map((timeframe) => Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedTimeframe = timeframe;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spMd,
                                vertical: spSm,
                              ),
                              decoration: BoxDecoration(
                                color: selectedTimeframe == timeframe ? primaryColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                timeframe.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: selectedTimeframe == timeframe ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Metric Selection
                Row(
                  children: [
                    Text(
                      "Metric:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QHorizontalScroll(
                        children: metrics.map((metric) => Container(
                          margin: EdgeInsets.only(right: spSm),
                          child: GestureDetector(
                            onTap: () {
                              selectedMetric = metric;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spMd,
                                vertical: spSm,
                              ),
                              decoration: BoxDecoration(
                                color: selectedMetric == metric ? successColor : Colors.grey[100],
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Text(
                                metric.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: selectedMetric == metric ? Colors.white : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Analytics Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Key Metrics Overview
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(spMd),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [infoColor, infoColor.withAlpha(180)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusLg),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.analytics,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Market Overview",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spMd),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${categoryAnalytics.fold(0, (sum, cat) => sum + (cat["totalApps"] as int))}",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Total Apps",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "10.6B",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Active Users",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${((categoryAnalytics.fold(0.0, (sum, cat) => sum + (cat["avgRating"] as double)) / categoryAnalytics.length)).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: fsH3,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Avg Rating",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Category Rankings
                  Text(
                    "Category Rankings",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  SizedBox(height: spMd),
                  
                  ...categoryAnalytics.map((category) {
                    Color categoryColor = Color(category["color"] as int);
                    bool rankUp = (category["currentRank"] as int) < (category["previousRank"] as int);
                    bool rankDown = (category["currentRank"] as int) > (category["previousRank"] as int);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusLg),
                        boxShadow: [shadowMd],
                      ),
                      child: Column(
                        children: [
                          // Rank Header
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(spMd),
                            decoration: BoxDecoration(
                              color: categoryColor.withAlpha(20),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                            ),
                            child: Row(
                              children: [
                                // Rank Badge
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: categoryColor,
                                    borderRadius: BorderRadius.circular(radiusLg),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "#${category["currentRank"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spMd),
                                // Category Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            category["icon"] as IconData,
                                            color: categoryColor,
                                            size: 20,
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${category["name"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spXs),
                                      Text(
                                        "${category["insights"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Rank Movement
                                if (rankUp)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.trending_up,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${(category["previousRank"] as int) - (category["currentRank"] as int)}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else if (rankDown)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.trending_down,
                                          size: 12,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${(category["currentRank"] as int) - (category["previousRank"] as int)}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: disabledBoldColor,
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "SAME",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          // Analytics Content
                          Padding(
                            padding: EdgeInsets.all(spMd),
                            child: Column(
                              children: [
                                // Key Metrics Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${category["totalApps"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: categoryColor,
                                            ),
                                          ),
                                          Text(
                                            "Apps",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${category["activeUsers"]}",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: categoryColor,
                                            ),
                                          ),
                                          Text(
                                            "Users",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 14,
                                                color: warningColor,
                                              ),
                                              SizedBox(width: 2),
                                              Text(
                                                "${category["avgRating"]}",
                                                style: TextStyle(
                                                  fontSize: fsH6,
                                                  fontWeight: FontWeight.bold,
                                                  color: categoryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "Rating",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${category["marketShare"]}%",
                                            style: TextStyle(
                                              fontSize: fsH6,
                                              fontWeight: FontWeight.bold,
                                              color: categoryColor,
                                            ),
                                          ),
                                          Text(
                                            "Market",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Growth Metrics
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: successColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${category["downloadGrowth"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: successColor,
                                              ),
                                            ),
                                            Text(
                                              "Downloads",
                                              style: TextStyle(
                                                fontSize: 10,
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
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: infoColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${category["revenueGrowth"]}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: infoColor,
                                              ),
                                            ),
                                            Text(
                                              "Revenue",
                                              style: TextStyle(
                                                fontSize: 10,
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
                                        padding: EdgeInsets.all(spSm),
                                        decoration: BoxDecoration(
                                          color: warningColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${category["userEngagement"]}%",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: warningColor,
                                              ),
                                            ),
                                            Text(
                                              "Engagement",
                                              style: TextStyle(
                                                fontSize: 10,
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
                                
                                // Top Performers
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(spSm),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Top Performers:",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: spXs),
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 4,
                                        children: (category["topPerformers"] as List).map((app) => Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spSm,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: categoryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusSm),
                                          ),
                                          child: Text(
                                            "$app",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: categoryColor,
                                            ),
                                          ),
                                        )).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                SizedBox(height: spMd),
                                
                                // Action Button
                                Container(
                                  width: double.infinity,
                                  child: QButton(
                                    label: "View Detailed Analytics",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
