import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class CrmSupportAnalyticsView extends StatefulWidget {
  const CrmSupportAnalyticsView({super.key});

  @override
  State<CrmSupportAnalyticsView> createState() => _CrmSupportAnalyticsViewState();
}

class _CrmSupportAnalyticsViewState extends State<CrmSupportAnalyticsView> {
  String selectedPeriod = "30_days";
  String selectedChannel = "all";
  
  List<Map<String, dynamic>> periodItems = [
    {"label": "Last 7 Days", "value": "7_days"},
    {"label": "Last 30 Days", "value": "30_days"},
    {"label": "Last 90 Days", "value": "90_days"},
    {"label": "This Year", "value": "year"},
  ];

  List<Map<String, dynamic>> channelItems = [
    {"label": "All Channels", "value": "all"},
    {"label": "Email", "value": "email"},
    {"label": "Live Chat", "value": "chat"},
    {"label": "Phone", "value": "phone"},
    {"label": "Social Media", "value": "social"},
  ];

  List<Map<String, dynamic>> supportMetrics = [
    {
      "title": "Total Tickets",
      "value": 2450,
      "change": 8.3,
      "icon": Icons.confirmation_number,
      "color": Colors.blue,
    },
    {
      "title": "Resolved Tickets",
      "value": 2105,
      "change": 12.5,
      "icon": Icons.check_circle,
      "color": Colors.green,
    },
    {
      "title": "Average Response Time",
      "value": 2.4,
      "change": -15.2,
      "icon": Icons.schedule,
      "color": Colors.orange,
      "suffix": " hours",
    },
    {
      "title": "Customer Satisfaction",
      "value": 94.5,
      "change": 5.8,
      "icon": Icons.sentiment_very_satisfied,
      "color": Colors.purple,
      "isPercentage": true,
    },
  ];

  List<Map<String, dynamic>> ticketsByStatus = [
    {
      "status": "Open",
      "count": 185,
      "percentage": 7.6,
      "color": Colors.orange,
    },
    {
      "status": "In Progress",
      "count": 160,
      "percentage": 6.5,
      "color": Colors.blue,
    },
    {
      "status": "Pending Customer",
      "count": 85,
      "percentage": 3.5,
      "color": Colors.purple,
    },
    {
      "status": "Resolved",
      "count": 2020,
      "percentage": 82.4,
      "color": Colors.green,
    },
  ];

  List<Map<String, dynamic>> ticketsByPriority = [
    {
      "priority": "Critical",
      "count": 45,
      "avgResolution": 1.2,
      "color": Colors.red,
    },
    {
      "priority": "High",
      "count": 125,
      "avgResolution": 3.5,
      "color": Colors.orange,
    },
    {
      "priority": "Medium",
      "count": 890,
      "avgResolution": 8.2,
      "color": Colors.blue,
    },
    {
      "priority": "Low",
      "count": 1390,
      "avgResolution": 24.6,
      "color": Colors.green,
    },
  ];

  List<Map<String, dynamic>> supportChannels = [
    {
      "channel": "Email",
      "tickets": 1205,
      "avgResponse": 4.2,
      "satisfaction": 92.3,
      "icon": Icons.email,
    },
    {
      "channel": "Live Chat",
      "tickets": 780,
      "avgResponse": 0.8,
      "satisfaction": 96.8,
      "icon": Icons.chat,
    },
    {
      "channel": "Phone",
      "tickets": 325,
      "avgResponse": 0.2,
      "satisfaction": 94.5,
      "icon": Icons.phone,
    },
    {
      "channel": "Social Media",
      "tickets": 140,
      "avgResponse": 2.1,
      "satisfaction": 89.7,
      "icon": Icons.share,
    },
  ];

