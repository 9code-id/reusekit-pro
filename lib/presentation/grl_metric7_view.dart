import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMetric7View extends StatefulWidget {
  @override
  State<GrlMetric7View> createState() => _GrlMetric7ViewState();
}

class _GrlMetric7ViewState extends State<GrlMetric7View> {
  String selectedMetric = "Customer Satisfaction";
  String selectedTimeframe = "Last 30 Days";
  
  List<Map<String, dynamic>> satisfactionData = [
    {
      "category": "Product Quality",
      "score": 4.8,
      "responses": 2847,
      "change": 0.3,
      "trend": "up",
      "color": Color(0xFF22C55E),
      "benchmark": 4.5,
    },
    {
      "category": "Customer Service",
      "score": 4.6,
      "responses": 1923,
      "change": 0.2,
      "trend": "up",
      "color": Color(0xFF3B82F6),
      "benchmark": 4.3,
    },
    {
      "category": "Delivery Experience",
      "score": 4.2,
      "responses": 3156,
      "change": -0.1,
      "trend": "down",
      "color": Color(0xFFF59E0B),
      "benchmark": 4.4,
    },
    {
      "category": "Value for Money",
      "score": 4.4,
      "responses": 2634,
      "change": 0.4,
      "trend": "up",
      "color": Color(0xFF8B5CF6),
      "benchmark": 4.2,
    },
    {
      "category": "User Experience",
      "score": 4.7,
      "responses": 1876,
      "change": 0.1,
      "trend": "up",
      "color": Color(0xFFEF4444),
      "benchmark": 4.5,
    },
  ];

  List<Map<String, dynamic>> npsData = [
    {"month": "Jan", "score": 42, "responses": 1250},
    {"month": "Feb", "score": 45, "responses": 1340},
    {"month": "Mar", "score": 48, "responses": 1420},
    {"month": "Apr", "score": 52, "responses": 1580},
    {"month": "May", "score": 55, "responses": 1650},
    {"month": "Jun", "score": 58, "responses": 1720},
  ];

  List<Map<String, dynamic>> feedbackTopics = [
    {"topic": "Shipping Speed", "mentions": 847, "sentiment": "negative", "priority": "high"},
    {"topic": "Product Features", "mentions": 623, "sentiment": "positive", "priority": "medium"},
    {"topic": "Customer Support", "mentions": 456, "sentiment": "positive", "priority": "low"},
    {"topic": "Pricing", "mentions": 389, "sentiment": "neutral", "priority": "medium"},
    {"topic": "User Interface", "mentions": 267, "sentiment": "positive", "priority": "low"},
  ];

  List<Map<String, dynamic>> metricItems = [
    {"label": "Customer Satisfaction", "value": "Customer Satisfaction"},
    {"label": "Net Promoter Score", "value": "Net Promoter Score"},
    {"label": "Customer Effort Score", "value": "Customer Effort Score"},
    {"label": "Retention Rate", "value": "Retention Rate"},
  ];

