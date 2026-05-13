import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaTrendingTopicsView extends StatefulWidget {
  const NmaTrendingTopicsView({super.key});

  @override
  State<NmaTrendingTopicsView> createState() => _NmaTrendingTopicsViewState();
}

class _NmaTrendingTopicsViewState extends State<NmaTrendingTopicsView> {
  String selectedTimeframe = "24h";
  String selectedCategory = "all";
  int selectedSortBy = 0;
  bool showEngagement = true;
  bool showTrendDirection = true;

  List<Map<String, dynamic>> timeframeOptions = [
    {"label": "Last 24 Hours", "value": "24h"},
    {"label": "Last 7 Days", "value": "7d"},
    {"label": "Last 30 Days", "value": "30d"},
    {"label": "This Week", "value": "week"},
    {"label": "This Month", "value": "month"},
  ];

  List<Map<String, dynamic>> categoryOptions = [
    {"label": "All Categories", "value": "all"},
    {"label": "Technology", "value": "technology"},
    {"label": "Business", "value": "business"},
    {"label": "Politics", "value": "politics"},
    {"label": "Sports", "value": "sports"},
    {"label": "Entertainment", "value": "entertainment"},
    {"label": "Science", "value": "science"},
    {"label": "Health", "value": "health"},
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {
      "title": "Artificial Intelligence Revolution",
      "category": "Technology",
      "trend_score": 95,
      "engagement": 125000,
      "articles": 1250,
      "trend_direction": "up",
      "trend_change": 45,
      "peak_time": "2 hours ago",
      "related_keywords": ["AI", "Machine Learning", "Innovation", "Future Tech"],
      "top_sources": ["TechCrunch", "MIT Technology Review", "Wired"],
      "sentiment": "positive",
      "geography": ["Global", "US", "Europe", "Asia"],
    },
    {
      "title": "Climate Change Summit",
      "category": "Politics",
      "trend_score": 89,
      "engagement": 98000,
      "articles": 890,
      "trend_direction": "up",
      "trend_change": 32,
      "peak_time": "4 hours ago",
      "related_keywords": ["Environment", "Policy", "Green Energy", "Sustainability"],
      "top_sources": ["BBC", "Reuters", "CNN"],
      "sentiment": "neutral",
      "geography": ["Global", "Europe", "North America"],
    },
    {
      "title": "Cryptocurrency Market Update",
      "category": "Business",
      "trend_score": 78,
      "engagement": 76000,
      "articles": 650,
      "trend_direction": "down",
      "trend_change": -12,
      "peak_time": "1 hour ago",
      "related_keywords": ["Bitcoin", "Ethereum", "Trading", "Investment"],
      "top_sources": ["CoinDesk", "Bloomberg", "Financial Times"],
      "sentiment": "mixed",
      "geography": ["Global", "US", "Asia"],
    },
    {
      "title": "Space Exploration Breakthrough",
      "category": "Science",
      "trend_score": 72,
      "engagement": 54000,
      "articles": 420,
      "trend_direction": "up",
      "trend_change": 28,
      "peak_time": "6 hours ago",
      "related_keywords": ["NASA", "SpaceX", "Mars", "Discovery"],
      "top_sources": ["NASA News", "Space.com", "Scientific American"],
      "sentiment": "positive",
      "geography": ["Global", "US", "Europe"],
    },
    {
      "title": "World Cup Championship",
      "category": "Sports",
      "trend_score": 68,
      "engagement": 89000,
      "articles": 750,
      "trend_direction": "stable",
      "trend_change": 5,
      "peak_time": "3 hours ago",
      "related_keywords": ["Football", "Tournament", "Champions", "Victory"],
      "top_sources": ["ESPN", "BBC Sport", "Sky Sports"],
      "sentiment": "positive",
      "geography": ["Global", "Europe", "South America"],
    },
    {
      "title": "Healthcare Innovation",
      "category": "Health",
      "trend_score": 65,
      "engagement": 42000,
      "articles": 380,
      "trend_direction": "up",
      "trend_change": 18,
      "peak_time": "5 hours ago",
      "related_keywords": ["Medicine", "Treatment", "Research", "Breakthrough"],
      "top_sources": ["Medical News Today", "Harvard Health", "Mayo Clinic"],
      "sentiment": "positive",
      "geography": ["Global", "US", "Europe"],
    },
  ];

  List<Map<String, dynamic>> get filteredTopics {
    var filtered = trendingTopics.where((topic) {
      if (selectedCategory != "all") {
        return (topic["category"] as String).toLowerCase() == selectedCategory;
      }
      return true;
    }).toList();

    // Sort based on selected criteria
    switch (selectedSortBy) {
      case 0: // Trend Score
        filtered.sort((a, b) => (b["trend_score"] as int).compareTo(a["trend_score"] as int));
        break;
      case 1: // Engagement
        filtered.sort((a, b) => (b["engagement"] as int).compareTo(a["engagement"] as int));
        break;
      case 2: // Articles Count
        filtered.sort((a, b) => (b["articles"] as int).compareTo(a["articles"] as int));
        break;
      case 3: // Trend Change
        filtered.sort((a, b) => (b["trend_change"] as int).compareTo(a["trend_change"] as int));
        break;
    }

    return filtered;
  }

  Color _getTrendColor(String direction) {
    switch (direction) {
      case "up":
        return successColor;
      case "down":
        return dangerColor;
      default:
        return warningColor;
    }
  }

