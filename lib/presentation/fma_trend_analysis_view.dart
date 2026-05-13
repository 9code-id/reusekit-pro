import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FmaTrendAnalysisView extends StatefulWidget {
  const FmaTrendAnalysisView({super.key});

  @override
  State<FmaTrendAnalysisView> createState() => _FmaTrendAnalysisViewState();
}

class _FmaTrendAnalysisViewState extends State<FmaTrendAnalysisView> {
  int selectedTab = 0;
  String selectedTimeframe = "12months";
  String selectedCategory = "all";
  String selectedTrend = "all";

  List<Map<String, dynamic>> marketTrends = [
    {
      "id": "trend001",
      "name": "Digital Ordering Revolution",
      "category": "Technology",
      "impact": "High",
      "confidence": 95,
      "timeline": "1-2 years",
      "description": "Massive shift towards mobile and online ordering platforms",
      "currentAdoption": 78,
      "projectedGrowth": 156,
      "marketSize": 2.3,
      "keyDrivers": [
        "Post-pandemic behavior changes",
        "Convenience demand",
        "Tech-savvy younger demographics"
      ],
      "implications": [
        "Need for robust digital infrastructure",
        "Staff retraining for digital platforms",
        "Updated POS systems required"
      ],
      "opportunities": [
        "Reduced labor costs",
        "Better order accuracy",
        "Enhanced customer data collection"
      ],
      "threats": [
        "Technology dependency",
        "Digital divide excluding some customers",
        "Higher initial investment costs"
      ]
    },
    {
      "id": "trend002",
      "name": "Sustainability Focus",
      "category": "Environmental",
      "impact": "Medium",
      "confidence": 85,
      "timeline": "2-3 years",
      "description": "Growing consumer demand for environmentally responsible practices",
      "currentAdoption": 42,
      "projectedGrowth": 89,
      "marketSize": 1.8,
      "keyDrivers": [
        "Climate change awareness",
        "Millennial and Gen Z preferences",
        "Corporate responsibility trends"
      ],
      "implications": [
        "Sustainable packaging requirements",
        "Local sourcing priorities",
        "Waste reduction programs"
      ],
      "opportunities": [
        "Premium pricing for eco-friendly options",
        "Brand differentiation",
        "Government incentives"
      ],
      "threats": [
        "Higher operational costs",
        "Supply chain complexity",
        "Regulatory compliance requirements"
      ]
    },
    {
      "id": "trend003",
      "name": "Ghost Kitchen Expansion",
      "category": "Operations",
      "impact": "High",
      "confidence": 82,
      "timeline": "6 months - 1 year",
      "description": "Rise of delivery-only restaurant concepts without traditional dining spaces",
      "currentAdoption": 35,
      "projectedGrowth": 245,
      "marketSize": 1.2,
      "keyDrivers": [
        "Lower real estate costs",
        "Delivery app proliferation",
        "Operational efficiency focus"
      ],
      "implications": [
        "Reduced front-of-house needs",
        "Kitchen optimization required",
        "Delivery logistics critical"
      ],
      "opportunities": [
        "Lower startup costs",
        "Multiple brand operations",
        "Rapid market expansion"
      ],
      "threats": [
        "Reduced customer connection",
        "Delivery platform dependency",
        "Brand visibility challenges"
      ]
    },
    {
      "id": "trend004",
      "name": "Health-Conscious Dining",
      "category": "Consumer Behavior",
      "impact": "Medium",
      "confidence": 78,
      "timeline": "1-3 years",
      "description": "Increased demand for healthier, transparent ingredient options",
      "currentAdoption": 58,
      "projectedGrowth": 67,
      "marketSize": 2.1,
      "keyDrivers": [
        "Health awareness campaigns",
        "Obesity epidemic concerns",
        "Wellness lifestyle trends"
      ],
      "implications": [
        "Menu reformulation needs",
        "Nutritional information transparency",
        "Ingredient sourcing changes"
      ],
      "opportunities": [
        "Premium healthy options",
        "Market differentiation",
        "Health-focused partnerships"
      ],
      "threats": [
        "Higher ingredient costs",
        "Complex menu management",
        "Taste preference challenges"
      ]
    }
  ];

  List<Map<String, dynamic>> industryMetrics = [
    {
      "metric": "Average Order Value",
      "current": 28.50,
      "trend": "up",
      "change": 8.5,
      "projection": 31.20,
      "timeframe": "12 months",
      "confidence": 88
    },
    {
      "metric": "Customer Acquisition Cost",
      "current": 15.30,
      "trend": "down",
      "change": -12.2,
      "projection": 13.45,
      "timeframe": "12 months",
      "confidence": 82
    },
    {
      "metric": "Digital Order Percentage",
      "current": 65.2,
      "trend": "up",
      "change": 23.1,
      "projection": 78.5,
      "timeframe": "12 months",
      "confidence": 92
    },
    {
      "metric": "Customer Retention Rate",
      "current": 74.8,
      "trend": "up",
      "change": 5.3,
      "projection": 79.1,
      "timeframe": "12 months",
      "confidence": 76
    }
  ];

