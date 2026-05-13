import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsContentPerformanceView extends StatefulWidget {
  const DmsContentPerformanceView({super.key});

  @override
  State<DmsContentPerformanceView> createState() => _DmsContentPerformanceViewState();
}

class _DmsContentPerformanceViewState extends State<DmsContentPerformanceView> {
  int currentTab = 0;
  String selectedPeriod = "30d";
  String selectedMetric = "views";
  String contentFilter = "all";
  String categoryFilter = "all";

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "Last 90 Days", "value": "90d"},
    {"label": "Last 6 Months", "value": "6m"},
    {"label": "Last Year", "value": "1y"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "Page Views", "value": "views"},
    {"label": "Unique Visitors", "value": "visitors"},
    {"label": "Engagement Rate", "value": "engagement"},
    {"label": "Time on Page", "value": "time"},
    {"label": "Bounce Rate", "value": "bounce"},
  ];

  List<Map<String, dynamic>> performanceData = [
    {
      "title": "10 Digital Marketing Trends for 2024",
      "type": "Blog Post",
      "category": "Marketing",
      "published": "2024-01-15",
      "views": 12847,
      "visitors": 8932,
      "engagement": 78.5,
      "timeOnPage": "4:32",
      "bounceRate": 23.4,
      "shares": 156,
      "comments": 89,
      "likes": 234,
      "status": "trending",
    },
    {
      "title": "Complete Guide to Social Media Analytics",
      "type": "Article",
      "category": "Technology",
      "published": "2024-01-12",
      "views": 8934,
      "visitors": 6421,
      "engagement": 82.1,
      "timeOnPage": "6:18",
      "bounceRate": 18.7,
      "shares": 98,
      "comments": 67,
      "likes": 187,
      "status": "performing",
    },
    {
      "title": "Customer Success Case Study - TechCorp",
      "type": "Case Study",
      "category": "Business",
      "published": "2024-01-10",
      "views": 5672,
      "visitors": 4123,
      "engagement": 91.3,
      "timeOnPage": "8:45",
      "bounceRate": 12.1,
      "shares": 145,
      "comments": 23,
      "likes": 98,
      "status": "excellent",
    },
    {
      "title": "Email Marketing Best Practices 2024",
      "type": "Tutorial",
      "category": "Marketing",
      "published": "2024-01-08",
      "views": 3421,
      "visitors": 2876,
      "engagement": 65.4,
      "timeOnPage": "3:12",
      "bounceRate": 35.8,
      "shares": 45,
      "comments": 12,
      "likes": 67,
      "status": "needs_improvement",
    },
  ];

  List<Map<String, dynamic>> topPerformers = [
    {
      "title": "10 Digital Marketing Trends for 2024",
      "views": 12847,
      "growth": 23.5,
      "category": "Marketing",
    },
    {
      "title": "Complete Guide to Social Media Analytics",
      "views": 8934,
      "growth": 18.2,
      "category": "Technology",
    },
    {
      "title": "Customer Success Case Study - TechCorp",
      "views": 5672,
      "growth": 45.7,
      "category": "Business",
    },
  ];

  List<Map<String, dynamic>> overallStats = [
    {
      "label": "Total Views",
      "value": "847K",
      "change": "+23.5%",
      "trend": "up",
      "color": primaryColor,
    },
    {
      "label": "Unique Visitors",
      "value": "234K",
      "change": "+18.2%",
      "trend": "up",
      "color": successColor,
    },
    {
      "label": "Avg. Engagement",
      "value": "76.8%",
      "change": "+5.3%",
      "trend": "up",
      "color": infoColor,
    },
    {
      "label": "Bounce Rate",
      "value": "22.4%",
      "change": "-3.1%",
      "trend": "down",
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Content Performance",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Overview", icon: Icon(Icons.dashboard)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Reports", icon: Icon(Icons.assessment)),
      ],
      tabChildren: [
        _buildOverviewTab(),
        _buildAnalyticsTab(),
        _buildReportsTab(),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Performance Filters
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
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
                    label: "Primary Metric",
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
          ),

          // Overall Statistics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: overallStats.map((stat) => _buildStatCard(stat)).toList(),
          ),

          // Top Performers
          Container(
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
                    Icon(Icons.trending_up, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Top Performing Content",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
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
                ...topPerformers.map((content) => _buildTopPerformerItem(content)),
              ],
            ),
          ),

          // Performance Chart Placeholder
          Container(
            height: 250,
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Performance Trend",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: spSm),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(radiusSm),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 48,
                            color: primaryColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "Performance Chart",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            "Visual representation of content performance trends",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Analytics Header
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: infoColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: infoColor.withAlpha(30)),
            ),
            child: Row(
              children: [
                Icon(Icons.analytics, color: infoColor),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Detailed Analytics",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "Deep dive into content performance metrics",
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
          ),

          // Content Performance Table
          Container(
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
                Text(
                  "Content Performance Breakdown",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ...performanceData.map((content) => _buildPerformanceItem(content)),
              ],
            ),
          ),

          // Engagement Metrics
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 200,
            children: [
              _buildEngagementCard("Total Shares", "1,247", Icons.share, primaryColor),
              _buildEngagementCard("Comments", "589", Icons.comment, successColor),
              _buildEngagementCard("Likes", "3,456", Icons.favorite, dangerColor),
              _buildEngagementCard("Avg. Time", "5:32", Icons.access_time, warningColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          // Report Options
          Container(
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
                Text(
                  "Generate Custom Report",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Report Type",
                        items: [
                          {"label": "Performance Summary", "value": "summary"},
                          {"label": "Detailed Analytics", "value": "detailed"},
                          {"label": "Content Comparison", "value": "comparison"},
                          {"label": "Trend Analysis", "value": "trends"},
                        ],
                        value: "summary",
                        onChanged: (value, label) {},
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Export Format",
                        items: [
                          {"label": "PDF Report", "value": "pdf"},
                          {"label": "Excel Spreadsheet", "value": "excel"},
                          {"label": "CSV Data", "value": "csv"},
                        ],
                        value: "pdf",
                        onChanged: (value, label) {},
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Generate Report",
                    icon: Icons.download,
                    size: bs.md,
                    onPressed: () {
                      ss("Report generation started");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Recent Reports
          Container(
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
                    Icon(Icons.assessment, color: primaryColor),
                    SizedBox(width: spSm),
                    Text(
                      "Recent Reports",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _buildReportItem("Monthly Performance Report - January 2024", "PDF", "2024-01-31", "2.4 MB"),
                _buildReportItem("Content Analytics Deep Dive", "Excel", "2024-01-28", "1.8 MB"),
                _buildReportItem("Top Performers Analysis", "PDF", "2024-01-25", "1.2 MB"),
                _buildReportItem("Engagement Trends Report", "CSV", "2024-01-22", "0.5 MB"),
              ],
            ),
          ),

          // Performance Insights
          Container(
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: successColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(color: successColor.withAlpha(30)),
            ),
            child: Column(
              spacing: spSm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: successColor),
                    SizedBox(width: spSm),
                    Text(
                      "Key Insights",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                  ],
                ),
                _buildInsightItem("📈", "Content views increased by 23% this month"),
                _buildInsightItem("⏰", "Best posting time is between 9-11 AM"),
                _buildInsightItem("📱", "Mobile traffic accounts for 68% of total views"),
                _buildInsightItem("🎯", "Marketing category performs 15% better than average"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(Map<String, dynamic> stat) {
    Color color = stat["color"] as Color;
    bool isUp = stat["trend"] == "up";

    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(
                  isUp ? Icons.trending_up : Icons.trending_down,
                  color: color,
                  size: 20,
                ),
              ),
              Spacer(),
              Text(
                "${stat["change"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: isUp ? successColor : dangerColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${stat["value"]}",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            "${stat["label"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformerItem(Map<String, dynamic> content) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${content["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  "${content["category"]}",
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
              Text(
                "${(content["views"] as int).toString()} views",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
              Text(
                "+${(content["growth"] as double).toStringAsFixed(1)}%",
                style: TextStyle(
                  fontSize: 11,
                  color: successColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(Map<String, dynamic> content) {
    Color statusColor = _getStatusColor(content["status"] as String);

    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${content["title"]}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${content["status"]}".replaceAll("_", " ").toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: spXs),
          Text(
            "${content["type"]} • ${content["category"]} • ${content["published"]}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
          SizedBox(height: spSm),
          ResponsiveGridView(
            padding: EdgeInsets.zero,
            minItemWidth: 80,
            children: [
              _buildMetricItem("Views", "${(content["views"] as int).toString()}"),
              _buildMetricItem("Visitors", "${(content["visitors"] as int).toString()}"),
              _buildMetricItem("Engagement", "${(content["engagement"] as double).toStringAsFixed(1)}%"),
              _buildMetricItem("Time", "${content["timeOnPage"]}"),
              _buildMetricItem("Bounce", "${(content["bounceRate"] as double).toStringAsFixed(1)}%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
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
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Spacer(),
              Icon(Icons.trending_up, color: successColor, size: 16),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
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
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildReportItem(String title, String format, String date, String size) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(
            format == "PDF" ? Icons.picture_as_pdf :
            format == "Excel" ? Icons.table_chart :
            Icons.description,
            color: primaryColor,
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "$format • $date • $size",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Download",
            size: bs.sm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildInsightItem(String emoji, String text) {
    return Container(
      padding: EdgeInsets.all(spSm),
      margin: EdgeInsets.only(bottom: spXs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(color: successColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: successColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "excellent":
        return successColor;
      case "trending":
        return primaryColor;
      case "performing":
        return infoColor;
      case "needs_improvement":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }
}