  List<Map<String, dynamic>> topAgents = [
    {
      "name": "Lisa Anderson",
      "avatar": "LA",
      "ticketsResolved": 145,
      "avgResolution": 3.2,
      "satisfaction": 98.5,
      "status": "online",
    },
    {
      "name": "Mark Thompson",
      "avatar": "MT",
      "ticketsResolved": 132,
      "avgResolution": 4.1,
      "satisfaction": 96.8,
      "status": "online",
    },
    {
      "name": "Jennifer Kim",
      "avatar": "JK",
      "ticketsResolved": 128,
      "avgResolution": 3.8,
      "satisfaction": 97.2,
      "status": "busy",
    },
    {
      "name": "Robert Garcia",
      "avatar": "RG",
      "ticketsResolved": 118,
      "avgResolution": 4.5,
      "satisfaction": 95.1,
      "status": "offline",
    },
  ];

  List<Map<String, dynamic>> commonIssues = [
    {
      "issue": "Login Problems",
      "count": 485,
      "percentage": 19.8,
      "avgResolution": 2.1,
      "trend": "up",
    },
    {
      "issue": "Payment Issues",
      "count": 365,
      "percentage": 14.9,
      "avgResolution": 4.5,
      "trend": "down",
    },
    {
      "issue": "Feature Requests",
      "count": 290,
      "percentage": 11.8,
      "avgResolution": 12.3,
      "trend": "up",
    },
    {
      "issue": "Bug Reports",
      "count": 245,
      "percentage": 10.0,
      "avgResolution": 8.7,
      "trend": "down",
    },
    {
      "issue": "Account Settings",
      "count": 180,
      "percentage": 7.3,
      "avgResolution": 1.8,
      "trend": "stable",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "online":
        return Colors.green;
      case "busy":
        return Colors.orange;
      case "offline":
        return Colors.grey;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Support Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Support report exported successfully");
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
                    label: "Channel",
                    items: channelItems,
                    value: selectedChannel,
                    onChanged: (value, label) {
                      selectedChannel = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Support Metrics
            Text(
              "Support Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: supportMetrics.map((metric) {
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

            // Tickets by Status
            Text(
              "Tickets by Status",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: ticketsByStatus.map((status) {
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
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: status["color"] as Color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Text(
                            "${status["status"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${(status["count"] as int)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${(status["percentage"] as double).toStringAsFixed(1)}% of total",
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

            // Support Channels
            Text(
              "Support Channels Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: supportChannels.map((channel) {
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
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          channel["icon"] as IconData,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${channel["channel"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(channel["tickets"] as int)} tickets",
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
                          Text(
                            "${(channel["avgResponse"] as double).toStringAsFixed(1)}h avg",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${(channel["satisfaction"] as double).toStringAsFixed(1)}% satisfaction",
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

            // Top Support Agents
            Text(
              "Top Support Agents",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: topAgents.map((agent) {
                return Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: primaryColor.withAlpha(51),
                            child: Text(
                              "${agent["avatar"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: _getStatusColor("${agent["status"]}"),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${agent["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(agent["ticketsResolved"] as int)} tickets resolved",
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
                          Text(
                            "${(agent["satisfaction"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "${(agent["avgResolution"] as double).toStringAsFixed(1)}h avg",
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

            // Tickets by Priority
            Text(
              "Tickets by Priority",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: ticketsByPriority.map((priority) {
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
                          color: priority["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${priority["priority"]} Priority",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${(priority["count"] as int)} tickets",
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
                          Text(
                            "${(priority["avgResolution"] as double).toStringAsFixed(1)}h",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Avg Resolution",
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

            // Common Issues
            Text(
              "Common Issues",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            Column(
              spacing: spSm,
              children: commonIssues.map((issue) {
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
                            Row(
                              children: [
                                Text(
                                  "${issue["issue"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  _getTrendIcon("${issue["trend"]}"),
                                  size: 16,
                                  color: issue["trend"] == "up"
                                      ? Colors.red
                                      : issue["trend"] == "down"
                                          ? Colors.green
                                          : Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${(issue["count"] as int)} tickets (${(issue["percentage"] as double).toStringAsFixed(1)}%)",
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
                          Text(
                            "${(issue["avgResolution"] as double).toStringAsFixed(1)}h",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Avg Resolution",
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
