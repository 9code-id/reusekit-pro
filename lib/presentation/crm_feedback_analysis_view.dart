import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmFeedbackAnalysisView extends StatefulWidget {
  const CrmFeedbackAnalysisView({super.key});

  @override
  State<CrmFeedbackAnalysisView> createState() => _CrmFeedbackAnalysisViewState();
}

class _CrmFeedbackAnalysisViewState extends State<CrmFeedbackAnalysisView> {
  String selectedPeriod = "30_days";
  String selectedSource = "all";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 90 Days", "value": "90_days"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> sourceItems = [
    {"label": "All Sources", "value": "all"},
    {"label": "App Reviews", "value": "app_reviews"},
    {"label": "Support Tickets", "value": "support"},
    {"label": "Surveys", "value": "surveys"},
    {"label": "Social Media", "value": "social"},
  ];

  List<Map<String, dynamic>> feedbackMetrics = [
    {
      "title": "Total Feedback",
      "value": 2847,
      "change": 18.5,
      "icon": Icons.feedback,
      "color": Colors.blue,
    },
    {
      "title": "Positive Sentiment",
      "value": 68.3,
      "change": 12.8,
      "icon": Icons.sentiment_very_satisfied,
      "color": Colors.green,
      "isPercentage": true,
    },
    {
      "title": "Response Rate",
      "value": 85.7,
      "change": 7.2,
      "icon": Icons.trending_up,
      "color": Colors.orange,
      "isPercentage": true,
    },
    {
      "title": "Issues Resolved",
      "value": 94.2,
      "change": 5.8,
      "icon": Icons.check_circle,
      "color": Colors.purple,
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> sentimentAnalysis = [
    {
      "sentiment": "Positive",
      "count": 1945,
      "percentage": 68.3,
      "color": Colors.green,
      "icon": Icons.sentiment_very_satisfied,
    },
    {
      "sentiment": "Neutral",
      "count": 568,
      "percentage": 20.0,
      "color": Colors.orange,
      "icon": Icons.sentiment_neutral,
    },
    {
      "sentiment": "Negative",
      "count": 334,
      "percentage": 11.7,
      "color": Colors.red,
      "icon": Icons.sentiment_very_dissatisfied,
    },
  ];

  List<Map<String, dynamic>> feedbackCategories = [
    {
      "category": "Product Features",
      "count": 845,
      "sentiment": "positive",
      "avgRating": 4.2,
      "trend": "up",
      "percentage": 29.7,
    },
    {
      "category": "Customer Support",
      "count": 642,
      "sentiment": "positive",
      "avgRating": 4.5,
      "trend": "up",
      "percentage": 22.5,
    },
    {
      "category": "User Experience",
      "count": 518,
      "sentiment": "neutral",
      "avgRating": 3.8,
      "trend": "stable",
      "percentage": 18.2,
    },
    {
      "category": "Pricing",
      "count": 425,
      "sentiment": "neutral",
      "avgRating": 3.5,
      "trend": "down",
      "percentage": 14.9,
    },
    {
      "category": "Performance",
      "count": 417,
      "sentiment": "negative",
      "avgRating": 3.2,
      "trend": "up",
      "percentage": 14.6,
    },
  ];

  List<Map<String, dynamic>> recentFeedback = [
    {
      "customer": "Sarah Johnson",
      "avatar": "SJ",
      "feedback": "The new dashboard feature is incredibly intuitive and has improved our workflow significantly.",
      "category": "Product Features",
      "sentiment": "positive",
      "rating": 5,
      "source": "App Review",
      "date": "2 hours ago",
    },
    {
      "customer": "Michael Chen",
      "avatar": "MC",
      "feedback": "Customer support was very helpful in resolving my billing issue quickly and professionally.",
      "category": "Customer Support",
      "sentiment": "positive",
      "rating": 5,
      "source": "Survey",
      "date": "4 hours ago",
    },
    {
      "customer": "Emma Williams",
      "avatar": "EW",
      "feedback": "The app sometimes crashes when uploading large files. This needs to be fixed urgently.",
      "category": "Performance",
      "sentiment": "negative",
      "rating": 2,
      "source": "Support Ticket",
      "date": "6 hours ago",
    },
    {
      "customer": "David Rodriguez",
      "avatar": "DR",
      "feedback": "Overall satisfied with the service, but the pricing could be more competitive.",
      "category": "Pricing",
      "sentiment": "neutral",
      "rating": 3,
      "source": "Survey",
      "date": "8 hours ago",
    },
  ];

  List<Map<String, dynamic>> keywordTrends = [
    {
      "keyword": "Easy to use",
      "count": 324,
      "sentiment": "positive",
      "change": 28.5,
    },
    {
      "keyword": "Great support",
      "count": 298,
      "sentiment": "positive",
      "change": 15.2,
    },
    {
      "keyword": "Slow performance",
      "count": 186,
      "sentiment": "negative",
      "change": -12.3,
    },
    {
      "keyword": "Expensive",
      "count": 142,
      "sentiment": "negative",
      "change": 8.7,
    },
    {
      "keyword": "Love the features",
      "count": 128,
      "sentiment": "positive",
      "change": 22.1,
    },
  ];

  List<Map<String, dynamic>> actionableInsights = [
    {
      "insight": "Customers love the new dashboard but request more customization options",
      "priority": "high",
      "category": "Product Features",
      "affectedCustomers": 324,
      "impact": "positive",
    },
    {
      "insight": "Performance issues on mobile app causing customer dissatisfaction",
      "priority": "critical",
      "category": "Performance",
      "affectedCustomers": 186,
      "impact": "negative",
    },
    {
      "insight": "Support team response time improved significantly this quarter",
      "priority": "medium",
      "category": "Customer Support",
      "affectedCustomers": 298,
      "impact": "positive",
    },
    {
      "insight": "Pricing feedback suggests need for more flexible plans",
      "priority": "medium",
      "category": "Pricing",
      "affectedCustomers": 142,
      "impact": "neutral",
    },
  ];

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case "positive":
        return Colors.green;
      case "negative":
        return Colors.red;
      case "neutral":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return Colors.red;
      case "high":
        return Colors.orange;
      case "medium":
        return Colors.blue;
      case "low":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 14,
          color: Colors.amber,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Feedback analysis report exported successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: periodItems,
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
                    label: "Feedback Source",
                    items: sourceItems,
                    value: selectedSource,
                    onChanged: (value, label) {
                      selectedSource = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Feedback Metrics
            Text(
              "Feedback Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: feedbackMetrics.map((metric) {
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              metric["icon"] as IconData,
                              color: metric["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) > 0
                                  ? Colors.green.withAlpha(51)
                                  : Colors.red.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (metric["change"] as double) > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        metric["isPercentage"] == true
                            ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                            : "${(metric["value"] as num).toString()}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Sentiment Analysis
            Text(
              "Sentiment Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: sentimentAnalysis.map((sentiment) {
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
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: (sentiment["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Icon(
                              sentiment["icon"] as IconData,
                              color: sentiment["color"] as Color,
                              size: 24,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(sentiment["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: sentiment["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${sentiment["sentiment"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${(sentiment["count"] as int).toString()}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "feedback items",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Feedback Categories
            Text(
              "Feedback by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: feedbackCategories.map((category) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _getSentimentColor("${category["sentiment"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${category["category"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  _getTrendIcon("${category["trend"]}"),
                                  size: 16,
                                  color: category["trend"] == "up"
                                      ? Colors.green
                                      : category["trend"] == "down"
                                          ? Colors.red
                                          : Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getSentimentColor("${category["sentiment"]}").withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${category["sentiment"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getSentimentColor("${category["sentiment"]}"),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(category["count"] as int)} items (${(category["percentage"] as double).toStringAsFixed(1)}%)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                            "${(category["avgRating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Avg Rating",
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
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Recent Feedback
            Text(
              "Recent Feedback",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: recentFeedback.map((feedback) {
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
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: primaryColor.withAlpha(51),
                            child: Text(
                              "${feedback["avatar"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${feedback["customer"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    _buildRatingStars(feedback["rating"] as int),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${feedback["source"]} • ${feedback["date"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getSentimentColor("${feedback["sentiment"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${feedback["sentiment"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getSentimentColor("${feedback["sentiment"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${feedback["feedback"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${feedback["category"]}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Keyword Trends
            Text(
              "Keyword Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: keywordTrends.map((keyword) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\"${keyword["keyword"]}\"",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spXs),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getSentimentColor("${keyword["sentiment"]}").withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${keyword["sentiment"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getSentimentColor("${keyword["sentiment"]}"),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(keyword["count"] as int)} mentions",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: (keyword["change"] as double) > 0
                                  ? Colors.green.withAlpha(51)
                                  : Colors.red.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(keyword["change"] as double) >= 0 ? '+' : ''}${(keyword["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: (keyword["change"] as double) > 0
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                          Text(
                            "Change",
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
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Actionable Insights
            Text(
              "Actionable Insights",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: actionableInsights.map((insight) {
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
                          Expanded(
                            child: Text(
                              "${insight["insight"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getPriorityColor("${insight["priority"]}").withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${insight["priority"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getPriorityColor("${insight["priority"]}"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${insight["category"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(insight["affectedCustomers"] as int)} customers affected",
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
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
