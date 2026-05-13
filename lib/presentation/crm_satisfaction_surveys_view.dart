import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmSatisfactionSurveysView extends StatefulWidget {
  const CrmSatisfactionSurveysView({super.key});

  @override
  State<CrmSatisfactionSurveysView> createState() => _CrmSatisfactionSurveysViewState();
}

class _CrmSatisfactionSurveysViewState extends State<CrmSatisfactionSurveysView> {
  String selectedStatus = "all";
  String selectedType = "all";
  
  List<Map<String, dynamic>> statusItems = [
    {"label": "All Surveys", "value": "all"},
    {"label": "Active", "value": "active"},
    {"label": "Draft", "value": "draft"},
    {"label": "Completed", "value": "completed"},
  ];

  List<Map<String, dynamic>> typeItems = [
    {"label": "All Types", "value": "all"},
    {"label": "Product Satisfaction", "value": "product"},
    {"label": "Service Quality", "value": "service"},
    {"label": "Support Experience", "value": "support"},
  ];

  List<Map<String, dynamic>> surveyMetrics = [
    {
      "title": "Total Surveys",
      "value": 24,
      "change": 14.3,
      "icon": Icons.quiz,
      "color": Colors.blue,
    },
    {
      "title": "Total Responses",
      "value": 3450,
      "change": 28.5,
      "icon": Icons.feedback,
      "color": Colors.green,
    },
    {
      "title": "Average Response Rate",
      "value": 72.8,
      "change": 5.2,
      "icon": Icons.trending_up,
      "color": Colors.orange,
      "isPercentage": true,
    },
    {
      "title": "Average Satisfaction",
      "value": 4.2,
      "change": 8.1,
      "icon": Icons.sentiment_very_satisfied,
      "color": Colors.purple,
      "suffix": "/5",
    },
  ];

  List<Map<String, dynamic>> activeSurveys = [
    {
      "title": "Q4 Customer Experience Survey",
      "type": "Service Quality",
      "responses": 285,
      "target": 500,
      "avgRating": 4.3,
      "endDate": "Dec 31, 2024",
      "status": "active",
    },
    {
      "title": "Product Feature Feedback",
      "type": "Product Satisfaction",
      "responses": 142,
      "target": 200,
      "avgRating": 3.9,
      "endDate": "Nov 30, 2024",
      "status": "active",
    },
    {
      "title": "Support Team Performance",
      "type": "Support Experience",
      "responses": 98,
      "target": 150,
      "avgRating": 4.6,
      "endDate": "Dec 15, 2024",
      "status": "active",
    },
  ];

  List<Map<String, dynamic>> completedSurveys = [
    {
      "title": "Q3 Overall Satisfaction",
      "type": "Service Quality",
      "responses": 624,
      "target": 600,
      "avgRating": 4.1,
      "completedDate": "Sep 30, 2024",
      "status": "completed",
    },
    {
      "title": "Mobile App User Experience",
      "type": "Product Satisfaction",
      "responses": 380,
      "target": 300,
      "avgRating": 3.8,
      "completedDate": "Oct 15, 2024",
      "status": "completed",
    },
    {
      "title": "Onboarding Process Review",
      "type": "Support Experience",
      "responses": 156,
      "target": 200,
      "avgRating": 4.4,
      "completedDate": "Oct 31, 2024",
      "status": "completed",
    },
  ];

  List<Map<String, dynamic>> satisfactionTrends = [
    {"period": "Jan", "score": 3.8, "responses": 245},
    {"period": "Feb", "score": 4.0, "responses": 268},
    {"period": "Mar", "score": 4.1, "responses": 295},
    {"period": "Apr", "score": 3.9, "responses": 312},
    {"period": "May", "score": 4.2, "responses": 341},
    {"period": "Jun", "score": 4.3, "responses": 378},
  ];

