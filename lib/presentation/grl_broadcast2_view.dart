import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast2View extends StatefulWidget {
  @override
  State<GrlBroadcast2View> createState() => _GrlBroadcast2ViewState();
}

class _GrlBroadcast2ViewState extends State<GrlBroadcast2View> {
  String selectedPeriod = "Last 30 Days";
  String selectedMetric = "Delivery Rate";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "Last 7 Days"},
    {"label": "Last 30 Days", "value": "Last 30 Days"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Delivery Rate", "value": "Delivery Rate"},
    {"label": "Open Rate", "value": "Open Rate"},
    {"label": "Click Rate", "value": "Click Rate"},
    {"label": "Engagement", "value": "Engagement"},
  ];

  List<Map<String, dynamic>> overviewStats = [
    {
      "title": "Total Broadcasts",
      "value": "156",
      "change": "+12",
      "isPositive": true,
      "icon": Icons.campaign,
      "color": primaryColor,
    },
    {
      "title": "Delivery Rate",
      "value": "98.5%",
      "change": "+2.3%",
      "isPositive": true,
      "icon": Icons.send,
      "color": successColor,
    },
    {
      "title": "Open Rate",
      "value": "76.8%",
      "change": "-1.2%",
      "isPositive": false,
      "icon": Icons.mark_email_read,
      "color": infoColor,
    },
    {
      "title": "Click Rate",
      "value": "24.3%",
      "change": "+5.7%",
      "isPositive": true,
      "icon": Icons.mouse,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> broadcastPerformance = [
    {
      "title": "New Feature Announcement",
      "type": "Product Update",
      "sent": "March 20, 2024",
      "audience": 125400,
      "delivered": 123890,
      "opened": 94567,
      "clicked": 23456,
      "deliveryRate": 98.8,
      "openRate": 76.3,
      "clickRate": 24.8,
      "status": "Completed",
    },
    {
      "title": "Live Stream Notification",
      "type": "Event",
      "sent": "March 18, 2024",
      "audience": 89600,
      "delivered": 88234,
      "opened": 71234,
      "clicked": 18567,
      "deliveryRate": 98.5,
      "openRate": 80.7,
      "clickRate": 26.1,
      "status": "Completed",
    },
    {
      "title": "Weekly Newsletter",
      "type": "Newsletter",
      "sent": "March 15, 2024",
      "audience": 156700,
      "delivered": 154230,
      "opened": 112890,
      "clicked": 25678,
      "deliveryRate": 98.4,
      "openRate": 73.2,
      "clickRate": 22.7,
      "status": "Completed",
    },
    {
      "title": "Premium Content Release",
      "type": "Content",
      "sent": "March 12, 2024",
      "audience": 45200,
      "delivered": 44678,
      "opened": 38234,
      "clicked": 15678,
      "deliveryRate": 98.8,
      "openRate": 85.6,
      "clickRate": 41.0,
      "status": "Completed",
    },
  ];

  List<Map<String, dynamic>> channelPerformance = [
    {
      "channel": "Push Notification",
      "sent": 89500,
      "delivered": 88234,
      "opened": 71234,
      "clicked": 18567,
      "deliveryRate": 98.6,
      "openRate": 80.7,
      "clickRate": 26.1,
      "icon": Icons.notifications,
      "color": primaryColor,
    },
    {
      "channel": "Email",
      "sent": 156700,
      "delivered": 154230,
      "opened": 112890,
      "clicked": 25678,
      "deliveryRate": 98.4,
      "openRate": 73.2,
      "clickRate": 22.7,
      "icon": Icons.email,
      "color": infoColor,
    },
    {
      "channel": "In-App",
      "sent": 234500,
      "delivered": 234500,
      "opened": 189600,
      "clicked": 45200,
      "deliveryRate": 100.0,
      "openRate": 80.9,
      "clickRate": 23.8,
      "icon": Icons.app_registration,
      "color": successColor,
    },
    {
      "channel": "SMS",
      "sent": 12600,
      "delivered": 12456,
      "opened": 11234,
      "clicked": 3567,
      "deliveryRate": 98.9,
      "openRate": 90.2,
      "clickRate": 31.8,
      "icon": Icons.sms,
      "color": warningColor,
    },
  ];

  List<Map<String, dynamic>> audienceInsights = [
    {"segment": "Active Subscribers", "percentage": 45.2, "engagement": 78.5},
    {"segment": "Premium Members", "percentage": 12.8, "engagement": 89.3},
    {"segment": "Recent Visitors", "percentage": 23.4, "engagement": 65.7},
    {"segment": "Inactive Users", "percentage": 18.6, "engagement": 42.1},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Broadcast Analytics"),
        actions: [
          Icon(Icons.download, size: 24),
          SizedBox(width: spMd),
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
                    label: "Period",
                    items: periodOptions,
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
                    label: "Metric",
                    items: metricOptions,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Overview Statistics
            Text(
              "Performance Overview",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: overviewStats.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
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
                              color: (stat["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              stat["icon"] as IconData,
                              color: stat["color"] as Color,
                              size: 20,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (stat["isPositive"] as bool) 
                                  ? successColor.withAlpha(51) 
                                  : dangerColor.withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${stat["change"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: (stat["isPositive"] as bool) ? successColor : dangerColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${stat["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: stat["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Performance Chart Placeholder
            Text(
              "Trend Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics,
                    color: primaryColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "$selectedMetric Trend",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Interactive chart for $selectedPeriod",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spMd),

            // Channel Performance
            Text(
              "Channel Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: channelPerformance.map((channel) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(color: disabledOutlineBorderColor),
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
                              color: (channel["color"] as Color).withAlpha(51),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              channel["icon"] as IconData,
                              color: channel["color"] as Color,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              "${channel["channel"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),
                      
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(channel["deliveryRate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: channel["color"] as Color,
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
                                  "Open Rate",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(channel["openRate"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: channel["color"] as Color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      
                      Row(
                        children: [
                          Text(
                            "Click Rate: ",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          Text(
                            "${(channel["clickRate"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: channel["color"] as Color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: spMd),

            // Recent Broadcast Performance
            Text(
              "Recent Broadcast Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: broadcastPerformance.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> broadcast = entry.value;
                  
                  return Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      border: index < broadcastPerformance.length - 1 
                          ? Border(bottom: BorderSide(color: disabledOutlineBorderColor))
                          : null,
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
                                    "${broadcast["title"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(51),
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                        child: Text(
                                          "${broadcast["type"]}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "${broadcast["sent"]}",
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
                              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                              decoration: BoxDecoration(
                                color: successColor.withAlpha(51),
                                borderRadius: BorderRadius.circular(radiusXs),
                              ),
                              child: Text(
                                "${broadcast["status"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        
                        ResponsiveGridView(
                          padding: EdgeInsets.zero,
                          minItemWidth: 100,
                          children: [
                            _buildStatItem("Audience", "${((broadcast["audience"] as int) / 1000).toStringAsFixed(0)}K"),
                            _buildStatItem("Delivered", "${(broadcast["deliveryRate"] as double).toStringAsFixed(1)}%"),
                            _buildStatItem("Opened", "${(broadcast["openRate"] as double).toStringAsFixed(1)}%"),
                            _buildStatItem("Clicked", "${(broadcast["clickRate"] as double).toStringAsFixed(1)}%"),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: spMd),

            // Audience Insights
            Text(
              "Audience Engagement by Segment",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: disabledOutlineBorderColor),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: audienceInsights.map((insight) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${insight["segment"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: disabledColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: (insight["percentage"] as double) / 100,
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
                        ),
                        SizedBox(width: spMd),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${(insight["percentage"] as double).toStringAsFixed(1)}%",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              Text(
                                "${(insight["engagement"] as double).toStringAsFixed(1)}% engaged",
                                style: TextStyle(
                                  fontSize: 11,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
