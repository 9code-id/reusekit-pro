import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BrsTrendShowcaseView extends StatefulWidget {
  const BrsTrendShowcaseView({super.key});

  @override
  State<BrsTrendShowcaseView> createState() => _BrsTrendShowcaseViewState();
}

class _BrsTrendShowcaseViewState extends State<BrsTrendShowcaseView> {
  List<Map<String, dynamic>> trendingHairstyles = [
    {
      "id": 1,
      "name": "Textured Fade",
      "description": "Modern textured top with clean fade sides",
      "image": "https://picsum.photos/500/600?random=1&keyword=textured",
      "popularity": 98,
      "trend": "Rising",
      "category": "Modern",
      "season": "All Season",
      "difficulty": "Medium",
      "averageTime": "45 minutes",
      "priceRange": "\$35-50",
      "suitableFace": ["Oval", "Square", "Round"],
      "tags": ["Professional", "Casual", "Trendy"],
      "bookingCount": 245,
      "rating": 4.8,
      "isBookmarked": false
    },
    {
      "id": 2,
      "name": "Slick Back",
      "description": "Classic slicked back style with modern touch",
      "image": "https://picsum.photos/500/600?random=2&keyword=slickback",
      "popularity": 92,
      "trend": "Stable",
      "category": "Classic",
      "season": "All Season",
      "difficulty": "Easy",
      "averageTime": "30 minutes",
      "priceRange": "\$25-40",
      "suitableFace": ["Oval", "Rectangle"],
      "tags": ["Professional", "Formal", "Elegant"],
      "bookingCount": 189,
      "rating": 4.7,
      "isBookmarked": true
    },
    {
      "id": 3,
      "name": "Buzz Cut Fade",
      "description": "Clean buzz cut with precise fade transition",
      "image": "https://picsum.photos/500/600?random=3&keyword=buzzcut",
      "popularity": 85,
      "trend": "Rising",
      "category": "Modern",
      "season": "Summer",
      "difficulty": "Easy",
      "averageTime": "20 minutes",
      "priceRange": "\$20-30",
      "suitableFace": ["Square", "Oval", "Diamond"],
      "tags": ["Low Maintenance", "Athletic", "Clean"],
      "bookingCount": 156,
      "rating": 4.6,
      "isBookmarked": false
    },
    {
      "id": 4,
      "name": "Pompadour",
      "description": "Vintage pompadour with contemporary styling",
      "image": "https://picsum.photos/500/600?random=4&keyword=pompadour",
      "popularity": 88,
      "trend": "Declining",
      "category": "Vintage",
      "season": "All Season",
      "difficulty": "Hard",
      "averageTime": "50 minutes",
      "priceRange": "\$40-60",
      "suitableFace": ["Oval", "Heart"],
      "tags": ["Vintage", "Formal", "Statement"],
      "bookingCount": 98,
      "rating": 4.9,
      "isBookmarked": true
    },
    {
      "id": 5,
      "name": "Curly Top Fade",
      "description": "Natural curls on top with faded sides",
      "image": "https://picsum.photos/500/600?random=5&keyword=curly",
      "popularity": 94,
      "trend": "Rising",
      "category": "Modern",
      "season": "All Season",
      "difficulty": "Medium",
      "averageTime": "40 minutes",
      "priceRange": "\$30-45",
      "suitableFace": ["Oval", "Round", "Heart"],
      "tags": ["Natural", "Textured", "Casual"],
      "bookingCount": 203,
      "rating": 4.8,
      "isBookmarked": false
    },
    {
      "id": 6,
      "name": "Side Part Classic",
      "description": "Traditional side part for professional look",
      "image": "https://picsum.photos/500/600?random=6&keyword=sidepart",
      "popularity": 79,
      "trend": "Stable",
      "category": "Classic",
      "season": "All Season",
      "difficulty": "Easy",
      "averageTime": "25 minutes",
      "priceRange": "\$25-35",
      "suitableFace": ["Oval", "Rectangle", "Square"],
      "tags": ["Professional", "Conservative", "Clean"],
      "bookingCount": 134,
      "rating": 4.5,
      "isBookmarked": false
    }
  ];

