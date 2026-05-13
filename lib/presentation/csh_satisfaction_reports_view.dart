import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CshSatisfactionReportsView extends StatefulWidget {
  const CshSatisfactionReportsView({super.key});

  @override
  State<CshSatisfactionReportsView> createState() => _CshSatisfactionReportsViewState();
}

class _CshSatisfactionReportsViewState extends State<CshSatisfactionReportsView> {
  String selectedPeriod = "Last 30 Days";
  String selectedChannel = "All Channels";
  String selectedTeam = "All Teams";
  
  List<Map<String, dynamic>> periods = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 90 Days", "value": "Last 90 Days"},
    {"label": "Last 6 Months", "value": "Last 6 Months"},
    {"label": "Last Year", "value": "Last Year"},
  ];

  List<Map<String, dynamic>> channels = [
    {"label": "All Channels", "value": "All Channels"},
    {"label": "Email", "value": "Email"},
    {"label": "Live Chat", "value": "Live Chat"},
    {"label": "Phone", "value": "Phone"},
    {"label": "Social Media", "value": "Social Media"},
    {"label": "Help Center", "value": "Help Center"},
  ];

  List<Map<String, dynamic>> teams = [
    {"label": "All Teams", "value": "All Teams"},
    {"label": "Technical Support", "value": "Technical Support"},
    {"label": "Sales Support", "value": "Sales Support"},
    {"label": "Billing Support", "value": "Billing Support"},
    {"label": "General Support", "value": "General Support"},
  ];

  List<Map<String, dynamic>> satisfactionMetrics = [
    {
      "title": "Overall Satisfaction",
      "rating": 4.6,
      "responses": 2847,
      "change": 0.2,
      "color": primaryColor,
      "target": 4.5
    },
    {
      "title": "Resolution Quality",
      "rating": 4.4,
      "responses": 2654,
      "change": 0.1,
      "color": successColor,
      "target": 4.3
    },
    {
      "title": "Response Speed",
      "rating": 4.2,
      "responses": 2789,
      "change": -0.1,
      "color": warningColor,
      "target": 4.4
    },
    {
      "title": "Agent Helpfulness",
      "rating": 4.7,
      "responses": 2698,
      "change": 0.3,
      "color": infoColor,
      "target": 4.5
    },
  ];

  List<Map<String, dynamic>> ratingDistribution = [
    {"rating": 5, "count": 1542, "percentage": 54.2},
    {"rating": 4, "count": 827, "percentage": 29.1},
    {"rating": 3, "count": 284, "percentage": 10.0},
    {"rating": 2, "count": 142, "percentage": 5.0},
    {"rating": 1, "count": 52, "percentage": 1.8},
  ];

  List<Map<String, dynamic>> channelSatisfaction = [
    {
      "channel": "Live Chat",
      "rating": 4.8,
      "responses": 756,
      "trend": "increasing",
      "change": 0.3,
      "responseTime": "2m 15s"
    },
    {
      "channel": "Email",
      "rating": 4.5,
      "responses": 1247,
      "trend": "stable",
      "change": 0.1,
      "responseTime": "4h 32m"
    },
    {
      "channel": "Phone",
      "rating": 4.7,
      "responses": 523,
      "trend": "increasing",
      "change": 0.2,
      "responseTime": "1m 45s"
    },
    {
      "channel": "Social Media",
      "rating": 4.2,
      "responses": 198,
      "trend": "decreasing",
      "change": -0.2,
      "responseTime": "3h 12m"
    },
    {
      "channel": "Help Center",
      "rating": 4.1,
      "responses": 123,
      "trend": "stable",
      "change": 0.0,
      "responseTime": "Self-service"
    },
  ];

  List<Map<String, dynamic>> agentRatings = [
    {
      "name": "Sarah Johnson",
      "avatar": "https://picsum.photos/50/50?random=1",
      "rating": 4.9,
      "responses": 145,
      "department": "Technical Support",
      "trend": "excellent"
    },
    {
      "name": "Mike Chen",
      "avatar": "https://picsum.photos/50/50?random=2",
      "rating": 4.8,
      "responses": 132,
      "department": "Sales Support",
      "trend": "excellent"
    },
    {
      "name": "Emily Davis",
      "avatar": "https://picsum.photos/50/50?random=3",
      "rating": 4.6,
      "responses": 118,
      "department": "Billing Support",
      "trend": "good"
    },
    {
      "name": "David Wilson",
      "avatar": "https://picsum.photos/50/50?random=4",
      "rating": 4.7,
      "responses": 156,
      "department": "Technical Support",
      "trend": "excellent"
    },
    {
      "name": "Lisa Brown",
      "avatar": "https://picsum.photos/50/50?random=5",
      "rating": 4.5,
      "responses": 109,
      "department": "General Support",
      "trend": "good"
    },
  ];

  List<Map<String, dynamic>> feedbackComments = [
    {
      "rating": 5,
      "comment": "Excellent support! The agent was very knowledgeable and resolved my issue quickly.",
      "agent": "Sarah Johnson",
      "channel": "Live Chat",
      "date": "2 hours ago",
      "category": "Technical Issue"
    },
    {
      "rating": 4,
      "comment": "Good service, but the response time could be improved for email support.",
      "agent": "Mike Chen",
      "channel": "Email",
      "date": "5 hours ago",
      "category": "Billing Question"
    },
    {
      "rating": 5,
      "comment": "Very helpful and patient agent. Explained everything clearly.",
      "agent": "Emily Davis",
      "channel": "Phone",
      "date": "1 day ago",
      "category": "Account Setup"
    },
    {
      "rating": 3,
      "comment": "The issue was resolved but it took longer than expected.",
      "agent": "David Wilson",
      "channel": "Email",
      "date": "2 days ago",
      "category": "Feature Request"
    },
    {
      "rating": 5,
      "comment": "Outstanding customer service! Went above and beyond to help.",
      "agent": "Lisa Brown",
      "channel": "Live Chat",
      "date": "3 days ago",
      "category": "General Inquiry"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Satisfaction Reports"),
        actions: [
          IconButton(
            icon: Icon(Icons.insights),
            onPressed: () {
              ss("Detailed insights opened");
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Satisfaction report exported");
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
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Report Filters",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    spacing: spSm,
                    children: [
                      Expanded(
                        child: QDropdownField(
                          label: "Period",
                          items: periods,
                          value: selectedPeriod,
                          onChanged: (value, label) {
                            selectedPeriod = value;
                            setState(() {});
                          },
                        ),
                      ),
                      Expanded(
                        child: QDropdownField(
                          label: "Channel",
                          items: channels,
                          value: selectedChannel,
                          onChanged: (value, label) {
                            selectedChannel = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  QDropdownField(
                    label: "Team",
                    items: teams,
                    value: selectedTeam,
                    onChanged: (value, label) {
                      selectedTeam = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

            // Satisfaction Metrics Overview
            Text(
              "Satisfaction Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            ResponsiveGridView(
              padding: EdgeInsets.all(0),
              minItemWidth: 200,
              children: satisfactionMetrics.map((metric) {
                double percentage = ((metric["rating"] as double) / 5.0) * 100;
                bool metTarget = (metric["rating"] as double) >= (metric["target"] as double);

                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.star,
                              size: 20,
                              color: metric["color"] as Color,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: metTarget
                                  ? successColor.withAlpha(20)
                                  : warningColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              metTarget ? "Target Met" : "Below Target",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: metTarget ? successColor : warningColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${(metric["rating"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "/5.0",
                            style: TextStyle(
                              fontSize: 16,
                              color: disabledBoldColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            (metric["change"] as double) >= 0
                                ? Icons.trending_up
                                : Icons.trending_down,
                            size: 16,
                            color: (metric["change"] as double) >= 0
                                ? successColor
                                : dangerColor,
                          ),
                          Text(
                            "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: (metric["change"] as double) >= 0
                                  ? successColor
                                  : dangerColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${metric["responses"]} responses",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: disabledOutlineBorderColor,
                        valueColor: AlwaysStoppedAnimation(metric["color"] as Color),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            // Rating Distribution
            Text(
              "Rating Distribution",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                spacing: spSm,
                children: ratingDistribution.map((rating) {
                  return Row(
                    children: [
                      Row(
                        spacing: 4,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: index < (rating["rating"] as int)
                                ? warningColor
                                : disabledOutlineBorderColor,
                          );
                        }),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (rating["percentage"] as double) / 100,
                          backgroundColor: disabledOutlineBorderColor,
                          valueColor: AlwaysStoppedAnimation(primaryColor),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${(rating["percentage"] as double).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(${rating["count"]})",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            // Channel Satisfaction
            Text(
              "Satisfaction by Channel",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: channelSatisfaction.map((channel) {
                  int index = channelSatisfaction.indexOf(channel);
                  Color trendColor = channel["trend"] == "increasing"
                      ? successColor
                      : channel["trend"] == "decreasing"
                          ? dangerColor
                          : disabledBoldColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < channelSatisfaction.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${channel["channel"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${channel["responses"]} responses",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "Avg Response: ${channel["responseTime"]}",
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
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                Text(
                                  "${(channel["rating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 4,
                              children: [
                                Icon(
                                  channel["trend"] == "increasing"
                                      ? Icons.trending_up
                                      : channel["trend"] == "decreasing"
                                          ? Icons.trending_down
                                          : Icons.trending_flat,
                                  size: 14,
                                  color: trendColor,
                                ),
                                Text(
                                  "${(channel["change"] as double) >= 0 ? '+' : ''}${(channel["change"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: trendColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Top Performing Agents
            Text(
              "Top Performing Agents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: agentRatings.map((agent) {
                  int index = agentRatings.indexOf(agent);
                  Color trendColor = agent["trend"] == "excellent"
                      ? successColor
                      : agent["trend"] == "good"
                          ? primaryColor
                          : warningColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < agentRatings.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Row(
                      spacing: spSm,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage("${agent["avatar"]}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${agent["name"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${agent["department"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Text(
                                "${agent["responses"]} responses",
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
                              spacing: 4,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: warningColor,
                                ),
                                Text(
                                  "${(agent["rating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: trendColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${agent["trend"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: trendColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Recent Feedback
            Text(
              "Recent Customer Feedback",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: feedbackComments.map((feedback) {
                  int index = feedbackComments.indexOf(feedback);
                  int rating = feedback["rating"] as int;
                  Color ratingColor = rating >= 4
                      ? successColor
                      : rating >= 3
                          ? warningColor
                          : dangerColor;

                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: index < feedbackComments.length - 1
                            ? BorderSide(
                                color: disabledOutlineBorderColor,
                                width: 1,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Column(
                      spacing: spXs,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              spacing: 2,
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  size: 14,
                                  color: index < rating
                                      ? warningColor
                                      : disabledOutlineBorderColor,
                                );
                              }),
                            ),
                            SizedBox(width: spSm),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spXs,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: ratingColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${feedback["category"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: ratingColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${feedback["date"]}",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${feedback["comment"]}",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Agent: ${feedback["agent"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: disabledBoldColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "via ${feedback["channel"]}",
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
            ),

            // Action Buttons
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QButton(
                    label: "View Detailed Analysis",
                    icon: Icons.analytics,
                    size: bs.md,
                    onPressed: () {
                      ss("Detailed analysis opened");
                    },
                  ),
                ),
                Expanded(
                  child: QButton(
                    label: "Export Report",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      ss("Satisfaction report exported");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
