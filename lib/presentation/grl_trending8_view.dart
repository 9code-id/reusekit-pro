import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTrending8View extends StatefulWidget {
  @override
  State<GrlTrending8View> createState() => _GrlTrending8ViewState();
}

class _GrlTrending8ViewState extends State<GrlTrending8View> {
  String selectedCategory = "All";
  String selectedDuration = "24h";
  bool showOnlyVerified = false;
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Categories", "value": "All"},
    {"label": "Entertainment", "value": "Entertainment"},
    {"label": "Education", "value": "Education"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Music", "value": "Music"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> durations = [
    {"label": "Last Hour", "value": "1h"},
    {"label": "24 Hours", "value": "24h"},
    {"label": "This Week", "value": "7d"},
    {"label": "This Month", "value": "30d"},
  ];

  List<Map<String, dynamic>> trendingVideos = [
    {
      "id": 1,
      "title": "Revolutionary AI Breakthrough Changes Everything",
      "creator": "TechInsider",
      "category": "Technology",
      "thumbnail": "https://picsum.photos/400/240?random=1&keyword=technology",
      "views": 8900000,
      "likes": 450000,
      "comments": 23000,
      "shares": 89000,
      "duration": "12:45",
      "upload_time": "2 hours ago",
      "trending_position": 1,
      "previous_position": 5,
      "growth_velocity": 234.5,
      "engagement_score": 94.8,
      "verified": true,
      "live_viewers": 12500,
      "peak_concurrent": 45000,
      "trending_countries": ["US", "UK", "CA", "AU", "DE"],
      "age_demographics": {
        "18-24": 35,
        "25-34": 28,
        "35-44": 22,
        "45+": 15
      },
      "platform_performance": {
        "YouTube": 4200000,
        "TikTok": 2800000,
        "Instagram": 1600000,
        "Twitter": 300000
      }
    },
    {
      "id": 2,
      "title": "Street Musician's Incredible Performance Goes Viral",
      "creator": "MusicLover_NYC",
      "category": "Entertainment",
      "thumbnail": "https://picsum.photos/400/240?random=2&keyword=music",
      "views": 15600000,
      "likes": 1200000,
      "comments": 89000,
      "shares": 245000,
      "duration": "4:32",
      "upload_time": "5 hours ago",
      "trending_position": 2,
      "previous_position": 8,
      "growth_velocity": 456.7,
      "engagement_score": 97.2,
      "verified": false,
      "live_viewers": 8900,
      "peak_concurrent": 67000,
      "trending_countries": ["US", "BR", "MX", "AR", "CO"],
      "age_demographics": {
        "18-24": 45,
        "25-34": 32,
        "35-44": 18,
        "45+": 5
      },
      "platform_performance": {
        "TikTok": 8900000,
        "Instagram": 3400000,
        "YouTube": 2800000,
        "Twitter": 500000
      }
    },
    {
      "id": 3,
      "title": "Mind-Blowing Science Experiment Explained",
      "creator": "ScienceExplainer",
      "category": "Education",
      "thumbnail": "https://picsum.photos/400/240?random=3&keyword=science",
      "views": 6780000,
      "likes": 340000,
      "comments": 45000,
      "shares": 67000,
      "duration": "8:15",
      "upload_time": "3 hours ago",
      "trending_position": 3,
      "previous_position": 1,
      "growth_velocity": 189.3,
      "engagement_score": 89.4,
      "verified": true,
      "live_viewers": 5600,
      "peak_concurrent": 23000,
      "trending_countries": ["US", "UK", "DE", "JP", "SG"],
      "age_demographics": {
        "18-24": 40,
        "25-34": 35,
        "35-44": 20,
        "45+": 5
      },
      "platform_performance": {
        "YouTube": 4200000,
        "Instagram": 1500000,
        "TikTok": 800000,
        "Twitter": 280000
      }
    },
  ];

  List<Map<String, dynamic>> get filteredVideos {
    var filtered = trendingVideos;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((video) => video["category"] == selectedCategory).toList();
    }
    
    if (showOnlyVerified) {
      filtered = filtered.where((video) => video["verified"] == true).toList();
    }
    
