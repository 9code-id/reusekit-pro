import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EmaAnalyticsView extends StatefulWidget {
  const EmaAnalyticsView({super.key});

  @override
  State<EmaAnalyticsView> createState() => _EmaAnalyticsViewState();
}

class _EmaAnalyticsViewState extends State<EmaAnalyticsView> {
  String selectedPeriod = "7 days";
  String selectedMetric = "Mood";
  int selectedTabIndex = 0;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "7 days", "value": "7 days"},
    {"label": "30 days", "value": "30 days"},
    {"label": "3 months", "value": "3 months"},
    {"label": "1 year", "value": "1 year"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Mood", "value": "Mood"},
    {"label": "Sleep", "value": "Sleep"},
    {"label": "Stress", "value": "Stress"},
    {"label": "Energy", "value": "Energy"},
  ];

  // Sample data for analytics
  Map<String, List<Map<String, dynamic>>> analyticsData = {
    "mood": [
      {"date": "2024-12-10", "value": 4.2, "responses": 45},
      {"date": "2024-12-11", "value": 3.8, "responses": 42},
      {"date": "2024-12-12", "value": 4.5, "responses": 48},
      {"date": "2024-12-13", "value": 4.1, "responses": 44},
      {"date": "2024-12-14", "value": 3.9, "responses": 46},
      {"date": "2024-12-15", "value": 4.3, "responses": 47},
      {"date": "2024-12-16", "value": 4.0, "responses": 43},
    ],
    "correlations": [
      {"factor1": "Sleep Quality", "factor2": "Mood", "correlation": 0.78},
      {"factor1": "Exercise", "factor2": "Energy", "correlation": 0.65},
      {"factor1": "Stress Level", "factor2": "Sleep Quality", "correlation": -0.72},
      {"factor1": "Social Activities", "factor2": "Mood", "correlation": 0.54},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "EMA Analytics",
      selectedIndex: selectedTabIndex,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Trends", icon: Icon(Icons.trending_up)),
        Tab(text: "Correlations", icon: Icon(Icons.analytics)),
        Tab(text: "Insights", icon: Icon(Icons.psychology)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildTrendsTab(),
        _buildCorrelationsTab(),
        _buildInsightsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key metrics cards
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildMetricCard("Total Responses", "1,247", "responses", Icons.bar_chart, primaryColor, "+12%"),
              _buildMetricCard("Avg Response Rate", "78.5%", "completion", Icons.check_circle, successColor, "+5.2%"),
              _buildMetricCard("Active Participants", "156", "users", Icons.people, infoColor, "+8"),
              _buildMetricCard("Data Quality", "94.2%", "accuracy", Icons.verified, warningColor, "+2.1%"),
            ],
          ),
          SizedBox(height: spMd),

          // Time period filter
          Row(
            children: [
              Text(
                "Analytics Period:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: QDropdownField(
                  label: "",
                  items: periodOptions,
                  value: selectedPeriod,
                  onChanged: (value, label) {
                    selectedPeriod = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),

          // Response distribution chart
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Response Distribution",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildResponseChart(),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Participant engagement
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Participant Engagement",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildEngagementMetrics(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Metric selector
          QDropdownField(
            label: "Select Metric",
            items: metricOptions,
            value: selectedMetric,
            onChanged: (value, label) {
              selectedMetric = value;
              setState(() {});
            },
          ),
          SizedBox(height: spMd),

          // Trend chart
          Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$selectedMetric Trends",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 4),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "↗ Improving",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildTrendChart(),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Weekly patterns
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Weekly Patterns",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildWeeklyPatterns(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorrelationsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Correlation matrix
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Factor Correlations",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  "Discover relationships between different factors",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildCorrelationList(),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Significant findings
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Significant Findings",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spMd),
                _buildSignificantFindings(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI-generated insights
          Container(
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
                    Icon(
                      Icons.psychology,
                      color: primaryColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "AI-Generated Insights",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildInsightsList(),
              ],
            ),
          ),
          SizedBox(height: spMd),

          // Recommendations
          Container(
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
                    Icon(
                      Icons.lightbulb,
                      color: warningColor,
                      size: 24,
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "Recommendations",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spMd),
                _buildRecommendations(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String unit, IconData icon, Color color, String change) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  change,
                  style: TextStyle(
                    fontSize: 10,
                    color: successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              fontSize: 10,
              color: disabledColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResponseChart() {
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final responses = [45, 42, 48, 44, 46, 47, 43];
    final maxResponse = responses.reduce((a, b) => a > b ? a : b);

    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(days.length, (index) {
          final height = (responses[index] / maxResponse) * 150;
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${responses[index]}",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 4),
              Container(
                width: 30,
                height: height,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
              SizedBox(height: spXs),
              Text(
                days[index],
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.trending_up,
              size: 48,
              color: primaryColor.withAlpha(100),
            ),
            SizedBox(height: spSm),
            Text(
              "Trend visualization would appear here",
              style: TextStyle(
                color: disabledBoldColor,
                fontSize: 14,
              ),
            ),
            Text(
              "Showing improvement over time",
              style: TextStyle(
                color: disabledColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementMetrics() {
    final metrics = [
      {"label": "Daily Active Users", "value": "89%", "color": successColor},
      {"label": "Weekly Retention", "value": "76%", "color": infoColor},
      {"label": "Survey Completion", "value": "84%", "color": warningColor},
      {"label": "Response Quality", "value": "92%", "color": primaryColor},
    ];

    return Column(
      children: metrics.map((metric) => Container(
        margin: EdgeInsets.only(bottom: spSm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${metric["label"]}",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
            Text(
              "${metric["value"]}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: metric["color"] as Color,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildWeeklyPatterns() {
    return Column(
      children: [
        Text(
          "Peak response times occur on Tuesday and Thursday",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spSm),
        Text(
          "Weekend responses tend to be more positive",
          style: TextStyle(
            fontSize: 14,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCorrelationList() {
    return Column(
      children: (analyticsData["correlations"] as List<Map<String, dynamic>>).map((correlation) {
        final strength = (correlation["correlation"] as double).abs();
        Color strengthColor = strength > 0.7 ? successColor : strength > 0.5 ? warningColor : disabledBoldColor;
        
        return Container(
          margin: EdgeInsets.only(bottom: spSm),
          padding: EdgeInsets.all(spSm),
          decoration: BoxDecoration(
            color: strengthColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${correlation["factor1"]} ↔ ${correlation["factor2"]}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      strength > 0.7 ? "Strong correlation" : strength > 0.5 ? "Moderate correlation" : "Weak correlation",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${(correlation["correlation"] as double).toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: strengthColor,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSignificantFindings() {
    final findings = [
      "Sleep quality strongly predicts next-day mood ratings",
      "Exercise frequency correlates with energy levels",
      "Social activities improve weekend mood scores",
      "Stress levels negatively impact sleep quality",
    ];

    return Column(
      children: findings.map((finding) => Container(
        margin: EdgeInsets.only(bottom: spSm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.circle,
              size: 8,
              color: primaryColor,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                finding,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildInsightsList() {
    final insights = [
      {
        "title": "Sleep-Mood Connection",
        "description": "Participants who sleep 7+ hours report 23% higher mood scores",
        "icon": Icons.bedtime,
        "color": primaryColor,
      },
      {
        "title": "Exercise Impact",
        "description": "Regular exercise correlates with 18% improvement in energy levels",
        "icon": Icons.fitness_center,
        "color": successColor,
      },
      {
        "title": "Social Wellbeing",
        "description": "Social interactions on weekends boost mood by average 15%",
        "icon": Icons.people,
        "color": infoColor,
      },
    ];

    return Column(
      children: insights.map((insight) => Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: (insight["color"] as Color).withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          children: [
            Icon(
              insight["icon"] as IconData,
              color: insight["color"] as Color,
              size: 24,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${insight["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: insight["color"] as Color,
                    ),
                  ),
                  Text(
                    "${insight["description"]}",
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
      )).toList(),
    );
  }

  Widget _buildRecommendations() {
    final recommendations = [
      "Consider sending mood surveys after sleep quality assessments",
      "Increase survey frequency on days with high stress indicators", 
      "Add contextual questions about weekend social activities",
      "Implement personalized reminder timing based on response patterns",
    ];

    return Column(
      children: recommendations.map((recommendation) => Container(
        margin: EdgeInsets.only(bottom: spSm),
        padding: EdgeInsets.all(spSm),
        decoration: BoxDecoration(
          color: warningColor.withAlpha(20),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lightbulb,
              color: warningColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Text(
                recommendation,
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}
