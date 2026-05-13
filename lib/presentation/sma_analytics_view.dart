import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaAnalyticsView extends StatefulWidget {
  const SmaAnalyticsView({super.key});

  @override
  State<SmaAnalyticsView> createState() => _SmaAnalyticsViewState();
}

class _SmaAnalyticsViewState extends State<SmaAnalyticsView> {
  int selectedPeriod = 0;
  String selectedPlatform = "all";
  
  final List<Map<String, dynamic>> periods = [
    {"label": "7 Days", "value": "7d"},
    {"label": "30 Days", "value": "30d"},
    {"label": "90 Days", "value": "90d"},
    {"label": "1 Year", "value": "1y"},
  ];

  final List<Map<String, dynamic>> platforms = [
    {"label": "All Platforms", "value": "all", "icon": Icons.apps, "color": Colors.grey},
    {"label": "Instagram", "value": "instagram", "icon": Icons.camera_alt, "color": Colors.pink},
    {"label": "Twitter", "value": "twitter", "icon": Icons.alternate_email, "color": Colors.blue},
    {"label": "Facebook", "value": "facebook", "icon": Icons.facebook, "color": Colors.indigo},
    {"label": "LinkedIn", "value": "linkedin", "icon": Icons.business, "color": Colors.blue[800]},
    {"label": "TikTok", "value": "tiktok", "icon": Icons.music_note, "color": Colors.black},
  ];

  final Map<String, dynamic> analyticsData = {
    "totalFollowers": 125430,
    "totalPosts": 342,
    "totalEngagement": 45670,
    "totalImpressions": 2850000,
    "engagementRate": 3.6,
    "reachGrowth": 12.5,
    "followerGrowth": 8.3,
    "postFrequency": 1.2,
  };

  final List<Map<String, dynamic>> platformStats = [
    {
      "platform": "Instagram",
      "followers": 45230,
      "posts": 128,
      "engagement": 18500,
      "impressions": 1200000,
      "growth": 15.2,
      "color": Colors.pink,
      "icon": Icons.camera_alt,
    },
    {
      "platform": "Twitter",
      "followers": 32100,
      "posts": 95,
      "engagement": 12300,
      "impressions": 850000,
      "growth": -2.1,
      "color": Colors.blue,
      "icon": Icons.alternate_email,
    },
    {
      "platform": "Facebook",
      "followers": 28900,
      "posts": 67,
      "engagement": 8900,
      "impressions": 520000,
      "growth": 5.8,
      "color": Colors.indigo,
      "icon": Icons.facebook,
    },
    {
      "platform": "LinkedIn",
      "followers": 12800,
      "posts": 32,
      "engagement": 4200,
      "impressions": 180000,
      "growth": 22.3,
      "color": Colors.blue[800],
      "icon": Icons.business,
    },
    {
      "platform": "TikTok",
      "followers": 6400,
      "posts": 20,
      "engagement": 1770,
      "impressions": 100000,
      "growth": 45.6,
      "color": Colors.black,
      "icon": Icons.music_note,
    },
  ];

