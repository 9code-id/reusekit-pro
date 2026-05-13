import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaReviewsView extends StatefulWidget {
  const RmaReviewsView({super.key});

  @override
  State<RmaReviewsView> createState() => _RmaReviewsViewState();
}

class _RmaReviewsViewState extends State<RmaReviewsView> {
  String searchQuery = "";
  String selectedRating = "all";
  String selectedCategory = "all";
  String sortBy = "newest";

  List<Map<String, dynamic>> ratingFilters = [
    {"label": "All Ratings", "value": "all"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"},
  ];

  List<Map<String, dynamic>> categoryFilters = [
    {"label": "All Categories", "value": "all"},
    {"label": "Features", "value": "features"},
    {"label": "Usability", "value": "usability"},
    {"label": "Performance", "value": "performance"},
    {"label": "Support", "value": "support"},
    {"label": "Design", "value": "design"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Highest Rated", "value": "highest"},
    {"label": "Lowest Rated", "value": "lowest"},
    {"label": "Most Helpful", "value": "helpful"},
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "user": "John Smith",
      "avatar": "https://picsum.photos/60/60?random=1",
      "rating": 5,
      "date": "2024-01-15",
      "title": "Excellent Real Estate Management Tool",
      "content": "This platform has revolutionized how I manage my property portfolio. The intuitive interface and comprehensive features make it easy to track everything from tenant information to financial reports.",
      "category": "features",
      "helpful": 24,
      "verified": true,
      "images": [
        "https://picsum.photos/200/150?random=10",
        "https://picsum.photos/200/150?random=11",
      ],
    },
    {
      "id": 2,
      "user": "Sarah Johnson",
      "avatar": "https://picsum.photos/60/60?random=2",
      "rating": 4,
      "date": "2024-01-12",
      "title": "Great for Property Management",
      "content": "Love the automated rent collection and maintenance tracking. The mobile app is responsive and works well on the go. Only wish there were more customization options for reports.",
      "category": "usability",
      "helpful": 18,
      "verified": true,
      "images": [],
    },
    {
      "id": 3,
      "user": "Mike Davis",
      "avatar": "https://picsum.photos/60/60?random=3",
      "rating": 5,
      "date": "2024-01-10",
      "title": "Best Investment Decision",
      "content": "The ROI calculators and market analysis tools have helped me make better investment decisions. Customer support is also very responsive and knowledgeable.",
      "category": "support",
      "helpful": 31,
      "verified": false,
      "images": [],
    },
    {
      "id": 4,
      "user": "Emily Brown",
      "avatar": "https://picsum.photos/60/60?random=4",
      "rating": 3,
      "date": "2024-01-08",
      "title": "Good but Room for Improvement",
      "content": "The core features work well, but the interface could be more modern. Some functions are not as intuitive as they could be. Performance has improved recently though.",
      "category": "design",
      "helpful": 12,
      "verified": true,
      "images": [
        "https://picsum.photos/200/150?random=12",
      ],
    },
    {
      "id": 5,
      "user": "Robert Wilson",
      "avatar": "https://picsum.photos/60/60?random=5",
      "rating": 5,
      "date": "2024-01-05",
      "title": "Outstanding Performance",
      "content": "Fast, reliable, and feature-rich. The bulk operations save me hours of work every week. The export functionality is exactly what I needed for my accounting software.",
      "category": "performance",
      "helpful": 27,
      "verified": true,
      "images": [],
    },
    {
      "id": 6,
      "user": "Lisa Martinez",
      "avatar": "https://picsum.photos/60/60?random=6",
      "rating": 4,
      "date": "2024-01-02",
      "title": "Solid Real Estate Platform",
      "content": "Been using this for 6 months now. The learning curve was minimal and the features are comprehensive. The tenant portal is a great addition that my tenants love.",
      "category": "features",
      "helpful": 15,
      "verified": true,
      "images": [],
    },
  ];

  List<Map<String, dynamic>> get filteredReviews {
    List<Map<String, dynamic>> filtered = List.from(reviews);

    // Search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((review) {
        return "${review["title"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${review["content"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
               "${review["user"]}".toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    // Rating filter
    if (selectedRating != "all") {
      filtered = filtered.where((review) {
        return (review["rating"] as int).toString() == selectedRating;
      }).toList();
    }

    // Category filter
    if (selectedCategory != "all") {
      filtered = filtered.where((review) {
        return review["category"] == selectedCategory;
      }).toList();
    }

    // Sort
    filtered.sort((a, b) {
      switch (sortBy) {
        case "newest":
          return "${b["date"]}".compareTo("${a["date"]}");
        case "oldest":
          return "${a["date"]}".compareTo("${b["date"]}");
        case "highest":
          return (b["rating"] as int).compareTo(a["rating"] as int);
        case "lowest":
          return (a["rating"] as int).compareTo(b["rating"] as int);
        case "helpful":
          return (b["helpful"] as int).compareTo(a["helpful"] as int);
        default:
          return 0;
      }
    });

    return filtered;
  }

  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    int total = reviews.fold(0, (sum, review) => sum + (review["rating"] as int));
    return total / reviews.length;
  }

