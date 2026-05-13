import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsKeywordTrackingView extends StatefulWidget {
  const DmsKeywordTrackingView({super.key});

  @override
  State<DmsKeywordTrackingView> createState() => _DmsKeywordTrackingViewState();
}

class _DmsKeywordTrackingViewState extends State<DmsKeywordTrackingView> {
  int selectedFilter = 0;
  String searchQuery = "";
  String selectedTimeframe = "last_30_days";
  String selectedKeywordType = "all";

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
  ];

  List<Map<String, dynamic>> keywordTypeOptions = [
    {"label": "All Keywords", "value": "all"},
    {"label": "Branded", "value": "branded"},
    {"label": "Non-Branded", "value": "non_branded"},
    {"label": "Local", "value": "local"},
  ];

  List<Map<String, dynamic>> keywordData = [
    {
      "keyword": "digital marketing agency",
      "current_position": 3,
      "previous_position": 5,
      "search_volume": 8100,
      "difficulty": 68,
      "cpc": 12.50,
      "url": "/services/digital-marketing",
      "trend": "up",
      "change": 2,
      "clicks": 245,
      "impressions": 3200,
      "ctr": 7.66,
    },
    {
      "keyword": "seo services",
      "current_position": 7,
      "previous_position": 6,
      "search_volume": 12000,
      "difficulty": 72,
      "cpc": 15.30,
      "url": "/services/seo",
      "trend": "down",
      "change": -1,
      "clicks": 180,
      "impressions": 2800,
      "ctr": 6.43,
    },
    {
      "keyword": "content marketing strategy",
      "current_position": 15,
      "previous_position": 18,
      "search_volume": 3600,
      "difficulty": 55,
      "cpc": 8.90,
      "url": "/blog/content-marketing",
      "trend": "up",
      "change": 3,
      "clicks": 95,
      "impressions": 1200,
      "ctr": 7.92,
    },
    {
      "keyword": "social media management",
      "current_position": 12,
      "previous_position": 12,
      "search_volume": 5400,
      "difficulty": 61,
      "cpc": 11.20,
      "url": "/services/social-media",
      "trend": "stable",
      "change": 0,
      "clicks": 125,
      "impressions": 1800,
      "ctr": 6.94,
    },
    {
      "keyword": "ppc advertising",
      "current_position": 8,
      "previous_position": 10,
      "search_volume": 4200,
      "difficulty": 64,
      "cpc": 18.75,
      "url": "/services/ppc",
      "trend": "up",
      "change": 2,
      "clicks": 150,
      "impressions": 2100,
      "ctr": 7.14,
    },
    {
      "keyword": "email marketing automation",
      "current_position": 4,
      "previous_position": 3,
      "search_volume": 2800,
      "difficulty": 52,
      "cpc": 9.40,
      "url": "/services/email-marketing",
      "trend": "down",
      "change": -1,
      "clicks": 210,
      "impressions": 1600,
      "ctr": 13.13,
    },
  ];

  List<Map<String, dynamic>> get filteredKeywords {
    List<Map<String, dynamic>> filtered = keywordData;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((keyword) =>
          (keyword["keyword"] as String)
              .toLowerCase()
              .contains(searchQuery.toLowerCase())).toList();
    }

    switch (selectedFilter) {
      case 1: // Top Performing
        filtered.sort((a, b) => (a["current_position"] as int).compareTo(b["current_position"] as int));
        break;
      case 2: // Declining
        filtered = filtered.where((keyword) => keyword["trend"] == "down").toList();
        break;
      case 3: // Improving
        filtered = filtered.where((keyword) => keyword["trend"] == "up").toList();
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keyword Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Refresh data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search Keywords",
                    value: searchQuery,
                    hint: "Enter keyword to search...",
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.search,
                  size: bs.sm,
                  onPressed: () {
                    // Search functionality
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filter Options
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Timeframe",
                    items: timeframeOptions,
                    value: selectedTimeframe,
                    onChanged: (value, label) {
                      selectedTimeframe = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Keyword Type",
                    items: keywordTypeOptions,
                    value: selectedKeywordType,
                    onChanged: (value, label) {
                      selectedKeywordType = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Keywords", "value": 0},
                {"label": "Top Performing", "value": 1},
                {"label": "Declining", "value": 2},
                {"label": "Improving", "value": 3},
              ],
              value: selectedFilter,
              onChanged: (index, label, value, item) {
                selectedFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Summary Cards
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          "Total Keywords",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${keywordData.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Avg Position",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(keywordData.map((k) => k["current_position"] as int).reduce((a, b) => a + b) / keywordData.length).toStringAsFixed(1)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
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
                      borderRadius: BorderRadius.circular(radiusMd),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Clicks",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${keywordData.map((k) => k["clicks"] as int).reduce((a, b) => a + b)}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Keywords List
            Text(
              "Keyword Performance",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredKeywords.map((keyword) {
              Color trendColor = keyword["trend"] == "up" 
                  ? successColor 
                  : keyword["trend"] == "down" 
                      ? dangerColor 
                      : disabledBoldColor;

              IconData trendIcon = keyword["trend"] == "up" 
                  ? Icons.trending_up 
                  : keyword["trend"] == "down" 
                      ? Icons.trending_down 
                      : Icons.trending_flat;

              return Container(
                margin: EdgeInsets.only(bottom: spSm),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${keyword["keyword"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${keyword["url"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: trendColor.withAlpha(30),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                trendIcon,
                                size: 16,
                                color: trendColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                keyword["change"] != 0 
                                    ? "${keyword["change"] > 0 ? "+" : ""}${keyword["change"]}"
                                    : "0",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: trendColor,
                                ),
                              ),
                            ],
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
                                "Position",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "#${keyword["current_position"]}",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Volume",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((keyword["search_volume"] as int) / 1000).toStringAsFixed(1)}K",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "Difficulty",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${keyword["difficulty"]}%",
                                style: TextStyle(
                                  fontSize: 14,
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
                                "CTR",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(keyword["ctr"] as double).toStringAsFixed(2)}%",
                                style: TextStyle(
                                  fontSize: 14,
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
    );
  }
}