  IconData _getTrendIcon(String direction) {
    switch (direction) {
      case "up":
        return Icons.trending_up;
      case "down":
        return Icons.trending_down;
      default:
        return Icons.trending_flat;
    }
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case "positive":
        return successColor;
      case "negative":
        return dangerColor;
      default:
        return warningColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Topics"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ss("Trending topics refreshed");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _showSettingsBottomSheet();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusMd),
                border: Border.all(color: primaryColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Live Trending",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Real-time topic analysis",
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
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: Colors.white,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "LIVE",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Filters
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
                    label: "Category",
                    items: categoryOptions,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Sort Options
            QCategoryPicker(
              label: "Sort By",
              items: [
                {"label": "Trend Score", "value": 0},
                {"label": "Engagement", "value": 1},
                {"label": "Articles", "value": 2},
                {"label": "Change", "value": 3},
              ],
              value: selectedSortBy,
              onChanged: (index, label, value, item) {
                selectedSortBy = value;
                setState(() {});
              },
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
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${filteredTopics.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Topics",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${(filteredTopics.fold(0, (sum, topic) => sum + (topic["engagement"] as int)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Engagement",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
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
                      border: Border.all(color: disabledOutlineBorderColor),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${(filteredTopics.fold(0, (sum, topic) => sum + (topic["articles"] as int)) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                        Text(
                          "Articles",
                          style: TextStyle(
                            fontSize: 12,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Trending Topics List
            Text(
              "Trending Now",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),

            ...filteredTopics.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> topic = entry.value;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      children: [
                        // Rank
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: index < 3 ? primaryColor : disabledColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: spSm),
                        
                        // Title and Category
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${topic["title"]}",
                                style: TextStyle(
                                  fontSize: fsH6,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${topic["category"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getSentimentColor(topic["sentiment"]).withAlpha(20),
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${topic["sentiment"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _getSentimentColor(topic["sentiment"]),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Trend Indicator
                        if (showTrendDirection)
                          Column(
                            children: [
                              Icon(
                                _getTrendIcon(topic["trend_direction"]),
                                color: _getTrendColor(topic["trend_direction"]),
                                size: 20,
                              ),
                              Text(
                                "${(topic["trend_change"] as int) >= 0 ? '+' : ''}${topic["trend_change"]}%",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: _getTrendColor(topic["trend_direction"]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Stats Row
                    if (showEngagement)
                      Row(
                        children: [
                          // Trend Score
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.whatshot,
                                  size: 16,
                                  color: warningColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${topic["trend_score"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: warningColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Engagement
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  size: 16,
                                  color: dangerColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${((topic["engagement"] as int) / 1000).toInt()}K",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Articles
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.article,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${topic["articles"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Peak Time
                          Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${topic["peak_time"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    SizedBox(height: spSm),

                    // Keywords
                    Text(
                      "Keywords:",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Wrap(
                      spacing: spXs,
                      runSpacing: spXs,
                      children: (topic["related_keywords"] as List).map((keyword) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: secondaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                            border: Border.all(color: secondaryColor.withAlpha(50)),
                          ),
                          child: Text(
                            "#$keyword",
                            style: TextStyle(
                              fontSize: 10,
                              color: secondaryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: spSm),

                    // Top Sources
                    Row(
                      children: [
                        Text(
                          "Top Sources: ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: disabledBoldColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (topic["top_sources"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Geography
                    Row(
                      children: [
                        Icon(
                          Icons.public,
                          size: 16,
                          color: disabledBoldColor,
                        ),
                        SizedBox(width: spXs),
                        Expanded(
                          child: Text(
                            (topic["geography"] as List).join(", "),
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: spSm),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: QButton(
                            label: "View Articles",
                            size: bs.sm,
                            onPressed: () {
                              ss("Viewing articles for ${topic["title"]}");
                            },
                          ),
                        ),
                        SizedBox(width: spSm),
                        QButton(
                          icon: Icons.bookmark_border,
                          size: bs.sm,
                          onPressed: () {
                            ss("Topic bookmarked");
                          },
                        ),
                        SizedBox(width: spXs),
                        QButton(
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            ss("Topic shared");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),

            SizedBox(height: spMd),

            // Load More
            Center(
              child: QButton(
                label: "Load More Topics",
                size: bs.md,
                onPressed: () {
                  ss("Loading more trending topics...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusLg),
            topRight: Radius.circular(radiusLg),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: disabledColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
              ),
            ),
            SizedBox(height: spMd),

            Text(
              "Display Settings",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spMd),

            // Show Engagement Toggle
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Show Engagement Stats",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Display engagement metrics for each topic",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: showEngagement,
                  onChanged: (value) {
                    showEngagement = value;
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Show Trend Direction Toggle
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Show Trend Direction",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Display trend arrows and percentage changes",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: showTrendDirection,
                  onChanged: (value) {
                    showTrendDirection = value;
                    setState(() {});
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            SizedBox(height: spMd),

            // Actions
            Row(
              children: [
                Expanded(
                  child: QButton(
                    label: "Export Data",
                    size: bs.md,
                    onPressed: () {
                      Navigator.pop(context);
                      ss("Trending topics data exported");
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QButton(
                    label: "Reset Filters",
                    size: bs.md,
                    onPressed: () {
                      selectedTimeframe = "24h";
                      selectedCategory = "all";
                      selectedSortBy = 0;
                      setState(() {});
                      Navigator.pop(context);
                      ss("Filters reset");
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: spMd),
          ],
        ),
      ),
    );
  }
}
