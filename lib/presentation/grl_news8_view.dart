import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlNews8View extends StatefulWidget {
  @override
  State<GrlNews8View> createState() => _GrlNews8ViewState();
}

class _GrlNews8ViewState extends State<GrlNews8View> {
  String searchQuery = "";
  String selectedMood = "All";
  String selectedTopic = "Headlines";
  bool darkModeEnabled = false;
  int currentTab = 0;

  List<Map<String, dynamic>> moods = [
    {"label": "All", "value": "All"},
    {"label": "Positive", "value": "Positive"},
    {"label": "Neutral", "value": "Neutral"},
    {"label": "Urgent", "value": "Urgent"},
    {"label": "Inspirational", "value": "Inspirational"},
  ];

  List<Map<String, dynamic>> topics = [
    {"label": "Headlines", "value": "Headlines"},
    {"label": "World News", "value": "World"},
    {"label": "Technology", "value": "Technology"},
    {"label": "Science", "value": "Science"},
    {"label": "Health", "value": "Health"},
    {"label": "Environment", "value": "Environment"},
  ];

  List<Map<String, dynamic>> moodBasedNews = [
    {
      "id": 1,
      "title": "Scientists Discover Breakthrough Treatment for Rare Disease",
      "excerpt": "Medical researchers achieve remarkable success in treating previously incurable condition",
      "image": "https://picsum.photos/300/180?random=1&keyword=medical",
      "mood": "Positive",
      "moodColor": successColor,
      "author": "Dr. Emily Watson",
      "publishedAt": "2024-01-15T10:00:00Z",
      "readTime": 6,
      "engagement": 94,
      "category": "Health",
      "tags": ["Medical", "Research", "Breakthrough"],
    },
    {
      "id": 2,
      "title": "Global Initiative Plants 1 Billion Trees in Record Time",
      "excerpt": "Environmental campaign exceeds ambitious goals months ahead of schedule",
      "image": "https://picsum.photos/300/180?random=2&keyword=trees",
      "mood": "Inspirational",
      "moodColor": successColor,
      "author": "Maria Gonzalez",
      "publishedAt": "2024-01-15T09:30:00Z",
      "readTime": 4,
      "engagement": 87,
      "category": "Environment",
      "tags": ["Environment", "Conservation", "Success"],
    },
    {
      "id": 3,
      "title": "Economic Markets Show Steady Recovery Pattern",
      "excerpt": "Financial indicators suggest sustained growth across multiple sectors",
      "image": "https://picsum.photos/300/180?random=3&keyword=finance",
      "mood": "Neutral",
      "moodColor": infoColor,
      "author": "Robert Chen",
      "publishedAt": "2024-01-15T08:45:00Z",
      "readTime": 5,
      "engagement": 72,
      "category": "Economics",
      "tags": ["Economy", "Markets", "Analysis"],
    },
    {
      "id": 4,
      "title": "Urgent: Natural Disaster Response Teams Mobilized",
      "excerpt": "Emergency services coordinate massive relief effort for affected regions",
      "image": "https://picsum.photos/300/180?random=4&keyword=rescue",
      "mood": "Urgent",
      "moodColor": dangerColor,
      "author": "Sarah Johnson",
      "publishedAt": "2024-01-15T08:00:00Z",
      "readTime": 7,
      "engagement": 89,
      "category": "Emergency",
      "tags": ["Emergency", "Disaster", "Relief"],
    },
  ];

