import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlMetric3View extends StatefulWidget {
  @override
  State<GrlMetric3View> createState() => _GrlMetric3ViewState();
}

class _GrlMetric3ViewState extends State<GrlMetric3View> {
  String selectedPeriod = "7d";
  
  Map<String, String> periods = {
    "24h": "Last 24 Hours",
    "7d": "Last 7 Days", 
    "30d": "Last 30 Days",
    "90d": "Last 3 Months"
  };

  Map<String, dynamic> realTimeMetrics = {
    "activeUsers": 1247,
    "sessionDuration": 284, // seconds
    "bounceRate": 24.8,
    "pageViews": 15436,
    "newSessions": 342,
    "conversionRate": 3.2
  };

  List<Map<String, dynamic>> topPages = [
    {
      "path": "/dashboard",
      "views": 2847,
      "uniqueViews": 2103,
      "avgTime": "4:32",
      "bounceRate": 18.2,
      "conversions": 145
    },
    {
      "path": "/products",
      "views": 1956,
      "uniqueViews": 1678,
      "avgTime": "6:18",
      "bounceRate": 22.4,
      "conversions": 98
    },
    {
      "path": "/checkout",
      "views": 1234,
      "uniqueViews": 1089,
      "avgTime": "2:45",
      "bounceRate": 45.6,
      "conversions": 234
    },
    {
      "path": "/profile",
      "views": 987,
      "uniqueViews": 823,
      "avgTime": "3:21",
      "bounceRate": 35.8,
      "conversions": 67
    },
    {
      "path": "/support",
      "views": 756,
      "uniqueViews": 612,
      "avgTime": "5:14",
      "bounceRate": 28.9,
      "conversions": 23
    }
  ];

  List<Map<String, dynamic>> realtimeEvents = [
    {
      "time": "14:32:18",
      "event": "Purchase Completed",
      "user": "user_8472",
      "value": 149.99,
      "page": "/checkout",
      "type": "conversion"
    },
    {
      "time": "14:31:45",
      "event": "Product Added to Cart",
      "user": "user_3921",
      "value": 79.99,
      "page": "/products/smartphone",
      "type": "engagement"
    },
    {
      "time": "14:31:23",
      "event": "User Registered",
      "user": "user_9183",
      "value": 0,
      "page": "/signup",
      "type": "acquisition"
    },
    {
      "time": "14:30:56",
      "event": "Newsletter Signup",
      "user": "user_5647",
      "value": 0,
      "page": "/newsletter",
      "type": "engagement"
    },
    {
      "time": "14:30:12",
      "event": "Support Ticket Created",
      "user": "user_2845",
      "value": 0,
      "page": "/support",
      "type": "support"
    }
  ];

