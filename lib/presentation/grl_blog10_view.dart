import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlBlog10View extends StatefulWidget {
  const GrlBlog10View({super.key});

  @override
  State<GrlBlog10View> createState() => _GrlBlog10ViewState();
}

class _GrlBlog10ViewState extends State<GrlBlog10View> {
  String selectedPeriod = "This Week";
  bool isAnalyticsExpanded = false;

  final List<Map<String, dynamic>> periodOptions = [
    {"label": "Today", "value": "Today"},
    {"label": "This Week", "value": "This Week"},
    {"label": "This Month", "value": "This Month"},
    {"label": "This Year", "value": "This Year"},
  ];

  final List<Map<String, dynamic>> analyticsData = [
    {
      "title": "Page Views",
      "value": 156780,
      "change": 12.5,
      "icon": Icons.visibility,
      "color": infoColor,
      "chartData": [45, 52, 48, 61, 55, 67, 74],
    },
    {
      "title": "Unique Visitors",
      "value": 89340,
      "change": 8.7,
      "icon": Icons.people,
      "color": successColor,
      "chartData": [30, 35, 32, 41, 38, 45, 52],
    },
    {
      "title": "Article Reads",
      "value": 67290,
      "change": 15.3,
      "icon": Icons.article,
      "color": primaryColor,
      "chartData": [25, 28, 30, 35, 32, 38, 42],
    },
    {
      "title": "Comments",
      "value": 4567,
      "change": -2.1,
      "icon": Icons.comment,
      "color": warningColor,
      "chartData": [12, 15, 13, 18, 16, 19, 17],
    },
  ];

  final List<Map<String, dynamic>> topPosts = [
    {
      "title": "Understanding Machine Learning Algorithms",
      "views": 25600,
      "engagement": 89.5,
      "category": "Technology",
      "publishedAt": "2024-01-20",
      "status": "trending",
    },
    {
      "title": "The Future of Remote Work Culture",
      "views": 18900,
      "engagement": 76.3,
      "category": "Business",
      "publishedAt": "2024-01-18",
      "status": "popular",
    },
    {
      "title": "Design Principles for Mobile Apps",
      "views": 14200,
      "engagement": 82.1,
      "category": "Design",
      "publishedAt": "2024-01-16",
      "status": "rising",
    },
    {
      "title": "Sustainable Business Practices",
      "views": 12800,
      "engagement": 71.8,
      "category": "Business",
      "publishedAt": "2024-01-14",
      "status": "steady",
    },
    {
      "title": "Healthcare Technology Innovations",
      "views": 9600,
      "engagement": 85.4,
      "category": "Healthcare",
      "publishedAt": "2024-01-12",
      "status": "growing",
    },
  ];

  final List<Map<String, dynamic>> audienceData = [
    {"country": "United States", "percentage": 35.6, "flag": "🇺🇸"},
    {"country": "United Kingdom", "percentage": 18.4, "flag": "🇬🇧"},
    {"country": "Canada", "percentage": 12.8, "flag": "🇨🇦"},
    {"country": "Australia", "percentage": 9.2, "flag": "🇦🇺"},
    {"country": "Germany", "percentage": 7.5, "flag": "🇩🇪"},
    {"country": "Others", "percentage": 16.5, "flag": "🌍"},
  ];

