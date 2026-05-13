import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class ReaSafetyRatingsView extends StatefulWidget {
  const ReaSafetyRatingsView({super.key});

  @override
  State<ReaSafetyRatingsView> createState() => _ReaSafetyRatingsViewState();
}

class _ReaSafetyRatingsViewState extends State<ReaSafetyRatingsView> {
  List<Map<String, dynamic>> safetyRatings = [
    {
      "category": "Crime Rate",
      "rating": 4.2,
      "score": "Low",
      "description": "Below average crime incidents reported",
      "icon": Icons.security,
      "color": const Color(0xFF4CAF50),
      "details": [
        {"type": "Theft", "incidents": 3, "trend": "down"},
        {"type": "Vandalism", "incidents": 1, "trend": "stable"},
        {"type": "Violence", "incidents": 0, "trend": "down"},
      ]
    },
    {
      "category": "Traffic Safety",
      "rating": 3.8,
      "score": "Moderate",
      "description": "Average traffic safety conditions",
      "icon": Icons.traffic,
      "color": const Color(0xFFFF9800),
      "details": [
        {"type": "Accidents", "incidents": 5, "trend": "up"},
        {"type": "Speeding", "incidents": 12, "trend": "stable"},
        {"type": "Violations", "incidents": 8, "trend": "down"},
      ]
    },
    {
      "category": "Emergency Response",
      "rating": 4.5,
      "score": "Excellent",
      "description": "Quick emergency response times",
      "icon": Icons.emergency,
      "color": const Color(0xFF4CAF50),
      "details": [
        {"type": "Fire", "time": "3 mins", "trend": "up"},
        {"type": "Police", "time": "4 mins", "trend": "stable"},
        {"type": "Medical", "time": "6 mins", "trend": "up"},
      ]
    },
    {
      "category": "Street Lighting",
      "rating": 4.0,
      "score": "Good",
      "description": "Well-lit streets and public areas",
      "icon": Icons.lightbulb,
      "color": const Color(0xFF2196F3),
      "details": [
        {"type": "Coverage", "percentage": 85, "trend": "up"},
        {"type": "Working", "percentage": 92, "trend": "stable"},
        {"type": "LED Upgrade", "percentage": 65, "trend": "up"},
      ]
    },
    {
      "category": "Natural Disasters",
      "rating": 4.3,
      "score": "Low Risk",
      "description": "Low probability of natural disasters",
      "icon": Icons.nature,
      "color": const Color(0xFF4CAF50),
      "details": [
        {"type": "Flood Risk", "level": "Low", "trend": "stable"},
        {"type": "Earthquake", "level": "Minimal", "trend": "stable"},
        {"type": "Storm", "level": "Low", "trend": "down"},
      ]
    },
    {
      "category": "Public Safety",
      "rating": 4.1,
      "score": "Good",
      "description": "Active community safety measures",
      "icon": Icons.groups,
      "color": const Color(0xFF2196F3),
      "details": [
        {"type": "Patrol", "frequency": "Regular", "trend": "up"},
        {"type": "CCTV", "coverage": 75, "trend": "up"},
        {"type": "Guards", "count": 12, "trend": "stable"},
      ]
    },
  ];

