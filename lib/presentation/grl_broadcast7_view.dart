import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBroadcast7View extends StatefulWidget {
  @override
  State<GrlBroadcast7View> createState() => _GrlBroadcast7ViewState();
}

class _GrlBroadcast7ViewState extends State<GrlBroadcast7View> {
  String selectedPeriod = "Today";
  
  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "Week"},
    {"label": "This Month", "value": "Month"},
    {"label": "This Year", "value": "Year"},
  ];

  List<Map<String, dynamic>> broadcastAnalytics = [
    {
      "metric": "Total Views",
      "value": 125000,
      "change": 15.2,
      "icon": Icons.visibility,
      "color": "primary"
    },
    {
      "metric": "Live Viewers",
      "value": 8500,
      "change": 8.7,
      "icon": Icons.people,
      "color": "success"
    },
    {
      "metric": "Stream Duration",
      "value": 4.5,
      "change": -2.1,
      "icon": Icons.timer,
      "color": "info"
    },
    {
      "metric": "Revenue",
      "value": 2450.0,
      "change": 23.8,
      "icon": Icons.monetization_on,
      "color": "warning"
    }
  ];

  List<Map<String, dynamic>> topBroadcasts = [
    {
      "title": "Tech News Roundup",
      "date": "2024-01-20",
      "duration": "1h 45m",
      "viewers": 15400,
      "engagement": 89.5,
      "revenue": 245.50,
      "thumbnail": "https://picsum.photos/120/80?random=1&keyword=tech"
    },
    {
      "title": "Live Q&A Session",
      "date": "2024-01-19",
      "duration": "2h 15m",
      "viewers": 12800,
      "engagement": 92.3,
      "revenue": 312.75,
      "thumbnail": "https://picsum.photos/120/80?random=2&keyword=meeting"
    },
    {
      "title": "Product Demo Stream",
      "date": "2024-01-18",
      "duration": "1h 30m",
      "viewers": 9600,
      "engagement": 85.7,
      "revenue": 189.25,
      "thumbnail": "https://picsum.photos/120/80?random=3&keyword=product"
    }
  ];

  List<Map<String, dynamic>> audienceData = [
    {"demographic": "Age 18-24", "percentage": 25.5, "color": Colors.blue},
    {"demographic": "Age 25-34", "percentage": 35.2, "color": Colors.green},
    {"demographic": "Age 35-44", "percentage": 22.8, "color": Colors.orange},
    {"demographic": "Age 45+", "percentage": 16.5, "color": Colors.purple},
  ];

  List<Map<String, dynamic>> viewerEngagement = [
    {"time": "9:00", "viewers": 1200},
    {"time": "10:00", "viewers": 2800},
    {"time": "11:00", "viewers": 4500},
    {"time": "12:00", "viewers": 6200},
    {"time": "13:00", "viewers": 8500},
    {"time": "14:00", "viewers": 7800},
    {"time": "15:00", "viewers": 5400},
    {"time": "16:00", "viewers": 3200},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: spLg),
            _buildPeriodSelector(),
            SizedBox(height: spLg),
            _buildMetricsOverview(),
            SizedBox(height: spLg),
            _buildViewerChart(),
            SizedBox(height: spLg),
            _buildTopBroadcasts(),
            SizedBox(height: spLg),
            _buildAudienceAnalytics(),
            SizedBox(height: spLg),
            _buildPerformanceInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [infoColor, primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusLg),
            boxShadow: [shadowMd],
          ),
          child: Icon(
            Icons.analytics,
            color: Colors.white,
            size: 28,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Broadcast Analytics",
                style: TextStyle(
                  fontSize: fsH4,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                "Track your streaming performance and audience insights",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ),
        QButton(
          icon: Icons.file_download,
          size: bs.sm,
          onPressed: () {
            ss("Analytics report downloaded");
          },
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      children: [
        Text(
          "Time Period:",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        SizedBox(width: spMd),
        Expanded(
          child: QDropdownField(
            label: "Select Period",
            items: periodOptions,
            value: selectedPeriod,
            onChanged: (value, label) {
              selectedPeriod = value;
              setState(() {});
            },
          ),
        ),
        SizedBox(width: spSm),
        QButton(
          icon: Icons.refresh,
          size: bs.sm,
          onPressed: () {
            si("Analytics refreshed");
          },
        ),
      ],
    );
  }

  Widget _buildMetricsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Key Metrics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: spMd),
        ResponsiveGridView(
          padding: EdgeInsets.zero,
          minItemWidth: 200,
          children: broadcastAnalytics.map((metric) {
            Color getColor() {
              switch (metric["color"]) {
                case "success": return successColor;
                case "info": return infoColor;
                case "warning": return warningColor;
                default: return primaryColor;
              }
            }

            return Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: getColor().withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: getColor(),
                          size: 24,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                        decoration: BoxDecoration(
                          color: (metric["change"] as double) >= 0 
                              ? successColor.withAlpha(20) 
                              : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              (metric["change"] as double) >= 0 
                                  ? Icons.trending_up 
                                  : Icons.trending_down,
                              color: (metric["change"] as double) >= 0 
                                  ? successColor 
                                  : dangerColor,
                              size: 12,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${(metric["change"] as double).abs().toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (metric["change"] as double) >= 0 
                                    ? successColor 
                                    : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Text(
                    "${metric["metric"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    _formatMetricValue(metric["metric"], metric["value"]),
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: getColor(),
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

  String _formatMetricValue(String metric, dynamic value) {
    if (metric.contains("Revenue")) {
      return "\$${((value as double).toStringAsFixed(0))}";
    } else if (metric.contains("Duration")) {
      return "${(value as double).toStringAsFixed(1)}h";
    } else if (metric.contains("Views") || metric.contains("Viewers")) {
      int intValue = (value as int);
      return intValue > 1000 ? "${(intValue / 1000).toStringAsFixed(1)}K" : "$intValue";
    }
    return "$value";
  }

  Widget _buildViewerChart() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.show_chart,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Viewer Engagement Timeline",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Container(
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: viewerEngagement.map((data) {
                double maxViewers = viewerEngagement
                    .map((e) => e["viewers"] as int)
                    .reduce((a, b) => a > b ? a : b)
                    .toDouble();
                double height = ((data["viewers"] as int) / maxViewers) * 180;
                
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: height,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [primaryColor.withAlpha(100), primaryColor],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(radiusXs),
                            ),
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${data["time"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBroadcasts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: warningColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Top Performing Broadcasts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Spacer(),
            QButton(
              label: "View All",
              size: bs.sm,
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: spMd),
        Column(
          children: topBroadcasts.map((broadcast) {
            return Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusSm),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusXs),
                    child: Image.network(
                      "${broadcast["thumbnail"]}",
                      width: 80,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${broadcast["title"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Row(
                          children: [
                            Icon(Icons.calendar_today, size: 12, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text("${broadcast["date"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                            SizedBox(width: spSm),
                            Icon(Icons.timer, size: 12, color: disabledBoldColor),
                            SizedBox(width: spXs),
                            Text("${broadcast["duration"]}", style: TextStyle(fontSize: 12, color: disabledBoldColor)),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Row(
                          children: [
                            _buildBroadcastMetric(
                              icon: Icons.visibility,
                              value: "${(broadcast["viewers"] as int) > 1000 ? '${((broadcast["viewers"] as int) / 1000).toStringAsFixed(1)}K' : broadcast["viewers"]}",
                              color: infoColor,
                            ),
                            SizedBox(width: spMd),
                            _buildBroadcastMetric(
                              icon: Icons.thumb_up,
                              value: "${(broadcast["engagement"] as double).toStringAsFixed(1)}%",
                              color: successColor,
                            ),
                            SizedBox(width: spMd),
                            _buildBroadcastMetric(
                              icon: Icons.monetization_on,
                              value: "\$${(broadcast["revenue"] as double).toStringAsFixed(0)}",
                              color: warningColor,
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildBroadcastMetric({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAudienceAnalytics() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.people,
                color: primaryColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Audience Demographics",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Column(
            children: audienceData.map((demo) {
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: demo["color"] as Color,
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Text(
                        "${demo["demographic"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      "${(demo["percentage"] as double).toStringAsFixed(1)}%",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: demo["color"] as Color,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceInsights() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowMd],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: warningColor,
                size: 20,
              ),
              SizedBox(width: spSm),
              Text(
                "Performance Insights",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          _buildInsightCard(
            title: "Peak Performance Time",
            description: "Your broadcasts perform best between 1:00 PM - 3:00 PM",
            icon: Icons.schedule,
            color: successColor,
          ),
          SizedBox(height: spSm),
          _buildInsightCard(
            title: "Audience Retention",
            description: "Average watch time increased by 15% this month",
            icon: Icons.trending_up,
            color: infoColor,
          ),
          SizedBox(height: spSm),
          _buildInsightCard(
            title: "Content Suggestion",
            description: "Tech content generates 23% more engagement",
            icon: Icons.recommend,
            color: warningColor,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(spXs),
            decoration: BoxDecoration(
              color: color.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusXs),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  description,
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
    );
  }
}
