import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaTrendingView extends StatefulWidget {
  const NmaTrendingView({super.key});

  @override
  State<NmaTrendingView> createState() => _NmaTrendingViewState();
}

class _NmaTrendingViewState extends State<NmaTrendingView> {
  String selectedTimeRange = "24h";
  List timeRanges = ["1h", "24h", "7d", "30d"];
  
  List trendingTopics = [
    {
      "id": 1,
      "topic": "Climate Change Summit",
      "mentions": 156780,
      "growth": 145.7,
      "sentiment": "mixed",
      "category": "Environment",
      "hashtags": ["#ClimateAction", "#COP30", "#GreenPolicy"],
      "topArticle": "Global Leaders Reach Historic Climate Agreement",
      "image": "https://picsum.photos/300/200?random=31&keyword=climate",
    },
    {
      "id": 2,
      "topic": "AI Technology Breakthrough",
      "mentions": 89340,
      "growth": 89.2,
      "sentiment": "positive",
      "category": "Technology",
      "hashtags": ["#AI", "#TechNews", "#Innovation"],
      "topArticle": "Revolutionary AI System Transforms Healthcare",
      "image": "https://picsum.photos/300/200?random=32&keyword=ai",
    },
    {
      "id": 3,
      "topic": "Stock Market Rally",
      "mentions": 67520,
      "growth": 67.8,
      "sentiment": "positive",
      "category": "Finance",
      "hashtags": ["#StockMarket", "#Investing", "#Economy"],
      "topArticle": "Markets Surge on Positive Economic Data",
      "image": "https://picsum.photos/300/200?random=33&keyword=stocks",
    },
    {
      "id": 4,
      "topic": "Space Exploration Mission",
      "mentions": 54120,
      "growth": 43.5,
      "sentiment": "positive",
      "category": "Science",
      "hashtags": ["#SpaceExploration", "#Mars", "#NASA"],
      "topArticle": "Successful Mars Landing Opens New Frontiers",
      "image": "https://picsum.photos/300/200?random=34&keyword=space",
    },
    {
      "id": 5,
      "topic": "Healthcare Reform",
      "mentions": 45890,
      "growth": 38.9,
      "sentiment": "mixed",
      "category": "Politics",
      "hashtags": ["#Healthcare", "#Policy", "#Reform"],
      "topArticle": "New Healthcare Bill Sparks National Debate",
      "image": "https://picsum.photos/300/200?random=35&keyword=healthcare",
    },
    {
      "id": 6,
      "topic": "Renewable Energy",
      "mentions": 39670,
      "growth": 29.4,
      "sentiment": "positive",
      "category": "Environment",
      "hashtags": ["#RenewableEnergy", "#Solar", "#WindPower"],
      "topArticle": "Solar Energy Costs Drop to Record Lows",
      "image": "https://picsum.photos/300/200?random=36&keyword=solar",
    },
    {
      "id": 7,
      "topic": "Education Technology",
      "mentions": 28450,
      "growth": 22.1,
      "sentiment": "positive",
      "category": "Education",
      "hashtags": ["#EdTech", "#OnlineLearning", "#Education"],
      "topArticle": "Digital Learning Platforms Transform Education",
      "image": "https://picsum.photos/300/200?random=37&keyword=education",
    },
    {
      "id": 8,
      "topic": "Celebrity Wedding",
      "mentions": 25120,
      "growth": 18.7,
      "sentiment": "positive",
      "category": "Entertainment",
      "hashtags": ["#CelebrityWedding", "#Entertainment", "#Hollywood"],
      "topArticle": "Star-Studded Wedding Captures Global Attention",
      "image": "https://picsum.photos/300/200?random=38&keyword=wedding",
    },
  ];

