import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaReviewsView extends StatefulWidget {
  const TtaReviewsView({super.key});

  @override
  State<TtaReviewsView> createState() => _TtaReviewsViewState();
}

class _TtaReviewsViewState extends State<TtaReviewsView> {
  String selectedFilter = "All";
  String selectedSortBy = "Recent";
  String searchQuery = "";

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Most Recent", "value": "Recent"},
    {"label": "Highest Rating", "value": "Rating"},
    {"label": "Most Helpful", "value": "Helpful"},
    {"label": "Oldest", "value": "Oldest"},
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "id": "1",
      "userName": "Emily Johnson",
      "userImage": "https://picsum.photos/60/60?random=1&keyword=person",
      "rating": 5,
      "date": "2 days ago",
      "title": "Amazing Eiffel Tower experience!",
      "content": "The view from the top is absolutely breathtaking. Worth every penny! The staff was helpful and the elevator ride was smooth. Perfect for sunset photos.",
      "location": "Eiffel Tower, Paris",
      "photos": [
        "https://picsum.photos/200/150?random=10&keyword=eiffel",
        "https://picsum.photos/200/150?random=11&keyword=paris",
      ],
      "helpfulCount": 24,
      "verified": true
    },
    {
      "id": "2", 
      "userName": "Marco Rodriguez",
      "userImage": "https://picsum.photos/60/60?random=2&keyword=person",
      "rating": 4,
      "date": "1 week ago",
      "title": "Great food, long wait",
      "content": "The cuisine was authentic and delicious. However, we had to wait 45 minutes for a table despite having a reservation. The atmosphere is cozy though.",
      "location": "Le Comptoir du Relais, Paris",
      "photos": [
        "https://picsum.photos/200/150?random=12&keyword=food",
      ],
      "helpfulCount": 18,
      "verified": true
    },
    {
      "id": "3",
      "userName": "Sarah Chen",
      "userImage": "https://picsum.photos/60/60?random=3&keyword=person", 
      "rating": 5,
      "date": "2 weeks ago",
      "title": "Must-visit museum!",
      "content": "The Louvre exceeded all my expectations. Spent the entire day here and still didn't see everything. The Mona Lisa was smaller than expected but still impressive. Audio guide was very informative.",
      "location": "Louvre Museum, Paris",
      "photos": [
        "https://picsum.photos/200/150?random=13&keyword=museum",
        "https://picsum.photos/200/150?random=14&keyword=art",
        "https://picsum.photos/200/150?random=15&keyword=louvre",
      ],
      "helpfulCount": 35,
      "verified": true
    },
    {
      "id": "4",
      "userName": "David Thompson",
      "userImage": "https://picsum.photos/60/60?random=4&keyword=person",
      "rating": 3,
      "date": "3 weeks ago", 
      "title": "Average hotel experience",
      "content": "Room was clean but outdated. Location is good for sightseeing. Staff was friendly but limited English. Breakfast was basic. Fair value for the price paid.",
      "location": "Hotel des Grands Boulevards, Paris",
      "photos": [],
      "helpfulCount": 12,
      "verified": false
    },
    {
      "id": "5",
      "userName": "Lisa Williams",
      "userImage": "https://picsum.photos/60/60?random=5&keyword=person",
      "rating": 2,
      "date": "1 month ago",
      "title": "Overpriced and crowded",
      "content": "Tourist trap! Prices are inflated and the place was packed. Service was slow and food quality didn't match the price. Better options available nearby.",
      "location": "Café de Flore, Paris",
      "photos": [
        "https://picsum.photos/200/150?random=16&keyword=cafe",
      ],
      "helpfulCount": 8,
      "verified": true
    },
  ];

  Map<String, dynamic> reviewStats = {
    "totalReviews": 156,
    "averageRating": 4.2,
    "ratingDistribution": {
      "5": 62,
      "4": 41,
      "3": 28,
      "2": 15,
      "1": 10
    }
  };

  List<Map<String, dynamic>> get filteredReviews {
    List<Map<String, dynamic>> filtered = reviews;

    // Apply rating filter
    if (selectedFilter != "All") {
      int filterRating = int.parse(selectedFilter);
      filtered = filtered.where((review) => review["rating"] == filterRating).toList();
    }

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((review) =>
        review["title"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        review["content"].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
        review["location"].toString().toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Apply sorting
    switch (selectedSortBy) {
      case "Recent":
        // Already sorted by recent
        break;
      case "Rating":
        filtered.sort((a, b) => (b["rating"] as int).compareTo(a["rating"] as int));
        break;
      case "Helpful":
        filtered.sort((a, b) => (b["helpfulCount"] as int).compareTo(a["helpfulCount"] as int));
        break;
      case "Oldest":
        filtered = filtered.reversed.toList();
        break;
    }

    return filtered;
  }

  Widget _buildStarRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: warningColor,
          size: 16,
        );
      }),
    );
  }

  void _markAsHelpful(String reviewId) {
    // Find and update the review
    int index = reviews.indexWhere((review) => review["id"] == reviewId);
    if (index != -1) {
      setState(() {
        reviews[index]["helpfulCount"] = (reviews[index]["helpfulCount"] as int) + 1;
      });
      ss("Marked as helpful");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews & Ratings"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Review Statistics
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                spacing: spMd,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: spXs,
                          children: [
                            Text(
                              "Overall Rating",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                            Row(
                              spacing: spSm,
                              children: [
                                Text(
                                  "${(reviewStats["averageRating"] as double).toStringAsFixed(1)}",
                                  style: TextStyle(
                                    fontSize: fsH3,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                _buildStarRating((reviewStats["averageRating"] as double).round()),
                              ],
                            ),
                            Text(
                              "${reviewStats["totalReviews"]} reviews",
                              style: TextStyle(
                                fontSize: 14,
                                color: disabledBoldColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 60,
                        color: disabledColor,
                      ),
                      SizedBox(width: spMd),
                      Expanded(
                        child: Column(
                          spacing: spXs,
                          children: List.generate(5, (index) {
                            int stars = 5 - index;
                            int count = (reviewStats["ratingDistribution"] as Map)[stars.toString()] as int;
                            double percentage = count / (reviewStats["totalReviews"] as int);
                            
                            return Row(
                              spacing: spSm,
                              children: [
                                Text(
                                  "$stars",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: warningColor,
                                  size: 12,
                                ),
                                Expanded(
                                  child: Container(
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: disabledColor,
                                      borderRadius: BorderRadius.circular(radiusXs),
                                    ),
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: percentage,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: warningColor,
                                          borderRadius: BorderRadius.circular(radiusXs),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "$count",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search and Filters
            Row(
              children: [
                Expanded(
                  child: QTextField(
                    label: "Search reviews...",
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

            Row(
              children: [
                Expanded(
                  child: QDropdownField(
                    label: "Filter by Rating",
                    items: filterOptions,
                    value: selectedFilter,
                    onChanged: (value, label) {
                      selectedFilter = value;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: QDropdownField(
                    label: "Sort by",
                    items: sortOptions,
                    value: selectedSortBy,
                    onChanged: (value, label) {
                      selectedSortBy = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),

            // Reviews List
            Text(
              "Reviews (${filteredReviews.length})",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            Column(
              spacing: spMd,
              children: List.generate(filteredReviews.length, (index) {
                final review = filteredReviews[index];
                
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                  ),
                  child: Column(
                    spacing: spSm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Reviewer Info
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(radiusLg),
                            child: Image.network(
                              "${review["userImage"]}",
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: spSm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXxs,
                              children: [
                                Row(
                                  spacing: spXs,
                                  children: [
                                    Text(
                                      "${review["userName"]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    if (review["verified"] as bool) ...[
                                      Icon(
                                        Icons.verified,
                                        color: successColor,
                                        size: 16,
                                      ),
                                    ],
                                  ],
                                ),
                                Row(
                                  spacing: spSm,
                                  children: [
                                    _buildStarRating(review["rating"] as int),
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
                        ],
                      ),

                      // Review Title
                      Text(
                        "${review["title"]}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      // Review Content
                      Text(
                        "${review["content"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),

                      // Location
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spSm,
                          vertical: spXs,
                        ),
                        decoration: BoxDecoration(
                          color: infoColor.withAlpha(30),
                          borderRadius: BorderRadius.circular(radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: spXs,
                          children: [
                            Icon(
                              Icons.place,
                              color: infoColor,
                              size: 14,
                            ),
                            Text(
                              "${review["location"]}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: infoColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Photos
                      if ((review["photos"] as List).isNotEmpty) ...[
                        QHorizontalScroll(
                          children: List.generate((review["photos"] as List).length, (photoIndex) {
                            final photo = (review["photos"] as List)[photoIndex];
                            
                            return Container(
                              margin: EdgeInsets.only(right: spSm),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(radiusMd),
                                child: Image.network(
                                  "$photo",
                                  width: 120,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],

                      // Actions
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _markAsHelpful("${review["id"]}"),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: spXs,
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: primaryColor,
                                  size: 16,
                                ),
                                Text(
                                  "Helpful (${review["helpfulCount"]})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              ss("Review reported");
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: spXs,
                              children: [
                                Icon(
                                  Icons.flag,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                Text(
                                  "Report",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: spSm),
                          GestureDetector(
                            onTap: () {
                              ss("Review shared");
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              spacing: spXs,
                              children: [
                                Icon(
                                  Icons.share,
                                  color: disabledBoldColor,
                                  size: 16,
                                ),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: disabledBoldColor,
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
              }),
            ),

            // Write Review Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Write a Review",
                size: bs.md,
                onPressed: () {
                  // Navigate to write review
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
