import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GeaNewsView extends StatefulWidget {
  const GeaNewsView({super.key});

  @override
  State<GeaNewsView> createState() => _GeaNewsViewState();
}

class _GeaNewsViewState extends State<GeaNewsView> {
  int selectedCategoryIndex = 0;
  String searchQuery = "";
  
  List<String> categories = [
    "All",
    "Technology", 
    "Business",
    "Health",
    "Sports",
    "Entertainment",
    "Science",
    "Politics"
  ];
  
  List<Map<String, dynamic>> trendingTopics = [
    {
      "title": "AI Revolution",
      "articles": 142,
      "trending": true,
    },
    {
      "title": "Climate Change",
      "articles": 89,
      "trending": true,
    },
    {
      "title": "Space Exploration",
      "articles": 67,
      "trending": false,
    },
    {
      "title": "Cryptocurrency",
      "articles": 234,
      "trending": true,
    },
  ];
  
  List<Map<String, dynamic>> articles = [
    {
      "title": "Revolutionary AI Technology Transforms Healthcare Industry",
      "summary": "New artificial intelligence breakthrough promises to revolutionize medical diagnosis and treatment methods across global healthcare systems.",
      "author": "Dr. Sarah Johnson",
      "publishedAt": "2024-03-15T10:30:00Z",
      "readTime": 5,
      "category": "Technology",
      "imageUrl": "https://picsum.photos/400/250?random=1&keyword=healthcare",
      "likes": 1245,
      "comments": 89,
      "shares": 234,
      "isBookmarked": false,
      "priority": "high",
    },
    {
      "title": "Global Climate Summit Reaches Historic Agreement",
      "summary": "World leaders unite in unprecedented climate action plan targeting carbon neutrality by 2035 with innovative green technology solutions.",
      "author": "Environmental Correspondent",
      "publishedAt": "2024-03-15T08:15:00Z",
      "readTime": 8,
      "category": "Politics",
      "imageUrl": "https://picsum.photos/400/250?random=2&keyword=environment",
      "likes": 2156,
      "comments": 156,
      "shares": 445,
      "isBookmarked": true,
      "priority": "high",
    },
    {
      "title": "SpaceX Successfully Launches Next-Generation Satellite Constellation",
      "summary": "Latest mission deploys advanced communication satellites designed to provide global internet coverage to remote and underserved regions.",
      "author": "Space Reporter",
      "publishedAt": "2024-03-14T22:45:00Z",
      "readTime": 6,
      "category": "Science",
      "imageUrl": "https://picsum.photos/400/250?random=3&keyword=space",
      "likes": 3421,
      "comments": 203,
      "shares": 678,
      "isBookmarked": false,
      "priority": "medium",
    },
    {
      "title": "Breakthrough in Quantum Computing Achieved by Research Team",
      "summary": "Scientists demonstrate practical quantum computer capable of solving complex problems previously impossible with classical computing methods.",
      "author": "Tech Analyst",
      "publishedAt": "2024-03-14T16:20:00Z",
      "readTime": 7,
      "category": "Technology",
      "imageUrl": "https://picsum.photos/400/250?random=4&keyword=quantum",
      "likes": 1876,
      "comments": 134,
      "shares": 289,
      "isBookmarked": true,
      "priority": "high",
    },
    {
      "title": "Olympic Games Preparation Reaches Final Stage",
      "summary": "Host city completes final preparations as athletes from around the world arrive for the upcoming Olympic Games competition events.",
      "author": "Sports Editor",
      "publishedAt": "2024-03-14T14:10:00Z",
      "readTime": 4,
      "category": "Sports",
      "imageUrl": "https://picsum.photos/400/250?random=5&keyword=olympics",
      "likes": 987,
      "comments": 67,
      "shares": 156,
      "isBookmarked": false,
      "priority": "medium",
    },
  ];
  
  List<Map<String, dynamic>> get filteredArticles {
    if (selectedCategoryIndex == 0) return articles;
    String selectedCategory = categories[selectedCategoryIndex];
    return articles.where((article) => 
      article["category"] == selectedCategory).toList();
  }
  