  Map<int, int> get ratingDistribution {
    Map<int, int> distribution = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in reviews) {
      distribution[review["rating"] as int] = (distribution[review["rating"] as int] ?? 0) + 1;
    }
    return distribution;
  }

  @override
  Widget build(BuildContext context) {
    final distribution = ratingDistribution;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews & Ratings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Reviews",
                    style: TextStyle(
                      fontSize: fsH3,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "See what our customers are saying about our platform",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(230),
                    ),
                  ),
                  SizedBox(height: spLg),
                  Row(
                    children: [
                      Expanded(
                        child: _buildHeaderStat(
                          "Total Reviews",
                          "${reviews.length}",
                          Icons.rate_review,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Average Rating",
                          "${averageRating.toStringAsFixed(1)}",
                          Icons.star,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: _buildHeaderStat(
                          "Satisfaction",
                          "94%",
                          Icons.sentiment_very_satisfied,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Rating Overview
            Container(
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
                border: Border.all(color: disabledOutlineBorderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rating Overview",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    children: [
                      // Overall Rating
                      Column(
                        children: [
                          Text(
                            "${averageRating.toStringAsFixed(1)}",
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: index < averageRating ? Colors.amber : disabledColor,
                                size: 20,
                              );
                            }),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "Based on ${reviews.length} reviews",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: spLg),
                      // Rating Distribution
                      Expanded(
                        child: Column(
                          children: [5, 4, 3, 2, 1].map((rating) {
                            int count = distribution[rating] ?? 0;
                            double percentage = reviews.isNotEmpty ? (count / reviews.length) * 100 : 0;
                            
                            return Container(
                              margin: EdgeInsets.only(bottom: spXs),
                              child: Row(
                                children: [
                                  Text(
                                    "$rating",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                  SizedBox(width: spXs),
                                  Icon(
                                    Icons.star,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: spSm),
                                  Expanded(
                                    child: Container(
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: disabledColor,
                                        borderRadius: BorderRadius.circular(radiusXs),
                                      ),
                                      child: FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor: percentage / 100,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: BorderRadius.circular(radiusXs),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: spSm),
                                  Text(
                                    "$count",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: disabledBoldColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spLg),

            // Filters
            Text(
              "Filter Reviews",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            QTextField(
              label: "Search Reviews",
              value: searchQuery,
              hint: "Search by title, content, or reviewer name...",
              onChanged: (value) {
                searchQuery = value;
                setState(() {});
              },
            ),
            SizedBox(height: spMd),
            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Rating",
                    items: ratingFilters,
                    value: selectedRating,
                    onChanged: (value, label) {
                      selectedRating = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Category",
                    items: categoryFilters,
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
                    label: "Sort By",
                    items: sortOptions,
                    value: sortBy,
                    onChanged: (value, label) {
                      sortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: spLg),

            // Reviews List
            Text(
              "Reviews (${filteredReviews.length})",
              style: TextStyle(
                fontSize: fsH5,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            SizedBox(height: spMd),
            if (filteredReviews.isEmpty)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spLg),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: disabledOutlineBorderColor),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: disabledColor,
                    ),
                    SizedBox(height: spMd),
                    Text(
                      "No reviews found",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: disabledBoldColor,
                      ),
                    ),
                    Text(
                      "Try adjusting your filters",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...filteredReviews.map((review) {
                return Container(
                  margin: EdgeInsets.only(bottom: spMd),
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusMd),
                    boxShadow: [shadowSm],
                    border: Border.all(color: disabledOutlineBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reviewer Info
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${review["avatar"]}",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${review["user"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (review["verified"] == true) ...[
                                      SizedBox(width: spXs),
                                      Icon(
                                        Icons.verified,
                                        size: 16,
                                        color: successColor,
                                      ),
                                    ],
                                  ],
                                ),
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        color: index < (review["rating"] as int) ? Colors.amber : disabledColor,
                                        size: 16,
                                      );
                                    }),
                                    SizedBox(width: spSm),
                                    Text(
                                      "${review["date"]}",
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: spSm,
                              vertical: spXs,
                            ),
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusSm),
                            ),
                            child: Text(
                              "${review["category"]}".toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spMd),

                      // Review Content
                      Text(
                        "${review["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spSm),
                      Text(
                        "${review["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                          height: 1.5,
                        ),
                      ),

                      // Review Images
                      if ((review["images"] as List).isNotEmpty) ...[
                        SizedBox(height: spMd),
                        QHorizontalScroll(
                          children: (review["images"] as List).map((imageUrl) {
                            return Container(
                              margin: EdgeInsets.only(right: spSm),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusSm),
                                child: Image.network(
                                  "$imageUrl",
                                  width: 120,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],

                      SizedBox(height: spMd),
                      
                      // Review Actions
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ss("Thank you for finding this review helpful!");
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  size: 16,
                                  color: disabledBoldColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Helpful (${review["helpful"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              ss("Review reported successfully!");
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.flag,
                                  size: 16,
                                  color: disabledColor,
                                ),
                                SizedBox(width: spXs),
                                Text(
                                  "Report",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(spSm),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(radiusSm),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(height: spXs),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }
}
