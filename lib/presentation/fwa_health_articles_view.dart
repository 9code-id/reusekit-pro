import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FwaHealthArticlesView extends StatefulWidget {
  const FwaHealthArticlesView({super.key});

  @override
  State<FwaHealthArticlesView> createState() => _FwaHealthArticlesViewState();
}

class _FwaHealthArticlesViewState extends State<FwaHealthArticlesView> {
  String selectedCategory = "All";
  String searchQuery = "";
  bool showBookmarked = false;
  
  List<String> categories = [
    "All",
    "Nutrition",
    "Fitness",
    "Mental Health",
    "Sleep",
    "Prevention",
    "Women's Health",
    "Men's Health"
  ];

  List<Map<String, dynamic>> articles = [
    {
      "id": 1,
      "title": "10 Superfoods That Boost Your Immune System",
      "category": "Nutrition",
      "author": "Dr. Sarah Johnson",
      "readTime": 5,
      "publishDate": "2024-06-10",
      "image": "https://picsum.photos/400/250?random=1&keyword=nutrition",
      "excerpt": "Discover the powerful foods that can strengthen your immune system naturally and protect against illness.",
      "isBookmarked": true,
      "views": 12500,
      "rating": 4.8,
      "tags": ["immunity", "nutrition", "superfoods"]
    },
    {
      "id": 2,
      "title": "The Science of Sleep: Why Quality Rest Matters",
      "category": "Sleep",
      "author": "Dr. Michael Chen",
      "readTime": 8,
      "publishDate": "2024-06-09",
      "image": "https://picsum.photos/400/250?random=2&keyword=sleep",
      "excerpt": "Understanding the critical role of sleep in physical and mental health, plus tips for better sleep hygiene.",
      "isBookmarked": false,
      "views": 18900,
      "rating": 4.9,
      "tags": ["sleep", "health", "wellness"]
    },
    {
      "id": 3,
      "title": "HIIT vs. Steady Cardio: Which Burns More Fat?",
      "category": "Fitness",
      "author": "Lisa Rodriguez",
      "readTime": 6,
      "publishDate": "2024-06-08",
      "image": "https://picsum.photos/400/250?random=3&keyword=fitness",
      "excerpt": "A comprehensive comparison of high-intensity interval training and traditional cardio for weight loss.",
      "isBookmarked": true,
      "views": 15200,
      "rating": 4.7,
      "tags": ["fitness", "cardio", "weight loss"]
    },
    {
      "id": 4,
      "title": "Managing Anxiety: Evidence-Based Strategies",
      "category": "Mental Health",
      "author": "Dr. Jennifer Walsh",
      "readTime": 10,
      "publishDate": "2024-06-07",
      "image": "https://picsum.photos/400/250?random=4&keyword=meditation",
      "excerpt": "Proven techniques and strategies for managing anxiety and stress in daily life.",
      "isBookmarked": false,
      "views": 22100,
      "rating": 4.9,
      "tags": ["anxiety", "mental health", "stress"]
    },
    {
      "id": 5,
      "title": "Heart Disease Prevention: Your Complete Guide",
      "category": "Prevention",
      "author": "Dr. Robert Kim",
      "readTime": 12,
      "publishDate": "2024-06-06",
      "image": "https://picsum.photos/400/250?random=5&keyword=heart",
      "excerpt": "Essential lifestyle changes and medical insights for preventing cardiovascular disease.",
      "isBookmarked": true,
      "views": 8700,
      "rating": 4.8,
      "tags": ["heart health", "prevention", "lifestyle"]
    },
    {
      "id": 6,
      "title": "Women's Health After 40: What to Expect",
      "category": "Women's Health",
      "author": "Dr. Amanda Foster",
      "readTime": 9,
      "publishDate": "2024-06-05",
      "image": "https://picsum.photos/400/250?random=6&keyword=women",
      "excerpt": "Important health considerations and screenings for women entering their 40s and beyond.",
      "isBookmarked": false,
      "views": 13400,
      "rating": 4.6,
      "tags": ["women's health", "aging", "hormones"]
    }
  ];

