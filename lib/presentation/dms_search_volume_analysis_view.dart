import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsSearchVolumeAnalysisView extends StatefulWidget {
  const DmsSearchVolumeAnalysisView({super.key});

  @override
  State<DmsSearchVolumeAnalysisView> createState() => _DmsSearchVolumeAnalysisViewState();
}

class _DmsSearchVolumeAnalysisViewState extends State<DmsSearchVolumeAnalysisView> {
  String selectedLocation = "united_states";
  String selectedLanguage = "english";
  String selectedTimeframe = "last_12_months";
  String searchKeyword = "";
  int selectedVolumeFilter = 0;

  List<Map<String, dynamic>> locationOptions = [
    {"label": "United States", "value": "united_states"},
    {"label": "United Kingdom", "value": "united_kingdom"},
    {"label": "Canada", "value": "canada"},
    {"label": "Australia", "value": "australia"},
    {"label": "Germany", "value": "germany"},
    {"label": "France", "value": "france"},
  ];

  List<Map<String, dynamic>> languageOptions = [
    {"label": "English", "value": "english"},
    {"label": "Spanish", "value": "spanish"},
    {"label": "French", "value": "french"},
    {"label": "German", "value": "german"},
    {"label": "Italian", "value": "italian"},
  ];

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 3 Months", "value": "last_3_months"},
    {"label": "Last 6 Months", "value": "last_6_months"},
    {"label": "Last 12 Months", "value": "last_12_months"},
    {"label": "Last 2 Years", "value": "last_2_years"},
  ];

  List<Map<String, dynamic>> volumeData = [
    {
      "keyword": "digital marketing",
      "monthly_volume": 165000,
      "volume_trend": "up",
      "trend_change": 12.5,
      "competition": "high",
      "cpc": 8.45,
      "seasonal_trend": [120000, 135000, 145000, 165000, 175000, 180000, 165000, 155000, 160000, 170000, 175000, 165000],
      "related_keywords": ["online marketing", "internet marketing", "digital advertising"],
      "difficulty": 78,
      "opportunity_score": 65,
    },
    {
      "keyword": "seo services",
      "monthly_volume": 89000,
      "volume_trend": "stable",
      "trend_change": 2.1,
      "competition": "high",
      "cpc": 12.80,
      "seasonal_trend": [85000, 87000, 89000, 91000, 88000, 89000, 90000, 89000, 88000, 89000, 91000, 89000],
      "related_keywords": ["search engine optimization", "seo agency", "seo company"],
      "difficulty": 82,
      "opportunity_score": 58,
    },
    {
      "keyword": "content marketing",
      "monthly_volume": 74000,
      "volume_trend": "up",
      "trend_change": 18.7,
      "competition": "medium",
      "cpc": 6.90,
      "seasonal_trend": [60000, 65000, 68000, 72000, 74000, 76000, 75000, 73000, 74000, 76000, 78000, 74000],
      "related_keywords": ["content strategy", "content creation", "blog marketing"],
      "difficulty": 65,
      "opportunity_score": 72,
    },
    {
      "keyword": "social media marketing",
      "monthly_volume": 135000,
      "volume_trend": "up",
      "trend_change": 15.2,
      "competition": "medium",
      "cpc": 4.25,
      "seasonal_trend": [115000, 120000, 125000, 130000, 135000, 140000, 138000, 132000, 135000, 138000, 142000, 135000],
      "related_keywords": ["social media management", "social media strategy", "social media advertising"],
      "difficulty": 58,
      "opportunity_score": 78,
    },
    {
      "keyword": "email marketing",
      "monthly_volume": 67000,
      "volume_trend": "stable",
      "trend_change": -1.5,
      "competition": "medium",
      "cpc": 7.65,
      "seasonal_trend": [68000, 67000, 66000, 67000, 68000, 67000, 66000, 67000, 68000, 67000, 68000, 67000],
      "related_keywords": ["email automation", "email campaigns", "newsletter marketing"],
      "difficulty": 52,
      "opportunity_score": 69,
    },
    {
      "keyword": "ppc advertising",
      "monthly_volume": 45000,
      "volume_trend": "down",
      "trend_change": -8.3,
      "competition": "high",
      "cpc": 15.20,
      "seasonal_trend": [50000, 48000, 47000, 45000, 44000, 43000, 44000, 45000, 46000, 45000, 44000, 45000],
      "related_keywords": ["pay per click", "google ads", "paid search"],
      "difficulty": 75,
      "opportunity_score": 45,
    },
  ];

  List<Map<String, dynamic>> get filteredVolumeData {
    List<Map<String, dynamic>> filtered = volumeData;

    if (searchKeyword.isNotEmpty) {
      filtered = filtered.where((item) =>
          (item["keyword"] as String)
              .toLowerCase()
              .contains(searchKeyword.toLowerCase())).toList();
    }

    switch (selectedVolumeFilter) {
      case 1: // High Volume
        filtered = filtered.where((item) => (item["monthly_volume"] as int) > 100000).toList();
        break;
      case 2: // Growing
        filtered = filtered.where((item) => item["volume_trend"] == "up").toList();
        break;
      case 3: // High Opportunity
        filtered = filtered.where((item) => (item["opportunity_score"] as int) > 70).toList();
        break;
    }

    filtered.sort((a, b) => (b["monthly_volume"] as int).compareTo(a["monthly_volume"] as int));
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Volume Analysis"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Advanced search
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              // Export volume data
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
                    value: searchKeyword,
                    hint: "Enter keyword to analyze...",
                    onChanged: (value) {
                      searchKeyword = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.analytics,
                  size: bs.sm,
                  onPressed: () {
                    // Analyze keyword
                  },
                ),
              ],
            ),
            SizedBox(height: spSm),

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
                    label: "Language",
                    items: languageOptions,
                    value: selectedLanguage,
                    onChanged: (value, label) {
                      selectedLanguage = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spSm),

            QDropdownField(
              label: "Timeframe",
              items: timeframeOptions,
              value: selectedTimeframe,
              onChanged: (value, label) {
                selectedTimeframe = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Volume Filter Tabs
            QCategoryPicker(
              items: [
                {"label": "All Keywords", "value": 0},
                {"label": "High Volume", "value": 1},
                {"label": "Growing", "value": 2},
                {"label": "High Opportunity", "value": 3},
              ],
              value: selectedVolumeFilter,
              onChanged: (index, label, value, item) {
                selectedVolumeFilter = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),

            // Volume Summary
            Container(
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
                    "Volume Summary",
                    style: TextStyle(
                      fontSize: fsH6,
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
                              "Total Volume",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${((volumeData.map((v) => v["monthly_volume"] as int).reduce((a, b) => a + b)) / 1000).toStringAsFixed(0)}K",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "Avg Volume",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${((volumeData.map((v) => v["monthly_volume"] as int).reduce((a, b) => a + b) / volumeData.length) / 1000).toStringAsFixed(1)}K",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "Growing",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${volumeData.where((v) => v["volume_trend"] == "up").length}",
                              style: TextStyle(
                                fontSize: fsH4,
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
                              "High Opp.",
                              style: TextStyle(
                                fontSize: 12,
                                color: disabledBoldColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${volumeData.where((v) => (v["opportunity_score"] as int) > 70).length}",
                              style: TextStyle(
                                fontSize: fsH4,
                                fontWeight: FontWeight.bold,
                                color: warningColor,
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
            SizedBox(height: spMd),

            // Volume Analysis List
            Text(
              "Keyword Volume Analysis",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredVolumeData.map((volume) {
              Color trendColor = volume["volume_trend"] == "up" 
                  ? successColor 
                  : volume["volume_trend"] == "down" 
                      ? dangerColor 
                      : disabledBoldColor;

              IconData trendIcon = volume["volume_trend"] == "up" 
                  ? Icons.trending_up 
                  : volume["volume_trend"] == "down" 
                      ? Icons.trending_down 
                      : Icons.trending_flat;

              Color competitionColor = volume["competition"] == "high" 
                  ? dangerColor 
                  : volume["competition"] == "medium" 
                      ? warningColor 
                      : successColor;

              Color opportunityColor = (volume["opportunity_score"] as int) > 70 
                  ? successColor 
                  : (volume["opportunity_score"] as int) > 50 
                      ? warningColor 
                      : dangerColor;

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
                                "${volume["keyword"]}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: competitionColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${volume["competition"]} competition",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: competitionColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                    decoration: BoxDecoration(
                                      color: opportunityColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${volume["opportunity_score"]}% opportunity",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: opportunityColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: trendColor.withAlpha(20),
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
                                "${volume["trend_change"] > 0 ? "+" : ""}${(volume["trend_change"] as double).toStringAsFixed(1)}%",
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

                    // Volume Metrics
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Monthly Volume",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${((volume["monthly_volume"] as int) / 1000).toStringAsFixed(1)}K",
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
                                "CPC",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "\$${(volume["cpc"] as double).toStringAsFixed(2)}",
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
                                "${volume["difficulty"]}%",
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
                                "Est. Traffic",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: disabledBoldColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${(((volume["monthly_volume"] as int) * 0.02)).toStringAsFixed(0)}",
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
                    SizedBox(height: spSm),

                    // Seasonal Trend Chart
                    Container(
                      height: 60,
                      child: Row(
                        children: [
                          ...(volume["seasonal_trend"] as List).asMap().entries.map((entry) {
                            int index = entry.key;
                            int volumeValue = entry.value;
                            double maxVolume = (volume["seasonal_trend"] as List).reduce((a, b) => a > b ? a : b).toDouble();
                            double height = (volumeValue / maxVolume) * 45;
                            
                            return Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: height.clamp(8.0, 45.0),
                                      decoration: BoxDecoration(
                                        color: index == (volume["seasonal_trend"] as List).length - 1 
                                            ? primaryColor 
                                            : primaryColor.withAlpha(100),
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                    ),
                                    SizedBox(height: spXs),
                                    Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        fontSize: 9,
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

                    // Related Keywords
                    Text(
                      "Related Keywords:",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (volume["related_keywords"] as List).map((keyword) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "$keyword",
                            style: TextStyle(
                              fontSize: 11,
                              color: primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
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
