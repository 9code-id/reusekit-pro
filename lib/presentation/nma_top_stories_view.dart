import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaTopStoriesView extends StatefulWidget {
  const NmaTopStoriesView({super.key});

  @override
  State<NmaTopStoriesView> createState() => _NmaTopStoriesViewState();
}

class _NmaTopStoriesViewState extends State<NmaTopStoriesView> {
  int selectedCategory = 0;
  String sortBy = "popularity";
  bool loading = false;
  
  List<String> categories = [
    "All Stories", "Politics", "Business", "Technology", "Health", "Sports", "Entertainment"
  ];
  
  List<String> sortOptions = ["popularity", "recent", "views", "comments"];

  List<Map<String, dynamic>> topStories = [
    {
      "id": 1,
      "title": "Global Economic Summit Addresses Inflation Concerns",
      "subtitle": "World leaders and economists discuss strategies to combat rising inflation rates",
      "category": "Business",
      "author": "Alexandra Thompson",
      "publishTime": "2 hours ago",
      "readTime": "8 min read",
      "image": "https://picsum.photos/300/200?random=1&keyword=economy",
      "views": 425000,
      "comments": 1240,
      "likes": 3450,
      "shares": 890,
      "rating": 4.8,
      "tags": ["economy", "inflation", "politics", "global"],
      "isExclusive": true,
      "isPremium": false,
      "priority": 1
    },
    {
      "id": 2,
      "title": "Revolutionary Cancer Treatment Shows 90% Success Rate",
      "subtitle": "Clinical trials reveal breakthrough immunotherapy treatment effectiveness",
      "category": "Health",
      "author": "Dr. Michael Chen",
      "publishTime": "4 hours ago",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=2&keyword=medical",
      "views": 380000,
      "comments": 2100,
      "likes": 5670,
      "shares": 1230,
      "rating": 4.9,
      "tags": ["cancer", "medical", "breakthrough", "health"],
      "isExclusive": false,
      "isPremium": true,
      "priority": 2
    },
    {
      "id": 3,
      "title": "Tech Giants Announce Joint Venture for Sustainable Computing",
      "subtitle": "Major technology companies collaborate on environmentally friendly data centers",
      "category": "Technology",
      "author": "Sarah Rodriguez",
      "publishTime": "6 hours ago",
      "readTime": "5 min read",
      "image": "https://picsum.photos/300/200?random=3&keyword=technology",
      "views": 295000,
      "comments": 890,
      "likes": 2340,
      "shares": 567,
      "rating": 4.6,
      "tags": ["technology", "environment", "sustainability", "data"],
      "isExclusive": false,
      "isPremium": false,
      "priority": 3
    },
    {
      "id": 4,
      "title": "International Space Station Welcomes Record Crew Size",
      "subtitle": "Historic mission brings together astronauts from eight different countries",
      "category": "Technology",
      "author": "Captain James Wilson",
      "publishTime": "8 hours ago",
      "readTime": "7 min read",
      "image": "https://picsum.photos/300/200?random=4&keyword=space",
      "views": 520000,
      "comments": 1560,
      "likes": 4120,
      "shares": 980,
      "rating": 4.7,
      "tags": ["space", "international", "cooperation", "astronauts"],
      "isExclusive": true,
      "isPremium": false,
      "priority": 4
    },
    {
      "id": 5,
      "title": "Olympic Games Preparation Faces Climate Challenges",
      "subtitle": "Rising temperatures force organizers to implement new safety protocols",
      "category": "Sports",
      "author": "Emma Davis",
      "publishTime": "10 hours ago",
      "readTime": "4 min read",
      "image": "https://picsum.photos/300/200?random=5&keyword=olympics",
      "views": 340000,
      "comments": 780,
      "likes": 1890,
      "shares": 445,
      "rating": 4.4,
      "tags": ["olympics", "climate", "sports", "safety"],
      "isExclusive": false,
      "isPremium": true,
      "priority": 5
    },
    {
      "id": 6,
      "title": "Hollywood Strikes Deal to Improve Digital Artist Rights",
      "subtitle": "Industry agreement ensures fair compensation for AI-generated content creators",
      "category": "Entertainment",
      "author": "David Park",
      "publishTime": "12 hours ago",
      "readTime": "6 min read",
      "image": "https://picsum.photos/300/200?random=6&keyword=hollywood",
      "views": 275000,
      "comments": 1340,
      "likes": 3210,
      "shares": 670,
      "rating": 4.5,
      "tags": ["hollywood", "ai", "rights", "entertainment"],
      "isExclusive": false,
      "isPremium": false,
      "priority": 6
    }
  ];

