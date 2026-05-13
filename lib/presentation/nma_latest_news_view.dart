import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaLatestNewsView extends StatefulWidget {
  const NmaLatestNewsView({super.key});

  @override
  State<NmaLatestNewsView> createState() => _NmaLatestNewsViewState();
}

class _NmaLatestNewsViewState extends State<NmaLatestNewsView> {
  bool loading = false;
  bool isRefreshing = false;
  String selectedRegion = "global";
  int selectedTimeFrame = 0;
  
  List<String> regions = ["global", "local", "national", "international"];
  List<String> timeFrames = ["Last Hour", "Last 6 Hours", "Today", "This Week"];

  List<Map<String, dynamic>> latestNews = [
    {
      "id": 1,
      "title": "Live Update: Global Climate Conference Reaches Consensus",
      "summary": "Representatives from 195 countries agree on new carbon emission standards",
      "category": "Politics",
      "region": "global",
      "author": "Emma Richardson",
      "publishTime": "12 minutes ago",
      "source": "Global News Network",
      "readTime": "3 min",
      "image": "https://picsum.photos/300/200?random=1&keyword=climate",
      "urgency": "high",
      "isLive": true,
      "views": 45200,
      "isBreaking": false,
      "tags": ["climate", "environment", "politics"]
    },
    {
      "id": 2,
      "title": "Tech Innovation: New AI Model Achieves Medical Breakthrough",
      "summary": "Revolutionary artificial intelligence system demonstrates 98% accuracy in early disease detection",
      "category": "Technology",
      "region": "global",
      "author": "Dr. James Park",
      "publishTime": "25 minutes ago",
      "source": "Tech Today",
      "readTime": "5 min",
      "image": "https://picsum.photos/300/200?random=2&keyword=ai",
      "urgency": "medium",
      "isLive": false,
      "views": 67800,
      "isBreaking": true,
      "tags": ["ai", "medical", "technology"]
    },
    {
      "id": 3,
      "title": "Market Alert: Cryptocurrency Reaches New All-Time High",
      "summary": "Digital currency surpasses previous records amid institutional adoption surge",
      "category": "Business",
      "region": "global",
      "author": "Sarah Williams",
      "publishTime": "38 minutes ago",
      "source": "Financial Express",
      "readTime": "4 min",
      "image": "https://picsum.photos/300/200?random=3&keyword=crypto",
      "urgency": "high",
      "isLive": true,
      "views": 89300,
      "isBreaking": false,
      "tags": ["cryptocurrency", "finance", "market"]
    },
    {
      "id": 4,
      "title": "Sports: Championship Finals Set Record Television Viewership",
      "summary": "Historic sporting event draws largest global audience in tournament history",
      "category": "Sports",
      "region": "global",
      "author": "Michael Torres",
      "publishTime": "52 minutes ago",
      "source": "Sports Central",
      "readTime": "2 min",
      "image": "https://picsum.photos/300/200?random=4&keyword=sports",
      "urgency": "low",
      "isLive": false,
      "views": 34500,
      "isBreaking": false,
      "tags": ["sports", "championship", "television"]
    },
    {
      "id": 5,
      "title": "Health Alert: New Study Reveals Surprising Nutrition Facts",
      "summary": "Comprehensive research challenges conventional dietary recommendations and guidelines",
      "category": "Health",
      "region": "global",
      "author": "Dr. Lisa Chen",
      "publishTime": "1 hour ago",
      "source": "Health Science Journal",
      "readTime": "6 min",
      "image": "https://picsum.photos/300/200?random=5&keyword=health",
      "urgency": "medium",
      "isLive": false,
      "views": 23400,
      "isBreaking": false,
      "tags": ["health", "nutrition", "research"]
    },
    {
      "id": 6,
      "title": "Entertainment: Streaming Platform Announces Major Content Deal",
      "summary": "Media giant secures exclusive rights to popular franchise for next five years",
      "category": "Entertainment",
      "region": "global",
      "author": "David Kim",
      "publishTime": "1 hour ago",
      "source": "Entertainment Weekly",
      "readTime": "3 min",
      "image": "https://picsum.photos/300/200?random=6&keyword=entertainment",
      "urgency": "low",
      "isLive": false,
      "views": 56700,
      "isBreaking": false,
      "tags": ["streaming", "entertainment", "media"]
    }
  ];