  String selectedTimeframe = "Last 6 Months";
  String selectedCategory = "All Categories";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Safety Ratings"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => ss("Safety report shared"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            _buildOverviewCard(),
            _buildFilterSection(),
            _buildSafetyMetrics(),
            _buildDetailedRatings(),
            _buildTrendAnalysis(),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    double overallRating = safetyRatings.map((e) => e["rating"] as double).reduce((a, b) => a + b) / safetyRatings.length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, primaryColor.withAlpha(150)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowMd],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.shield_outlined,
                color: Colors.white,
                size: 32,
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overall Safety Score",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fsH6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Based on comprehensive analysis",
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${overallRating.toStringAsFixed(1)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: spSm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "/5.0",
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Excellent",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "+0.3",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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

  Widget _buildFilterSection() {
    return Row(
      spacing: spSm,
      children: [
        Expanded(
          child: QDropdownField(
            label: "Timeframe",
            items: [
              {"label": "Last Month", "value": "Last Month"},
              {"label": "Last 3 Months", "value": "Last 3 Months"},
              {"label": "Last 6 Months", "value": "Last 6 Months"},
              {"label": "Last Year", "value": "Last Year"},
            ],
            value: selectedTimeframe,
            onChanged: (value, label) {
              selectedTimeframe = value;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: QDropdownField(
            label: "Category",
            items: [
              {"label": "All Categories", "value": "All Categories"},
              {"label": "Crime", "value": "Crime"},
              {"label": "Traffic", "value": "Traffic"},
              {"label": "Emergency", "value": "Emergency"},
              {"label": "Natural", "value": "Natural"},
            ],
            value: selectedCategory,
            onChanged: (value, label) {
              selectedCategory = value;
              setState(() {});
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSafetyMetrics() {
    return ResponsiveGridView(
      padding: EdgeInsets.zero,
      minItemWidth: 150,
      children: [
        _buildMetricCard("Crime Index", "Low", Icons.security, successColor),
        _buildMetricCard("Safety Score", "8.4/10", Icons.shield, primaryColor),
        _buildMetricCard("Response Time", "4 mins", Icons.timer, infoColor),
        _buildMetricCard("Risk Level", "Minimal", Icons.warning, warningColor),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedRatings() {
    return Column(
      spacing: spSm,
      children: [
        Row(
          children: [
            Text(
              "Safety Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => ss("Viewing all categories"),
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
        ...safetyRatings.map((rating) => _buildRatingCard(rating)),
      ],
    );
  }

  Widget _buildRatingCard(Map<String, dynamic> rating) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: (rating["color"] as Color).withAlpha(30),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(
                  rating["icon"] as IconData,
                  color: rating["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${rating["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${rating["description"]}",
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
                      ...List.generate(5, (index) {
                        return Icon(
                          index < (rating["rating"] as double).floor()
                              ? Icons.star
                              : index < (rating["rating"] as double)
                                  ? Icons.star_half
                                  : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        );
                      }),
                    ],
                  ),
                  Text(
                    "${rating["score"]}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: rating["color"] as Color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          QHorizontalScroll(
            children: (rating["details"] as List).map((detail) {
              return Container(
                width: 120,
                padding: EdgeInsets.all(spXs),
                margin: EdgeInsets.only(right: spXs),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Column(
                  spacing: spXs,
                  children: [
                    Text(
                      "${detail["type"]}",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      detail.containsKey("incidents") 
                          ? "${detail["incidents"]}"
                          : detail.containsKey("time")
                              ? "${detail["time"]}"
                              : detail.containsKey("percentage")
                                  ? "${detail["percentage"]}%"
                                  : "${detail["level"]}",
                      style: TextStyle(
                        fontSize: 10,
                        color: disabledBoldColor,
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

  Widget _buildTrendAnalysis() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Safety Trends",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Row(
            spacing: spSm,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: successColor,
                        size: 16,
                      ),
                      Text(
                        "Improving",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "4 Categories",
                        style: TextStyle(
                          fontSize: 10,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.horizontal_rule,
                        color: infoColor,
                        size: 16,
                      ),
                      Text(
                        "Stable",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "2 Categories",
                        style: TextStyle(
                          fontSize: 10,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: warningColor.withAlpha(30),
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        color: warningColor,
                        size: 16,
                      ),
                      Text(
                        "Declining",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: warningColor,
                        ),
                      ),
                      Text(
                        "0 Categories",
                        style: TextStyle(
                          fontSize: 10,
                          color: warningColor,
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
    );
  }

  Widget _buildRecommendations() {
    List<Map<String, dynamic>> recommendations = [
      {
        "title": "Install additional CCTV",
        "description": "Increase surveillance coverage in parking areas",
        "priority": "High",
        "color": dangerColor,
      },
      {
        "title": "Improve street lighting",
        "description": "Add LED lights in poorly lit sections",
        "priority": "Medium",
        "color": warningColor,
      },
      {
        "title": "Regular safety patrol",
        "description": "Increase security patrol frequency during night hours",
        "priority": "Low",
        "color": successColor,
      },
    ];

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spXs),
              Text(
                "Safety Recommendations",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          ...recommendations.map((rec) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: rec["color"] as Color,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${rec["title"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "${rec["description"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                    decoration: BoxDecoration(
                      color: (rec["color"] as Color).withAlpha(30),
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: Text(
                      "${rec["priority"]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: rec["color"] as Color,
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
  }
}
