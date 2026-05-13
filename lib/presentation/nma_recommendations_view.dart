import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class NmaRecommendationsView extends StatefulWidget {
  const NmaRecommendationsView({Key? key}) : super(key: key);

  @override
  State<NmaRecommendationsView> createState() => _NmaRecommendationsViewState();
}

class _NmaRecommendationsViewState extends State<NmaRecommendationsView> {
  String selectedCategory = "all";
  bool showExplanations = true;
  
  List<Map<String, dynamic>> recommendations = [
    {
      "id": 1,
      "title": "The Future of Quantum Computing: Breaking Through the Noise",
      "description": "Scientists at IBM have achieved a major breakthrough in quantum error correction, bringing us closer to practical quantum computers",
      "author": "Dr. Sarah Chen",
      "publication": "Quantum Weekly",
      "publishedDate": "2024-06-11",
      "readTime": "8 min",
      "imageUrl": "https://picsum.photos/300/200?random=1",
      "category": "Technology",
      "tags": ["Quantum Computing", "IBM", "Science"],
      "confidence": 95,
      "reason": "Based on your interest in Technology and recent reading patterns",
      "type": "trending",
      "views": 15420,
      "likes": 1240,
      "bookmarked": false,
    },
    {
      "id": 2,
      "title": "Climate Tipping Points: What the Latest Research Reveals",
      "description": "New climate models show concerning acceleration in key climate tipping points, with significant implications for global policy",
      "author": "Prof. Maria Rodriguez",
      "publication": "Climate Science Today",
      "publishedDate": "2024-06-10",
      "readTime": "12 min",
      "imageUrl": "https://picsum.photos/300/200?random=2",
      "category": "Environment",
      "tags": ["Climate Change", "Research", "Policy"],
      "confidence": 88,
      "reason": "Similar to articles you've bookmarked about environmental science",
      "type": "similar_reading",
      "views": 9870,
      "likes": 892,
      "bookmarked": false,
    },
    {
      "id": 3,
      "title": "Mental Health in the Digital Age: A Comprehensive Analysis",
      "description": "How social media and digital technology are reshaping mental health challenges and therapeutic approaches",
      "author": "Dr. James Wilson",
      "publication": "Psychology Review",
      "publishedDate": "2024-06-09",
      "readTime": "15 min",
      "imageUrl": "https://picsum.photos/300/200?random=3",
      "category": "Health",
      "tags": ["Mental Health", "Digital", "Psychology"],
      "confidence": 82,
      "reason": "Trending in your Health category with high engagement",
      "type": "category_trending",
      "views": 12500,
      "likes": 1050,
      "bookmarked": true,
    },
    {
      "id": 4,
      "title": "The Rise of Sustainable Investing: ESG Goes Mainstream",
      "description": "Environmental, social, and governance factors are becoming central to investment decisions across major financial institutions",
      "author": "Lisa Thompson",
      "publication": "Financial Future",
      "publishedDate": "2024-06-08",
      "readTime": "10 min",
      "imageUrl": "https://picsum.photos/300/200?random=4",
      "category": "Finance",
      "tags": ["ESG", "Investing", "Sustainability"],
      "confidence": 75,
      "reason": "Authors you follow often write about sustainable business practices",
      "type": "author_connection",
      "views": 8420,
      "likes": 654,
      "bookmarked": false,
    },
    {
      "id": 5,
      "title": "Space Tourism Takes Off: Virgin Galactic's Latest Mission",
      "description": "Commercial space travel reaches new heights as Virgin Galactic completes another successful passenger flight",
      "author": "Michael Zhang",
      "publication": "Space Explorer",
      "publishedDate": "2024-06-07",
      "readTime": "6 min",
      "imageUrl": "https://picsum.photos/300/200?random=5",
      "category": "Science",
      "tags": ["Space", "Tourism", "Virgin Galactic"],
      "confidence": 70,
      "reason": "Popular among readers with similar interests to yours",
      "type": "collaborative",
      "views": 18900,
      "likes": 1680,
      "bookmarked": false,
    },
  ];

