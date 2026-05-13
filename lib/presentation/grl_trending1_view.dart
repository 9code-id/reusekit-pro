import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlTrending1View extends StatefulWidget {
  @override
  State<GrlTrending1View> createState() => _GrlTrending1ViewState();
}

class _GrlTrending1ViewState extends State<GrlTrending1View> {
  String searchQuery = "";
  String selectedTimeframe = "Today";
  String selectedCategory = "All";
  
  List<String> timeframeOptions = ["Today", "This Week", "This Month", "All Time"];
  List<String> categoryOptions = ["All", "Technology", "Entertainment", "Sports", "Politics", "Science"];

  List<Map<String, dynamic>> trendingTopics = [
    {
      "rank": 1,
      "title": "Climate Change Summit 2024",
      "category": "Science",
      "mentions": 2450000,
      "growth": "+85%",
      "timeframe": "24h",
      "sentiment": "Positive",
      "relatedHashtags": ["#ClimateChange", "#COP29", "#Sustainability"],
      "keyInsight": "Global leaders announce new carbon reduction targets",
      "trendingLocations": ["Global", "Europe", "Asia"]
    },
    {
      "rank": 2,
      "title": "AI Revolution in Healthcare",
      "category": "Technology",
      "mentions": 1890000,
      "growth": "+67%",
      "timeframe": "24h",
      "sentiment": "Positive",
      "relatedHashtags": ["#AI", "#Healthcare", "#Innovation"],
      "keyInsight": "New AI diagnosis tool shows 95% accuracy rate",
      "trendingLocations": ["USA", "Canada", "UK"]
    },
    {
      "rank": 3,
      "title": "Space Mission Success",
      "category": "Science",
      "mentions": 1560000,
      "growth": "+92%",
      "timeframe": "24h",
      "sentiment": "Positive",
      "relatedHashtags": ["#Space", "#NASA", "#Mars"],
      "keyInsight": "Mars rover discovers potential signs of ancient life",
      "trendingLocations": ["Global", "USA", "International"]
    },
    {
      "rank": 4,
      "title": "Olympic Games Preparation",
      "category": "Sports",
      "mentions": 1340000,
      "growth": "+43%",
      "timeframe": "24h",
      "sentiment": "Neutral",
      "relatedHashtags": ["#Olympics", "#Paris2024", "#Sports"],
      "keyInsight": "Final preparations underway for summer games",
      "trendingLocations": ["France", "Global", "Europe"]
    },
    {
      "rank": 5,
      "title": "Tech Layoffs Continue",
      "category": "Technology",
      "mentions": 1120000,
      "growth": "+28%",
      "timeframe": "24h",
      "sentiment": "Negative",
      "relatedHashtags": ["#TechLayoffs", "#Employment", "#Economy"],
      "keyInsight": "Major tech companies announce workforce reductions",
      "trendingLocations": ["USA", "Silicon Valley", "Global"]
    }
  ];

  List<Map<String, dynamic>> emergingTrends = [
    {
      "title": "Quantum Computing Breakthrough",
      "growth": "+156%",
      "mentions": 450000,
      "category": "Technology",
      "isRising": true
    },
    {
      "title": "Electric Vehicle Adoption",
      "growth": "+89%",
      "mentions": 670000,
      "category": "Technology",
      "isRising": true
    },
    {
      "title": "Mental Health Awareness",
      "growth": "+72%",
      "mentions": 890000,
      "category": "Health",
      "isRising": true
    }
  ];

  List<Map<String, dynamic>> trendingHashtags = [
    {"tag": "#ClimateAction", "posts": "2.3M", "growth": "+85%"},
    {"tag": "#AI2024", "posts": "1.8M", "growth": "+67%"},
    {"tag": "#SpaceExploration", "posts": "1.5M", "growth": "+92%"},
    {"tag": "#Olympics2024", "posts": "1.3M", "growth": "+43%"},
    {"tag": "#TechNews", "posts": "1.1M", "growth": "+28%"}
  ];

  Color _getSentimentColor(String sentiment) {
    switch (sentiment.toLowerCase()) {
      case 'positive':
        return successColor;
      case 'negative':
        return dangerColor;
      case 'neutral':
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Topics"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spLg,
          children: [
            // Search and Filters
            Column(
              spacing: spSm,
              children: [
                QTextField(
                  label: "Search trending topics...",
                  value: searchQuery,
                  onChanged: (value) {
                    searchQuery = value;
                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Timeframe",
                        items: timeframeOptions.map((option) => {
                          "label": option,
                          "value": option,
                        }).toList(),
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
                        items: categoryOptions.map((option) => {
                          "label": option,
                          "value": option,
                        }).toList(),
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Trending Hashtags
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.tag,
                      color: primaryColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Trending Hashtags",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                QHorizontalScroll(
                  children: List.generate(trendingHashtags.length, (index) {
                    final hashtag = trendingHashtags[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: Border.all(
                          color: disabledOutlineBorderColor,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${hashtag["tag"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "${hashtag["growth"]}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${hashtag["posts"]} posts",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),

            // Emerging Trends
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: successColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Emerging Trends",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: List.generate(emergingTrends.length, (index) {
                    final trend = emergingTrends[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                        border: Border(
                          left: BorderSide(
                            width: 4,
                            color: successColor,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Icon(
                              Icons.trending_up,
                              color: successColor,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXs,
                              children: [
                                Text(
                                  "${trend["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Row(
                                  children: [
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
                                        "${trend["category"]}",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: infoColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${((trend["mentions"] as int) / 1000).toStringAsFixed(0)}K mentions",
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
                          SizedBox(width: spSm),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${trend["growth"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: successColor,
                                ),
                              ),
                              Text(
                                "growth",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),

            // Top Trending Topics
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.whatshot,
                      color: dangerColor,
                      size: 20,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Top Trending Topics",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: spSm,
                  children: List.generate(trendingTopics.length, (index) {
                    final topic = trendingTopics[index];
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Header Row
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                ),
                                child: Center(
                                  child: Text(
                                    "#${(topic["rank"] as int)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${topic["title"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: secondaryColor.withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${topic["category"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: secondaryColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: spXs),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: spXs,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getSentimentColor(topic["sentiment"] as String).withAlpha(20),
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                          child: Text(
                                            "${topic["sentiment"]}",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color: _getSentimentColor(topic["sentiment"] as String),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spSm),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${topic["growth"]}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: successColor,
                                    ),
                                  ),
                                  Text(
                                    "${topic["timeframe"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Key Insight
                          Container(
                            padding: EdgeInsets.all(spXs),
                            decoration: BoxDecoration(
                              color: infoColor.withAlpha(10),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  size: 16,
                                  color: infoColor,
                                ),
                                SizedBox(width: spXs),
                                Expanded(
                                  child: Text(
                                    "${topic["keyInsight"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: primaryColor,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Stats Row
                          Row(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${((topic["mentions"] as int) / 1000000).toStringAsFixed(1)}M mentions",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  "${(topic["trendingLocations"] as List).join(", ")}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          // Related Hashtags
                          QHorizontalScroll(
                            children: List.generate((topic["relatedHashtags"] as List).length, (hashIndex) {
                              final hashtag = (topic["relatedHashtags"] as List)[hashIndex];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spXs,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "$hashtag",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                  ),
                                ),
                              );
                            }),
                          ),

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
                              Expanded(
                                child: QButton(
                                  label: "Track Topic",
                                  size: bs.sm,
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