  List<Map<String, dynamic>> emergingTrends = [
    {
      "trend": "AI-Powered Personalization",
      "stage": "Early Adoption",
      "potential": "High",
      "timeToImpact": "6-12 months",
      "description": "AI algorithms personalizing menu recommendations and pricing",
      "adoptionRate": 15,
      "investmentRequired": "Medium"
    },
    {
      "trend": "Robotic Kitchen Automation",
      "stage": "Innovation",
      "potential": "High",
      "timeToImpact": "2-3 years",
      "description": "Automated cooking and food preparation systems",
      "adoptionRate": 5,
      "investmentRequired": "High"
    },
    {
      "trend": "Micro-Fulfillment Centers",
      "stage": "Growth",
      "potential": "Medium",
      "timeToImpact": "1-2 years",
      "description": "Small-scale distribution centers for rapid delivery",
      "adoptionRate": 28,
      "investmentRequired": "Medium"
    },
    {
      "trend": "Voice Ordering Integration",
      "stage": "Early Adoption",
      "potential": "Medium",
      "timeToImpact": "6-18 months",
      "description": "Voice-activated ordering through smart devices",
      "adoptionRate": 12,
      "investmentRequired": "Low"
    }
  ];

  List<Map<String, dynamic>> trendPredictions = [
    {
      "prediction": "50% of orders will be digital by Q4",
      "probability": 85,
      "impact": "High",
      "category": "Digital Transformation",
      "timeline": "9 months",
      "preparation": [
        "Upgrade POS systems",
        "Train staff on digital platforms",
        "Optimize online menu presentation"
      ]
    },
    {
      "prediction": "Delivery costs will increase 15-20%",
      "probability": 78,
      "impact": "Medium",
      "category": "Operations",
      "timeline": "6 months",
      "preparation": [
        "Negotiate platform contracts",
        "Develop in-house delivery",
        "Optimize packaging costs"
      ]
    },
    {
      "prediction": "Labor shortage will intensify",
      "probability": 92,
      "impact": "High",
      "category": "Human Resources",
      "timeline": "3 months",
      "preparation": [
        "Increase automation",
        "Improve employee benefits",
        "Implement retention programs"
      ]
    },
    {
      "prediction": "Sustainability regulations will tighten",
      "probability": 70,
      "impact": "Medium",
      "category": "Compliance",
      "timeline": "12 months",
      "preparation": [
        "Source sustainable materials",
        "Implement waste reduction",
        "Monitor regulatory changes"
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Trend Analysis",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.trending_up)),
        Tab(text: "Market Trends", icon: Icon(Icons.timeline)),
        Tab(text: "Emerging", icon: Icon(Icons.new_releases)),
        Tab(text: "Predictions", icon: Icon(Icons.psychology)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildMarketTrendsTab(),
        _buildEmergingTab(),
        _buildPredictionsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Key Metrics Cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Trends Tracked", "24", Icons.trending_up, primaryColor),
              _buildMetricCard("High Impact", "8", Icons.priority_high, dangerColor),
              _buildMetricCard("Confidence Level", "82%", Icons.verified, successColor),
              _buildMetricCard("Market Size", "\$4.2B", Icons.attach_money, warningColor),
            ],
          ),

          // Industry Metrics Overview
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Key Industry Metrics",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...industryMetrics.map((metric) => _buildMetricTrendItem(metric)),
              ],
            ),
          ),

          // Top Trends Summary
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Top Market Trends",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                ...marketTrends.take(3).map((trend) => _buildTrendSummaryItem(trend)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Filters
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: [
                    {"label": "All Categories", "value": "all"},
                    {"label": "Technology", "value": "technology"},
                    {"label": "Consumer Behavior", "value": "behavior"},
                    {"label": "Operations", "value": "operations"},
                    {"label": "Environmental", "value": "environmental"},
                  ],
                  value: selectedCategory,
                  onChanged: (value, label) {
                    selectedCategory = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "Impact Level",
                  items: [
                    {"label": "All Impact", "value": "all"},
                    {"label": "High Impact", "value": "high"},
                    {"label": "Medium Impact", "value": "medium"},
                    {"label": "Low Impact", "value": "low"},
                  ],
                  value: "all",
                  onChanged: (value, label) {},
                ),
              ),
            ],
          ),

          // Trends List
          ...marketTrends.map((trend) => _buildTrendCard(trend)),
        ],
      ),
    );
  }

  Widget _buildEmergingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Innovation Pipeline
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Text(
                  "Innovation Pipeline",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Emerging trends and technologies with potential market impact",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Emerging Trends Grid
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: emergingTrends.map((trend) => _buildEmergingTrendCard(trend)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Prediction Accuracy
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
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
                    Icon(Icons.psychology, color: primaryColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "AI-Powered Market Predictions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Based on current market data, historical trends, and machine learning analysis",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Prediction Accuracy: ",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "87.3%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Predictions List
          ...trendPredictions.map((prediction) => _buildPredictionCard(prediction)),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
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
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTrendItem(Map<String, dynamic> metric) {
    Color trendColor = metric["trend"] == "up" ? successColor : dangerColor;
    IconData trendIcon = metric["trend"] == "up" ? Icons.trending_up : Icons.trending_down;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        border: Border.all(color: disabledOutlineBorderColor),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${metric["metric"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      metric["metric"].toString().contains("Percentage") ? 
                        "${(metric["current"] as num).toStringAsFixed(1)}%" :
                        "\$${((metric["current"] as num).toDouble()).currency}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Icon(trendIcon, color: trendColor, size: 16),
                    Text(
                      "${(metric["change"] as num) >= 0 ? '+' : ''}${(metric["change"] as num).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: trendColor,
                        fontWeight: FontWeight.w600,
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
              Text(
                "Projection",
                style: TextStyle(
                  fontSize: 10,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                metric["metric"].toString().contains("Percentage") ? 
                  "${(metric["projection"] as num).toStringAsFixed(1)}%" :
                  "\$${((metric["projection"] as num).toDouble()).currency}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendSummaryItem(Map<String, dynamic> trend) {
    Color impactColor = trend["impact"] == "High" ? dangerColor : 
                       trend["impact"] == "Medium" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${trend["name"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${trend["category"]} • ${trend["timeline"]}",
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
              color: impactColor,
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Text(
              "${trend["impact"]}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> trend) {
    Color impactColor = trend["impact"] == "High" ? dangerColor : 
                       trend["impact"] == "Medium" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "${trend["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: impactColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${trend["impact"]} Impact",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${trend["category"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Text(
                "Timeline: ${trend["timeline"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          Text(
            "${trend["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),

          // Metrics Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Adoption",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${trend["currentAdoption"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
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
                      "Growth Projection",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "+${trend["projectedGrowth"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: successColor,
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
                      "Confidence",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${trend["confidence"]}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: trend["confidence"] >= 80 ? successColor : warningColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Key Drivers
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Key Drivers",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(trend["keyDrivers"] as List).map((driver) =>
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.only(top: 6, right: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "$driver",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Opportunities and Threats
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Opportunities",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(trend["opportunities"] as List).take(2).map((opp) =>
                      Text(
                        "• $opp",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Threats",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: dangerColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    ...(trend["threats"] as List).take(2).map((threat) =>
                      Text(
                        "• $threat",
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "View Full Analysis",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergingTrendCard(Map<String, dynamic> trend) {
    Color stageColor = trend["stage"] == "Innovation" ? infoColor :
                      trend["stage"] == "Early Adoption" ? warningColor : successColor;
    
    Color potentialColor = trend["potential"] == "High" ? dangerColor : 
                          trend["potential"] == "Medium" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          Text(
            "${trend["trend"]}",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),

          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: stageColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${trend["stage"]}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spXs),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: potentialColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${trend["potential"]} Potential",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Text(
            "${trend["description"]}",
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 14,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time to Impact",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${trend["timeToImpact"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                      "Adoption Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${trend["adoptionRate"]}%",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
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
                "Investment Required: ",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                "${trend["investmentRequired"]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: trend["investmentRequired"] == "High" ? dangerColor :
                        trend["investmentRequired"] == "Medium" ? warningColor : successColor,
                ),
              ),
            ],
          ),

          // Adoption Progress Bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Market Adoption Progress",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(height: spXs),
              LinearProgressIndicator(
                value: (trend["adoptionRate"] as num) / 100,
                backgroundColor: disabledColor,
                valueColor: AlwaysStoppedAnimation<Color>(stageColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionCard(Map<String, dynamic> prediction) {
    Color probabilityColor = (prediction["probability"] as num) >= 80 ? successColor :
                            (prediction["probability"] as num) >= 60 ? warningColor : dangerColor;
    
    Color impactColor = prediction["impact"] == "High" ? dangerColor : 
                       prediction["impact"] == "Medium" ? warningColor : successColor;

    return Container(
      padding: EdgeInsets.all(spMd),
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
              Expanded(
                child: Text(
                  "${prediction["prediction"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                decoration: BoxDecoration(
                  color: impactColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${prediction["impact"]} Impact",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${prediction["category"]}",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Text(
                "Expected in ${prediction["timeline"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),

          // Probability and Confidence
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Probability",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${prediction["probability"]}%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: probabilityColor,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Icon(
                          (prediction["probability"] as num) >= 80 ? Icons.trending_up :
                          (prediction["probability"] as num) >= 60 ? Icons.trending_flat : Icons.trending_down,
                          color: probabilityColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Probability Progress Bar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Confidence Level",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    LinearProgressIndicator(
                      value: (prediction["probability"] as num) / 100,
                      backgroundColor: disabledColor,
                      valueColor: AlwaysStoppedAnimation<Color>(probabilityColor),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Preparation Steps
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recommended Preparation Steps",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spXs),
              ...(prediction["preparation"] as List).map((step) =>
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        margin: EdgeInsets.only(right: spXs),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Icon(Icons.check, color: primaryColor, size: 12),
                      ),
                      Expanded(
                        child: Text(
                          "$step",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Container(
            width: double.infinity,
            child: QButton(
              label: "Create Action Plan",
              size: bs.sm,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