  List get filteredTrending {
    // In a real app, this would filter based on time range
    return trendingTopics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshTrending();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTimeRangeFilter(),
          _buildTrendingStats(),
          Expanded(
            child: _buildTrendingList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeFilter() {
    return Container(
      padding: EdgeInsets.all(spMd),
      child: Row(
        children: [
          Text(
            "Trending in:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
          SizedBox(width: spMd),
          ...timeRanges.map((range) {
            final isSelected = selectedTimeRange == range;
            return Container(
              margin: EdgeInsets.only(right: spSm),
              child: GestureDetector(
                onTap: () {
                  selectedTimeRange = range;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: isSelected ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  child: Text(
                    range,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : disabledBoldColor,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTrendingStats() {
    final totalMentions = trendingTopics.fold(0, (sum, topic) => sum + (topic["mentions"] as int));
    final avgGrowth = trendingTopics.fold(0.0, (sum, topic) => sum + (topic["growth"] as double)) / trendingTopics.length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withAlpha(20), infoColor.withAlpha(20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: primaryColor.withAlpha(30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "${(totalMentions / 1000).toStringAsFixed(0)}K",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Total Mentions",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: disabledBoldColor.withAlpha(50),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "+${avgGrowth.toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                Text(
                  "Avg Growth",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: disabledBoldColor.withAlpha(50),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  "${trendingTopics.length}",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: infoColor,
                  ),
                ),
                Text(
                  "Trending Topics",
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
    );
  }

  Widget _buildTrendingList() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          _buildTopTrending(),
          _buildAllTrending(),
        ],
      ),
    );
  }

  Widget _buildTopTrending() {
    if (filteredTrending.isEmpty) return Container();
    
    final topTrending = filteredTrending.first;
    
    return Column(
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
            SizedBox(width: spSm),
            Text(
              "#1 Trending",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [successColor.withAlpha(20), primaryColor.withAlpha(10)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(radiusMd),
            border: Border.all(color: successColor.withAlpha(50)),
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
                      color: successColor,
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "#1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
                      color: _getCategoryColor(topTrending["category"]).withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${topTrending["category"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: _getCategoryColor(topTrending["category"]),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 12,
                          color: successColor,
                        ),
                        SizedBox(width: spXs),
                        Text(
                          "+${(topTrending["growth"] as double).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12,
                            color: successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${topTrending["topic"]}",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${topTrending["image"]}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Top Article: ${topTrending["topArticle"]}",
                style: TextStyle(
                  fontSize: 14,
                  color: disabledBoldColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Wrap(
                spacing: spXs,
                runSpacing: spXs,
                children: (topTrending["hashtags"] as List).map((hashtag) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: infoColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "$hashtag",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
              Row(
                children: [
                  Icon(
                    Icons.visibility,
                    size: 16,
                    color: disabledBoldColor,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${((topTrending["mentions"] as int) / 1000).toStringAsFixed(0)}K mentions",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Icon(
                    _getSentimentIcon(topTrending["sentiment"]),
                    size: 16,
                    color: _getSentimentColor(topTrending["sentiment"]),
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "${topTrending["sentiment"]}".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: _getSentimentColor(topTrending["sentiment"]),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Explore Topic",
                  size: bs.md,
                  onPressed: () {
                    // navigateTo(NmaTopicDetailView(topicId: topTrending["id"]));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllTrending() {
    final remainingTrending = filteredTrending.skip(1).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spSm,
      children: [
        Text(
          "Other Trending Topics",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        ...remainingTrending.asMap().entries.map((entry) {
          final index = entry.key + 2; // +2 because we skip the first item
          final topic = entry.value;
          
          return Container(
            margin: EdgeInsets.only(bottom: spSm),
            padding: EdgeInsets.all(spSm),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getRankColor(index).withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                    border: Border.all(
                      color: _getRankColor(index),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "#$index",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _getRankColor(index),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: spSm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(radiusSm),
                  child: Image.network(
                    "${topic["image"]}",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(topic["category"]).withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${topic["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                color: _getCategoryColor(topic["category"]),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 10,
                                  color: successColor,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  "+${(topic["growth"] as double).toStringAsFixed(1)}%",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: successColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "${topic["topic"]}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${topic["topArticle"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                            "${((topic["mentions"] as int) / 1000).toStringAsFixed(0)}K",
                            style: TextStyle(
                              fontSize: 11,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Icon(
                            _getSentimentIcon(topic["sentiment"]),
                            size: 14,
                            color: _getSentimentColor(topic["sentiment"]),
                          ),
                          SizedBox(width: spXs),
                          Text(
                            "${topic["sentiment"]}".substring(0, 3).toUpperCase(),
                            style: TextStyle(
                              fontSize: 11,
                              color: _getSentimentColor(topic["sentiment"]),
                              fontWeight: FontWeight.w600,
                            ),
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
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case "Environment":
        return successColor;
      case "Technology":
        return infoColor;
      case "Finance":
        return warningColor;
      case "Science":
        return secondaryColor;
      case "Politics":
        return primaryColor;
      case "Education":
        return infoColor;
      case "Entertainment":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  Color _getRankColor(int rank) {
    if (rank <= 3) return successColor;
    if (rank <= 6) return warningColor;
    return infoColor;
  }

  Color _getSentimentColor(String sentiment) {
    switch (sentiment) {
      case "positive":
        return successColor;
      case "negative":
        return dangerColor;
      case "mixed":
        return warningColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getSentimentIcon(String sentiment) {
    switch (sentiment) {
      case "positive":
        return Icons.sentiment_very_satisfied;
      case "negative":
        return Icons.sentiment_very_dissatisfied;
      case "mixed":
        return Icons.sentiment_neutral;
      default:
        return Icons.sentiment_neutral;
    }
  }

  void _refreshTrending() {
    setState(() {
      // In a real app, this would fetch new trending data
    });
    
    ss("Trending topics updated");
  }
}
