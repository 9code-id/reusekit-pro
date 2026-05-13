import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTrending10View extends StatefulWidget {
  @override
  State<GrlTrending10View> createState() => _GrlTrending10ViewState();
}

class _GrlTrending10ViewState extends State<GrlTrending10View> {
  String selectedTimePeriod = "1h";
  String selectedContentType = "All";
  bool isFollowingTrends = false;
  
  List<Map<String, dynamic>> timePeriods = [
    {"label": "Last Hour", "value": "1h"},
    {"label": "Last 6 Hours", "value": "6h"},
    {"label": "Last 24 Hours", "value": "24h"},
    {"label": "Last Week", "value": "7d"},
  ];

  List<Map<String, dynamic>> contentTypes = [
    {"label": "All Content", "value": "All"},
    {"label": "Videos", "value": "Video"},
    {"label": "Images", "value": "Image"},
    {"label": "Articles", "value": "Article"},
    {"label": "Polls", "value": "Poll"},
  ];

  List<Map<String, dynamic>> personalizedTrends = [
    {
      "id": 1,
      "title": "AI-Powered Design Tools Revolution",
      "type": "Article",
      "platform": "Medium",
      "author": "TechDesigner",
      "thumbnail": "https://picsum.photos/300/200?random=1&keyword=design",
      "engagement": 245000,
      "relevance_score": 95.8,
      "reading_time": "8 min read",
      "tags": ["AI", "Design", "Tools", "Productivity"],
      "trending_reason": "Based on your interest in AI and Design",
      "share_count": 12500,
      "comment_count": 890,
      "bookmark_count": 3400,
      "publish_time": "2 hours ago",
      "growth_rate": 156.7,
      "category": "Technology",
      "difficulty": "Intermediate",
      "author_followers": 89000,
      "author_verified": true,
    },
    {
      "id": 2,
      "title": "Sustainable Fashion Trends for 2024",
      "type": "Video",
      "platform": "YouTube",
      "author": "EcoFashionista",
      "thumbnail": "https://picsum.photos/300/200?random=2&keyword=fashion",
      "engagement": 450000,
      "relevance_score": 89.2,
      "reading_time": "12:30",
      "tags": ["Fashion", "Sustainability", "Environment", "Trends"],
      "trending_reason": "Popular in your network",
      "share_count": 23000,
      "comment_count": 1200,
      "bookmark_count": 5600,
      "publish_time": "4 hours ago",
      "growth_rate": 234.5,
      "category": "Lifestyle",
      "difficulty": "Beginner",
      "author_followers": 156000,
      "author_verified": true,
    },
    {
      "id": 3,
      "title": "Remote Work Productivity Hacks",
      "type": "Image",
      "platform": "Instagram",
      "author": "ProductivityGuru",
      "thumbnail": "https://picsum.photos/300/200?random=3&keyword=productivity",
      "engagement": 180000,
      "relevance_score": 92.4,
      "reading_time": "2 min read",
      "tags": ["Productivity", "Remote Work", "Tips", "Efficiency"],
      "trending_reason": "Trending in your location",
      "share_count": 8900,
      "comment_count": 450,
      "bookmark_count": 2100,
      "publish_time": "1 hour ago",
      "growth_rate": 189.3,
      "category": "Business",
      "difficulty": "Beginner",
      "author_followers": 234000,
      "author_verified": false,
    },
    {
      "id": 4,
      "title": "Best Programming Languages in 2024",
      "type": "Poll",
      "platform": "Twitter",
      "author": "CodeMaster",
      "thumbnail": "https://picsum.photos/300/200?random=4&keyword=programming",
      "engagement": 320000,
      "relevance_score": 96.1,
      "reading_time": "Poll",
      "tags": ["Programming", "Technology", "Career", "Development"],
      "trending_reason": "Based on your programming interests",
      "share_count": 15600,
      "comment_count": 2300,
      "bookmark_count": 4500,
      "publish_time": "3 hours ago",
      "growth_rate": 298.7,
      "category": "Technology",
      "difficulty": "All Levels",
      "author_followers": 345000,
      "author_verified": true,
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {
      "topic": "Artificial Intelligence",
      "relevance": 95.8,
      "posts_count": 234000,
      "growth": 45.7,
      "color": primaryColor,
    },
    {
      "topic": "Sustainable Living",
      "relevance": 89.2,
      "posts_count": 189000,
      "growth": 67.3,
      "color": successColor,
    },
    {
      "topic": "Remote Work",
      "relevance": 92.4,
      "posts_count": 156000,
      "growth": 23.8,
      "color": warningColor,
    },
    {
      "topic": "Mental Health",
      "relevance": 87.6,
      "posts_count": 145000,
      "growth": 89.1,
      "color": infoColor,
    },
    {
      "topic": "Cryptocurrency",
      "relevance": 84.3,
      "posts_count": 198000,
      "growth": -12.4,
      "color": dangerColor,
    },
  ];

  Color _getTypeColor(String type) {
    switch (type) {
      case "Video": return dangerColor;
      case "Article": return primaryColor;
      case "Image": return successColor;
      case "Poll": return warningColor;
      default: return disabledBoldColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Video": return Icons.play_circle;
      case "Article": return Icons.article;
      case "Image": return Icons.image;
      case "Poll": return Icons.poll;
      default: return Icons.content_copy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Trends"),
        actions: [
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () => _showCustomizationDialog(),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Personalization Header
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withAlpha(200),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Personalized Trends",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Curated based on your interests and activity",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withAlpha(220),
                              ),
                            ),
                          ],
                        ),
                      ),
                      QSwitch(
                        items: [
                          {
                            "label": "",
                            "value": true,
                            "checked": isFollowingTrends,
                          }
                        ],
                        value: isFollowingTrends ? [{"label": "", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          isFollowingTrends = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "AI-powered recommendations • Updated every hour",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Period",
                    items: timePeriods,
                    value: selectedTimePeriod,
                    onChanged: (value, label) {
                      selectedTimePeriod = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Content Type",
                    items: contentTypes,
                    value: selectedContentType,
                    onChanged: (value, label) {
                      selectedContentType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Quick Topics Overview
            Text(
              "Your Trending Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: trendingTopics.map((topic) {
                return Container(
                  width: 160,
                  margin: EdgeInsets.only(right: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: topic["color"].withAlpha(30),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: topic["color"].withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusLg),
                        ),
                        child: Icon(
                          Icons.trending_up,
                          color: topic["color"],
                          size: 24,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${topic["topic"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${((topic["posts_count"] as int) / 1000).toStringAsFixed(0)}K posts",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      SizedBox(height: spXs),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: (topic["growth"] as num) >= 0 
                            ? successColor.withAlpha(20) 
                            : dangerColor.withAlpha(20),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "${(topic["growth"] as num) >= 0 ? '+' : ''}${(topic["growth"] as num).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 11,
                            color: (topic["growth"] as num) >= 0 
                              ? successColor 
                              : dangerColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Personalized Content Feed
            Text(
              "Recommended for You",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: List.generate(personalizedTrends.length, (index) {
                final content = personalizedTrends[index];
                final typeColor = _getTypeColor(content["type"]);
                final typeIcon = _getTypeIcon(content["type"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: Border.all(
                      color: typeColor.withAlpha(30),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Content Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: typeColor.withAlpha(10),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: typeColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Icon(
                                typeIcon,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "@${content["author"]}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: typeColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (content["author_verified"] as bool) ...[
                                        SizedBox(width: spXs),
                                        Icon(
                                          Icons.verified,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                      ],
                                      SizedBox(width: spSm),
                                      Text(
                                        "• ${content["platform"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: disabledBoldColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${content["publish_time"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${(content["relevance_score"] as num).toStringAsFixed(0)}% match",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Content Body
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Thumbnail and Title
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${content["thumbnail"]}",
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
                                        "${content["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: spXs),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.schedule,
                                            color: disabledBoldColor,
                                            size: 14,
                                          ),
                                          SizedBox(width: spXs),
                                          Text(
                                            "${content["reading_time"]}",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: disabledBoldColor,
                                            ),
                                          ),
                                          SizedBox(width: spMd),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spSm,
                                              vertical: spXs,
                                            ),
                                            decoration: BoxDecoration(
                                              color: typeColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${content["difficulty"]}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: typeColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Trending Reason
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    color: primaryColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Text(
                                      "${content["trending_reason"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Tags
                            Wrap(
                              spacing: spSm,
                              runSpacing: spXs,
                              children: (content["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: typeColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: typeColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Engagement Metrics
                            Row(
                              children: [
                                _buildEngagementMetric(
                                  Icons.favorite,
                                  "${((content["engagement"] as int) / 1000).toStringAsFixed(0)}K",
                                ),
                                SizedBox(width: spMd),
                                _buildEngagementMetric(
                                  Icons.share,
                                  "${((content["share_count"] as int) / 1000).toStringAsFixed(1)}K",
                                ),
                                SizedBox(width: spMd),
                                _buildEngagementMetric(
                                  Icons.comment,
                                  "${content["comment_count"]}",
                                ),
                                SizedBox(width: spMd),
                                _buildEngagementMetric(
                                  Icons.bookmark,
                                  "${((content["bookmark_count"] as int) / 1000).toStringAsFixed(1)}K",
                                ),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: successColor.withAlpha(20),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "+${(content["growth_rate"] as num).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: successColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: content["type"] == "Video" ? "Watch" : 
                                           content["type"] == "Article" ? "Read" :
                                           content["type"] == "Poll" ? "Vote" : "View",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.bookmark_border,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.more_vert,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEngagementMetric(IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 16,
        ),
        SizedBox(width: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showCustomizationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Customize Your Trends"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Personalization options coming soon..."),
            SizedBox(height: spMd),
            Text(
              "• Interest preferences\n• Content type filters\n• Language settings\n• Notification frequency",
              style: TextStyle(
                fontSize: 14,
                color: disabledBoldColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
