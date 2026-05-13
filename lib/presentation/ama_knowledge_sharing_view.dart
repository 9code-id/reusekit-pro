import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class AmaKnowledgeSharingView extends StatefulWidget {
  const AmaKnowledgeSharingView({super.key});

  @override
  State<AmaKnowledgeSharingView> createState() => _AmaKnowledgeSharingViewState();
}

class _AmaKnowledgeSharingViewState extends State<AmaKnowledgeSharingView> {
  int selectedCategory = 0;
  String searchQuery = "";
  
  List<Map<String, dynamic>> categories = [
    {"label": "All Topics", "value": 0},
    {"label": "Crop Management", "value": 1},
    {"label": "Pest Control", "value": 2},
    {"label": "Irrigation", "value": 3},
    {"label": "Soil Health", "value": 4},
    {"label": "Technology", "value": 5},
  ];
  
  List<Map<String, dynamic>> knowledgeArticles = [
    {
      "id": "1",
      "title": "Integrated Pest Management for Organic Farms",
      "author": "Dr. Sarah Chen",
      "category": "Pest Control",
      "readTime": 8,
      "views": 2847,
      "likes": 156,
      "image": "https://picsum.photos/300/200?random=1&keyword=farming",
      "publishedDate": "2024-06-10",
      "summary": "Learn effective strategies for managing pests naturally without harmful chemicals, protecting both crops and environment.",
      "difficulty": "Intermediate",
      "authorImage": "https://picsum.photos/40/40?random=11&keyword=expert",
      "tags": ["organic", "pesticides", "natural"],
      "bookmarked": false,
    },
    {
      "id": "2", 
      "title": "Smart Irrigation Systems: Maximize Water Efficiency",
      "author": "Miguel Santos",
      "category": "Irrigation",
      "readTime": 12,
      "views": 3456,
      "likes": 234,
      "image": "https://picsum.photos/300/200?random=2&keyword=irrigation",
      "publishedDate": "2024-06-08",
      "summary": "Discover how modern irrigation technology can reduce water usage by up to 40% while improving crop yields.",
      "difficulty": "Advanced",
      "authorImage": "https://picsum.photos/40/40?random=12&keyword=expert",
      "tags": ["technology", "water", "efficiency"],
      "bookmarked": true,
    },
    {
      "id": "3",
      "title": "Soil Microbiome: The Foundation of Healthy Crops",
      "author": "Prof. Rajesh Kumar",
      "category": "Soil Health",
      "readTime": 15,
      "views": 1923,
      "likes": 89,
      "image": "https://picsum.photos/300/200?random=3&keyword=soil",
      "publishedDate": "2024-06-05",
      "summary": "Understanding soil microorganisms and their crucial role in nutrient cycling and plant health.",
      "difficulty": "Advanced",
      "authorImage": "https://picsum.photos/40/40?random=13&keyword=expert",
      "tags": ["soil", "microbiome", "nutrients"],
      "bookmarked": false,
    },
    {
      "id": "4",
      "title": "Precision Agriculture: Data-Driven Farming",
      "author": "Anna Kowalski",
      "category": "Technology",
      "readTime": 10,
      "views": 4521,
      "likes": 312,
      "image": "https://picsum.photos/300/200?random=4&keyword=technology",
      "publishedDate": "2024-06-03",
      "summary": "How GPS, sensors, and AI are revolutionizing modern agriculture for better yields and sustainability.",
      "difficulty": "Intermediate",
      "authorImage": "https://picsum.photos/40/40?random=14&keyword=expert",
      "tags": ["precision", "AI", "sensors"],
      "bookmarked": true,
    },
    {
      "id": "5",
      "title": "Cover Crops: Building Soil Fertility Naturally",
      "author": "John Peterson",
      "category": "Crop Management",
      "readTime": 6,
      "views": 1654,
      "likes": 78,
      "image": "https://picsum.photos/300/200?random=5&keyword=crops",
      "publishedDate": "2024-06-01",
      "summary": "Learn how cover crops can improve soil structure, prevent erosion, and increase organic matter.",
      "difficulty": "Beginner",
      "authorImage": "https://picsum.photos/40/40?random=15&keyword=expert",
      "tags": ["cover crops", "fertility", "organic"],
      "bookmarked": false,
    },
  ];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = List.from(knowledgeArticles);
    
    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((article) =>
        (article["title"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (article["summary"] as String).toLowerCase().contains(searchQuery.toLowerCase()) ||
        (article["author"] as String).toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }
    
    // Apply category filter
    if (selectedCategory > 0) {
      String categoryName = categories[selectedCategory]["label"] as String;
      filtered = filtered.where((article) => 
        article["category"] as String == categoryName
      ).toList();
    }
    
    return filtered;
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case "Beginner":
        return successColor;
      case "Intermediate":
        return warningColor;
      case "Advanced":
        return dangerColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Knowledge Sharing"),
        actions: [
          QButton(
            icon: Icons.add_circle,
            size: bs.sm,
            onPressed: () {},
          ),
          SizedBox(width: spSm),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search articles, topics, or authors...",
                    value: searchQuery,
                    onChanged: (value) {
                      searchQuery = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.bookmark,
                  size: bs.sm,
                  onPressed: () {},
                ),
              ],
            ),
            
            // Category Filter
            QCategoryPicker(
              items: categories,
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                selectedCategory = value as int;
                setState(() {});
              },
            ),
            
            // Knowledge Base Stats
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Text(
                    "Expanding Agricultural Knowledge",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "1,847",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Articles",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "567",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Experts",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "23K",
                              style: TextStyle(
                                fontSize: fsH5,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Readers",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
            
            // Featured Articles
            ...List.generate(filteredArticles.length, (index) {
              final article = filteredArticles[index];
              return Container(
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
                      borderRadius: BorderRadius.vertical(top: Radius.circular(radiusMd)),
                      child: Stack(
                        children: [
                          Image.network(
                            "${article["image"]}",
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: spSm,
                            right: spSm,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: _getDifficultyColor(article["difficulty"] as String),
                                borderRadius: BorderRadius.circular(radiusSm),
                              ),
                              child: Text(
                                "${article["difficulty"]}",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: spSm,
                            left: spSm,
                            child: GestureDetector(
                              onTap: () {
                                article["bookmarked"] = !(article["bookmarked"] as bool);
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(spXs),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(200),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  (article["bookmarked"] as bool) ? Icons.bookmark : Icons.bookmark_border,
                                  size: 20,
                                  color: (article["bookmarked"] as bool) ? warningColor : disabledBoldColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Article Content
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          // Category Tag
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${article["category"]}",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          
                          // Title
                          Text(
                            "${article["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          
                          // Summary
                          Text(
                            "${article["summary"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              height: 1.4,
                            ),
                          ),
                          
                          // Author Info
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(radiusLg),
                                child: Image.network(
                                  "${article["authorImage"]}",
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${article["author"]}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${article["publishedDate"]}",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: disabledBoldColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "${article["readTime"]} min read",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                            ],
                          ),
                          
                          // Stats and Actions
                          Row(
                            children: [
                              Icon(
                                Icons.visibility,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${(article["views"] as int).toString()}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Icon(
                                Icons.thumb_up,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Text(
                                "${article["likes"]}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: disabledBoldColor,
                                ),
                              ),
                              Spacer(),
                              QButton(
                                label: "Read Article",
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
            
            if (filteredArticles.isEmpty)
              Container(
                padding: EdgeInsets.all(spLg),
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: disabledColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "No articles found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try different search terms or categories",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