    return filtered;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Technology": return primaryColor;
      case "Entertainment": return dangerColor;
      case "Education": return successColor;
      case "Music": return warningColor;
      case "Sports": return infoColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Live Dashboard Header
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
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: successColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: successColor.withAlpha(100),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Live Trending Dashboard",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "Real-time",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Track viral content performance across all platforms",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQuickStat(
                          "Active Trends",
                          "${filteredVideos.length}",
                          Icons.trending_up,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(60),
                      ),
                      Expanded(
                        child: _buildQuickStat(
                          "Total Views",
                          "${(filteredVideos.fold(0, (sum, video) => sum + (video["views"] as int)) / 1000000).toStringAsFixed(1)}M",
                          Icons.visibility,
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.white.withAlpha(60),
                      ),
                      Expanded(
                        child: _buildQuickStat(
                          "Live Viewers",
                          "${(filteredVideos.fold(0, (sum, video) => sum + (video["live_viewers"] as int)) / 1000).toStringAsFixed(0)}K",
                          Icons.remove_red_eye,
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
                    label: "Category",
                    items: categories,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Duration",
                    items: durations,
                    value: selectedDuration,
                    onChanged: (value, label) {
                      selectedDuration = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Verified Filter
            QSwitch(
              items: [
                {
                  "label": "Show only verified creators",
                  "value": true,
                  "checked": showOnlyVerified,
                }
              ],
              value: showOnlyVerified ? [{"label": "Show only verified creators", "value": true, "checked": true}] : [],
              onChanged: (values, ids) {
                showOnlyVerified = values.isNotEmpty;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Trending Videos List
            Text(
              "Trending Content",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: List.generate(filteredVideos.length, (index) {
                final video = filteredVideos[index];
                final categoryColor = _getCategoryColor(video["category"]);
                final positionChange = (video["previous_position"] as int) - (video["trending_position"] as int);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: Border.all(
                      color: categoryColor.withAlpha(30),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Video Header
                      Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: categoryColor.withAlpha(20),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(radiusLg),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Position Badge
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Center(
                                child: Text(
                                  "#${video["trending_position"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: spMd),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${video["title"]}",
                                          style: TextStyle(
                                            fontSize: fsH6,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (video["verified"] as bool)
                                        Icon(
                                          Icons.verified,
                                          color: primaryColor,
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: spXs),
                                  Text(
                                    "${video["creator"]} • ${video["upload_time"]}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Position Change Indicator
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: positionChange > 0 
                                  ? successColor.withAlpha(20) 
                                  : positionChange < 0 
                                    ? dangerColor.withAlpha(20) 
                                    : Colors.grey.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    positionChange > 0 
                                      ? Icons.keyboard_arrow_up 
                                      : positionChange < 0 
                                        ? Icons.keyboard_arrow_down 
                                        : Icons.remove,
                                    color: positionChange > 0 
                                      ? successColor 
                                      : positionChange < 0 
                                        ? dangerColor 
                                        : Colors.grey,
                                    size: 16,
                                  ),
                                  if (positionChange != 0)
                                    Text(
                                      "${positionChange.abs()}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: positionChange > 0 
                                          ? successColor 
                                          : dangerColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Video Thumbnail and Metrics
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          children: [
                            // Thumbnail
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  child: Image.network(
                                    "${video["thumbnail"]}",
                                    height: 160,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: categoryColor.withAlpha(40),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${video["category"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: categoryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: spSm,
                                  right: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(180),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Text(
                                      "${video["duration"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: spSm,
                                  left: spSm,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spSm,
                                      vertical: spXs,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor.withAlpha(200),
                                      borderRadius: BorderRadius.circular(radiusSm),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Text(
                                          "${((video["live_viewers"] as int) / 1000).toStringAsFixed(1)}K watching",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Performance Metrics
                            ResponsiveGridView(
                              minItemWidth: 200,
                              children: [
                                _buildMetricCard(
                                  "Views",
                                  "${((video["views"] as int) / 1000000).toStringAsFixed(1)}M",
                                  Icons.visibility,
                                  primaryColor,
                                ),
                                _buildMetricCard(
                                  "Engagement",
                                  "${(video["engagement_score"] as num).toStringAsFixed(1)}%",
                                  Icons.favorite,
                                  dangerColor,
                                ),
                                _buildMetricCard(
                                  "Growth",
                                  "+${(video["growth_velocity"] as num).toStringAsFixed(1)}%",
                                  Icons.trending_up,
                                  successColor,
                                ),
                                _buildMetricCard(
                                  "Peak Viewers",
                                  "${((video["peak_concurrent"] as int) / 1000).toStringAsFixed(0)}K",
                                  Icons.people,
                                  warningColor,
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Platform Performance
                            Container(
                              padding: EdgeInsets.all(spSm),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Platform Performance",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spSm),
                                  ...((video["platform_performance"] as Map<String, dynamic>).entries.map((entry) {
                                    final platformViews = entry.value as int;
                                    final totalViews = video["views"] as int;
                                    final percentage = (platformViews / totalViews * 100);
                                    
                                    return Container(
                                      margin: EdgeInsets.only(bottom: spXs),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            child: Text(
                                              entry.key,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: disabledBoldColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: FractionallySizedBox(
                                                alignment: Alignment.centerLeft,
                                                widthFactor: percentage / 100,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: categoryColor,
                                                    borderRadius: BorderRadius.circular(radiusXs),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: spSm),
                                          Text(
                                            "${percentage.toStringAsFixed(0)}%",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: categoryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()),
                                ],
                              ),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Analytics",
                                    size: bs.sm,
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: spSm),
                                QButton(
                                  icon: Icons.share,
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                                SizedBox(width: spXs),
                                QButton(
                                  icon: Icons.bookmark_border,
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

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withAlpha(200),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
        border: Border.all(
          color: color.withAlpha(50),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Advanced Filters"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Filter options coming soon..."),
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