  List<Map<String, dynamic>> get filteredNews {
    List<Map<String, dynamic>> filtered = latestNews;
    
    if (selectedRegion != "global") {
      filtered = filtered.where((news) => 
        news["region"] == selectedRegion).toList();
    }
    
    return filtered;
  }

  Color getUrgencyColor(String urgency) {
    switch (urgency) {
      case "high":
        return dangerColor;
      case "medium":
        return warningColor;
      case "low":
        return successColor;
      default:
        return infoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              isRefreshing = true;
              setState(() {});
              
              Future.delayed(Duration(seconds: 2), () {
                isRefreshing = false;
                setState(() {});
                ss("Latest news refreshed");
              });
            },
          ),
        ],
      ),
      body: isRefreshing 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Live Updates Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
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
                        "LIVE NEWS",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Text(
                          "Updates every minute • Last refresh: now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.notifications_active,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Filter Controls
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Region",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          QCategoryPicker(
                            items: regions.map((region) => {
                              "label": region.toUpperCase(),
                              "value": region,
                            }).toList(),
                            value: selectedRegion,
                            onChanged: (index, label, value, item) {
                              selectedRegion = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Time Frame Filter
                Row(
                  children: [
                    Text(
                      "Time Frame",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QCategoryPicker(
                        items: timeFrames.asMap().entries.map((entry) => {
                          "label": entry.value,
                          "value": entry.key,
                        }).toList(),
                        value: selectedTimeFrame,
                        onChanged: (index, label, value, item) {
                          selectedTimeFrame = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Quick Stats
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredNews.length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "Stories",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredNews.where((news) => news["isLive"] == true).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: dangerColor,
                              ),
                            ),
                            Text(
                              "Live",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(spSm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(radiusSm),
                          boxShadow: [shadowSm],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${filteredNews.where((news) => news["isBreaking"] == true).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            Text(
                              "Breaking",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Latest News Section
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Latest Updates",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Auto-refresh: ON",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // News List
                Column(
                  children: filteredNews.map((news) {
                    Color urgencyColor = getUrgencyColor(news["urgency"]);
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: Border(
                          left: BorderSide(
                            width: 3,
                            color: urgencyColor,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // News Header
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Row(
                              children: [
                                // Status Badges
                                if (news["isLive"] == true)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: dangerColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "LIVE",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (news["isBreaking"] == true)
                                  Container(
                                    margin: EdgeInsets.only(left: news["isLive"] == true ? 4 : 0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: spXs,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "BREAKING",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                Spacer(),
                                Text(
                                  "${news["publishTime"]}",
                                  style: TextStyle(
                                    color: urgencyColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // News Content
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  "${news["title"]}",
                                  style: TextStyle(
                                    fontSize: fsH6,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                
                                SizedBox(height: spXs),
                                
                                // Summary
                                Text(
                                  "${news["summary"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Category and Source Info
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primaryColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${news["category"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Icon(
                                      Icons.person,
                                      size: 12,
                                      color: disabledColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${news["author"]}",
                                      style: TextStyle(
                                        color: disabledColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: spXs,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: infoColor.withAlpha(20),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Text(
                                        "${news["readTime"]}",
                                        style: TextStyle(
                                          color: infoColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // News Image
                          if (news["image"] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(radiusSm),
                              child: Image.network(
                                "${news["image"]}",
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          
                          // News Footer
                          Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(radiusSm),
                                bottomRight: Radius.circular(radiusSm),
                              ),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.source,
                                      size: 14,
                                      color: disabledColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${news["source"]}",
                                      style: TextStyle(
                                        color: disabledColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: spSm),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.visibility,
                                      size: 14,
                                      color: disabledColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${((news["views"] as int) / 1000).toStringAsFixed(1)}K",
                                      style: TextStyle(
                                        color: disabledColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        ss("News bookmarked");
                                      },
                                      child: Icon(
                                        Icons.bookmark_border,
                                        color: disabledBoldColor,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    GestureDetector(
                                      onTap: () {
                                        ss("News shared");
                                      },
                                      child: Icon(
                                        Icons.share,
                                        color: disabledBoldColor,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    QButton(
                                      label: "Read More",
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
                  }).toList(),
                ),
                
                SizedBox(height: spMd),
                
                // Load More Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Load More Latest News",
                    size: bs.md,
                    onPressed: () {
                      loading = true;
                      setState(() {});
                      
                      Future.delayed(Duration(seconds: 2), () {
                        loading = false;
                        setState(() {});
                        ss("More news loaded");
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
