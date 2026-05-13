import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRating8View extends StatefulWidget {
  @override
  State<GrlRating8View> createState() => _GrlRating8ViewState();
}

class _GrlRating8ViewState extends State<GrlRating8View> {
  String selectedPeriod = "month";
  String selectedMetric = "rating";
  
  Map<String, dynamic> ratingTrends = {
    "currentPeriod": {
      "averageRating": 4.3,
      "totalReviews": 1247,
      "growthRate": 12.5,
      "responseRate": 89.4,
    },
    "previousPeriod": {
      "averageRating": 4.1,
      "totalReviews": 1098,
      "growthRate": 8.2,
      "responseRate": 85.2,
    },
  };

  List<Map<String, dynamic>> monthlyTrends = [
    {"month": "Jan", "rating": 3.8, "reviews": 156, "responses": 134},
    {"month": "Feb", "rating": 4.0, "reviews": 189, "responses": 167},
    {"month": "Mar", "rating": 4.1, "reviews": 234, "responses": 201},
    {"month": "Apr", "rating": 4.2, "reviews": 278, "responses": 245},
    {"month": "May", "rating": 4.3, "reviews": 312, "responses": 289},
    {"month": "Jun", "rating": 4.4, "reviews": 345, "responses": 324},
  ];

  List<Map<String, dynamic>> competitorTrends = [
    {
      "name": "Your Business",
      "currentRating": 4.3,
      "previousRating": 4.1,
      "trend": "up",
      "color": primaryColor,
      "data": [3.8, 4.0, 4.1, 4.2, 4.3, 4.4],
    },
    {
      "name": "Competitor A",
      "currentRating": 3.9,
      "previousRating": 4.0,
      "trend": "down",
      "color": dangerColor,
      "data": [4.1, 4.0, 3.9, 3.8, 3.9, 3.9],
    },
    {
      "name": "Competitor B",
      "currentRating": 4.1,
      "previousRating": 3.8,
      "trend": "up",
      "color": successColor,
      "data": [3.6, 3.7, 3.8, 3.9, 4.0, 4.1],
    },
    {
      "name": "Industry Avg",
      "currentRating": 4.0,
      "previousRating": 4.0,
      "trend": "stable",
      "color": warningColor,
      "data": [3.9, 4.0, 4.0, 4.0, 4.0, 4.0],
    },
  ];

  List<Map<String, dynamic>> categoryTrends = [
    {
      "category": "Product Quality",
      "currentRating": 4.5,
      "previousRating": 4.2,
      "trend": 7.1,
      "color": successColor,
      "icon": Icons.inventory,
      "monthlyData": [4.0, 4.1, 4.2, 4.3, 4.4, 4.5],
    },
    {
      "category": "Customer Service",
      "currentRating": 4.2,
      "previousRating": 4.0,
      "trend": 5.0,
      "color": primaryColor,
      "icon": Icons.support_agent,
      "monthlyData": [3.8, 3.9, 4.0, 4.1, 4.1, 4.2],
    },
    {
      "category": "Delivery Speed",
      "currentRating": 4.0,
      "previousRating": 4.3,
      "trend": -7.0,
      "color": dangerColor,
      "icon": Icons.local_shipping,
      "monthlyData": [4.4, 4.3, 4.2, 4.1, 4.0, 4.0],
    },
    {
      "category": "Value for Money",
      "currentRating": 3.8,
      "previousRating": 3.9,
      "trend": -2.6,
      "color": warningColor,
      "icon": Icons.attach_money,
      "monthlyData": [4.0, 3.9, 3.9, 3.8, 3.8, 3.8],
    },
  ];

