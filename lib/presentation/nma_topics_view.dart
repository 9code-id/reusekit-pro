import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaTopicsView extends StatefulWidget {
  const NmaTopicsView({Key? key}) : super(key: key);

  @override
  State<NmaTopicsView> createState() => _NmaTopicsViewState();
}

class _NmaTopicsViewState extends State<NmaTopicsView> {
  String selectedCategory = "all";
  String sortBy = "trending";
  bool isLoading = false;
  
  List<Map<String, dynamic>> topics = [
    {
      "id": 1,
      "title": "Artificial Intelligence Revolution",
      "description": "Latest developments in AI technology, machine learning, and their impact on various industries",
      "category": "Technology",
      "subscribers": 45200,
      "articles": 1247,
      "weeklyGrowth": 15.3,
      "trending": true,
      "imageUrl": "https://picsum.photos/300/200?random=1",
      "tags": ["AI", "Machine Learning", "Technology", "Innovation"],
      "lastUpdated": "2 hours ago",
      "subscribed": true,
    },
    {
      "id": 2,
      "title": "Climate Change & Sustainability",
      "description": "Environmental news, climate science, renewable energy, and sustainable living practices",
      "category": "Environment",
      "subscribers": 38900,
      "articles": 892,
      "weeklyGrowth": 12.8,
      "trending": true,
      "imageUrl": "https://picsum.photos/300/200?random=2",
      "tags": ["Climate", "Environment", "Sustainability", "Green Energy"],
      "lastUpdated": "4 hours ago",
      "subscribed": false,
    },
    {
      "id": 3,
      "title": "Space Exploration",
      "description": "Space missions, astronomical discoveries, and the future of human space exploration",
      "category": "Science",
      "subscribers": 32500,
      "articles": 634,
      "weeklyGrowth": 18.7,
      "trending": true,
      "imageUrl": "https://picsum.photos/300/200?random=3",
      "tags": ["Space", "NASA", "Astronomy", "Exploration"],
      "lastUpdated": "1 hour ago",
      "subscribed": true,
    },
    {
      "id": 4,
      "title": "Cryptocurrency & Blockchain",
      "description": "Digital currencies, blockchain technology, DeFi, and cryptocurrency market analysis",
      "category": "Finance",
      "subscribers": 29100,
      "articles": 745,
      "weeklyGrowth": 8.4,
      "trending": false,
      "imageUrl": "https://picsum.photos/300/200?random=4",
      "tags": ["Crypto", "Blockchain", "DeFi", "Bitcoin"],
      "lastUpdated": "6 hours ago",
      "subscribed": false,
    },
    {
      "id": 5,
      "title": "Mental Health & Wellness",
      "description": "Mental health awareness, wellness tips, psychological research, and self-care practices",
      "category": "Health",
      "subscribers": 25800,
      "articles": 423,
      "weeklyGrowth": 22.1,
      "trending": true,
      "imageUrl": "https://picsum.photos/300/200?random=5",
      "tags": ["Mental Health", "Wellness", "Psychology", "Self-Care"],
      "lastUpdated": "3 hours ago",
      "subscribed": true,
    },
    {
      "id": 6,
      "title": "Electric Vehicles",
      "description": "EV technology, automotive industry trends, charging infrastructure, and sustainable transportation",
      "category": "Technology",
      "subscribers": 21400,
      "articles": 356,
      "weeklyGrowth": 11.2,
      "trending": false,
      "imageUrl": "https://picsum.photos/300/200?random=6",
      "tags": ["EV", "Automotive", "Tesla", "Transportation"],
      "lastUpdated": "5 hours ago",
      "subscribed": false,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All Topics", "value": "all", "count": 156, "color": primaryColor},
    {"label": "Technology", "value": "technology", "count": 42, "color": Colors.blue},
    {"label": "Science", "value": "science", "count": 38, "color": Colors.green},
    {"label": "Health", "value": "health", "count": 28, "color": Colors.red},
    {"label": "Environment", "value": "environment", "count": 24, "color": Colors.teal},
    {"label": "Finance", "value": "finance", "count": 16, "color": Colors.orange},
    {"label": "Sports", "value": "sports", "count": 8, "color": Colors.purple},
  ];

  List<Map<String, dynamic>> trendingTags = [
    {"tag": "AI", "count": 245, "growth": 35.2},
    {"tag": "Climate Change", "count": 189, "growth": 28.7},
    {"tag": "Space", "count": 156, "growth": 42.1},
    {"tag": "Mental Health", "count": 134, "growth": 15.8},
    {"tag": "Cryptocurrency", "count": 98, "growth": 8.3},
    {"tag": "Electric Vehicles", "count": 87, "growth": 12.4},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Topics"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category filters
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: spMd),
            child: QHorizontalScroll(
              children: categories.map((category) {
                bool isSelected = category["value"] == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    selectedCategory = category["value"];
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    margin: EdgeInsets.only(right: spXs),
                    decoration: BoxDecoration(
                      color: isSelected ? category["color"] : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? category["color"] : disabledOutlineBorderColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${category["label"]}",
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : disabledBoldColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: spXs),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white.withAlpha(30) : disabledColor,
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${category["count"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected ? Colors.white : disabledBoldColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: spMd,
                children: [
                  // Sort and view options
                  Row(
                    children: [
                      Text(
                        "Sort by:",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Expanded(
                        child: QDropdownField(
                          label: "",
                          items: [
                            {"label": "Trending", "value": "trending"},
                            {"label": "Most Subscribers", "value": "subscribers"},
                            {"label": "Most Articles", "value": "articles"},
                            {"label": "Recently Updated", "value": "recent"},
                            {"label": "Alphabetical", "value": "alphabetical"},
                          ],
                          value: sortBy,
                          onChanged: (value, label) {
                            sortBy = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),

                  // Trending tags
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryColor.withAlpha(10), primaryColor.withAlpha(5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(radiusMd),
                      border: Border.all(color: primaryColor.withAlpha(30)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: primaryColor,
                              size: 18,
                            ),
                            SizedBox(width: spXs),
                            Text(
                              "Trending Tags",
                              style: TextStyle(
                                fontSize: fsH6,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: trendingTags.map((tag) {
                            return GestureDetector(
                              onTap: () => _searchByTag(tag["tag"]),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(radiusLg),
                                  border: Border.all(color: primaryColor.withAlpha(30)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${tag["tag"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: spXs),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                      decoration: BoxDecoration(
                                        color: successColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            color: Colors.white,
                                            size: 8,
                                          ),
                                          SizedBox(width: 1),
                                          Text(
                                            "${(tag["growth"] as double).toStringAsFixed(1)}%",
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  // Topics list
                  Text(
                    "All Topics",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Column(
                    spacing: spSm,
                    children: topics.map((topic) => _buildTopicCard(topic)).toList(),
                  ),

                  // Load more button
                  Container(
                    width: double.infinity,
                    child: QButton(
                      label: "Load More Topics",
                      size: bs.md,
                      onPressed: () => _loadMoreTopics(),
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

  Widget _buildTopicCard(Map<String, dynamic> topic) {
    bool isSubscribed = topic["subscribed"];
    bool isTrending = topic["trending"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
        border: isSubscribed ? Border.all(color: primaryColor, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header with trending badge
          Row(
            children: [
              Expanded(
                child: Text(
                  "${topic["title"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
              if (isTrending)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: dangerColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.white,
                        size: 10,
                      ),
                      SizedBox(width: 2),
                      Text(
                        "TRENDING",
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              if (isSubscribed)
                Container(
                  margin: EdgeInsets.only(left: spXs),
                  padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(radiusXs),
                  ),
                  child: Text(
                    "SUBSCRIBED",
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          
          // Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spXs,
                  children: [
                    Text(
                      "${topic["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Statistics
                    Row(
                      children: [
                        Icon(Icons.people, size: 12, color: disabledBoldColor),
                        SizedBox(width: 2),
                        Text(
                          "${(topic["subscribers"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                          style: TextStyle(fontSize: 10, color: disabledBoldColor),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.article, size: 12, color: disabledBoldColor),
                        SizedBox(width: 2),
                        Text(
                          "${topic["articles"]} articles",
                          style: TextStyle(fontSize: 10, color: disabledBoldColor),
                        ),
                        SizedBox(width: spSm),
                        Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                        SizedBox(width: 2),
                        Text(
                          "${topic["lastUpdated"]}",
                          style: TextStyle(fontSize: 10, color: disabledBoldColor),
                        ),
                      ],
                    ),
                    
                    // Growth indicator
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: successColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.trending_up,
                                color: successColor,
                                size: 10,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "${(topic["weeklyGrowth"] as double).toStringAsFixed(1)}% this week",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: spSm),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                          decoration: BoxDecoration(
                            color: infoColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(radiusXs),
                          ),
                          child: Text(
                            "${topic["category"]}",
                            style: TextStyle(
                              fontSize: 10,
                              color: infoColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(width: spSm),
              
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${topic["imageUrl"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          
          // Tags
          Wrap(
            spacing: spXs,
            children: (topic["tags"] as List).map((tag) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: secondaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 10,
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          
          // Action buttons
          Row(
            children: [
              QButton(
                label: isSubscribed ? "Unsubscribe" : "Subscribe",
                size: bs.sm,
                onPressed: () => _toggleSubscription(topic),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () => _viewTopicDetails(topic),
                child: Text(
                  "View Articles",
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _shareTopic(topic),
                child: Icon(
                  Icons.share,
                  size: 16,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSubscription(Map<String, dynamic> topic) {
    topic["subscribed"] = !topic["subscribed"];
    setState(() {});
    
    if (topic["subscribed"]) {
      ss("Subscribed to ${topic["title"]}");
    } else {
      ss("Unsubscribed from ${topic["title"]}");
    }
  }

  void _viewTopicDetails(Map<String, dynamic> topic) {
    //navigateTo('TopicDetailView');
  }

  void _shareTopic(Map<String, dynamic> topic) {
    ss("Topic link copied to clipboard");
  }

  void _searchByTag(String tag) {
    ss("Searching for articles with tag: $tag");
    //navigateTo('SearchResultsView');
  }

  void _loadMoreTopics() {
    isLoading = true;
    setState(() {});
    
    // Simulate loading
    Future.delayed(Duration(seconds: 2), () {
      isLoading = false;
      setState(() {});
      ss("More topics loaded");
    });
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Search Topics"),
        content: QTextField(
          label: "Search topics...",
          value: "",
          hint: "Enter topic name or keyword",
          onChanged: (value) {},
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Search",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              //navigateTo('SearchResultsView');
            },
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Filter Topics"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QDropdownField(
              label: "Minimum Subscribers",
              items: [
                {"label": "Any", "value": "any"},
                {"label": "1,000+", "value": "1000"},
                {"label": "10,000+", "value": "10000"},
                {"label": "50,000+", "value": "50000"},
              ],
              value: "any",
              onChanged: (value, label) {},
            ),
            SizedBox(height: spSm),
            QDropdownField(
              label: "Activity Level",
              items: [
                {"label": "All", "value": "all"},
                {"label": "Very Active", "value": "very_active"},
                {"label": "Active", "value": "active"},
                {"label": "Moderate", "value": "moderate"},
              ],
              value: "all",
              onChanged: (value, label) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          QButton(
            label: "Apply",
            size: bs.sm,
            onPressed: () {
              Navigator.of(context).pop();
              ss("Filters applied");
            },
          ),
        ],
      ),
    );
  }
}
