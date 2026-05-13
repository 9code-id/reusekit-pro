import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsKeywordRankingView extends StatefulWidget {
  const DmsKeywordRankingView({super.key});

  @override
  State<DmsKeywordRankingView> createState() => _DmsKeywordRankingViewState();
}

class _DmsKeywordRankingViewState extends State<DmsKeywordRankingView> {
  String selectedLocation = "united_states";
  String selectedDevice = "desktop";
  String selectedPeriod = "last_30_days";
  int selectedRankingFilter = 0;

  List<Map<String, dynamic>> locationOptions = [
    {"label": "United States", "value": "united_states"},
    {"label": "United Kingdom", "value": "united_kingdom"},
    {"label": "Canada", "value": "canada"},
    {"label": "Australia", "value": "australia"},
    {"label": "Germany", "value": "germany"},
  ];

  List<Map<String, dynamic>> deviceOptions = [
    {"label": "Desktop", "value": "desktop"},
    {"label": "Mobile", "value": "mobile"},
    {"label": "Tablet", "value": "tablet"},
  ];

  List<Map<String, dynamic>> periodOptions = [
    {"label": "Last 7 Days", "value": "last_7_days"},
    {"label": "Last 30 Days", "value": "last_30_days"},
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last Year", "value": "last_year"},
  ];

  List<Map<String, dynamic>> rankingData = [
    {
      "keyword": "best digital marketing agency",
      "current_rank": 1,
      "previous_rank": 2,
      "best_rank": 1,
      "worst_rank": 5,
      "url": "/",
      "search_volume": 5400,
      "traffic_value": 1200,
      "visibility": 85.4,
      "history": [3, 2, 2, 1, 1, 1, 1],
      "change": 1,
    },
    {
      "keyword": "seo optimization services",
      "current_rank": 3,
      "previous_rank": 4,
      "best_rank": 2,
      "worst_rank": 8,
      "url": "/services/seo",
      "search_volume": 8900,
      "traffic_value": 2100,
      "visibility": 72.8,
      "history": [6, 5, 4, 4, 3, 3, 3],
      "change": 1,
    },
    {
      "keyword": "content marketing strategy",
      "current_rank": 7,
      "previous_rank": 6,
      "best_rank": 4,
      "worst_rank": 12,
      "url": "/blog/content-strategy",
      "search_volume": 3200,
      "traffic_value": 680,
      "visibility": 58.2,
      "history": [8, 7, 6, 6, 7, 7, 7],
      "change": -1,
    },
    {
      "keyword": "social media marketing",
      "current_rank": 5,
      "previous_rank": 5,
      "best_rank": 3,
      "worst_rank": 9,
      "url": "/services/social-media",
      "search_volume": 6700,
      "traffic_value": 1450,
      "visibility": 65.1,
      "history": [7, 6, 5, 5, 5, 5, 5],
      "change": 0,
    },
    {
      "keyword": "ppc management services",
      "current_rank": 9,
      "previous_rank": 11,
      "best_rank": 6,
      "worst_rank": 15,
      "url": "/services/ppc",
      "search_volume": 4100,
      "traffic_value": 920,
      "visibility": 42.3,
      "history": [13, 12, 11, 11, 10, 9, 9],
      "change": 2,
    },
    {
      "keyword": "email marketing automation",
      "current_rank": 4,
      "previous_rank": 3,
      "best_rank": 2,
      "worst_rank": 7,
      "url": "/services/email-marketing",
      "search_volume": 2800,
      "traffic_value": 760,
      "visibility": 68.9,
      "history": [5, 4, 3, 3, 4, 4, 4],
      "change": -1,
    },
  ];

  List<Map<String, dynamic>> get filteredRankings {
    List<Map<String, dynamic>> filtered = rankingData;

    switch (selectedRankingFilter) {
      case 1: // Top 10
        filtered = filtered.where((item) => (item["current_rank"] as int) <= 10).toList();
        break;
      case 2: // Improved
        filtered = filtered.where((item) => (item["change"] as int) > 0).toList();
        break;
      case 3: // Declined
        filtered = filtered.where((item) => (item["change"] as int) < 0).toList();
        break;
    }

    filtered.sort((a, b) => (a["current_rank"] as int).compareTo(b["current_rank"] as int));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Keyword Ranking"),
        actions: [
          IconButton(
            icon: Icon(Icons.analytics),
            onPressed: () {
              // Analytics view
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export ranking data
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Controls
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Location",
                    items: locationOptions,
                    value: selectedLocation,
                    onChanged: (value, label) {
                      selectedLocation = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Device",
                    items: deviceOptions,
                    value: selectedDevice,
                    onChanged: (value, label) {
                      selectedDevice = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Time Period",
              items: periodOptions,
              value: selectedPeriod,
              onChanged: (value, label) {
                selectedPeriod = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Ranking Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Rankings", "value": 0},
                {"label": "Top 10", "value": 1},
                {"label": "Improved", "value": 2},
                {"label": "Declined", "value": 3},
              ],
              value: selectedRankingFilter,
              onChanged: (index, label, value, item) {
                selectedRankingFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Summary Statistics
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
                          "Avg Rank",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${(rankingData.map((r) => r["current_rank"] as int).reduce((a, b) => a + b) / rankingData.length).toStringAsFixed(1)}",
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
                          "Top 10",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${rankingData.where((r) => (r["current_rank"] as int) <= 10).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
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
                          "Improved",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "${rankingData.where((r) => (r["change"] as int) > 0).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Rankings List
            Text(
              "Keyword Rankings",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredRankings.map((ranking) {
              Color changeColor = (ranking["change"] as int) > 0 
                  ? successColor 
                  : (ranking["change"] as int) < 0 
                      ? dangerColor 
                      : disabledBoldColor;

              IconData changeIcon = (ranking["change"] as int) > 0 
                  ? Icons.arrow_upward 
                  : (ranking["change"] as int) < 0 
                      ? Icons.arrow_downward 
                      : Icons.remove;

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
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "#${ranking["current_rank"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${ranking["keyword"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Text(
                                "${ranking["url"]}",
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
                            color: changeColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                changeIcon,
                                size: 14,
                                color: changeColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(ranking["change"] as int).abs()}",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: changeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spSm),

                    // Ranking trend chart simulation
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          ...(ranking["history"] as List).asMap().entries.map((entry) {
                            int index = entry.key;
                            int rank = entry.value;
                            double height = (15 - rank) * 3.0; // Invert for visual representation
                            
                            return Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: height.clamp(5.0, 45.0),
                                      decoration: BoxDecoration(
                                        color: index == (ranking["history"] as List).length - 1 
                                            ? primaryColor 
                                            : primaryColor.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "$rank",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
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
                                "Volume",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((ranking["search_volume"] as int) / 1000).toStringAsFixed(1)}K",
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
                                "Traffic Value",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${((ranking["traffic_value"] as int).toDouble()).currency}",
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
                                "Visibility",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(ranking["visibility"] as double).toStringAsFixed(1)}%",
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
                                "Best/Worst",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "#${ranking["best_rank"]}/#${ranking["worst_rank"]}",
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