  List<Map<String, dynamic>> insights = [
    {
      "type": "positive",
      "title": "Product Quality Improvement",
      "description": "Product quality ratings increased by 7.1% this month, driven by recent quality control improvements.",
      "impact": "high",
      "icon": Icons.trending_up,
    },
    {
      "type": "warning",
      "title": "Delivery Speed Decline",
      "description": "Delivery ratings dropped by 7.0%. Consider reviewing logistics partnerships and processes.",
      "impact": "medium",
      "icon": Icons.warning,
    },
    {
      "type": "info",
      "title": "Response Rate Target",
      "description": "You're at 89.4% response rate. Aim for 95% to maximize customer satisfaction.",
      "impact": "low",
      "icon": Icons.info,
    },
    {
      "type": "positive",
      "title": "Competitive Advantage",
      "description": "Your rating is 0.4 points above Competitor A and trending upward.",
      "impact": "high",
      "icon": Icons.star,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rating Trends"),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            QCategoryPicker(
              items: [
                {"label": "Last 7 Days", "value": "week"},
                {"label": "Last Month", "value": "month"},
                {"label": "Last Quarter", "value": "quarter"},
                {"label": "Last Year", "value": "year"},
              ],
              value: selectedPeriod,
              onChanged: (index, label, value, item) {
                selectedPeriod = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Key Metrics Comparison
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
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Performance Overview",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          "Average Rating",
                          "${ratingTrends["currentPeriod"]["averageRating"]}",
                          "${ratingTrends["previousPeriod"]["averageRating"]}",
                          Icons.star,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Total Reviews",
                          "${ratingTrends["currentPeriod"]["totalReviews"]}",
                          "${ratingTrends["previousPeriod"]["totalReviews"]}",
                          Icons.reviews,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          "Response Rate",
                          "${ratingTrends["currentPeriod"]["responseRate"]}%",
                          "${ratingTrends["previousPeriod"]["responseRate"]}%",
                          Icons.reply,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildMetricCard(
                          "Growth Rate",
                          "+${ratingTrends["currentPeriod"]["growthRate"]}%",
                          "+${ratingTrends["previousPeriod"]["growthRate"]}%",
                          Icons.trending_up,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Monthly Trend Chart
            Text(
              "Rating Trend (6 Months)",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  // Chart Header
                  Row(
                    children: [
                      Expanded(
                        child: QCategoryPicker(
                          items: [
                            {"label": "Rating", "value": "rating"},
                            {"label": "Reviews", "value": "reviews"},
                            {"label": "Responses", "value": "responses"},
                          ],
                          value: selectedMetric,
                          onChanged: (index, label, value, item) {
                            selectedMetric = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Simple Chart Representation
                  Container(
                    height: 150,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: monthlyTrends.map((data) {
                        double value;
                        switch (selectedMetric) {
                          case "rating":
                            value = (data["rating"] as double) / 5.0;
                            break;
                          case "reviews":
                            value = (data["reviews"] as int) / 350.0;
                            break;
                          case "responses":
                            value = (data["responses"] as int) / 350.0;
                            break;
                          default:
                            value = 0.0;
                        }
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: value * 120,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXs)),
                                  ),
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${data["month"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
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

            SizedBox(height: spMd),

            // Competitor Comparison
            Text(
              "Competitive Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            ...competitorTrends.map((competitor) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
                border: competitor["name"] == "Your Business" 
                    ? Border.all(color: primaryColor.withAlpha(50))
                    : null,
              ),
              child: Row(
                children: [
                  if (competitor["name"] == "Your Business")
                    Container(
                      margin: EdgeInsets.only(right: spSm),
                      padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "YOU",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${competitor["name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: competitor["name"] == "Your Business" ? primaryColor : null,
                          ),
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  (competitor["currentRating"] as double) > index ? Icons.star : Icons.star_border,
                                  size: 12,
                                  color: warningColor,
                                );
                              }),
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "${competitor["currentRating"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
                            _getTrendIcon(competitor["trend"]),
                            size: 16,
                            color: _getTrendColor(competitor["trend"]),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${((competitor["currentRating"] as double) - (competitor["previousRating"] as double)).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getTrendColor(competitor["trend"]),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "vs previous",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Category Performance Trends
            Text(
              "Category Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            ...categoryTrends.map((category) => Container(
              margin: EdgeInsets.only(bottom: spSm),
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
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: (category["color"] as Color).withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          color: category["color"] as Color,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${category["category"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      (category["currentRating"] as double) > index ? Icons.star : Icons.star_border,
                                      size: 12,
                                      color: warningColor,
                                    );
                                  }),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${category["currentRating"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                                (category["trend"] as double) > 0 ? Icons.trending_up : Icons.trending_down,
                                size: 16,
                                color: (category["trend"] as double) > 0 ? successColor : dangerColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(category["trend"] as double) > 0 ? '+' : ''}${category["trend"]}%",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: (category["trend"] as double) > 0 ? successColor : dangerColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "vs previous",
                            style: TextStyle(
                              fontSize: 10,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: spMd),
                  
                  // Mini trend chart
                  Container(
                    height: 40,
                    child: Row(
                      children: (category["monthlyData"] as List).asMap().entries.map((entry) {
                        int index = entry.key;
                        double value = entry.value as double;
                        double normalizedValue = value / 5.0;
                        
                        return Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: normalizedValue * 30,
                                  decoration: BoxDecoration(
                                    color: category["color"] as Color,
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXs)),
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
            )).toList(),

            SizedBox(height: spMd),

            // Insights & Recommendations
            Text(
              "Insights & Recommendations",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: spSm),

            ...insights.map((insight) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: _getInsightColor(insight["type"]).withAlpha(10),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: _getInsightColor(insight["type"]).withAlpha(30)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: _getInsightColor(insight["type"]),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      insight["icon"] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${insight["title"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _getInsightColor(insight["type"]),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getImpactColor(insight["impact"]),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${insight["impact"]}".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${insight["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: _getInsightColor(insight["type"]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String currentValue, String previousValue, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.white.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: spXs),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            currentValue,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            "was $previousValue",
            style: TextStyle(
              fontSize: 8,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      case "stable":
        return Icons.trending_flat;
      default:
        return Icons.help;
    }
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      case "stable":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getInsightColor(String type) {
    switch (type) {
      case "positive":
        return successColor;
      case "warning":
        return warningColor;
      case "info":
        return infoColor;
      case "negative":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  Color _getImpactColor(String impact) {
    switch (impact) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return primaryColor;
    }
  }
}