  List<Map<String, dynamic>> topFeedbackTopics = [
    {
      "topic": "Product Features",
      "mentions": 542,
      "sentiment": "positive",
      "percentage": 28.5,
    },
    {
      "topic": "Customer Support",
      "mentions": 418,
      "sentiment": "positive",
      "percentage": 22.0,
    },
    {
      "topic": "Pricing",
      "mentions": 365,
      "sentiment": "neutral",
      "percentage": 19.2,
    },
    {
      "topic": "User Interface",
      "mentions": 298,
      "sentiment": "positive",
      "percentage": 15.7,
    },
    {
      "topic": "Performance Issues",
      "mentions": 275,
      "sentiment": "negative",
      "percentage": 14.5,
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

  Color _getStatusColor(String status) {
    switch (status) {
      case "active":
        return Colors.green;
      case "draft":
        return Colors.orange;
      case "completed":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating
                  ? Icons.star_half
                  : Icons.star_border,
          size: 16,
          color: Colors.amber,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satisfaction Surveys"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              ss("Create new survey feature coming soon");
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
                    label: "Status",
                    items: statusItems,
                    value: selectedStatus,
                    onChanged: (value, label) {
                      selectedStatus = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Survey Type",
                    items: typeItems,
                    value: selectedType,
                    onChanged: (value, label) {
                      selectedType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Survey Metrics
            Text(
              "Survey Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: surveyMetrics.map((metric) {
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
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: metric["isPercentage"] == true
                                  ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                                  : "${(metric["value"] as num).toString()}",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            if (metric["suffix"] != null)
                              TextSpan(
                                text: "${metric["suffix"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: disabledBoldColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Active Surveys
            Text(
              "Active Surveys",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: activeSurveys.map((survey) {
                double progressPercentage = (survey["responses"] as int) / (survey["target"] as int);
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${survey["title"]}",
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
                                        color: primaryColor.withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${survey["type"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spSm,
                                        vertical: spXs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getStatusColor("${survey["status"]}").withAlpha(51),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${survey["status"]}".toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: _getStatusColor("${survey["status"]}"),
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
                              Row(
                                children: [
                                  _buildRatingStars(survey["avgRating"] as double),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(survey["avgRating"] as double).toStringAsFixed(1)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Ends ${survey["endDate"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
                          Text(
                            "${(survey["responses"] as int)} / ${(survey["target"] as int)} responses",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "${(progressPercentage * 100).toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: disabledColor,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progressPercentage > 1.0 ? 1.0 : progressPercentage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spLg),

            // Recently Completed Surveys
            Text(
              "Recently Completed Surveys",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: completedSurveys.map((survey) {
                double responseRate = (survey["responses"] as int) / (survey["target"] as int) * 100;
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
                              "${survey["title"]}",
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
                                    color: primaryColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${survey["type"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Completed ${survey["completedDate"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${(survey["responses"] as int)} responses (${responseRate.toStringAsFixed(0)}% response rate)",
                              style: TextStyle(
                                fontSize: 14,
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
                              _buildRatingStars(survey["avgRating"] as double),
                              SizedBox(width: spXs),
                              Text(
                                "${(survey["avgRating"] as double).toStringAsFixed(1)}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Average Rating",
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

            // Satisfaction Trends
            Text(
              "Satisfaction Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Monthly Satisfaction Score",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Score",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: secondaryColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "Responses",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spLg),
                  QHorizontalScroll(
                    children: satisfactionTrends.map((trend) {
                      return Container(
                        width: 100,
                        margin: EdgeInsets.only(right: spSm),
                        child: Column(
                          children: [
                            Text(
                              "${trend["period"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${(trend["score"] as double).toStringAsFixed(1)}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Score",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${(trend["responses"] as int)}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: secondaryColor,
                              ),
                            ),
                            Text(
                              "Responses",
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
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Top Feedback Topics
            Text(
              "Top Feedback Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: topFeedbackTopics.map((topic) {
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
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getSentimentColor("${topic["sentiment"]}"),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${topic["topic"]}",
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
                                    color: _getSentimentColor("${topic["sentiment"]}").withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${topic["sentiment"]}".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: _getSentimentColor("${topic["sentiment"]}"),
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${(topic["mentions"] as int)} mentions",
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
                            "${(topic["percentage"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "of feedback",
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
