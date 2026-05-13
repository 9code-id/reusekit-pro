import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcmEngagementMetricsView extends StatefulWidget {
  const EcmEngagementMetricsView({super.key});

  @override
  State<EcmEngagementMetricsView> createState() => _EcmEngagementMetricsViewState();
}

class _EcmEngagementMetricsViewState extends State<EcmEngagementMetricsView> {
  String selectedPeriod = "This Week";
  String selectedMetric = "All Metrics";
  String searchQuery = "";
  bool loading = false;

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "Last 3 Months", "value": "Last 3 Months"},
    {"label": "This Year", "value": "This Year"},
  ];

  List<Map<String, dynamic>> metricOptions = [
    {"label": "All Metrics", "value": "All Metrics"},
    {"label": "Session Engagement", "value": "Session Engagement"},
    {"label": "Social Interaction", "value": "Social Interaction"},
    {"label": "Content Consumption", "value": "Content Consumption"},
    {"label": "Networking Activity", "value": "Networking Activity"},
  ];

  List<Map<String, dynamic>> engagementMetrics = [
    {
      "title": "Average Session Duration",
      "value": "45.2",
      "unit": "minutes",
      "change": "+12.3%",
      "trend": "up",
      "icon": Icons.access_time,
      "color": Colors.blue,
    },
    {
      "title": "Interactive Sessions",
      "value": "87%",
      "unit": "participation",
      "change": "+5.2%",
      "trend": "up",
      "icon": Icons.touch_app,
      "color": Colors.green,
    },
    {
      "title": "Q&A Participation",
      "value": "234",
      "unit": "questions",
      "change": "+18.4%",
      "trend": "up",
      "icon": Icons.question_answer,
      "color": Colors.orange,
    },
    {
      "title": "Poll Responses",
      "value": "1,456",
      "unit": "responses",
      "change": "+7.9%",
      "trend": "up",
      "icon": Icons.poll,
      "color": Colors.purple,
    },
  ];

  List<Map<String, dynamic>> socialMetrics = [
    {
      "title": "Social Media Mentions",
      "value": "2,847",
      "unit": "mentions",
      "change": "+23.1%",
      "trend": "up",
      "icon": Icons.share,
      "color": Colors.teal,
    },
    {
      "title": "Hashtag Usage",
      "value": "1,923",
      "unit": "posts",
      "change": "+15.6%",
      "trend": "up",
      "icon": Icons.tag,
      "color": Colors.indigo,
    },
    {
      "title": "Photo Shares",
      "value": "756",
      "unit": "photos",
      "change": "+9.3%",
      "trend": "up",
      "icon": Icons.photo_camera,
      "color": Colors.pink,
    },
    {
      "title": "Live Stream Views",
      "value": "4,521",
      "unit": "views",
      "change": "+31.2%",
      "trend": "up",
      "icon": Icons.live_tv,
      "color": Colors.red,
    },
  ];

  List<Map<String, dynamic>> contentMetrics = [
    {
      "session": "AI in Healthcare",
      "downloads": 342,
      "views": 1287,
      "shares": 89,
      "rating": 4.8,
      "engagement": 92,
    },
    {
      "session": "Future of Work",
      "downloads": 298,
      "views": 1156,
      "shares": 76,
      "rating": 4.6,
      "engagement": 88,
    },
    {
      "session": "Sustainable Technology",
      "downloads": 267,
      "views": 1034,
      "shares": 65,
      "rating": 4.7,
      "engagement": 85,
    },
    {
      "session": "Digital Transformation",
      "downloads": 234,
      "views": 923,
      "shares": 54,
      "rating": 4.5,
      "engagement": 82,
    },
    {
      "session": "Cybersecurity Trends",
      "downloads": 189,
      "views": 756,
      "shares": 43,
      "rating": 4.4,
      "engagement": 78,
    },
  ];

  List<Map<String, dynamic>> networkingData = [
    {
      "activity": "New Connections",
      "count": 1847,
      "percentage": 85,
      "trend": "+12.4%",
    },
    {
      "activity": "Business Cards Exchanged",
      "count": 923,
      "percentage": 76,
      "trend": "+8.7%",
    },
    {
      "activity": "Meeting Requests",
      "count": 456,
      "percentage": 68,
      "trend": "+15.2%",
    },
    {
      "activity": "Follow-up Messages",
      "count": 678,
      "percentage": 72,
      "trend": "+9.8%",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Engagement Metrics"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loading = true;
              setState(() {});
              Future.delayed(Duration(seconds: 2), () {
                loading = false;
                setState(() {});
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ss("Engagement report exported successfully");
            },
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilters(),
                  SizedBox(height: spLg),
                  _buildOverallMetrics(),
                  SizedBox(height: spLg),
                  _buildSocialMetrics(),
                  SizedBox(height: spLg),
                  _buildContentEngagement(),
                  SizedBox(height: spLg),
                  _buildNetworkingActivity(),
                  SizedBox(height: spLg),
                  _buildEngagementTrends(),
                  SizedBox(height: spLg),
                  _buildActionButtons(),
                ],
              ),
            ),
    );
  }

  Widget _buildFilters() {
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
          Text(
            "Filter Engagement Data",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
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
                  label: "Metric Type",
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
          SizedBox(height: spSm),
          QTextField(
            label: "Search Sessions",
            value: searchQuery,
            hint: "Search by session name or speaker",
            onChanged: (value) {
              searchQuery = value;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOverallMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overall Engagement",
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
          children: engagementMetrics.map((metric) {
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
                          color: (metric["color"] as Color).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: metric["color"] as Color,
                          size: 20,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${metric["change"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${metric["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${metric["unit"]}",
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
    );
  }

  Widget _buildSocialMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Social Media Engagement",
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
          children: socialMetrics.map((metric) {
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
                          color: (metric["color"] as Color).withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Icon(
                          metric["icon"] as IconData,
                          color: metric["color"] as Color,
                          size: 20,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${metric["change"]}",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${metric["title"]}",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Row(
                    children: [
                      Text(
                        "${metric["value"]}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${metric["unit"]}",
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
    );
  }

  Widget _buildContentEngagement() {
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
          Text(
            "Content Engagement by Session",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...contentMetrics.map((content) {
            return Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                border: Border.all(color: disabledOutlineBorderColor),
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${content["session"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                        decoration: BoxDecoration(
                          color: successColor.withAlpha(51),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${content["engagement"]}% engaged",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: successColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Downloads",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${content["downloads"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                              "Views",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${content["views"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                              "Shares",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Text(
                              "${content["shares"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                              "Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 16,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "${content["rating"]}",
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
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  LinearProgressIndicator(
                    value: (content["engagement"] as int) / 100,
                    backgroundColor: disabledOutlineBorderColor,
                    valueColor: AlwaysStoppedAnimation<Color>(successColor),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNetworkingActivity() {
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
          Text(
            "Networking Activity",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          ...networkingData.map((activity) {
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
                          "${activity["activity"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${activity["count"]} total",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${activity["percentage"]}%",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${activity["trend"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: successColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: (activity["percentage"] as int) / 100,
                          backgroundColor: disabledOutlineBorderColor,
                          valueColor: AlwaysStoppedAnimation<Color>(infoColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildEngagementTrends() {
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
          Text(
            "Engagement Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    size: 48,
                    color: successColor,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Engagement Trending Upward",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "Overall engagement has increased by 18.5% this week",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: QButton(
            label: "Generate Report",
            icon: Icons.file_download,
            size: bs.md,
            onPressed: () {
              ss("Detailed engagement report generated successfully");
            },
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: QButton(
            label: "Share Insights",
            icon: Icons.share,
            size: bs.md,
            onPressed: () {
              ss("Engagement insights shared with team");
            },
          ),
        ),
      ],
    );
  }
}