  List<Map<String, dynamic>> timeframeItems = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "This Year", "value": "This Year"},
  ];

  @override
  Widget build(BuildContext context) {
    double overallScore = satisfactionData.fold(0.0, (sum, item) => sum + (item["score"] as double)) / satisfactionData.length;
    int totalResponses = satisfactionData.fold(0, (sum, item) => sum + (item["responses"] as int));
    double currentNPS = npsData.isNotEmpty ? (npsData.last["score"] as int).toDouble() : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Experience"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
                    items: metricItems,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeItems,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Key Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildMetricCard(
                  "Overall Score",
                  "${overallScore.toStringAsFixed(1)}/5.0",
                  Icons.star,
                  successColor,
                  "Excellent",
                ),
                _buildMetricCard(
                  "Total Responses",
                  "${(totalResponses / 1000).toStringAsFixed(1)}K",
                  Icons.feedback,
                  infoColor,
                  "+12% vs last month",
                ),
                _buildMetricCard(
                  "NPS Score",
                  "${currentNPS.toInt()}",
                  Icons.trending_up,
                  primaryColor,
                  "Strong promoters",
                ),
                _buildMetricCard(
                  "Response Rate",
                  "68.5%",
                  Icons.rate_review,
                  warningColor,
                  "Above industry avg",
                ),
              ],
            ),

            // Satisfaction Categories
            Text(
              "Satisfaction by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: satisfactionData.map((item) => _buildSatisfactionItem(item)).toList(),
              ),
            ),

            // NPS Trend
            Text(
              "Net Promoter Score Trend",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              height: 220,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "6-Month NPS Progress",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "+16 points",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: npsData.map((item) {
                        double score = (item["score"] as int).toDouble();
                        double height = (score / 70) * 120; // Scale to chart height
                        Color barColor = score >= 50 ? successColor : score >= 30 ? warningColor : dangerColor;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${item["score"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Container(
                              width: 25,
                              height: height,
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${item["month"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Feedback Topics
            Text(
              "Top Feedback Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: feedbackTopics.map((item) => _buildFeedbackTopicItem(item)).toList(),
              ),
            ),

            // Customer Experience Insights
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(10),
                    successColor.withAlpha(10),
                  ],
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Experience Insights",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Column(
                      spacing: spXs,
                      children: [
                        _buildInsightItem(
                          Icons.emoji_events,
                          "Product Quality exceeds expectations (4.8/5.0)",
                          successColor,
                        ),
                        _buildInsightItem(
                          Icons.warning,
                          "Delivery Experience needs improvement (4.2/5.0)",
                          warningColor,
                        ),
                        _buildInsightItem(
                          Icons.trending_up,
                          "NPS improved by 16 points in 6 months",
                          infoColor,
                        ),
                        _buildInsightItem(
                          Icons.priority_high,
                          "Shipping Speed is top concern - high priority",
                          dangerColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action Plan
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: primaryColor,
                        size: 20,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Improvement Action Plan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: spXs,
                    children: [
                      _buildActionItem("Optimize shipping and delivery processes", dangerColor, "High Priority"),
                      _buildActionItem("Implement faster shipping options", warningColor, "Medium Priority"),
                      _buildActionItem("Enhance customer service training", infoColor, "Medium Priority"),
                      _buildActionItem("Develop pricing strategy review", successColor, "Low Priority"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              Icon(
                Icons.trending_up,
                color: color,
                size: 16,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSatisfactionItem(Map<String, dynamic> item) {
    double score = item["score"] as double;
    double benchmark = item["benchmark"] as double;
    bool aboveBenchmark = score > benchmark;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: (item["color"] as Color).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  _getCategoryIcon("${item["category"]}"),
                  color: item["color"] as Color,
                  size: 20,
                ),
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item["category"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "${item["responses"]} responses",
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
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star,
                        size: 14,
                        color: index < score ? warningColor : disabledColor,
                      );
                    }),
                  ),
                  Text(
                    "${score.toStringAsFixed(1)}/5.0",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: disabledColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: score / 5.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: score >= 4.5 ? successColor : score >= 3.5 ? warningColor : dangerColor,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    "${item["trend"]}" == "up" ? Icons.arrow_upward : Icons.arrow_downward,
                    color: "${item["trend"]}" == "up" ? successColor : dangerColor,
                    size: 12,
                  ),
                  Text(
                    "${(item["change"] as double).abs().toStringAsFixed(1)}",
                    style: TextStyle(
                      fontSize: 12,
                      color: "${item["trend"]}" == "up" ? successColor : dangerColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Benchmark: ${benchmark.toStringAsFixed(1)}",
                style: TextStyle(
                  fontSize: 11,
                  color: disabledBoldColor,
                ),
              ),
              Text(
                aboveBenchmark ? "Above benchmark" : "Below benchmark",
                style: TextStyle(
                  fontSize: 11,
                  color: aboveBenchmark ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackTopicItem(Map<String, dynamic> item) {
    Color sentimentColor = _getSentimentColor("${item["sentiment"]}");
    Color priorityColor = _getPriorityColor("${item["priority"]}");

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: disabledOutlineBorderColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: sentimentColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              _getTopicIcon("${item["topic"]}"),
              color: sentimentColor,
              size: 20,
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item["topic"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: sentimentColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["sentiment"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: sentimentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: spXs),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                      decoration: BoxDecoration(
                        color: priorityColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${item["priority"]} priority",
                        style: TextStyle(
                          fontSize: 10,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
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
                "${item["mentions"]}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "mentions",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 16,
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(String text, Color color, String priority) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusXs),
          ),
          child: Text(
            priority,
            style: TextStyle(
              fontSize: 10,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Product Quality":
        return Icons.verified;
      case "Customer Service":
        return Icons.support_agent;
      case "Delivery Experience":
        return Icons.local_shipping;
      case "Value for Money":
        return Icons.attach_money;
      case "User Experience":
        return Icons.smartphone;
      default:
        return Icons.star;
    }
  }

  IconData _getTopicIcon(String topic) {
    switch (topic) {
      case "Shipping Speed":
        return Icons.speed;
      case "Product Features":
        return Icons.featured_play_list;
      case "Customer Support":
        return Icons.support;
      case "Pricing":
        return Icons.local_offer;
      case "User Interface":
        return Icons.design_services;
      default:
        return Icons.topic;
    }
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case "positive":
        return successColor;
      case "negative":
        return dangerColor;
      case "neutral":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }
}