  List<Map<String, dynamic>> recommendationTypes = [
    {
      "type": "trending",
      "label": "Trending Now",
      "description": "Popular articles gaining momentum",
      "icon": Icons.trending_up,
      "color": Colors.red,
      "count": 1,
    },
    {
      "type": "similar_reading",
      "label": "Similar to Your Reading",
      "description": "Based on articles you've engaged with",
      "icon": Icons.favorite,
      "color": Colors.pink,
      "count": 1,
    },
    {
      "type": "category_trending",
      "label": "Trending in Your Categories",
      "description": "Popular in your interested topics",
      "icon": Icons.category,
      "color": Colors.blue,
      "count": 1,
    },
    {
      "type": "author_connection",
      "label": "From Authors You Follow",
      "description": "Content from your favorite writers",
      "icon": Icons.person,
      "color": Colors.green,
      "count": 1,
    },
    {
      "type": "collaborative",
      "label": "Readers Like You Enjoyed",
      "description": "Popular among similar users",
      "icon": Icons.people,
      "color": Colors.orange,
      "count": 1,
    },
  ];

  List<Map<String, dynamic>> categories = [
    {"label": "All", "value": "all", "count": 5},
    {"label": "Technology", "value": "technology", "count": 1},
    {"label": "Science", "value": "science", "count": 1},
    {"label": "Health", "value": "health", "count": 1},
    {"label": "Environment", "value": "environment", "count": 1},
    {"label": "Finance", "value": "finance", "count": 1},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredRecommendations = selectedCategory == "all" 
        ? recommendations 
        : recommendations.where((r) => r["category"].toString().toLowerCase() == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations"),
        actions: [
          IconButton(
            icon: Icon(showExplanations ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              showExplanations = !showExplanations;
              setState(() {});
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _refreshRecommendations(),
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
                      color: isSelected ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(radiusLg),
                      border: Border.all(
                        color: isSelected ? primaryColor : disabledOutlineBorderColor,
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
                  // Recommendation types overview
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
                              Icons.auto_awesome,
                              color: primaryColor,
                              size: 18,
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
                          ],
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Content tailored to your interests and reading patterns",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                        ),
                        SizedBox(height: spSm),
                        Wrap(
                          spacing: spXs,
                          runSpacing: spXs,
                          children: recommendationTypes.map((type) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(radiusLg),
                                border: Border.all(color: (type["color"] as Color).withAlpha(30)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    type["icon"],
                                    color: type["color"],
                                    size: 12,
                                  ),
                                  SizedBox(width: spXs),
                                  Text(
                                    "${type["label"]}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: type["color"],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: type["color"],
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: Text(
                                      "${type["count"]}",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
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

                  // Recommendations list
                  Text(
                    "Recommended for You",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  
                  if (filteredRecommendations.isEmpty)
                    Container(
                      padding: EdgeInsets.all(spLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radiusMd),
                        boxShadow: [shadowSm],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: disabledBoldColor,
                          ),
                          SizedBox(height: spSm),
                          Text(
                            "No recommendations found",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Try adjusting your filters or check back later",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      spacing: spSm,
                      children: filteredRecommendations.map((recommendation) => 
                        _buildRecommendationCard(recommendation)
                      ).toList(),
                    ),

                  // Load more button
                  if (filteredRecommendations.isNotEmpty)
                    Container(
                      width: double.infinity,
                      child: QButton(
                        label: "Load More Recommendations",
                        size: bs.md,
                        onPressed: () => _loadMoreRecommendations(),
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

  Widget _buildRecommendationCard(Map<String, dynamic> recommendation) {
    Color typeColor = _getTypeColor(recommendation["type"]);
    bool isBookmarked = recommendation["bookmarked"];
    
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spSm,
        children: [
          // Header with type badge
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: typeColor,
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getTypeIcon(recommendation["type"]),
                      color: Colors.white,
                      size: 10,
                    ),
                    SizedBox(width: 2),
                    Text(
                      _getTypeLabel(recommendation["type"]),
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                decoration: BoxDecoration(
                  color: _getConfidenceColor(recommendation["confidence"]).withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusXs),
                ),
                child: Text(
                  "${recommendation["confidence"]}% match",
                  style: TextStyle(
                    fontSize: 8,
                    color: _getConfidenceColor(recommendation["confidence"]),
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
                      "${recommendation["title"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    
                    Text(
                      "${recommendation["description"]}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Metadata
                    Text(
                      "${recommendation["author"]} • ${recommendation["publication"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.schedule, size: 12, color: disabledBoldColor),
                        SizedBox(width: 2),
                        Text(
                          "${recommendation["readTime"]} • ${recommendation["publishedDate"]}",
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
              
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(radiusSm),
                child: Image.network(
                  "${recommendation["imageUrl"]}",
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          
          // Explanation
          if (showExplanations)
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(10),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(color: infoColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: infoColor,
                    size: 14,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "${recommendation["reason"]}",
                      style: TextStyle(
                        fontSize: 11,
                        color: infoColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          
          // Tags
          Wrap(
            spacing: spXs,
            children: (recommendation["tags"] as List).map((tag) {
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
          
          // Stats and actions
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.visibility, size: 12, color: disabledBoldColor),
                  SizedBox(width: 2),
                  Text(
                    "${(recommendation["views"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                  ),
                ],
              ),
              SizedBox(width: spSm),
              Row(
                children: [
                  Icon(Icons.thumb_up, size: 12, color: disabledBoldColor),
                  SizedBox(width: 2),
                  Text(
                    "${recommendation["likes"]}",
                    style: TextStyle(fontSize: 10, color: disabledBoldColor),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _toggleBookmark(recommendation),
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      size: 16,
                      color: isBookmarked ? primaryColor : disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => _shareRecommendation(recommendation),
                    child: Icon(
                      Icons.share,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(width: spSm),
                  GestureDetector(
                    onTap: () => _hideRecommendation(recommendation),
                    child: Icon(
                      Icons.visibility_off,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "trending":
        return Colors.red;
      case "similar_reading":
        return Colors.pink;
      case "category_trending":
        return Colors.blue;
      case "author_connection":
        return Colors.green;
      case "collaborative":
        return Colors.orange;
      default:
        return primaryColor;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "trending":
        return Icons.trending_up;
      case "similar_reading":
        return Icons.favorite;
      case "category_trending":
        return Icons.category;
      case "author_connection":
        return Icons.person;
      case "collaborative":
        return Icons.people;
      default:
        return Icons.auto_awesome;
    }
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case "trending":
        return "TRENDING";
      case "similar_reading":
        return "SIMILAR";
      case "category_trending":
        return "CATEGORY";
      case "author_connection":
        return "AUTHOR";
      case "collaborative":
        return "POPULAR";
      default:
        return "RECOMMENDED";
    }
  }

  Color _getConfidenceColor(int confidence) {
    if (confidence >= 90) return successColor;
    if (confidence >= 70) return warningColor;
    return dangerColor;
  }

  void _toggleBookmark(Map<String, dynamic> recommendation) {
    recommendation["bookmarked"] = !recommendation["bookmarked"];
    setState(() {});
    
    if (recommendation["bookmarked"]) {
      ss("Article bookmarked");
    } else {
      ss("Bookmark removed");
    }
  }

  void _shareRecommendation(Map<String, dynamic> recommendation) {
    ss("Article link copied to clipboard");
  }

  void _hideRecommendation(Map<String, dynamic> recommendation) {
    recommendations.remove(recommendation);
    setState(() {});
    ss("Recommendation hidden");
  }

  void _refreshRecommendations() {
    ss("Refreshing recommendations...");
    // Simulate refresh
    Future.delayed(Duration(seconds: 1), () {
      ss("Recommendations updated");
    });
  }

  void _loadMoreRecommendations() {
    ss("Loading more recommendations...");
    // Simulate loading more
  }
}
