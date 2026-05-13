import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaBreakingNewsView extends StatefulWidget {
  const NmaBreakingNewsView({super.key});

  @override
  State<NmaBreakingNewsView> createState() => _NmaBreakingNewsViewState();
}

class _NmaBreakingNewsViewState extends State<NmaBreakingNewsView> {
  bool isLiveMode = true;
  
  List breakingNews = [
    {
      "id": 1,
      "title": "URGENT: Major Earthquake Strikes Pacific Coast - Tsunami Warning Issued",
      "summary": "7.2 magnitude earthquake hits 50 miles off the coast, emergency services responding",
      "author": "Emergency News Team",
      "timestamp": "NOW",
      "location": "Pacific Coast",
      "image": "https://picsum.photos/400/250?random=21&keyword=earthquake",
      "priority": "critical",
      "isLive": true,
      "views": 45230,
      "category": "Emergency",
      "severity": "high",
    },
    {
      "id": 2,
      "title": "BREAKING: Stock Market Crashes 8% in Emergency Trading Halt",
      "summary": "Major indices plummet following unexpected economic announcement",
      "author": "Market Watch Team",
      "timestamp": "3 minutes ago",
      "location": "New York",
      "image": "https://picsum.photos/400/250?random=22&keyword=market",
      "priority": "critical",
      "isLive": true,
      "views": 38760,
      "category": "Finance",
      "severity": "high",
    },
    {
      "id": 3,
      "title": "UPDATE: Wildfire Forces Evacuation of 10,000 Residents",
      "summary": "Fast-moving blaze threatens multiple communities, evacuation orders expanded",
      "author": "Field Reporter Sarah Mills",
      "timestamp": "12 minutes ago",
      "location": "California",
      "image": "https://picsum.photos/400/250?random=23&keyword=wildfire",
      "priority": "urgent",
      "isLive": true,
      "views": 29480,
      "category": "Natural Disaster",
      "severity": "high",
    },
    {
      "id": 4,
      "title": "DEVELOPING: International Diplomatic Crisis Unfolds",
      "summary": "Emergency UN Security Council meeting called as tensions escalate",
      "author": "UN Correspondent",
      "timestamp": "28 minutes ago",
      "location": "United Nations",
      "image": "https://picsum.photos/400/250?random=24&keyword=diplomatic",
      "priority": "urgent",
      "isLive": false,
      "views": 22150,
      "category": "Politics",
      "severity": "medium",
    },
    {
      "id": 5,
      "title": "ALERT: Cyber Attack Targets Major Infrastructure",
      "summary": "Government agencies investigating coordinated attack on power grid systems",
      "author": "Cybersecurity Reporter",
      "timestamp": "45 minutes ago",
      "location": "Multiple States",
      "image": "https://picsum.photos/400/250?random=25&keyword=cyber",
      "priority": "urgent",
      "isLive": false,
      "views": 18920,
      "category": "Technology",
      "severity": "medium",
    },
    {
      "id": 6,
      "title": "FLASH: Celebrity Scandal Rocks Entertainment Industry",
      "summary": "Major revelations surface in ongoing investigation",
      "author": "Entertainment Reporter",
      "timestamp": "1 hour ago",
      "location": "Hollywood",
      "image": "https://picsum.photos/400/250?random=26&keyword=celebrity",
      "priority": "normal",
      "isLive": false,
      "views": 15640,
      "category": "Entertainment",
      "severity": "low",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "LIVE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: spSm),
            Text("Breaking News"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshNews();
            },
          ),
          IconButton(
            icon: Icon(isLiveMode ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                isLiveMode = !isLiveMode;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildLiveIndicator(),
          Expanded(
            child: _buildBreakingNewsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveIndicator() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: isLiveMode ? dangerColor.withAlpha(20) : disabledColor.withAlpha(20),
        border: Border(
          bottom: BorderSide(
            color: isLiveMode ? dangerColor : disabledColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: isLiveMode ? dangerColor : disabledColor,
              shape: BoxShape.circle,
            ),
            child: isLiveMode
                ? Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
          SizedBox(width: spSm),
          Text(
            isLiveMode ? "LIVE UPDATES ENABLED" : "LIVE UPDATES PAUSED",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isLiveMode ? dangerColor : disabledBoldColor,
            ),
          ),
          Spacer(),
          Text(
            "Last updated: ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}",
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakingNewsList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildCriticalAlerts(),
          _buildAllBreakingNews(),
        ],
      ),
    );
  }

  Widget _buildCriticalAlerts() {
    final criticalNews = breakingNews.where((news) => news["priority"] == "critical").toList();
    
    if (criticalNews.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Row(
          children: [
            Icon(
              Icons.emergency,
              color: dangerColor,
              size: 20,
            ),
            SizedBox(width: spSm),
            Text(
              "Critical Alerts",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: dangerColor,
              ),
            ),
          ],
        ),
        ...criticalNews.map((news) {
          return Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: dangerColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusMd),
              border: Border.all(
                color: dangerColor,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    if (news["isLive"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "LIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Spacer(),
                    Text(
                      "${news["timestamp"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${news["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dangerColor,
                  ),
                ),
                Text(
                  "${news["summary"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: primaryColor,
                    height: 1.4,
                  ),
                ),
                if (news["image"] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "${news["image"]}",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: dangerColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${news["location"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: dangerColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.visibility,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${((news["views"] as int) / 1000).toStringAsFixed(1)}K views",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Read Full Coverage",
                    size: bs.md,
                    onPressed: () {
                      // navigateTo(NmaArticleDetailView(articleId: news["id"]));
                    },
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildAllBreakingNews() {
    final otherNews = breakingNews.where((news) => news["priority"] != "critical").toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Other Breaking News",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...otherNews.map((news) {
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
              border: Border.all(
                color: _getPriorityColor(news["priority"]).withAlpha(30),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getPriorityColor(news["priority"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${news["priority"]}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          color: _getPriorityColor(news["priority"]),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: spSm),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spSm,
                        vertical: spXs,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(news["category"]).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Text(
                        "${news["category"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: _getCategoryColor(news["category"]),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    if (news["isLive"] as bool)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: dangerColor,
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Text(
                          "LIVE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (news["image"] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${news["image"]}",
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    if (news["image"] != null) SizedBox(width: spSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Text(
                            "${news["title"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${news["summary"]}",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${news["location"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      " • ",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "${news["author"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${news["timestamp"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: _getPriorityColor(news["priority"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 14,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${((news["views"] as int) / 1000).toStringAsFixed(1)}K views",
                      style: TextStyle(
                        fontSize: 11,
                        color: disabledBoldColor,
                      ),
                    ),
                    Spacer(),
                    QButton(
                      label: "Read More",
                      size: bs.sm,
                      onPressed: () {
                        // navigateTo(NmaArticleDetailView(articleId: news["id"]));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case "critical":
        return dangerColor;
      case "urgent":
        return warningColor;
      default:
        return successColor;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Emergency":
        return dangerColor;
      case "Finance":
        return infoColor;
      case "Natural Disaster":
        return warningColor;
      case "Politics":
        return primaryColor;
      case "Technology":
        return secondaryColor;
      case "Entertainment":
        return successColor;
      default:
        return disabledBoldColor;
    }
  }

  void _refreshNews() {
    // Simulate news refresh
    setState(() {
      // In a real app, this would fetch new data
    });
    
    ss("Breaking news updated");
  }
}
