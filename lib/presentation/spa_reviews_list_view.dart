import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class SpaReviewsListView extends StatefulWidget {
  const SpaReviewsListView({Key? key}) : super(key: key);

  @override
  State<SpaReviewsListView> createState() => _SpaReviewsListViewState();
}

class _SpaReviewsListViewState extends State<SpaReviewsListView> {
  String selectedFilter = "all";
  String sortBy = "newest";
  bool showPhotosOnly = false;

  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "userName": "Sarah Johnson",
      "userImage": "https://picsum.photos/100/100?random=1&keyword=woman",
      "rating": 5,
      "date": "2024-06-15",
      "treatment": "Hydrating Facial Treatment",
      "spa": "Luxury Spa & Wellness",
      "verified": true,
      "helpful": 24,
      "review": "Absolutely amazing experience! The facial left my skin glowing and hydrated. The therapist was very professional and knowledgeable. The ambiance was perfect and I felt completely relaxed throughout the treatment.",
      "photos": [
        "https://picsum.photos/300/200?random=10&keyword=facial",
        "https://picsum.photos/300/200?random=11&keyword=spa",
      ],
      "response": {
        "spa": "Luxury Spa & Wellness",
        "date": "2024-06-16",
        "text": "Thank you so much for your wonderful review, Sarah! We're thrilled that you enjoyed your facial treatment and that our therapist exceeded your expectations. We look forward to welcoming you back soon!"
      }
    },
    {
      "id": 2,
      "userName": "Michael Chen",
      "userImage": "https://picsum.photos/100/100?random=2&keyword=man",
      "rating": 4,
      "date": "2024-06-12",
      "treatment": "Anti-Aging Facial",
      "spa": "Elite Beauty Center",
      "verified": true,
      "helpful": 18,
      "review": "Great treatment overall. The anti-aging facial definitely improved the texture of my skin. The only downside was the wait time - had to wait about 15 minutes past my appointment time. Staff was apologetic though.",
      "photos": [],
      "response": null
    },
    {
      "id": 3,
      "userName": "Emma Rodriguez",
      "userImage": "https://picsum.photos/100/100?random=3&keyword=woman",
      "rating": 5,
      "date": "2024-06-08",
      "treatment": "Organic Skin Renewal",
      "spa": "Natural Spa Retreat",
      "verified": true,
      "helpful": 31,
      "review": "I love that this spa uses completely organic products. My sensitive skin reacted beautifully to the treatment. The results were visible immediately and lasted for weeks. Highly recommend for anyone with sensitive skin!",
      "photos": [
        "https://picsum.photos/300/200?random=12&keyword=organic",
      ],
      "response": {
        "spa": "Natural Spa Retreat",
        "date": "2024-06-09",
        "text": "Emma, we're so happy to hear about your positive experience! Our organic treatments are specially designed for sensitive skin, and we're glad it worked perfectly for you. Thank you for recommending us!"
      }
    },
    {
      "id": 4,
      "userName": "David Kim",
      "userImage": "https://picsum.photos/100/100?random=4&keyword=man",
      "rating": 3,
      "date": "2024-06-05",
      "treatment": "Diamond Microdermabrasion",
      "spa": "Premium Skin Clinic",
      "verified": false,
      "helpful": 9,
      "review": "The treatment was okay, but I expected more dramatic results for the price. The facility is nice and clean, but the therapist seemed rushed. Might try a different treatment next time.",
      "photos": [],
      "response": {
        "spa": "Premium Skin Clinic",
        "date": "2024-06-06",
        "text": "Thank you for your feedback, David. We apologize that your experience didn't meet expectations. We'd love to discuss this further and offer you a complimentary consultation. Please contact our customer service team."
      }
    },
    {
      "id": 5,
      "userName": "Lisa Thompson",
      "userImage": "https://picsum.photos/100/100?random=5&keyword=woman",
      "rating": 5,
      "date": "2024-06-01",
      "treatment": "Hydrating Facial Treatment",
      "spa": "Luxury Spa & Wellness",
      "verified": true,
      "helpful": 42,
      "review": "This was my third visit and it never disappoints! The hydrating facial is perfect for my dry skin. The products they use are top quality and the results are immediate. The spa atmosphere is so relaxing and the staff is incredibly friendly.",
      "photos": [
        "https://picsum.photos/300/200?random=13&keyword=skincare",
        "https://picsum.photos/300/200?random=14&keyword=beauty",
        "https://picsum.photos/300/200?random=15&keyword=treatment",
      ],
      "response": null
    },
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All Reviews", "value": "all"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"},
    {"label": "With Photos", "value": "photos"},
    {"label": "Verified Only", "value": "verified"},
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Highest Rated", "value": "rating_high"},
    {"label": "Lowest Rated", "value": "rating_low"},
    {"label": "Most Helpful", "value": "helpful"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Reviews"),
        actions: [
          QButton(
            icon: Icons.rate_review,
            size: bs.sm,
            onPressed: () {
              //navigateTo ( SpaWriteReviewView )
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Review Summary
          _buildReviewSummary(),

          // Filter and Sort Controls
          Container(
            padding: EdgeInsets.all(spMd),
            color: Colors.grey[50],
            child: Column(
              spacing: spSm,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: QDropdownField(
                        label: "Filter by",
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
                        value: sortBy,
                        onChanged: (value, label) {
                          sortBy = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                QSwitch(
                  items: [
                    {
                      "label": "Show reviews with photos only",
                      "value": "photos_only",
                      "checked": showPhotosOnly,
                    }
                  ],
                  value: showPhotosOnly
                      ? [
                          {
                            "label": "Show reviews with photos only",
                            "value": "photos_only",
                            "checked": true,
                          }
                        ]
                      : [],
                  onChanged: (values, ids) {
                    showPhotosOnly = values.isNotEmpty;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Reviews List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(spMd),
              itemCount: _getFilteredReviews().length,
              itemBuilder: (context, index) {
                final review = _getFilteredReviews()[index];
                return _buildReviewCard(review);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //navigateTo ( SpaWriteReviewView )
        },
        backgroundColor: primaryColor,
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildReviewSummary() {
    double averageRating = _calculateAverageRating();
    Map<int, int> ratingCounts = _getRatingCounts();
    int totalReviews = reviews.length;

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [shadowSm],
      ),
      child: Column(
        children: [
          // Overall Rating
          Row(
            children: [
              Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < averageRating.floor()
                            ? Icons.star
                            : index < averageRating
                                ? Icons.star_half
                                : Icons.star_border,
                        color: warningColor,
                        size: 20,
                      );
                    }),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "$totalReviews reviews",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(width: spMd),
              Expanded(
                child: Column(
                  children: [
                    for (int rating = 5; rating >= 1; rating--)
                      _buildRatingBar(
                        rating,
                        ratingCounts[rating] ?? 0,
                        totalReviews,
                      ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: spMd),

          // Quick Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickStat("Verified", _getVerifiedCount()),
              _buildQuickStat("With Photos", _getPhotosCount()),
              _buildQuickStat("Recent", _getRecentCount()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int rating, int count, int total) {
    double percentage = total > 0 ? count / total : 0;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            "$rating",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: spXs),
          Icon(Icons.star, color: warningColor, size: 16),
          SizedBox(width: spSm),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
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
  }

  Widget _buildQuickStat(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info and Rating
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage("${review["userImage"]}"),
                ),
                SizedBox(width: spSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${review["userName"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (review["verified"] as bool) ...[
                            SizedBox(width: spXs),
                            Icon(
                              Icons.verified,
                              color: successColor,
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: spXs),
                      Row(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (review["rating"] as int)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: warningColor,
                                size: 16,
                              );
                            }),
                          ),
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
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      color: disabledBoldColor,
                      size: 16,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${review["helpful"]}",
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

          // Treatment Info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Text(
                "${review["treatment"]} at ${review["spa"]}",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(height: spSm),

          // Review Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spSm),
            child: Text(
              "${review["review"]}",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          // Photos
          if ((review["photos"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: (review["photos"] as List<String>).map((photo) {
                return Container(
                  margin: EdgeInsets.only(right: spSm),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      photo,
                      width: 120,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],

          // Action Buttons
          Padding(
            padding: EdgeInsets.all(spSm),
            child: Row(
              children: [
                QButton(
                  label: "Helpful",
                  size: bs.sm,
                  color: secondaryColor,
                  icon: Icons.thumb_up,
                  onPressed: () {
                    _markHelpful(review["id"]);
                  },
                ),
                SizedBox(width: spSm),
                QButton(
                  label: "Report",
                  size: bs.sm,
                  color: dangerColor,
                  icon: Icons.flag,
                  onPressed: () {
                    _reportReview(review["id"]);
                  },
                ),
                Spacer(),
                QButton(
                  label: "Share",
                  size: bs.sm,
                  color: infoColor,
                  icon: Icons.share,
                  onPressed: () {
                    _shareReview(review);
                  },
                ),
              ],
            ),
          ),

          // Spa Response
          if (review["response"] != null) ...[
            Container(
              margin: EdgeInsets.symmetric(horizontal: spSm),
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(25),
                borderRadius: BorderRadius.circular(radiusSm),
                border: Border.all(
                  color: primaryColor.withAlpha(100),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: primaryColor,
                        size: 16,
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "Response from ${review["response"]["spa"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "${review["response"]["date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${review["response"]["text"]}",
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: spSm),
          ],
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredReviews() {
    List<Map<String, dynamic>> filtered = List.from(reviews);

    // Apply filters
    if (selectedFilter != "all") {
      if (selectedFilter == "photos") {
        filtered = filtered.where((review) => (review["photos"] as List).isNotEmpty).toList();
      } else if (selectedFilter == "verified") {
        filtered = filtered.where((review) => review["verified"] as bool).toList();
      } else {
        int rating = int.tryParse(selectedFilter) ?? 0;
        if (rating > 0) {
          filtered = filtered.where((review) => review["rating"] == rating).toList();
        }
      }
    }

    if (showPhotosOnly) {
      filtered = filtered.where((review) => (review["photos"] as List).isNotEmpty).toList();
    }

    // Apply sorting
    switch (sortBy) {
      case "oldest":
        filtered.sort((a, b) => a["date"].compareTo(b["date"]));
        break;
      case "rating_high":
        filtered.sort((a, b) => (b["rating"] as int).compareTo(a["rating"] as int));
        break;
      case "rating_low":
        filtered.sort((a, b) => (a["rating"] as int).compareTo(b["rating"] as int));
        break;
      case "helpful":
        filtered.sort((a, b) => (b["helpful"] as int).compareTo(a["helpful"] as int));
        break;
      default: // newest
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
    }

    return filtered;
  }

  double _calculateAverageRating() {
    if (reviews.isEmpty) return 0.0;
    int total = reviews.fold(0, (sum, review) => sum + (review["rating"] as int));
    return total / reviews.length;
  }

  Map<int, int> _getRatingCounts() {
    Map<int, int> counts = {5: 0, 4: 0, 3: 0, 2: 0, 1: 0};
    for (var review in reviews) {
      int rating = review["rating"] as int;
      counts[rating] = (counts[rating] ?? 0) + 1;
    }
    return counts;
  }

  int _getVerifiedCount() {
    return reviews.where((review) => review["verified"] as bool).length;
  }

  int _getPhotosCount() {
    return reviews.where((review) => (review["photos"] as List).isNotEmpty).length;
  }

  int _getRecentCount() {
    DateTime oneWeekAgo = DateTime.now().subtract(Duration(days: 7));
    return reviews.where((review) {
      DateTime reviewDate = DateTime.parse(review["date"]);
      return reviewDate.isAfter(oneWeekAgo);
    }).length;
  }

  void _markHelpful(int reviewId) {
    ss("Review marked as helpful");
  }

  void _reportReview(int reviewId) {
    sw("Review reported for review");
  }

  void _shareReview(Map<String, dynamic> review) {
    si("Review shared successfully");
  }
}
