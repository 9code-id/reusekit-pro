import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SmaTrendingView extends StatefulWidget {
  const SmaTrendingView({super.key});

  @override
  State<SmaTrendingView> createState() => _SmaTrendingViewState();
}

class _SmaTrendingViewState extends State<SmaTrendingView> {
  String selectedCategory = "For You";
  List<Map<String, dynamic>> categories = [
    {"label": "For You", "value": "For You"},
    {"label": "Trending", "value": "Trending"},
    {"label": "Music", "value": "Music"},
    {"label": "Gaming", "value": "Gaming"},
    {"label": "News", "value": "News"},
    {"label": "Sports", "value": "Sports"},
  ];

  List<Map<String, dynamic>> trendingHashtags = [
    {
      "hashtag": "#SummerVibes",
      "posts": 2847563,
      "growth": 125.5,
      "category": "Lifestyle",
      "description": "Summer activities and beach vibes",
    },
    {
      "hashtag": "#TechNews",
      "posts": 1923847,
      "growth": 89.3,
      "category": "Technology",
      "description": "Latest technology updates and gadgets",
    },
    {
      "hashtag": "#FitnessMotivation",
      "posts": 3456789,
      "growth": 156.7,
      "category": "Health",
      "description": "Workout inspiration and fitness tips",
    },
    {
      "hashtag": "#FoodieLife",
      "posts": 2134567,
      "growth": 78.9,
      "category": "Food",
      "description": "Delicious recipes and food photography",
    },
    {
      "hashtag": "#TravelDiaries",
      "posts": 4567890,
      "growth": 203.4,
      "category": "Travel",
      "description": "Travel experiences around the world",
    },
    {
      "hashtag": "#ArtisticVibes",
      "posts": 1567890,
      "growth": 94.2,
      "category": "Art",
      "description": "Creative artwork and artistic expressions",
    },
  ];

  List<Map<String, dynamic>> trendingTopics = [
    {
      "title": "AI Revolution",
      "posts": 156789,
      "engagement": 89.5,
      "timeframe": "Last 24 hours",
      "description": "Latest developments in artificial intelligence",
    },
    {
      "title": "Climate Action",
      "posts": 234567,
      "engagement": 76.8,
      "timeframe": "Last 12 hours",
      "description": "Environmental initiatives and climate change",
    },
    {
      "title": "Space Exploration",
      "posts": 123456,
      "engagement": 92.3,
      "timeframe": "Last 6 hours",
      "description": "Recent space missions and discoveries",
    },
    {
      "title": "Digital Art",
      "posts": 345678,
      "engagement": 83.7,
      "timeframe": "Last 3 hours",
      "description": "NFTs and digital artistic creations",
    },
  ];

  List<Map<String, dynamic>> trendingCreators = [
    {
      "username": "@tech_guru",
      "followers": 2456789,
      "growth": 45.6,
      "avatar": "https://picsum.photos/80/80?random=201",
      "verified": true,
      "category": "Technology",
    },
    {
      "username": "@fitness_queen",
      "followers": 1876543,
      "growth": 67.8,
      "avatar": "https://picsum.photos/80/80?random=202",
      "verified": true,
      "category": "Fitness",
    },
    {
      "username": "@travel_nomad",
      "followers": 3234567,
      "growth": 89.2,
      "avatar": "https://picsum.photos/80/80?random=203",
      "verified": false,
      "category": "Travel",
    },
    {
      "username": "@food_artist",
      "followers": 1567890,
      "growth": 34.5,
      "avatar": "https://picsum.photos/80/80?random=204",
      "verified": true,
      "category": "Food",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trending"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Filter
            QCategoryPicker(
              label: "Trending Categories",
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spMd),
            
            // Trending Hashtags Section
            Text(
              "Trending Hashtags",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: trendingHashtags.map((hashtag) {
                return Container(
                  width: 200,
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(right: spSm),
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
                          Text(
                            "${hashtag["hashtag"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spXs,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusXs),
                            ),
                            child: Text(
                              "+${(hashtag["growth"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 10,
                                color: successColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Text(
                        "${((hashtag["posts"] as int) / 1000000).toStringAsFixed(1)}M posts",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Text(
                        "${hashtag["description"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: spXs),
                      
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spXs,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withAlpha(50),
                          borderRadius: BorderRadius.circular(radiusXs),
                        ),
                        child: Text(
                          "${hashtag["category"]}",
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Trending Topics Section
            Text(
              "Trending Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: trendingTopics.map((topic) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
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
                              "${topic["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${topic["description"]}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Row(
                              children: [
                                Text(
                                  "${((topic["posts"] as int) / 1000).toStringAsFixed(0)}K posts",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Text(
                                  "${topic["timeframe"]}",
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
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: successColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${(topic["engagement"] as num).toStringAsFixed(1)}%",
                              style: TextStyle(
                                fontSize: 14,
                                color: successColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          Text(
                            "Engagement",
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
              }).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Trending Creators Section
            Text(
              "Trending Creators",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            Column(
              children: trendingCreators.map((creator) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  margin: EdgeInsets.only(bottom: spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("${creator["avatar"]}"),
                      ),
                      
                      SizedBox(width: spSm),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${creator["username"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                if (creator["verified"] == true) ...[
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.verified,
                                    size: 16,
                                    color: primaryColor,
                                  ),
                                ],
                              ],
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Text(
                              "${((creator["followers"] as int) / 1000000).toStringAsFixed(1)}M followers",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            
                            SizedBox(height: spXs),
                            
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spXs,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(50),
                                    borderRadius: BorderRadius.circular(radiusXs),
                                  ),
                                  child: Text(
                                    "${creator["category"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                
                                SizedBox(width: spSm),
                                
                                Text(
                                  "+${(creator["growth"] as num).toStringAsFixed(1)}% growth",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: successColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      QButton(
                        label: "Follow",
                        size: bs.sm,
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