  final List<Map<String, dynamic>> topPosts = [
    {
      "id": "1",
      "title": "Spring Fashion Trends 2024",
      "platform": "Instagram",
      "engagement": 2850,
      "likes": 2145,
      "comments": 234,
      "shares": 471,
      "impressions": 45600,
      "date": "2024-03-15",
      "image": "https://picsum.photos/300/300?random=1&keyword=fashion",
    },
    {
      "id": "2",
      "title": "Behind the Scenes: Product Launch",
      "platform": "TikTok",
      "engagement": 1920,
      "likes": 1654,
      "comments": 156,
      "shares": 110,
      "impressions": 28900,
      "date": "2024-03-12",
      "image": "https://picsum.photos/300/300?random=2&keyword=behind-scenes",
    },
    {
      "id": "3",
      "title": "Customer Success Story",
      "platform": "LinkedIn",
      "engagement": 1560,
      "likes": 1234,
      "comments": 89,
      "shares": 237,
      "impressions": 18500,
      "date": "2024-03-10",
      "image": "https://picsum.photos/300/300?random=3&keyword=success",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export analytics data
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Share analytics report
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(150)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.analytics,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Social Media Analytics",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Track your performance across all platforms",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Time Period Filter
            Row(
              children: [
                Text(
                  "Time Period:",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QHorizontalScroll(
                    children: periods.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> period = entry.value;
                      bool isSelected = selectedPeriod == index;
                      
                      return GestureDetector(
                        onTap: () {
                          selectedPeriod = index;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: spSm),
                          padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusSm),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "${period["label"]}",
                            style: TextStyle(
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spLg),
            
            // Overview Metrics
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 150,
              children: [
                _buildMetricCard(
                  "Total Followers",
                  "${((analyticsData["totalFollowers"] as int) / 1000).toStringAsFixed(1)}K",
                  Icons.people,
                  primaryColor,
                  "+${analyticsData["followerGrowth"]}%",
                ),
                _buildMetricCard(
                  "Total Posts",
                  "${analyticsData["totalPosts"]}",
                  Icons.post_add,
                  infoColor,
                  "+${analyticsData["postFrequency"]} per day",
                ),
                _buildMetricCard(
                  "Engagement",
                  "${((analyticsData["totalEngagement"] as int) / 1000).toStringAsFixed(1)}K",
                  Icons.favorite,
                  dangerColor,
                  "${analyticsData["engagementRate"]}% rate",
                ),
                _buildMetricCard(
                  "Impressions",
                  "${((analyticsData["totalImpressions"] as int) / 1000000).toStringAsFixed(1)}M",
                  Icons.visibility,
                  warningColor,
                  "+${analyticsData["reachGrowth"]}%",
                ),
              ],
            ),
            
            SizedBox(height: spXl),
            
            // Platform Performance
            Text(
              "Platform Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ...platformStats.map((platform) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                  border: Border(
                    left: BorderSide(
                      width: 4,
                      color: platform["color"] as Color,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Platform Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(spSm),
                          decoration: BoxDecoration(
                            color: (platform["color"] as Color).withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Icon(
                            platform["icon"] as IconData,
                            color: platform["color"] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Text(
                          "${platform["platform"]}",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: (platform["growth"] as double) >= 0 ? successColor.withAlpha(30) : dangerColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${(platform["growth"] as double) >= 0 ? '+' : ''}${(platform["growth"] as double).toStringAsFixed(1)}%",
                            style: TextStyle(
                              color: (platform["growth"] as double) >= 0 ? successColor : dangerColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: spMd),
                    
                    // Platform Metrics
                    Row(
                      children: [
                        Expanded(
                          child: _buildPlatformMetric("Followers", "${((platform["followers"] as int) / 1000).toStringAsFixed(1)}K"),
                        ),
                        Expanded(
                          child: _buildPlatformMetric("Posts", "${platform["posts"]}"),
                        ),
                        Expanded(
                          child: _buildPlatformMetric("Engagement", "${((platform["engagement"] as int) / 1000).toStringAsFixed(1)}K"),
                        ),
                        Expanded(
                          child: _buildPlatformMetric("Impressions", "${((platform["impressions"] as int) / 1000).toStringAsFixed(0)}K"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spXl),
            
            // Top Performing Posts
            Text(
              "Top Performing Posts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            
            ...topPosts.map((post) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Row(
                  children: [
                    // Post Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(radiusSm),
                      child: Image.network(
                        "${post["image"]}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                    SizedBox(width: spMd),
                    
                    // Post Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${post["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: spXs),
                          Row(
                            children: [
                              Text(
                                "${post["platform"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Text(
                                "• ${DateTime.parse(post["date"]).dMMMy}",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),
                          Row(
                            children: [
                              _buildPostMetric(Icons.favorite, "${post["likes"]}", dangerColor),
                              SizedBox(width: spMd),
                              _buildPostMetric(Icons.comment, "${post["comments"]}", infoColor),
                              SizedBox(width: spMd),
                              _buildPostMetric(Icons.share, "${post["shares"]}", successColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Engagement Score
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${((post["engagement"] as int) / 1000).toStringAsFixed(1)}K",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "engagement",
                          style: TextStyle(
                            fontSize: 10,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            
            SizedBox(height: spXl),
            
            // Insights & Recommendations
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(
                  color: infoColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "AI Insights & Recommendations",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  ...[
                    "Your TikTok engagement is 45% higher than average - consider increasing posting frequency",
                    "Instagram posts with fashion content perform 23% better than other topics",
                    "LinkedIn engagement peaks on Tuesday mornings - optimize your posting schedule",
                    "Consider using more video content - it generates 3x more engagement than images",
                  ].map((insight) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: spSm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: infoColor,
                            size: 16,
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Text(
                              insight,
                              style: TextStyle(
                                fontSize: 13,
                                color: primaryColor,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: Border(
          left: BorderSide(
            width: 3,
            color: color,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(spXs),
                decoration: BoxDecoration(
                  color: color.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.trending_up,
                  color: color,
                  size: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: spMd),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH5,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              color: disabledBoldColor,
              fontSize: 12,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformMetric(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildPostMetric(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
          size: 14,
        ),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