  List<Map<String, dynamic>> deviceMetrics = [
    {"device": "Desktop", "percentage": 45.2, "sessions": 2847, "color": primaryColor},
    {"device": "Mobile", "percentage": 38.7, "sessions": 2436, "color": successColor},
    {"device": "Tablet", "percentage": 16.1, "sessions": 1014, "color": warningColor}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real-Time Analytics"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: spSm),
            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: 4),
            decoration: BoxDecoration(
              color: successColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: successColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  "LIVE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Selector
            _buildPeriodSelector(),
            
            SizedBox(height: spMd),

            // Real-time Overview
            _buildRealtimeOverview(),
            
            SizedBox(height: spMd),

            // Live Activity Feed
            _buildLiveActivityFeed(),
            
            SizedBox(height: spMd),

            // Top Pages Performance
            _buildTopPagesPerformance(),
            
            SizedBox(height: spMd),

            // Device Analytics
            _buildDeviceAnalytics(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () => _refreshData(),
        child: Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: periods.length,
        itemBuilder: (context, index) {
          final entry = periods.entries.elementAt(index);
          final isSelected = selectedPeriod == entry.key;
          
          return Container(
            margin: EdgeInsets.only(right: spSm),
            child: GestureDetector(
              onTap: () {
                selectedPeriod = entry.key;
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                  boxShadow: isSelected ? [shadowSm] : [],
                ),
                child: Center(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : disabledBoldColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRealtimeOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: successColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: spXs),
            Text(
              "Live Metrics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          minItemWidth: 160,
          children: [
            _buildRealtimeMetricCard(
              "Active Users",
              "${realTimeMetrics["activeUsers"]}",
              Icons.people,
              successColor,
              "Currently online",
            ),
            _buildRealtimeMetricCard(
              "Avg. Session",
              "${((realTimeMetrics["sessionDuration"] as int) / 60).toStringAsFixed(1)} min",
              Icons.timer,
              primaryColor,
              "Session duration",
            ),
            _buildRealtimeMetricCard(
              "Bounce Rate",
              "${((realTimeMetrics["bounceRate"] as double)).toStringAsFixed(1)}%",
              Icons.exit_to_app,
              warningColor,
              "Exit percentage",
            ),
            _buildRealtimeMetricCard(
              "Page Views",
              "${realTimeMetrics["pageViews"]}",
              Icons.visibility,
              infoColor,
              "Total views",
            ),
            _buildRealtimeMetricCard(
              "New Sessions",
              "${realTimeMetrics["newSessions"]}",
              Icons.fiber_new,
              dangerColor,
              "First-time visits",
            ),
            _buildRealtimeMetricCard(
              "Conversion",
              "${((realTimeMetrics["conversionRate"] as double)).toStringAsFixed(1)}%",
              Icons.trending_up,
              successColor,
              "Conversion rate",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRealtimeMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          top: BorderSide(width: 3, color: color),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Icon(icon, color: color, size: 18),
              ),
              Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: successColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
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
            style: TextStyle(
              fontSize: 12,
              color: primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveActivityFeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Live Activity Feed",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusXs),
              ),
              child: Text(
                "Auto-refresh: ON",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: successColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: spSm),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: ListView.builder(
            padding: EdgeInsets.all(spSm),
            itemCount: realtimeEvents.length,
            itemBuilder: (context, index) {
              final event = realtimeEvents[index];
              return _buildActivityItem(event, index < realtimeEvents.length - 1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> event, bool showDivider) {
    Color eventColor = _getEventColor(event["type"]);
    
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: eventColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: spSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${event["event"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "${event["time"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${event["user"]} • ${event["page"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if ((event["value"] as double) > 0) ...[
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "\$${((event["value"] as double)).toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider) ...[
          SizedBox(height: spSm),
          Divider(color: disabledOutlineBorderColor),
          SizedBox(height: spSm),
        ] else
          SizedBox(height: spSm),
      ],
    );
  }

  Widget _buildTopPagesPerformance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Pages Performance",
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
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(spSm),
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                ),
                child: Row(
                  children: [
                    Expanded(flex: 3, child: Text("Page", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor))),
                    Expanded(child: Text("Views", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor))),
                    Expanded(child: Text("Avg Time", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor))),
                    Expanded(child: Text("Conv.", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: disabledBoldColor))),
                  ],
                ),
              ),
              // Data
              ...List.generate(topPages.length, (index) {
                final page = topPages[index];
                final isLast = index == topPages.length - 1;
                
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    border: isLast ? null : Border(bottom: BorderSide(color: disabledOutlineBorderColor)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${page["path"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${page["uniqueViews"]} unique",
                              style: TextStyle(
                                fontSize: 10,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${page["views"]}",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${page["avgTime"]}",
                          style: TextStyle(fontSize: 12, color: disabledBoldColor),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${page["conversions"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceAnalytics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Device Breakdown",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spSm),
        ResponsiveGridView(
          minItemWidth: 200,
          children: deviceMetrics.map((device) {
            return Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: device["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${device["device"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${((device["percentage"] as double)).toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: device["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: disabledColor,
                      borderRadius: BorderRadius.circular(radiusXs),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: (device["percentage"] as double) / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: device["color"] as Color,
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${device["sessions"]} sessions",
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
    );
  }

  Color _getEventColor(String type) {
    switch (type) {
      case "conversion":
        return successColor;
      case "engagement":
        return primaryColor;
      case "acquisition":
        return infoColor;
      case "support":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  void _refreshData() {
    // Refresh real-time data
    setState(() {});
  }
}
