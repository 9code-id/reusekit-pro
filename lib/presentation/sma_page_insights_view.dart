import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaPageInsightsView extends StatefulWidget {
  const SmaPageInsightsView({super.key});

  @override
  State<SmaPageInsightsView> createState() => _SmaPageInsightsViewState();
}

class _SmaPageInsightsViewState extends State<SmaPageInsightsView> {
  String selectedPeriod = "7 days";
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 days", "value": "7 days"},
    {"label": "Last 30 days", "value": "30 days"},
    {"label": "Last 90 days", "value": "90 days"},
    {"label": "Last year", "value": "1 year"},
  ];

  Map<String, dynamic> insightsData = {
    "followers": {
      "current": 125000,
      "growth": 2350,
      "growthPercentage": 1.9,
      "dailyData": [1200, 1450, 980, 1650, 2100, 1800, 2350]
    },
    "engagement": {
      "rate": 4.2,
      "likes": 15420,
      "comments": 3250,
      "shares": 1890,
      "growthPercentage": 12.5
    },
    "reach": {
      "total": 285000,
      "organic": 198000,
      "paid": 87000,
      "growthPercentage": 8.3
    },
    "posts": {
      "published": 24,
      "avgLikes": 642,
      "avgComments": 135,
      "avgShares": 78,
      "bestTime": "6:00 PM"
    },
    "demographics": {
      "ageGroups": [
        {"range": "18-24", "percentage": 25},
        {"range": "25-34", "percentage": 35},
        {"range": "35-44", "percentage": 22},
        {"range": "45-54", "percentage": 12},
        {"range": "55+", "percentage": 6}
      ],
      "topLocations": [
        {"city": "San Francisco", "percentage": 18},
        {"city": "New York", "percentage": 15},
        {"city": "Los Angeles", "percentage": 12},
        {"city": "Seattle", "percentage": 10},
        {"city": "Austin", "percentage": 8}
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Insights"),
        actions: [
          IconButton(
            onPressed: () {
              si("Exporting insights report...");
            },
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Period Selector
            Card(
              child: Container(
                padding: EdgeInsets.all(spSm),
                child: QDropdownField(
                  label: "Time Period",
                  value: selectedPeriod,
                  items: periodOptions,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ),

            // Key Metrics Overview
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${((insightsData["followers"]["current"] as int) / 1000).toInt()}K",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      color: successColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "+${insightsData["followers"]["growthPercentage"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
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
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${insightsData["engagement"]["rate"]}%",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
                                  ),
                                ),
                                Text(
                                  "Engagement",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      color: successColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "+${insightsData["engagement"]["growthPercentage"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
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
                              color: infoColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "${((insightsData["reach"]["total"] as int) / 1000).toInt()}K",
                                  style: TextStyle(
                                    fontSize: fsH5,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "Reach",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.trending_up,
                                      color: successColor,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "+${insightsData["reach"]["growthPercentage"]}%",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: successColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
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
            ),

            // Follower Growth
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Follower Growth",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: primaryColor,
                            size: 24,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "+${insightsData["followers"]["growth"]} new followers",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "in the last ${selectedPeriod.toLowerCase()}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "+${insightsData["followers"]["growthPercentage"]}%",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Simple graph representation
                    Container(
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: (insightsData["followers"]["dailyData"] as List).asMap().entries.map((entry) {
                          int index = entry.key;
                          int value = entry.value;
                          double maxValue = 2500;
                          double height = (value / maxValue) * 100;
                          
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: height,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "D${index + 1}",
                                    style: TextStyle(
                                      fontSize: 8,
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

            // Engagement Metrics
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Engagement Details",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: dangerColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: dangerColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${((insightsData["engagement"]["likes"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Likes",
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.comment,
                                  color: infoColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${((insightsData["engagement"]["comments"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Comments",
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(25),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: successColor,
                                  size: 24,
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${((insightsData["engagement"]["shares"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Shares",
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
                  ],
                ),
              ),
            ),

            // Post Performance
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Post Performance",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Posts Published:",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "${insightsData["posts"]["published"]}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Avg. Likes per Post:",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "${insightsData["posts"]["avgLikes"]}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Avg. Comments per Post:",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "${insightsData["posts"]["avgComments"]}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Best Time to Post:",
                                style: TextStyle(color: disabledBoldColor),
                              ),
                              Spacer(),
                              Text(
                                "${insightsData["posts"]["bestTime"]}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Demographics
            Card(
              child: Container(
                padding: EdgeInsets.all(spMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spMd,
                  children: [
                    Text(
                      "Audience Demographics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    Text(
                      "Age Groups",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    ...(insightsData["demographics"]["ageGroups"] as List).map((group) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                "${group["range"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: (group["percentage"] as int) / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${group["percentage"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    SizedBox(height: spMd),
                    
                    Text(
                      "Top Locations",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    ...(insightsData["demographics"]["topLocations"] as List).map((location) {
                      return Container(
                        margin: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "${location["city"]}",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: (location["percentage"] as int) / 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: successColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${location["percentage"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
