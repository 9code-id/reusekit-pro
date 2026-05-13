import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTrending6View extends StatefulWidget {
  @override
  State<GrlTrending6View> createState() => _GrlTrending6ViewState();
}

class _GrlTrending6ViewState extends State<GrlTrending6View> with TickerProviderStateMixin {
  String selectedTimeFrame = "24h";
  String selectedRegion = "Global";
  
  List<Map<String, dynamic>> timeFrames = [
    {"label": "1 Hour", "value": "1h"},
    {"label": "24 Hours", "value": "24h"},
    {"label": "7 Days", "value": "7d"},
    {"label": "30 Days", "value": "30d"},
  ];

  List<Map<String, dynamic>> regions = [
    {"label": "Global", "value": "Global"},
    {"label": "United States", "value": "US"},
    {"label": "Europe", "value": "EU"},
    {"label": "Asia", "value": "Asia"},
  ];

  List<Map<String, dynamic>> trendingData = [
    {
      "rank": 1,
      "title": "Climate Change Summit 2024",
      "category": "News",
      "mentions": 1250000,
      "engagement": 89.5,
      "sentiment": 72.3,
      "change": 45.8,
      "countries": ["US", "UK", "CA", "AU", "DE"],
      "peak_time": "2 hours ago",
      "related_keywords": ["climate", "summit", "environment", "policy"],
    },
    {
      "rank": 2,
      "title": "New AI Breakthrough",
      "category": "Technology",
      "mentions": 980000,
      "engagement": 94.2,
      "sentiment": 85.7,
      "change": 67.3,
      "countries": ["US", "CN", "JP", "KR", "IN"],
      "peak_time": "4 hours ago",
      "related_keywords": ["artificial intelligence", "machine learning", "innovation"],
    },
    {
      "rank": 3,
      "title": "Global Sports Championship",
      "category": "Sports",
      "mentions": 2100000,
      "engagement": 76.8,
      "sentiment": 91.2,
      "change": 128.4,
      "countries": ["BR", "AR", "ES", "IT", "FR"],
      "peak_time": "1 hour ago",
      "related_keywords": ["championship", "sports", "competition", "athletes"],
    },
    {
      "rank": 4,
      "title": "Cryptocurrency Market Update",
      "category": "Finance",
      "mentions": 750000,
      "engagement": 82.1,
      "sentiment": 58.9,
      "change": -12.6,
      "countries": ["US", "SG", "JP", "CH", "UK"],
      "peak_time": "6 hours ago",
      "related_keywords": ["bitcoin", "ethereum", "blockchain", "trading"],
    },
    {
      "rank": 5,
      "title": "Space Mission Launch",
      "category": "Science",
      "mentions": 680000,
      "engagement": 88.4,
      "sentiment": 96.1,
      "change": 89.7,
      "countries": ["US", "RU", "CN", "IN", "JP"],
      "peak_time": "8 hours ago",
      "related_keywords": ["space", "mission", "satellite", "exploration"],
    },
  ];

  Color _getCategoryColor(String category) {
    switch (category) {
      case "News": return infoColor;
      case "Technology": return primaryColor;
      case "Sports": return successColor;
      case "Finance": return warningColor;
      case "Science": return secondaryColor;
      default: return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global Trends"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Real-time Indicator
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(200)],
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
                        width: 12,
                        height: 12,
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
                      Text(
                        "Live Global Trends",
                        style: TextStyle(
                          fontSize: fsH4,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Real-time trending topics worldwide",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(220),
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      Icon(
                        Icons.update,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Last updated: just now",
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
            
            // Filter Section
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Time Frame",
                    items: timeFrames,
                    value: selectedTimeFrame,
                    onChanged: (value, label) {
                      selectedTimeFrame = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Region",
                    items: regions,
                    value: selectedRegion,
                    onChanged: (value, label) {
                      selectedRegion = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Quick Stats
            ResponsiveGridView(
              minItemWidth: 200,
              children: [
                _buildStatCard(
                  "Total Mentions",
                  "${(trendingData.fold(0, (sum, item) => sum + (item["mentions"] as int)) / 1000000).toStringAsFixed(1)}M",
                  Icons.chat_bubble_outline,
                  primaryColor,
                ),
                _buildStatCard(
                  "Avg Engagement",
                  "${(trendingData.fold(0.0, (sum, item) => sum + (item["engagement"] as num)) / trendingData.length).toStringAsFixed(1)}%",
                  Icons.trending_up,
                  successColor,
                ),
                _buildStatCard(
                  "Top Category",
                  "Sports",
                  Icons.category,
                  warningColor,
                ),
                _buildStatCard(
                  "Countries",
                  "${trendingData.expand((item) => item["countries"] as List).toSet().length}",
                  Icons.public,
                  infoColor,
                ),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Trending Topics List
            Text(
              "Trending Topics",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: List.generate(trendingData.length, (index) {
                final item = trendingData[index];
                final categoryColor = _getCategoryColor(item["category"]);
                
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: categoryColor.withAlpha(30),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header
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
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(radiusLg),
                              ),
                              child: Center(
                                child: Text(
                                  "#${item["rank"]}",
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
                                  Text(
                                    "${item["title"]}",
                                    style: TextStyle(
                                      fontSize: fsH6,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: spXs),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: categoryColor.withAlpha(50),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "${item["category"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: categoryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: spSm),
                                      Text(
                                        "Peak: ${item["peak_time"]}",
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
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: (item["change"] as num) >= 0 
                                  ? successColor.withAlpha(20) 
                                  : dangerColor.withAlpha(20),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    (item["change"] as num) >= 0 
                                      ? Icons.arrow_upward 
                                      : Icons.arrow_downward,
                                    color: (item["change"] as num) >= 0 
                                      ? successColor 
                                      : dangerColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${(item["change"] as num).abs().toStringAsFixed(1)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: (item["change"] as num) >= 0 
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
                      
                      // Metrics
                      Padding(
                        padding: EdgeInsets.all(spMd),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: _buildMetric(
                                    "Mentions",
                                    "${((item["mentions"] as int) / 1000).toStringAsFixed(0)}K",
                                    Icons.chat_bubble_outline,
                                  ),
                                ),
                                Expanded(
                                  child: _buildMetric(
                                    "Engagement",
                                    "${(item["engagement"] as num).toStringAsFixed(1)}%",
                                    Icons.favorite,
                                  ),
                                ),
                                Expanded(
                                  child: _buildMetric(
                                    "Sentiment",
                                    "${(item["sentiment"] as num).toStringAsFixed(1)}%",
                                    Icons.sentiment_satisfied,
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Countries
                            Row(
                              children: [
                                Icon(
                                  Icons.public,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "Trending in:",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: disabledBoldColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Wrap(
                                    spacing: spSm,
                                    children: (item["countries"] as List).take(3).map((country) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: spSm,
                                          vertical: spXs,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withAlpha(20),
                                          borderRadius: BorderRadius.circular(radiusSm),
                                        ),
                                        child: Text(
                                          "$country",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Related Keywords
                            Wrap(
                              spacing: spSm,
                              runSpacing: spXs,
                              children: (item["related_keywords"] as List).map((keyword) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: categoryColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$keyword",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: categoryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            
                            SizedBox(height: spMd),
                            
                            // Action Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: QButton(
                                    label: "View Details",
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: [shadowSm],
        border: Border.all(
          color: color.withAlpha(30),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: spXs),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: disabledBoldColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: disabledBoldColor,
          size: 20,
        ),
        SizedBox(height: spXs),
        Text(
          value,
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }
}