  void _toggleBookmark(int index) {
    articles[index]["isBookmarked"] = !articles[index]["isBookmarked"];
    setState(() {});
  }
  
  void _shareArticle(Map<String, dynamic> article) {
    ss("Article shared: ${article["title"]}");
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GEA News"),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search news...",
                    value: searchQuery,
                    hint: "Enter keywords, topics, or authors",
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
            
            SizedBox(height: spLg),
            
            // Breaking News Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: dangerColor,
                borderRadius: BorderRadius.circular(radiusMd),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.flash_on,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BREAKING NEWS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Major earthquake hits coastal region - Emergency response activated",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  QButton(
                    label: "Read More",
                    size: bs.sm,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spLg),
            
            // Category Selection
            Text(
              "Categories",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QCategoryPicker(
              items: categories.asMap().entries.map((entry) => {
                "label": entry.value,
                "value": entry.key,
              }).toList(),
              value: selectedCategoryIndex,
              onChanged: (index, label, value, item) {
                selectedCategoryIndex = value;
                setState(() {});
              },
            ),
            
            SizedBox(height: spLg),
            
            // Trending Topics
            Text(
              "Trending Topics",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: List.generate(trendingTopics.length, (index) {
                final topic = trendingTopics[index];
                return Container(
                  width: 160,
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: topic["trending"] ? primaryColor : disabledOutlineBorderColor,
                      width: topic["trending"] ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${topic["title"]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          if (topic["trending"])
                            Icon(
                              Icons.trending_up,
                              color: successColor,
                              size: 16,
                            ),
                        ],
                      ),
                      SizedBox(height: spXs),
                      Text(
                        "${topic["articles"]} articles",
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
            
            SizedBox(height: spLg),
            
            // Articles Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCategoryIndex == 0 
                    ? "Latest News" 
                    : "${categories[selectedCategoryIndex]} News",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sort,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "Sort by Latest",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: spSm),
            
            // Articles List
            ...List.generate(filteredArticles.length, (index) {
              final article = filteredArticles[index];
              final priorityColor = article["priority"] == "high" 
                ? dangerColor 
                : article["priority"] == "medium" 
                  ? warningColor 
                  : infoColor;
              
              return Container(
                margin: EdgeInsets.only(bottom: spSm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowSm],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(radiusMd),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            "${article["imageUrl"]}",
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
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
                                color: priorityColor,
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${article["category"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          if (article["priority"] == "high")
                            Positioned(
                              top: spSm,
                              right: spSm,
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: dangerColor,
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Icon(
                                  Icons.priority_high,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // Article Content
                    Padding(
                      padding: EdgeInsets.all(spSm),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            "${article["title"]}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          SizedBox(height: spXs),
                          
                          // Summary
                          Text(
                            "${article["summary"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Author and Time
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: disabledBoldColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${article["author"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.access_time,
                                color: disabledBoldColor,
                                size: 14,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${article["readTime"]} min read",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: spSm),
                          
                          // Actions
                          Row(
                            children: [
                              // Likes
                              Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${article["likes"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(width: spSm),
                              
                              // Comments
                              Row(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    color: disabledBoldColor,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${article["comments"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                              
                              Spacer(),
                              
                              // Bookmark
                              GestureDetector(
                                onTap: () => _toggleBookmark(index),
                                child: Icon(
                                  article["isBookmarked"] 
                                    ? Icons.bookmark 
                                    : Icons.bookmark_border,
                                  color: article["isBookmarked"] 
                                    ? primaryColor 
                                    : disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              
                              SizedBox(width: spSm),
                              
                              // Share
                              GestureDetector(
                                onTap: () => _shareArticle(article),
                                child: Icon(
                                  Icons.share,
                                  color: disabledBoldColor,
                                  size: 20,
                                ),
                              ),
                              
                              SizedBox(width: spSm),
                              
                              // Read More Button
                              QButton(
                                label: "Read More",
                                size: bs.sm,
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            // Load More Button
            if (filteredArticles.isNotEmpty)
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: spSm),
                child: QButton(
                  label: "Load More Articles",
                  size: bs.md,
                  onPressed: () {
                    ss("Loading more articles...");
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
