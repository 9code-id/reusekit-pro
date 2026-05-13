import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class DmsHashtagResearchView extends StatefulWidget {
  const DmsHashtagResearchView({super.key});

  @override
  State<DmsHashtagResearchView> createState() => _DmsHashtagResearchViewState();
}

class _DmsHashtagResearchViewState extends State<DmsHashtagResearchView> {
  String searchQuery = "";
  String selectedCategory = "All";
  String selectedDifficulty = "All";
  bool isLoading = false;
  int currentTab = 0;

  List<Map<String, dynamic>> hashtagCategories = [
    {"label": "All", "value": "All"},
    {"label": "Business", "value": "business"},
    {"label": "Technology", "value": "tech"},
    {"label": "Fashion", "value": "fashion"},
    {"label": "Food", "value": "food"},
    {"label": "Travel", "value": "travel"},
    {"label": "Fitness", "value": "fitness"},
  ];

  List<Map<String, dynamic>> difficultyLevels = [
    {"label": "All", "value": "All"},
    {"label": "Easy", "value": "easy"},
    {"label": "Medium", "value": "medium"},
    {"label": "Hard", "value": "hard"},
  ];

  List<Map<String, dynamic>> trendingHashtags = [
    {
      "hashtag": "#digitalmarketing",
      "posts": 2345678,
      "engagement": 4.8,
      "difficulty": "medium",
      "category": "business",
      "trend": "up",
      "growth": 15.3
    },
    {
      "hashtag": "#contentcreator",
      "posts": 1876543,
      "engagement": 6.2,
      "difficulty": "hard",
      "category": "business",
      "trend": "up",
      "growth": 23.7
    },
    {
      "hashtag": "#smallbusiness",
      "posts": 3456789,
      "engagement": 3.9,
      "difficulty": "easy",
      "category": "business",
      "trend": "stable",
      "growth": 5.1
    },
    {
      "hashtag": "#entrepreneur",
      "posts": 4567890,
      "engagement": 5.4,
      "difficulty": "medium",
      "category": "business",
      "trend": "up",
      "growth": 18.9
    },
    {
      "hashtag": "#socialmedia",
      "posts": 6789012,
      "engagement": 4.1,
      "difficulty": "easy",
      "category": "tech",
      "trend": "down",
      "growth": -2.3
    },
  ];

  List<Map<String, dynamic>> savedHashtags = [
    {
      "hashtag": "#marketing",
      "posts": 1234567,
      "engagement": 5.2,
      "savedDate": DateTime.now().subtract(Duration(days: 2)),
    },
    {
      "hashtag": "#branding",
      "posts": 987654,
      "engagement": 4.7,
      "savedDate": DateTime.now().subtract(Duration(days: 5)),
    },
  ];

