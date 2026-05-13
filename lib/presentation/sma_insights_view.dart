import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaInsightsView extends StatefulWidget {
  const SmaInsightsView({super.key});

  @override
  State<SmaInsightsView> createState() => _SmaInsightsViewState();
}

class _SmaInsightsViewState extends State<SmaInsightsView> {
  String selectedPeriod = "This Week";
  String selectedInsightType = "All";
  
  List<Map<String, dynamic>> insights = [
    {
      "type": "Growth",
      "title": "Follower Growth Surge",
      "description": "Your follower count increased by 15% this week, primarily from organic discovery.",
      "impact": "High",
      "icon": Icons.trending_up,
      "color": successColor,
      "actionable": true,
      "recommendation": "Continue posting similar content to maintain this growth trend.",
      "timestamp": "2 hours ago",
    },
    {
      "type": "Engagement",
      "title": "Peak Engagement Time Identified",
      "description": "Your posts perform 3x better when published between 2-4 PM on weekdays.",
      "impact": "High",
      "icon": Icons.schedule,
      "color": primaryColor,
      "actionable": true,
      "recommendation": "Schedule your important posts during 2-4 PM for maximum reach.",
      "timestamp": "4 hours ago",
    },
    {
      "type": "Content",
      "title": "Video Content Outperforming",
      "description": "Video posts are getting 40% more engagement than image posts this month.",
      "impact": "Medium",
      "icon": Icons.videocam,
      "color": infoColor,
      "actionable": true,
      "recommendation": "Increase video content ratio to 60% of your total posts.",
      "timestamp": "6 hours ago",
    },
    {
      "type": "Audience",
      "title": "New Audience Segment Discovered",
      "description": "25-34 age group showing increased interest in your content (up 22%).",
      "impact": "Medium",
      "icon": Icons.people,
      "color": warningColor,
      "actionable": true,
      "recommendation": "Create content specifically targeting this age group's interests.",
      "timestamp": "1 day ago",
    },
    {
      "type": "Performance",
      "title": "Declining Reach Alert",
      "description": "Your average post reach has decreased by 8% compared to last month.",
      "impact": "High",
      "icon": Icons.trending_down,
      "color": dangerColor,
      "actionable": true,
      "recommendation": "Review and optimize your hashtag strategy and posting frequency.",
      "timestamp": "1 day ago",
    },
    {
      "type": "Competitive",
      "title": "Competitor Analysis Update",
      "description": "Your main competitors are using more interactive content (polls, Q&A).",
      "impact": "Medium",
      "icon": Icons.compare_arrows,
      "color": infoColor,
      "actionable": true,
      "recommendation": "Incorporate more interactive elements in your content strategy.",
      "timestamp": "2 days ago",
    },
  ];

  List<Map<String, dynamic>> quickStats = [
    {
      "title": "AI Insights Generated",
      "value": 127,
      "change": 18,
      "isPositive": true,
      "icon": Icons.psychology,
      "color": primaryColor,
    },
    {
      "title": "Actionable Recommendations",
      "value": 24,
      "change": 12,
      "isPositive": true,
      "icon": Icons.lightbulb,
      "color": successColor,
    },
    {
      "title": "Performance Improvements",
      "value": 89,
      "change": -3,
      "isPositive": false,
      "icon": Icons.trending_up,
      "color": infoColor,
      "unit": "%",
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {
      "topic": "Summer Fashion",
      "engagement": 94.5,
      "growth": 23.4,
      "posts": 156,
      "color": primaryColor,
    },
    {
      "topic": "Sustainable Living",
      "engagement": 87.2,
      "growth": 45.7,
      "posts": 89,
      "color": successColor,
    },
    {
      "topic": "Tech Reviews",
      "engagement": 82.8,
      "growth": 12.3,
      "posts": 234,
      "color": infoColor,
    },
    {
      "topic": "Home Decor",
      "engagement": 79.1,
      "growth": 18.9,
      "posts": 145,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> get filteredInsights {
    return insights.where((insight) =>
        selectedInsightType == "All" || insight["type"] == selectedInsightType
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insights"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh insights
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.insights,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "AI-Powered Insights",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Get personalized recommendations and discover opportunities to grow your social media presence.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withAlpha(200),
                    ),
                  ),
                ],
              ),
            ),

            // Quick Stats
            Row(
              children: quickStats.map((stat) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: stat != quickStats.last ? spSm : 0),
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 16,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${stat["value"]}${stat["unit"] ?? ''}",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${stat["title"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Icon(
                              (stat["isPositive"] as bool) 
                                  ? Icons.arrow_upward 
                                  : Icons.arrow_downward,
                              color: (stat["isPositive"] as bool) 
                                  ? successColor 
                                  : dangerColor,
                              size: 12,
                            ),
                            Text(
                              "${stat["change"]}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: (stat["isPositive"] as bool) 
                                    ? successColor 
                                    : dangerColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: [
                      {"label": "This Week", "value": "This Week"},
                      {"label": "This Month", "value": "This Month"},
                      {"label": "Last 3 Months", "value": "Last 3 Months"},
                      {"label": "This Year", "value": "This Year"},
                    ],
                    value: selectedPeriod,
                    onChanged: (value, label) {
                      selectedPeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Insight Type",
                    items: [
                      {"label": "All Types", "value": "All"},
                      {"label": "Growth", "value": "Growth"},
                      {"label": "Engagement", "value": "Engagement"},
                      {"label": "Content", "value": "Content"},
                      {"label": "Audience", "value": "Audience"},
                      {"label": "Performance", "value": "Performance"},
                    ],
                    value: selectedInsightType,
                    onChanged: (value, label) {
                      selectedInsightType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Insights List
            ...filteredInsights.map((insight) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: insight["impact"] == "High"
                      ? Border.all(color: (insight["color"] as Color).withAlpha(100), width: 2)
                      : null,
                ),
                child: Padding(
                  padding: EdgeInsets.all(spSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      // Insight Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (insight["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              insight["icon"] as IconData,
                              color: insight["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${insight["title"]}",
                                      style: TextStyle(
                                        fontSize: fsH6,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: insight["impact"] == "High" 
                                            ? dangerColor
                                            : insight["impact"] == "Medium"
                                                ? warningColor
                                                : successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${insight["impact"]} Impact",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${insight["type"]} • ${insight["timestamp"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Insight Description
                      Text(
                        "${insight["description"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.4,
                        ),
                      ),

                      // Recommendation
                      if (insight["actionable"] as bool) ...[
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (insight["color"] as Color).withAlpha(10),
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(color: (insight["color"] as Color).withAlpha(30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb,
                                    color: insight["color"] as Color,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "Recommendation",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: insight["color"] as Color,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${insight["recommendation"]}",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: QButton(
                                label: "Apply Suggestion",
                                size: bs.sm,
                                onPressed: () {
                                  //navigateTo('ApplyInsightView', arguments: insight)
                                },
                              ),
                            ),
                            SizedBox(width: spSm),
                            QButton(
                              label: "Learn More",
                              size: bs.sm,
                              onPressed: () {
                                //navigateTo('InsightDetailView', arguments: insight)
                              },
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),

            // Trending Topics
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spSm,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Trending Topics in Your Niche",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  ...trendingTopics.map((topic) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spXs),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (topic["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: topic["color"] as Color,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${topic["topic"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Text(
                                  "${topic["posts"]} posts • ${(topic["engagement"] as double).toStringAsFixed(1)}% engagement",
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    color: successColor,
                                    size: 12,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    "${(topic["growth"] as double).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "growth",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  QButton(
                    label: "Explore All Trends",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo('TrendingTopicsView')
                    },
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
