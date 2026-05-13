import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmFeedbackAnalysisView extends StatefulWidget {
  const EcmFeedbackAnalysisView({super.key});

  @override
  State<EcmFeedbackAnalysisView> createState() => _EcmFeedbackAnalysisViewState();
}

class _EcmFeedbackAnalysisViewState extends State<EcmFeedbackAnalysisView> {
  String selectedFilter = "all";
  String selectedSentiment = "all";
  String selectedTimeframe = "event";
  
  Map<String, dynamic> analysisData = {
    "summary": {
      "totalFeedback": 1247,
      "averageRating": 4.3,
      "responseRate": 82.4,
      "sentimentPositive": 76.2,
      "sentimentNeutral": 18.3,
      "sentimentNegative": 5.5
    },
    "trends": [
      {"period": "Day 1", "positive": 72, "neutral": 21, "negative": 7, "total": 456},
      {"period": "Day 2", "positive": 78, "neutral": 16, "negative": 6, "total": 523},
      {"period": "Day 3", "positive": 81, "neutral": 15, "negative": 4, "total": 268},
    ],
    "topKeywords": [
      {"word": "excellent", "count": 342, "sentiment": "positive"},
      {"word": "informative", "count": 298, "sentiment": "positive"},
      {"word": "engaging", "count": 267, "sentiment": "positive"},
      {"word": "networking", "count": 234, "sentiment": "positive"},
      {"word": "overcrowded", "count": 89, "sentiment": "negative"},
      {"word": "loud", "count": 67, "sentiment": "negative"},
      {"word": "confusing", "count": 45, "sentiment": "negative"},
      {"word": "basic", "count": 38, "sentiment": "neutral"},
    ],
    "categories": [
      {
        "name": "Content Quality",
        "rating": 4.5,
        "feedback": 823,
        "positive": 78,
        "neutral": 16,
        "negative": 6,
        "topics": ["excellent content", "informative sessions", "practical examples"]
      },
      {
        "name": "Speaker Performance",
        "rating": 4.4,
        "feedback": 798,
        "positive": 75,
        "neutral": 19,
        "negative": 6,
        "topics": ["knowledgeable speakers", "engaging presentation", "clear delivery"]
      },
      {
        "name": "Event Organization",
        "rating": 4.1,
        "feedback": 654,
        "positive": 68,
        "neutral": 24,
        "negative": 8,
        "topics": ["well organized", "smooth registration", "clear directions"]
      },
      {
        "name": "Venue & Facilities",
        "rating": 3.9,
        "feedback": 567,
        "positive": 62,
        "neutral": 28,
        "negative": 10,
        "topics": ["nice venue", "comfortable seating", "good location"]
      },
      {
        "name": "Networking",
        "rating": 4.2,
        "feedback": 445,
        "positive": 71,
        "neutral": 22,
        "negative": 7,
        "topics": ["great networking", "valuable connections", "good breaks"]
      }
    ],
    "issues": [
      {
        "issue": "Audio/Visual Problems",
        "severity": "high",
        "mentions": 78,
        "sessions": ["Main Hall Session 1", "Room B Workshop", "Panel Discussion"],
        "sentiment": "negative",
        "impact": 8.2
      },
      {
        "issue": "Overcrowding",
        "severity": "medium",
        "mentions": 56,
        "sessions": ["Keynote Session", "AI Workshop", "Marketing Panel"],
        "sentiment": "negative",
        "impact": 6.8
      },
      {
        "issue": "Food Quality",
        "severity": "low",
        "mentions": 34,
        "sessions": ["Lunch Break", "Coffee Break"],
        "sentiment": "negative",
        "impact": 3.2
      },
      {
        "issue": "Limited Parking",
        "severity": "medium",
        "mentions": 42,
        "sessions": ["General"],
        "sentiment": "negative",
        "impact": 4.5
      }
    ]
  };
  
  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Feedback", "value": "all"},
    {"label": "Sessions Only", "value": "sessions"},
    {"label": "Speakers Only", "value": "speakers"},
    {"label": "Venue Only", "value": "venue"},
    {"label": "Organization", "value": "organization"},
  ];
  
  List<Map<String, dynamic>> sentimentOptions = [
    {"label": "All Sentiment", "value": "all"},
    {"label": "Positive", "value": "positive"},
    {"label": "Neutral", "value": "neutral"},
    {"label": "Negative", "value": "negative"},
  ];
  
  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Entire Event", "value": "event"},
    {"label": "Daily", "value": "daily"},
    {"label": "By Session", "value": "session"},
  ];

  @override
  Widget build(BuildContext context) {
    final summary = analysisData["summary"] as Map<String, dynamic>;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback Analysis"),
        actions: [
          QButton(
            icon: Icons.refresh,
            size: bs.sm,
            onPressed: _refreshAnalysis,
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
                    label: "Category",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sentiment",
                    items: sentimentOptions,
                    value: selectedSentiment,
                    onChanged: (value, label) {
                      selectedSentiment = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            // Summary cards
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildSummaryCard(
                  "Total Feedback",
                  "${summary["totalFeedback"]}",
                  Icons.feedback,
                  primaryColor,
                ),
                _buildSummaryCard(
                  "Average Rating",
                  "${(summary["averageRating"] as double).toStringAsFixed(1)}/5",
                  Icons.star,
                  warningColor,
                ),
                _buildSummaryCard(
                  "Response Rate",
                  "${(summary["responseRate"] as double).toStringAsFixed(1)}%",
                  Icons.analytics,
                  successColor,
                ),
                _buildSummaryCard(
                  "Positive Sentiment",
                  "${(summary["sentimentPositive"] as double).toStringAsFixed(1)}%",
                  Icons.sentiment_very_satisfied,
                  successColor,
                ),
              ],
            ),
            
            // Sentiment distribution
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sentiment Distribution",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  _buildSentimentBar(
                    "Positive",
                    summary["sentimentPositive"] as double,
                    successColor,
                  ),
                  
                  _buildSentimentBar(
                    "Neutral",
                    summary["sentimentNeutral"] as double,
                    warningColor,
                  ),
                  
                  _buildSentimentBar(
                    "Negative",
                    summary["sentimentNegative"] as double,
                    dangerColor,
                  ),
                ],
              ),
            ),
            
            // Sentiment trend
            if (selectedTimeframe == "daily") ...[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daily Sentiment Trend",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    ...(analysisData["trends"] as List).map((trend) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(spXs),
                        margin: EdgeInsets.only(bottom: spXs),
                        decoration: BoxDecoration(
                          color: disabledColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Column(
                          spacing: spXs,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${trend["period"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${trend["total"]} responses",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            
                            Row(
                              children: [
                                _buildMiniSentimentIndicator("Positive", trend["positive"] as int, successColor),
                                SizedBox(width: spSm),
                                _buildMiniSentimentIndicator("Neutral", trend["neutral"] as int, warningColor),
                                SizedBox(width: spSm),
                                _buildMiniSentimentIndicator("Negative", trend["negative"] as int, dangerColor),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
            
            // Top keywords
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top Keywords",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  Wrap(
                    spacing: spXs,
                    runSpacing: spXs,
                    children: (analysisData["topKeywords"] as List).map((keyword) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: _getSentimentColor("${keyword["sentiment"]}").withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                          border: Border.all(
                            color: _getSentimentColor("${keyword["sentiment"]}").withAlpha(100),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${keyword["word"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getSentimentColor("${keyword["sentiment"]}"),
                              ),
                            ),
                            SizedBox(width: spXs),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: _getSentimentColor("${keyword["sentiment"]}"),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${keyword["count"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Category analysis
            Text(
              "Category Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            ...(analysisData["categories"] as List).map((category) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${category["name"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: warningColor),
                            SizedBox(width: 4),
                            Text(
                              "${(category["rating"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    Text(
                      "${category["feedback"]} feedback responses",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                    
                    Row(
                      children: [
                        _buildCategorySentiment("Positive", category["positive"] as int, successColor),
                        SizedBox(width: spSm),
                        _buildCategorySentiment("Neutral", category["neutral"] as int, warningColor),
                        SizedBox(width: spSm),
                        _buildCategorySentiment("Negative", category["negative"] as int, dangerColor),
                      ],
                    ),
                    
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (category["topics"] as List).map((topic) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$topic",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            // Issues analysis
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Key Issues Identified",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: dangerColor,
                    ),
                  ),
                  
                  ...(analysisData["issues"] as List).map((issue) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spXs),
                      decoration: BoxDecoration(
                        color: _getSeverityColor("${issue["severity"]}").withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                        border: Border.all(
                          color: _getSeverityColor("${issue["severity"]}").withAlpha(100),
                        ),
                      ),
                      child: Column(
                        spacing: spXs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${issue["issue"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _getSeverityColor("${issue["severity"]}"),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _getSeverityColor("${issue["severity"]}"),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${issue["severity"]}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          Row(
                            children: [
                              Text(
                                "${issue["mentions"]} mentions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Impact: ${(issue["impact"] as double).toStringAsFixed(1)}/10",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _getSeverityColor("${issue["severity"]}"),
                                ),
                              ),
                            ],
                          ),
                          
                          if ((issue["sessions"] as List).isNotEmpty) ...[
                            Text(
                              "Affected: ${(issue["sessions"] as List).join(", ")}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Analysis",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: _exportAnalysis,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.description,
                    size: bs.md,
                    onPressed: _generateReport,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spXs,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: spXs),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSentimentBar(String label, double percentage, Color color) {
    return Column(
      spacing: spXs,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Spacer(),
            Text(
              "${percentage.toStringAsFixed(1)}%",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: disabledColor.withAlpha(50),
            borderRadius: BorderRadius.circular(radiusSm),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildMiniSentimentIndicator(String label, int value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        SizedBox(width: 4),
        Text(
          "$label: $value%",
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
  
  Widget _buildCategorySentiment(String label, int percentage, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(radiusLg),
          ),
        ),
        SizedBox(width: 4),
        Text(
          "$label $percentage%",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
  
  Color _getSentimentColor(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return successColor;
      case 'negative':
        return dangerColor;
      case 'neutral':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
  
  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return dangerColor;
      case 'medium':
        return warningColor;
      case 'low':
        return infoColor;
      default:
        return disabledBoldColor;
    }
  }
  
  void _refreshAnalysis() {
    ss("Analysis refreshed with latest data");
  }
  
  void _exportAnalysis() {
    ss("Feedback analysis exported successfully");
  }
  
  void _generateReport() {
    ss("Comprehensive report generated");
  }
}