  List<Map<String, dynamic>> get filteredAndSortedStories {
    List<Map<String, dynamic>> filtered = topStories;
    
    if (selectedCategory > 0) {
      String categoryName = categories[selectedCategory];
      filtered = filtered.where((story) => 
        story["category"] == categoryName).toList();
    }
    
    switch (sortBy) {
      case "recent":
        filtered.sort((a, b) => (a["priority"] as int).compareTo(b["priority"] as int));
        break;
      case "views":
        filtered.sort((a, b) => (b["views"] as int).compareTo(a["views"] as int));
        break;
      case "comments":
        filtered.sort((a, b) => (b["comments"] as int).compareTo(a["comments"] as int));
        break;
      default: // popularity
        filtered.sort((a, b) => 
          ((b["likes"] as int) + (b["shares"] as int) * 2)
              .compareTo((a["likes"] as int) + (a["shares"] as int) * 2));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Stories"),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              loading = true;
              setState(() {});
              
              Future.delayed(Duration(seconds: 2), () {
                loading = false;
                setState(() {});
                ss("Top stories refreshed");
              });
            },
          ),
        ],
      ),
      body: loading 
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: EdgeInsets.all(spMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Story Banner
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withAlpha(90),
                        primaryColor.withAlpha(60),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: warningColor,
                        size: 24,
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Editor's Pick",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: fsH6,
                              ),
                            ),
                            Text(
                              "Hand-selected stories by our editorial team",
                              style: TextStyle(
                                color: Colors.white.withAlpha(200),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: spMd),
                
                // Filter Controls
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          QCategoryPicker(
                            items: categories.asMap().entries.map((entry) => {
                              "label": entry.value,
                              "value": entry.key,
                            }).toList(),
                            value: selectedCategory,
                            onChanged: (index, label, value, item) {
                              selectedCategory = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Sort Options
                Row(
                  children: [
                    Text(
                      "Sort by:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QCategoryPicker(
                        items: sortOptions.map((option) => {
                          "label": option.toUpperCase(),
                          "value": option,
                        }).toList(),
                        value: sortBy,
                        onChanged: (index, label, value, item) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spMd),
                
                // Stories Count
                Row(
                  children: [
                    Text(
                      "Top Stories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: spXs,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusXs),
                      ),
                      child: Text(
                        "${filteredAndSortedStories.length} stories",
                        style: TextStyle(
                          color: successColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: spSm),
                
                // Stories List
                Column(
                  children: filteredAndSortedStories.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> story = entry.value;
                    
                    return Container(
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusSm),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Story Header
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Row(
                              children: [
                                // Ranking Badge
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: index < 3 ? warningColor : primaryColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                
                                SizedBox(width: spSm),
                                
                                // Story Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: spXs,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withAlpha(20),
                                              borderRadius: BorderRadius.circular(radiusXs),
                                            ),
                                            child: Text(
                                              "${story["category"]}",
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (story["isExclusive"] == true)
                                            Container(
                                              margin: EdgeInsets.only(left: 4),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: warningColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "EXCLUSIVE",
                                                style: TextStyle(
                                                  color: warningColor,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          if (story["isPremium"] == true)
                                            Container(
                                              margin: EdgeInsets.only(left: 4),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: spXs,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: infoColor.withAlpha(20),
                                                borderRadius: BorderRadius.circular(radiusXs),
                                              ),
                                              child: Text(
                                                "PREMIUM",
                                                style: TextStyle(
                                                  color: infoColor,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${story["title"]}",
                                        style: TextStyle(
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                
                                // Rating
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: warningColor,
                                          size: 16,
                                        ),
                                        SizedBox(width: 2),
                                        Text(
                                          "${(story["rating"] as double).toStringAsFixed(1)}",
                                          style: TextStyle(
                                            color: warningColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Rating",
                                      style: TextStyle(
                                        color: disabledColor,
                                        fontSize: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          // Story Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusSm),
                            child: Image.network(
                              "${story["image"]}",
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          
                          Padding(
                            padding: EdgeInsets.all(spSm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Story Subtitle
                                Text(
                                  "${story["subtitle"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Story Meta
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 14,
                                      color: disabledColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${story["author"]}",
                                      style: TextStyle(
                                        color: disabledColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(width: spSm),
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: disabledColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${story["publishTime"]}",
                                      style: TextStyle(
                                        color: disabledColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Spacer(),
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
                                        "${story["readTime"]}",
                                        style: TextStyle(
                                          color: infoColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                
                                SizedBox(height: spSm),
                                
                                // Engagement Stats
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.visibility,
                                          size: 16,
                                          color: disabledColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${((story["views"] as int) / 1000).toStringAsFixed(0)}K",
                                          style: TextStyle(
                                            color: disabledColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          size: 16,
                                          color: disabledColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${((story["likes"] as int) / 1000).toStringAsFixed(1)}K",
                                          style: TextStyle(
                                            color: disabledColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: spSm),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.comment,
                                          size: 16,
                                          color: disabledColor,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "${story["comments"]}",
                                          style: TextStyle(
                                            color: disabledColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            ss("Story bookmarked");
                                          },
                                          child: Icon(
                                            Icons.bookmark_border,
                                            color: disabledBoldColor,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        GestureDetector(
                                          onTap: () {
                                            ss("Story shared");
                                          },
                                          child: Icon(
                                            Icons.share,
                                            color: disabledBoldColor,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(width: spSm),
                                        QButton(
                                          label: "Read More",
                                          size: bs.sm,
                                          onPressed: () {},
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
                ),
                
                SizedBox(height: spMd),
                
                // Load More Button
                Container(
                  width: double.infinity,
                  child: QButton(
                    label: "Load More Stories",
                    size: bs.md,
                    onPressed: () {
                      ss("Loading more top stories...");
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