  List<Map<String, dynamic>> personalizedRecommendations = [
    {
      "id": 5,
      "title": "AI Revolution Transforms Educational Methods",
      "excerpt": "Personalized learning powered by artificial intelligence",
      "image": "https://picsum.photos/250/150?random=5&keyword=education",
      "relevanceScore": 96,
      "readTime": 8,
      "category": "Education",
    },
    {
      "id": 6,
      "title": "Space Tourism Industry Reaches New Milestone",
      "excerpt": "Commercial space flights become accessible to more travelers",
      "image": "https://picsum.photos/250/150?random=6&keyword=space",
      "relevanceScore": 89,
      "readTime": 6,
      "category": "Space",
    },
    {
      "id": 7,
      "title": "Renewable Energy Costs Drop to Historic Lows",
      "excerpt": "Solar and wind power become most affordable energy sources",
      "image": "https://picsum.photos/250/150?random=7&keyword=renewable",
      "relevanceScore": 92,
      "readTime": 5,
      "category": "Energy",
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {"name": "Climate Action", "count": 1247, "trend": "up"},
    {"name": "AI Innovation", "count": 892, "trend": "up"},
    {"name": "Space Exploration", "count": 634, "trend": "stable"},
    {"name": "Healthcare", "count": 1089, "trend": "up"},
    {"name": "Education Reform", "count": 456, "trend": "down"},
  ];

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Smart News",
      selectedIndex: currentTab,
      tabs: [
        Tab(text: "Mood Feed", icon: Icon(Icons.mood)),
        Tab(text: "For You", icon: Icon(Icons.person)),
        Tab(text: "Trending", icon: Icon(Icons.trending_up)),
      ],
      tabChildren: [
        // Mood Feed Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Search and Filters
              Row(
                children: [
                  Expanded(
                    child: QTextField(
                      label: "Search by mood or topic...",
                      value: searchQuery,
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
                    onPressed: () {},
                  ),
                ],
              ),

              // Mood and Topic Filters
              Row(
                children: [
                  Expanded(
                    child: QDropdownField(
                      label: "Mood Filter",
                      items: moods,
                      value: selectedMood,
                      onChanged: (value, label) {
                        selectedMood = value;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: QDropdownField(
                      label: "Topic",
                      items: topics,
                      value: selectedTopic,
                      onChanged: (value, label) {
                        selectedTopic = value;
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),

              // Mood Indicator
              Row(
                children: [
                  Icon(
                    Icons.psychology,
                    color: primaryColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Mood-Based News Feed",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "AI Curated",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Mood-Based News Cards
              ...moodBasedNews.map((news) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowMd],
                    border: Border(
                      left: BorderSide(
                        width: 4,
                        color: news["moodColor"] as Color,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(radiusLg),
                              topRight: Radius.circular(radiusLg),
                            ),
                            child: Image.network(
                              "${news["image"]}",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: spSm,
                                vertical: spXs,
                              ),
                              decoration: BoxDecoration(
                                color: news["moodColor"] as Color,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    _getMoodIcon("${news["mood"]}"),
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${news["mood"]}".toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.all(spXs),
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(128),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.bookmark_border,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(spSm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spSm,
                          children: [
                            Wrap(
                              spacing: spXs,
                              runSpacing: spXs,
                              children: (news["tags"] as List).map((tag) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (news["moodColor"] as Color).withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "$tag",
                                    style: TextStyle(
                                      color: news["moodColor"] as Color,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Text(
                              "${news["title"]}",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                                height: 1.3,
                              ),
                            ),
                            Text(
                              "${news["excerpt"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: primaryColor.withAlpha(51),
                                  child: Text(
                                    "${news["author"]}".substring(0, 1),
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${news["author"]}",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${news["category"]} • ${DateTime.parse("${news["publishedAt"]}").dMMMy}",
                                        style: TextStyle(
                                          color: disabledBoldColor,
                                          fontSize: 11,
                                        ),
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
                                    color: successColor.withAlpha(25),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: successColor,
                                        size: 12,
                                      ),
                                      SizedBox(width: spXs),
                                      Text(
                                        "${news["engagement"]}%",
                                        style: TextStyle(
                                          color: successColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${news["readTime"]} min read",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.thumb_up_outlined,
                                        size: 18,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.share,
                                        size: 18,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.more_horiz,
                                        size: 18,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
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
          ),
        ),

        // For You Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: warningColor,
                    size: 20,
                  ),
                  SizedBox(width: spXs),
                  Text(
                    "Personalized Recommendations",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Customize",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              ResponsiveGridView(
                padding: EdgeInsets.zero,
                minItemWidth: 200,
                children: personalizedRecommendations.map((recommendation) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      boxShadow: [shadowSm],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(radiusLg),
                                topRight: Radius.circular(radiusLg),
                              ),
                              child: Image.network(
                                "${recommendation["image"]}",
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${recommendation["relevanceScore"]}%",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(spSm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXs,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: infoColor.withAlpha(25),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${recommendation["category"]}",
                                  style: TextStyle(
                                    color: infoColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                "${recommendation["title"]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${recommendation["excerpt"]}",
                                style: TextStyle(
                                  color: disabledBoldColor,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${recommendation["readTime"]} min",
                                    style: TextStyle(
                                      color: disabledBoldColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.bookmark_border,
                                      size: 16,
                                      color: disabledBoldColor,
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
              ),
            ],
          ),
        ),

        // Trending Tab
        SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
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
                    "Trending Topics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spSm,
                      vertical: spXs,
                    ),
                    decoration: BoxDecoration(
                      color: successColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "Live Data",
                      style: TextStyle(
                        color: successColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              ...trendingTopics.asMap().entries.map((entry) {
                int index = entry.key + 1;
                Map<String, dynamic> topic = entry.value;
                
                Color trendColor = topic["trend"] == "up"
                    ? successColor
                    : topic["trend"] == "down"
                        ? dangerColor
                        : disabledBoldColor;

                IconData trendIcon = topic["trend"] == "up"
                    ? Icons.trending_up
                    : topic["trend"] == "down"
                        ? Icons.trending_down
                        : Icons.trending_flat;

                return Container(
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            "$index",
                            style: TextStyle(
                              fontSize: 18,
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
                              "${topic["name"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Text(
                              "${topic["count"]} articles",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 12,
                              ),
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
                          color: trendColor.withAlpha(25),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              trendIcon,
                              color: trendColor,
                              size: 14,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "${topic["trend"]}".toUpperCase(),
                              style: TextStyle(
                                color: trendColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
      onInit: (tabController) {
        // Optional: Access to TabController if needed
      },
    );
  }

  IconData _getMoodIcon(String mood) {
    switch (mood.toLowerCase()) {
      case 'positive':
        return Icons.sentiment_very_satisfied;
      case 'neutral':
        return Icons.sentiment_neutral;
      case 'urgent':
        return Icons.priority_high;
      case 'inspirational':
        return Icons.auto_awesome;
      default:
        return Icons.mood;
    }
  }
}