  final List<Map<String, dynamic>> recentActivity = [
    {
      "type": "comment",
      "user": "Sarah Johnson",
      "action": "commented on",
      "target": "Machine Learning Algorithms",
      "time": "2 minutes ago",
      "icon": Icons.comment,
      "color": infoColor,
    },
    {
      "type": "like",
      "user": "Michael Chen",
      "action": "liked",
      "target": "Remote Work Culture",
      "time": "15 minutes ago",
      "icon": Icons.favorite,
      "color": dangerColor,
    },
    {
      "type": "share",
      "user": "Emma Rodriguez",
      "action": "shared",
      "target": "Design Principles",
      "time": "1 hour ago",
      "icon": Icons.share,
      "color": successColor,
    },
    {
      "type": "subscription",
      "user": "David Park",
      "action": "subscribed to your blog",
      "target": "",
      "time": "3 hours ago",
      "icon": Icons.person_add,
      "color": warningColor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Analytics"),
        actions: [
          IconButton(
            onPressed: () {
              isAnalyticsExpanded = !isAnalyticsExpanded;
              setState(() {});
            },
            icon: Icon(isAnalyticsExpanded ? Icons.expand_less : Icons.expand_more),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.download),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period Filter
            Row(
              children: [
                Text(
                  "Analytics Overview",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 120,
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
              ],
            ),

            SizedBox(height: spMd),

            // Summary Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: analyticsData.map((stat) {
                return Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            stat["icon"] as IconData,
                            color: stat["color"] as Color,
                            size: 24,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                            decoration: BoxDecoration(
                              color: (stat["change"] as double) > 0 
                                  ? successColor.withAlpha(20) 
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(stat["change"] as double) > 0 ? '+' : ''}${(stat["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: (stat["change"] as double) > 0 ? successColor : dangerColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${((stat["value"] as int) / 1000).toStringAsFixed(0)}K",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${stat["title"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      if (isAnalyticsExpanded) ...[
                        SizedBox(height: spSm),
                        Container(
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: (stat["chartData"] as List).map<Widget>((value) {
                              return Container(
                                width: 8,
                                height: (value as int).toDouble(),
                                decoration: BoxDecoration(
                                  color: (stat["color"] as Color).withAlpha(150),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: spMd),

            // Top Performing Posts
            Text(
              "Top Performing Posts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            Column(
              children: topPosts.map((post) {
                Color statusColor = primaryColor;
                IconData statusIcon = Icons.trending_flat;
                
                switch (post["status"]) {
                  case "trending":
                    statusColor = dangerColor;
                    statusIcon = Icons.trending_up;
                    break;
                  case "popular":
                    statusColor = successColor;
                    statusIcon = Icons.star;
                    break;
                  case "rising":
                    statusColor = warningColor;
                    statusIcon = Icons.trending_up;
                    break;
                  case "growing":
                    statusColor = infoColor;
                    statusIcon = Icons.show_chart;
                    break;
                  default:
                    statusColor = primaryColor;
                    statusIcon = Icons.trending_flat;
                }

                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${post["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(statusIcon, size: 16, color: statusColor),
                          SizedBox(width: spXs),
                          Text(
                            "${post["status"]}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${post["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Row(
                        children: [
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
                                  "${((post["views"] as int) / 1000).toStringAsFixed(1)}K",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
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
                                  "Engagement",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${(post["engagement"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: successColor,
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
                                  "Published",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Text(
                                  "${post["publishedAt"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
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

            // Audience Demographics
            Text(
              "Audience by Country",
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
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: audienceData.map((country) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Text(
                          "${country["flag"]}",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "${country["country"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: disabledColor,
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: (country["percentage"] as double) / 100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${(country["percentage"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: spMd),

            // Recent Activity
            Text(
              "Recent Activity",
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
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: recentActivity.map((activity) {
                  return Container(
                    margin: EdgeInsets.only(bottom: spSm),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spXs),
                          decoration: BoxDecoration(
                            color: (activity["color"] as Color).withAlpha(20),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            activity["icon"] as IconData,
                            size: 16,
                            color: activity["color"] as Color,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(fontSize: 14, color: primaryColor),
                                  children: [
                                    TextSpan(
                                      text: "${activity["user"]} ",
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    TextSpan(
                                      text: "${activity["action"]} ",
                                      style: TextStyle(color: disabledBoldColor),
                                    ),
                                    if (activity["target"].toString().isNotEmpty)
                                      TextSpan(
                                        text: "${activity["target"]}",
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                  ],
                                ),
                              ),
                              Text(
                                "${activity["time"]}",
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
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
