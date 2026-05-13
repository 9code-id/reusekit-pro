import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlAnalytics7View extends StatefulWidget {
  @override
  State<GrlAnalytics7View> createState() => _GrlAnalytics7ViewState();
}

class _GrlAnalytics7ViewState extends State<GrlAnalytics7View> {
  String selectedPlatform = "all";
  String selectedMetric = "engagement";

  List<Map<String, dynamic>> platforms = [
    {"label": "All Platforms", "value": "all"},
    {"label": "Facebook", "value": "facebook"},
    {"label": "Instagram", "value": "instagram"},
    {"label": "Twitter", "value": "twitter"},
    {"label": "LinkedIn", "value": "linkedin"},
    {"label": "TikTok", "value": "tiktok"},
  ];

  List<Map<String, dynamic>> metrics = [
    {"label": "Engagement", "value": "engagement"},
    {"label": "Reach", "value": "reach"},
    {"label": "Growth", "value": "growth"},
    {"label": "Performance", "value": "performance"},
  ];

  List<Map<String, dynamic>> socialMetrics = [
    {
      "title": "Total Followers",
      "value": 284500,
      "change": 12.8,
      "icon": Icons.people,
      "color": Colors.blue
    },
    {
      "title": "Engagement Rate",
      "value": 4.2,
      "change": 18.5,
      "icon": Icons.favorite,
      "color": Colors.red
    },
    {
      "title": "Reach",
      "value": 1250000,
      "change": 8.9,
      "icon": Icons.visibility,
      "color": Colors.green
    },
    {
      "title": "Impressions",
      "value": 3450000,
      "change": 15.2,
      "icon": Icons.remove_red_eye,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> platformData = [
    {
      "platform": "Instagram",
      "followers": 125000,
      "engagement": 5.8,
      "posts": 156,
      "growth": 15.2,
      "icon": Icons.camera_alt,
      "color": Colors.pink
    },
    {
      "platform": "Facebook",
      "followers": 89500,
      "engagement": 3.2,
      "posts": 89,
      "growth": 8.7,
      "icon": Icons.facebook,
      "color": Colors.blue
    },
    {
      "platform": "Twitter",
      "followers": 42300,
      "engagement": 4.8,
      "posts": 234,
      "growth": 22.1,
      "icon": Icons.alternate_email,
      "color": Colors.lightBlue
    },
    {
      "platform": "LinkedIn",
      "followers": 18900,
      "engagement": 6.2,
      "posts": 45,
      "growth": 28.5,
      "icon": Icons.business,
      "color": Colors.indigo
    },
    {
      "platform": "TikTok",
      "followers": 8800,
      "engagement": 12.5,
      "posts": 67,
      "growth": 35.8,
      "icon": Icons.music_note,
      "color": Colors.black
    },
  ];

  List<Map<String, dynamic>> topPosts = [
    {
      "platform": "Instagram",
      "content": "Behind the scenes of our product photoshoot",
      "type": "Image",
      "likes": 15640,
      "comments": 324,
      "shares": 156,
      "engagement": 6.8,
      "posted": "2 days ago",
      "image": "https://picsum.photos/60/60?random=1&keyword=photoshoot"
    },
    {
      "platform": "Facebook",
      "content": "Customer success story: How we helped increase sales",
      "type": "Video",
      "likes": 8920,
      "comments": 245,
      "shares": 89,
      "engagement": 5.2,
      "posted": "3 days ago",
      "image": "https://picsum.photos/60/60?random=2&keyword=success"
    },
    {
      "platform": "Twitter",
      "content": "Breaking: New feature announcement thread",
      "type": "Thread",
      "likes": 4560,
      "comments": 156,
      "shares": 234,
      "engagement": 8.9,
      "posted": "1 day ago",
      "image": "https://picsum.photos/60/60?random=3&keyword=announcement"
    },
    {
      "platform": "LinkedIn",
      "content": "Industry insights: Digital transformation trends",
      "type": "Article",
      "likes": 2340,
      "comments": 89,
      "shares": 45,
      "engagement": 7.1,
      "posted": "4 days ago",
      "image": "https://picsum.photos/60/60?random=4&keyword=insights"
    },
  ];

  List<Map<String, dynamic>> audienceData = [
    {
      "demographic": "Age 18-24",
      "percentage": 32.5,
      "engagement": 5.2,
      "color": Colors.blue
    },
    {
      "demographic": "Age 25-34",
      "percentage": 41.8,
      "engagement": 4.8,
      "color": Colors.green
    },
    {
      "demographic": "Age 35-44",
      "percentage": 18.7,
      "engagement": 3.9,
      "color": Colors.orange
    },
    {
      "demographic": "Age 45+",
      "percentage": 7.0,
      "engagement": 3.2,
      "color": Colors.purple
    },
  ];

  List<Map<String, dynamic>> contentPerformance = [
    {
      "type": "Video",
      "posts": 67,
      "avg_engagement": 6.8,
      "total_views": 2450000,
      "color": Colors.red
    },
    {
      "type": "Image",
      "posts": 234,
      "avg_engagement": 4.2,
      "total_views": 1890000,
      "color": Colors.blue
    },
    {
      "type": "Carousel",
      "posts": 89,
      "avg_engagement": 5.5,
      "total_views": 1250000,
      "color": Colors.green
    },
    {
      "type": "Story",
      "posts": 156,
      "avg_engagement": 3.8,
      "total_views": 890000,
      "color": Colors.orange
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Media Analytics"),
        actions: [
          Icon(Icons.share),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Platform",
                    items: platforms,
                    value: selectedPlatform,
                    onChanged: (value, label) {
                      selectedPlatform = value;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: QDropdownField(
                    label: "Metric",
                    items: metrics,
                    value: selectedMetric,
                    onChanged: (value, label) {
                      selectedMetric = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 200,
              children: socialMetrics.map((metric) {
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: (metric["color"] as Color).withAlpha(20),
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
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: (metric["change"] as double) >= 0
                                  ? successColor.withAlpha(20)
                                  : dangerColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "${(metric["change"] as double) >= 0 ? '+' : ''}${(metric["change"] as double).toStringAsFixed(1)}%",
                              style: TextStyle(
                                color: (metric["change"] as double) >= 0
                                    ? successColor
                                    : dangerColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${metric["title"]}",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Text(
                        metric["title"] == "Engagement Rate"
                            ? "${(metric["value"] as double).toStringAsFixed(1)}%"
                            : metric["title"] == "Total Followers"
                            ? "${((metric["value"] as int) / 1000).toStringAsFixed(0)}K"
                            : "${((metric["value"] as int) / 1000000).toStringAsFixed(1)}M",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Platform Performance",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...platformData.map((platform) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (platform["color"] as Color).withAlpha(10),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: (platform["color"] as Color).withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  platform["icon"] as IconData,
                                  color: platform["color"] as Color,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Text(
                                  "${platform["platform"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "+${(platform["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
                                  children: [
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${((platform["followers"] as int) / 1000).toStringAsFixed(0)}K",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Engagement",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(platform["engagement"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    Text(
                                      "${(platform["posts"] as int)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
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
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Top Performing Posts",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  ...topPosts.map((post) {
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${post["image"]}",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${post["platform"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 1,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${post["type"]}",
                                        style: TextStyle(
                                          color: infoColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Text(
                                  "${post["content"]}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: primaryColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    Text(
                                      "${(post["likes"] as int)} likes",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${(post["engagement"] as double).toStringAsFixed(1)}% engagement",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: successColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "${post["posted"]}",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            Row(
              spacing: spSm,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Audience Demographics",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...audienceData.map((audience) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: audience["color"] as Color,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${audience["demographic"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${(audience["percentage"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: audience["color"] as Color,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Text(
                                      "Engagement: ${(audience["engagement"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Content Performance",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        ...contentPerformance.map((content) {
                          return Container(
                            margin: EdgeInsets.only(bottom: spSm),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: content["color"] as Color,
                                        borderRadius: BorderRadius.circular(radiusLg),
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Expanded(
                                      child: Text(
                                        "${content["type"]}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "${(content["avg_engagement"] as double).toStringAsFixed(1)}%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: content["color"] as Color,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: spXs),
                                Row(
                                  children: [
                                    SizedBox(width: 16),
                                    Text(
                                      "${(content["posts"] as int)} posts, ${((content["total_views"] as int) / 1000).toStringAsFixed(0)}K views",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
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