  String selectedCategory = "All";
  String selectedTrend = "All";
  String selectedSeason = "All";
  
  List<String> categories = ["All", "Modern", "Classic", "Vintage"];
  List<String> trends = ["All", "Rising", "Stable", "Declining"];
  List<String> seasons = ["All", "All Season", "Summer", "Winter", "Spring", "Fall"];

  List<Map<String, dynamic>> get filteredTrends {
    return trendingHairstyles.where((style) {
      bool categoryMatch = selectedCategory == "All" || style["category"] == selectedCategory;
      bool trendMatch = selectedTrend == "All" || style["trend"] == selectedTrend;
      bool seasonMatch = selectedSeason == "All" || style["season"] == selectedSeason;
      return categoryMatch && trendMatch && seasonMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trend Showcase"),
        actions: [
          IconButton(
            icon: Icon(Icons.trending_up),
            onPressed: () {
              _showTrendAnalyticsDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Trends shared successfully");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    warningColor.withAlpha(20),
                    warningColor.withAlpha(5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: warningColor.withAlpha(30)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.whatshot,
                    color: warningColor,
                    size: 32,
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What's Trending",
                          style: TextStyle(
                            fontSize: fsH5,
                            fontWeight: FontWeight.bold,
                            color: warningColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Discover the latest hairstyle trends and popular cuts",
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

            SizedBox(height: spLg),

            // Quick Stats
            ResponsiveGridView(
              padding: EdgeInsets.zero,
              minItemWidth: 120,
              children: [
                _buildStatCard(
                  "Total Trends",
                  "${trendingHairstyles.length}",
                  Icons.style,
                  primaryColor,
                ),
                _buildStatCard(
                  "Rising",
                  "${trendingHairstyles.where((t) => t["trend"] == "Rising").length}",
                  Icons.trending_up,
                  successColor,
                ),
                _buildStatCard(
                  "Popular",
                  "${((trendingHairstyles.map((t) => t["popularity"] as int).reduce((a, b) => a + b)) / trendingHairstyles.length).round()}%",
                  Icons.star,
                  warningColor,
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Filter Section
            Text(
              "Filter Trends",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),

            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Category",
                        items: categories.map((cat) => {"label": cat, "value": cat}).toList(),
                        value: selectedCategory,
                        onChanged: (value, label) {
                          selectedCategory = value;
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(width: spSm),
                    Expanded(
                      child: QDropdownField(
                        label: "Trend",
                        items: trends.map((trend) => {"label": trend, "value": trend}).toList(),
                        value: selectedTrend,
                        onChanged: (value, label) {
                          selectedTrend = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spSm),
                QDropdownField(
                  label: "Season",
                  items: seasons.map((season) => {"label": season, "value": season}).toList(),
                  value: selectedSeason,
                  onChanged: (value, label) {
                    selectedSeason = value;
                    setState(() {});
                  },
                ),
              ],
            ),

            SizedBox(height: spLg),

            // Results Header
            Row(
              children: [
                Text(
                  "Trending Styles",
                  style: TextStyle(
                    fontSize: fsH5,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                Text(
                  "${filteredTrends.length} Results",
                  style: TextStyle(
                    color: disabledBoldColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: spMd),

            // Trending Styles List
            ...filteredTrends.map((style) {
              return Container(
                margin: EdgeInsets.only(bottom: spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowMd],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image and Quick Info
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusLg)),
                          child: Image.network(
                            "${style["image"]}",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: spSm,
                          right: spSm,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: _getTrendColor(style["trend"] as String).withAlpha(200),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getTrendIcon(style["trend"] as String),
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    SizedBox(width: spXs),
                                    Text(
                                      "${style["trend"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: spXs),
                              GestureDetector(
                                onTap: () {
                                  style["isBookmarked"] = !(style["isBookmarked"] as bool);
                                  setState(() {});
                                  ss(style["isBookmarked"] as bool ? "Bookmarked!" : "Bookmark removed");
                                },
                                child: Container(
                                  padding: EdgeInsets.all(spXs),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(200),
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Icon(
                                    style["isBookmarked"] as bool ? Icons.bookmark : Icons.bookmark_border,
                                    color: style["isBookmarked"] as bool ? primaryColor : disabledBoldColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: spSm,
                          left: spSm,
                          right: spSm,
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(150),
                              borderRadius: BorderRadius.circular(radiusMd),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${style["name"]}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: fsH6,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${style["category"]} • ${style["priceRange"]}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                  decoration: BoxDecoration(
                                    color: warningColor,
                                    borderRadius: BorderRadius.circular(radiusSm),
                                  ),
                                  child: Text(
                                    "${style["popularity"]}%",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Detailed Information
                    Padding(
                      padding: EdgeInsets.all(spMd),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${style["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: spMd),

                          // Quick Info Row
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoItem(
                                  Icons.access_time,
                                  "Time",
                                  "${style["averageTime"]}",
                                ),
                              ),
                              Expanded(
                                child: _buildInfoItem(
                                  Icons.fitness_center,
                                  "Difficulty",
                                  "${style["difficulty"]}",
                                ),
                              ),
                              Expanded(
                                child: _buildInfoItem(
                                  Icons.star,
                                  "Rating",
                                  "${style["rating"]}",
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: spMd),

                          // Face Shape and Tags
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.face,
                                size: 16,
                                color: disabledBoldColor,
                              ),
                              SizedBox(width: spXs),
                              Expanded(
                                child: Text(
                                  "Suitable for: ${(style["suitableFace"] as List).join(", ")}",
                                  style: TextStyle(
                                    color: disabledBoldColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: spSm),

                          // Tags
                          Wrap(
                            spacing: spXs,
                            runSpacing: spXs,
                            children: (style["tags"] as List).map((tag) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  borderRadius: BorderRadius.circular(radiusSm),
                                  border: Border.all(color: primaryColor.withAlpha(50)),
                                ),
                                child: Text(
                                  "$tag",
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          SizedBox(height: spMd),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "📊 ${style["bookingCount"]} Bookings",
                                  size: bs.sm,
                                  onPressed: () {
                                    si("Booking analytics for ${style["name"]}");
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Book Now",
                                  size: bs.sm,
                                  onPressed: () {
                                    ss("Booking ${style["name"]} style");
                                  },
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
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: color.withAlpha(10),
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: color.withAlpha(30)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: spSm),
          Text(
            value,
            style: TextStyle(
              fontSize: fsH4,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: disabledBoldColor,
        ),
        SizedBox(height: spXs),
        Text(
          label,
          style: TextStyle(
            color: disabledBoldColor,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getTrendColor(String trend) {
    switch (trend) {
      case "Rising":
        return successColor;
      case "Stable":
        return infoColor;
      case "Declining":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getTrendIcon(String trend) {
    switch (trend) {
      case "Rising":
        return Icons.trending_up;
      case "Stable":
        return Icons.trending_flat;
      case "Declining":
        return Icons.trending_down;
      default:
        return Icons.help;
    }
  }

  void _showTrendAnalyticsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Trend Analytics"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("View detailed analytics and insights about trending hairstyles."),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: successColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Rising Trends",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                          Text(
                            "${trendingHairstyles.where((t) => t["trend"] == "Rising").length}",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: successColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: warningColor.withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Average Pop.",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                          Text(
                            "${((trendingHairstyles.map((t) => t["popularity"] as int).reduce((a, b) => a + b)) / trendingHairstyles.length).round()}%",
                            style: TextStyle(
                              fontSize: fsH5,
                              fontWeight: FontWeight.bold,
                              color: warningColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