  List<Map<String, dynamic>> get filteredArticles {
    List<Map<String, dynamic>> filtered = articles;
    
    if (selectedCategory != "All") {
      filtered = filtered.where((article) => article["category"] == selectedCategory).toList();
    }
    
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((article) => 
        article["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        article["author"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        (article["tags"] as List).any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
      ).toList();
    }
    
    if (showBookmarked) {
      filtered = filtered.where((article) => article["isBookmarked"] == true).toList();
    }
    
    return filtered;
  }

  void toggleBookmark(int articleId) {
    setState(() {
      int index = articles.indexWhere((article) => article["id"] == articleId);
      if (index != -1) {
        articles[index]["isBookmarked"] = !articles[index]["isBookmarked"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Articles"),
        actions: [
          IconButton(
            icon: Icon(
              showBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: showBookmarked ? primaryColor : null,
            ),
            onPressed: () {
              setState(() {
                showBookmarked = !showBookmarked;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // Search Bar
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search articles...",
                    value: searchQuery,
                    hint: "Search by title, author, or tags",
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: spSm),
                QButton(
                  icon: Icons.filter_list,
                  size: bs.sm,
                  onPressed: () {
                    // Filter options
                  },
                ),
              ],
            ),

            // Categories
            QCategoryPicker(
              label: "Categories",
              items: categories.map((category) => {
                "label": category,
                "value": category,
              }).toList(),
              value: selectedCategory,
              onChanged: (index, label, value, item) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            // Stats Header
            Container(
              padding: EdgeInsets.all(spMd),
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
                          "${filteredArticles.length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        Text(
                          "Articles Found",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${articles.where((a) => a["isBookmarked"] == true).length}",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        Text(
                          "Bookmarked",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${(articles.map((a) => a["views"] as int).reduce((a, b) => a + b) / 1000).toInt()}K",
                          style: TextStyle(
                            fontSize: fsH4,
                            fontWeight: FontWeight.bold,
                            color: successColor,
                          ),
                        ),
                        Text(
                          "Total Views",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Featured Article
            if (filteredArticles.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radiusMd),
                  boxShadow: [shadowMd],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radiusMd),
                  child: Container(
                    height: 280,
                    child: Stack(
                      children: [
                        Image.network(
                          "${filteredArticles[0]["image"]}",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(200),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: spMd,
                          right: spMd,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "FEATURED",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: spMd,
                          left: spMd,
                          right: spMd,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spSm,
                                  vertical: spXs,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(51),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Text(
                                  "${filteredArticles[0]["category"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(height: spSm),
                              Text(
                                "${filteredArticles[0]["title"]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fsH5,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: spXs),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${filteredArticles[0]["author"]}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${filteredArticles[0]["readTime"]} min read",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Articles List
            Text(
              showBookmarked ? "Bookmarked Articles" : "Latest Articles",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

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
                    SizedBox(height: spMd),
                    Text(
                      "No articles found",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Try adjusting your search or filters",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...filteredArticles.skip(1).map((article) {
                return Container(
                  margin: EdgeInsets.only(bottom: spSm),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radiusSm),
                        child: Image.network(
                          "${article["image"]}",
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: spSm,
                                    vertical: spXs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withAlpha(51),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${article["category"]}",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () => toggleBookmark(article["id"]),
                                  child: Icon(
                                    article["isBookmarked"] ? Icons.bookmark : Icons.bookmark_border,
                                    color: article["isBookmarked"] ? warningColor : disabledBoldColor,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: spSm),
                            Text(
                              "${article["title"]}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spXs),
                            Text(
                              "${article["excerpt"]}",
                              style: TextStyle(
                                color: disabledBoldColor,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: spSm),
                            Row(
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${article["author"]}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(width: spSm),
                                Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "${article["readTime"]} min",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: warningColor,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${article["rating"]}",
                                      style: TextStyle(
                                        color: disabledBoldColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
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

            // Load More Button
            if (filteredArticles.length > 1)
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Load More Articles",
                  size: bs.md,
                  onPressed: () {
                    // Load more functionality
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