  List<Map<String, dynamic>> get filteredHashtags {
    return trendingHashtags.where((hashtag) {
      bool matchesSearch = hashtag["hashtag"].toString().toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesCategory = selectedCategory == "All" || hashtag["category"] == selectedCategory;
      bool matchesDifficulty = selectedDifficulty == "All" || hashtag["difficulty"] == selectedDifficulty;
      return matchesSearch && matchesCategory && matchesDifficulty;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Hashtag Research",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
        Tab(text: "Saved", icon: Icon(Icons.bookmark)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
      ],
      tabChildren: [
        _buildTrendingTab(),
        _buildSavedTab(),
        _buildAnalyticsTab(),
      ],
    );
  }

  Widget _buildTrendingTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchSection(),
          _buildFiltersSection(),
          _buildHashtagsList(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Search Hashtags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: QTextField(
                  label: "Enter hashtag or keyword",
                  value: searchQuery,
                  hint: "e.g., marketing, fashion, tech",
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
                  setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Category",
                  items: hashtagCategories,
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
                  label: "Difficulty",
                  items: difficultyLevels,
                  value: selectedDifficulty,
                  onChanged: (value, label) {
                    selectedDifficulty = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHashtagsList() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      spacing: spSm,
      children: filteredHashtags.map((hashtag) {
        return _buildHashtagCard(hashtag);
      }).toList(),
    );
  }

  Widget _buildHashtagCard(Map<String, dynamic> hashtag) {
    Color trendColor = hashtag["trend"] == "up" 
        ? successColor 
        : hashtag["trend"] == "down" 
            ? dangerColor 
            : infoColor;

    IconData trendIcon = hashtag["trend"] == "up" 
        ? Icons.trending_up 
        : hashtag["trend"] == "down" 
            ? Icons.trending_down 
            : Icons.trending_flat;

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${hashtag["hashtag"]}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "${((hashtag["posts"] as int) / 1000000).toStringAsFixed(1)}M posts",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(hashtag["difficulty"]),
                  borderRadius: BorderRadius.circular(radiusSm),
                ),
                child: Text(
                  "${hashtag["difficulty"]}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  "Engagement",
                  "${(hashtag["engagement"] as double).toStringAsFixed(1)}%",
                  Icons.favorite,
                ),
              ),
              Expanded(
                child: _buildMetricItem(
                  "Growth",
                  "${(hashtag["growth"] as double) >= 0 ? '+' : ''}${(hashtag["growth"] as double).toStringAsFixed(1)}%",
                  trendIcon,
                  color: trendColor,
                ),
              ),
              QButton(
                icon: Icons.bookmark_border,
                size: bs.sm,
                onPressed: () {
                  _saveHashtag(hashtag);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon, {Color? color}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: color ?? disabledBoldColor,
        ),
        SizedBox(width: spXs),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: disabledBoldColor,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color ?? primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSavedTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSavedHeader(),
          if (savedHashtags.isEmpty)
            _buildEmptyState()
          else
            ...savedHashtags.map((hashtag) => _buildSavedHashtagCard(hashtag)),
        ],
      ),
    );
  }

  Widget _buildSavedHeader() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Icon(
            Icons.bookmark,
            color: primaryColor,
            size: 24,
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Saved Hashtags",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${savedHashtags.length} hashtags saved",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            label: "Export",
            size: bs.sm,
            onPressed: () {
              _exportHashtags();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSavedHashtagCard(Map<String, dynamic> hashtag) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${hashtag["hashtag"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${((hashtag["posts"] as int) / 1000000).toStringAsFixed(1)}M posts • ${(hashtag["engagement"] as double).toStringAsFixed(1)}% engagement",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Saved ${(hashtag["savedDate"] as DateTime).dMMMy}",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledColor,
                  ),
                ),
              ],
            ),
          ),
          QButton(
            icon: Icons.delete,
            size: bs.sm,
            onPressed: () {
              _removeSavedHashtag(hashtag);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildAnalyticsOverview(),
          _buildTopPerformingHashtags(),
          _buildHashtagTrends(),
        ],
      ),
    );
  }

  Widget _buildAnalyticsOverview() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Analytics Overview",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  "Total Hashtags",
                  "1,234",
                  Icons.tag,
                  primaryColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Avg Engagement",
                  "4.8%",
                  Icons.favorite,
                  successColor,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildAnalyticsCard(
                  "Best Performing",
                  "#contentcreator",
                  Icons.trending_up,
                  warningColor,
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: _buildAnalyticsCard(
                  "Saved",
                  "${savedHashtags.length}",
                  Icons.bookmark,
                  infoColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: disabledBoldColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPerformingHashtags() {
    List<Map<String, dynamic>> topHashtags = List.from(trendingHashtags)
      ..sort((a, b) => (b["engagement"] as double).compareTo(a["engagement"] as double));

    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Top Performing Hashtags",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          ...topHashtags.take(3).map((hashtag) => _buildTopHashtagItem(hashtag)),
        ],
      ),
    );
  }

  Widget _buildTopHashtagItem(Map<String, dynamic> hashtag) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: primaryColor.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Icon(
              Icons.tag,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: spSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${hashtag["hashtag"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "${(hashtag["engagement"] as double).toStringAsFixed(1)}% engagement",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.star,
            color: warningColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildHashtagTrends() {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        spacing: spSm,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hashtag Trends",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(10),
              borderRadius: BorderRadius.circular(radiusSm),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.show_chart,
                    color: primaryColor,
                    size: 48,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Hashtag Trends Chart",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Visual representation of hashtag performance over time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(spLg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.bookmark_border,
              color: disabledBoldColor,
              size: 64,
            ),
            SizedBox(height: spMd),
            Text(
              "No Saved Hashtags",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: disabledBoldColor,
              ),
            ),
            SizedBox(height: spSm),
            Text(
              "Start by saving hashtags from the trending tab to build your collection.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: disabledColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "easy":
        return successColor;
      case "medium":
        return warningColor;
      case "hard":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  void _saveHashtag(Map<String, dynamic> hashtag) {
    if (!savedHashtags.any((saved) => saved["hashtag"] == hashtag["hashtag"])) {
      savedHashtags.add({
        "hashtag": hashtag["hashtag"],
        "posts": hashtag["posts"],
        "engagement": hashtag["engagement"],
        "savedDate": DateTime.now(),
      });
      setState(() {});
      ss("Hashtag saved successfully");
    } else {
      sw("Hashtag already saved");
    }
  }

  void _removeSavedHashtag(Map<String, dynamic> hashtag) {
    savedHashtags.removeWhere((saved) => saved["hashtag"] == hashtag["hashtag"]);
    setState(() {});
    ss("Hashtag removed from saved list");
  }

  void _exportHashtags() {
    if (savedHashtags.isEmpty) {
      sw("No hashtags to export");
      return;
    }
    ss("Hashtags exported successfully");
  }
}
