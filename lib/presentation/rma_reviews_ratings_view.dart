import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class RmaReviewsRatingsView extends StatefulWidget {
  const RmaReviewsRatingsView({super.key});

  @override
  State<RmaReviewsRatingsView> createState() => _RmaReviewsRatingsViewState();
}

class _RmaReviewsRatingsViewState extends State<RmaReviewsRatingsView> {
  int selectedTab = 0;
  String searchQuery = "";
  String selectedRating = "All";
  String selectedStatus = "All";
  bool showOnlyVerified = false;

  List<Map<String, dynamic>> reviewsData = [
    {
      "id": "REV001",
      "customer": "Alice Parker",
      "avatar": "https://picsum.photos/80/80?random=1&keyword=woman",
      "product": "Wireless Bluetooth Headphones",
      "product_image": "https://picsum.photos/100/100?random=10&keyword=headphones",
      "rating": 5,
      "title": "Amazing Sound Quality!",
      "review": "These headphones exceeded my expectations. The sound quality is crystal clear, bass is perfect, and battery life is excellent. Highly recommended!",
      "verified_purchase": true,
      "helpful_count": 24,
      "date": "2024-06-18",
      "status": "Published",
      "photos": [
        "https://picsum.photos/200/200?random=11&keyword=headphones",
        "https://picsum.photos/200/200?random=12&keyword=headphones"
      ],
      "response": "",
      "response_date": ""
    },
    {
      "id": "REV002",
      "customer": "John Martinez",
      "avatar": "https://picsum.photos/80/80?random=2&keyword=man",
      "product": "Smart Fitness Watch",
      "product_image": "https://picsum.photos/100/100?random=13&keyword=watch",
      "rating": 4,
      "title": "Good value for money",
      "review": "The watch works well and has most features I need. Heart rate monitor is accurate. Only issue is the strap feels a bit cheap.",
      "verified_purchase": true,
      "helpful_count": 15,
      "date": "2024-06-17",
      "status": "Published",
      "photos": [],
      "response": "Thank you for your feedback! We're glad you're enjoying the watch features. We'll pass your strap feedback to our product team.",
      "response_date": "2024-06-17"
    },
    {
      "id": "REV003",
      "customer": "Sarah Kim",
      "avatar": "https://picsum.photos/80/80?random=3&keyword=woman",
      "product": "Portable Phone Charger",
      "product_image": "https://picsum.photos/100/100?random=14&keyword=charger",
      "rating": 2,
      "title": "Doesn't hold charge well",
      "review": "Product arrived damaged and doesn't hold charge as advertised. Very disappointing quality for the price.",
      "verified_purchase": false,
      "helpful_count": 8,
      "date": "2024-06-16",
      "status": "Under Review",
      "photos": [
        "https://picsum.photos/200/200?random=15&keyword=damage"
      ],
      "response": "",
      "response_date": ""
    },
    {
      "id": "REV004",
      "customer": "Mike Thompson",
      "avatar": "https://picsum.photos/80/80?random=4&keyword=man",
      "product": "Gaming Mouse",
      "product_image": "https://picsum.photos/100/100?random=16&keyword=mouse",
      "rating": 5,
      "title": "Perfect for gaming",
      "review": "Excellent mouse with precise tracking and comfortable grip. RGB lighting is a nice touch. Great for long gaming sessions.",
      "verified_purchase": true,
      "helpful_count": 32,
      "date": "2024-06-15",
      "status": "Published",
      "photos": [],
      "response": "",
      "response_date": ""
    },
    {
      "id": "REV005",
      "customer": "Emma Wilson",
      "avatar": "https://picsum.photos/80/80?random=5&keyword=woman",
      "product": "Wireless Keyboard",
      "product_image": "https://picsum.photos/100/100?random=17&keyword=keyboard",
      "rating": 3,
      "title": "Average product",
      "review": "The keyboard is okay but keys feel mushy and connection drops occasionally. Expected better for this price range.",
      "verified_purchase": true,
      "helpful_count": 6,
      "date": "2024-06-14",
      "status": "Published",
      "photos": [],
      "response": "We appreciate your honest feedback. Please contact our support team for assistance with the connection issues.",
      "response_date": "2024-06-15"
    }
  ];

  List<Map<String, dynamic>> get filteredReviews {
    return reviewsData.where((review) {
      bool matchesSearch = "${review["customer"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${review["product"]}".toLowerCase().contains(searchQuery.toLowerCase()) ||
                          "${review["title"]}".toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesRating = selectedRating == "All" || (review["rating"] as int).toString() == selectedRating;
      bool matchesStatus = selectedStatus == "All" || review["status"] == selectedStatus;
      bool matchesVerified = !showOnlyVerified || (review["verified_purchase"] as bool);
      
      return matchesSearch && matchesRating && matchesStatus && matchesVerified;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return QTabBar(
      title: "Reviews & Ratings",
      selectedIndex: selectedTab,
      tabs: [
        Tab(text: "All Reviews", icon: Icon(Icons.rate_review)),
        Tab(text: "Analytics", icon: Icon(Icons.analytics)),
        Tab(text: "Moderation", icon: Icon(Icons.admin_panel_settings)),
      ],
      tabChildren: [
        _buildReviewsListTab(),
        _buildAnalyticsTab(),
        _buildModerationTab(),
      ],
    );
  }

  Widget _buildReviewsListTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildSearchAndFilters(),
          _buildReviewsStats(),
          _buildReviewsList(),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      spacing: spSm,
      children: [
        QTextField(
          label: "Search reviews",
          value: searchQuery,
          hint: "Search by customer, product, or review title",
          onChanged: (value) {
            searchQuery = value;
            setState(() {});
          },
        ),
        Row(
          children: [
            Expanded(
              child: QDropdownField(
                label: "Rating",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "5 Stars", "value": "5"},
                  {"label": "4 Stars", "value": "4"},
                  {"label": "3 Stars", "value": "3"},
                  {"label": "2 Stars", "value": "2"},
                  {"label": "1 Star", "value": "1"},
                ],
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
                label: "Status",
                items: [
                  {"label": "All", "value": "All"},
                  {"label": "Published", "value": "Published"},
                  {"label": "Under Review", "value": "Under Review"},
                  {"label": "Hidden", "value": "Hidden"},
                ],
                value: selectedStatus,
                onChanged: (value, label) {
                  selectedStatus = value;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Show only verified purchases",
                    "value": true,
                    "checked": showOnlyVerified,
                  }
                ],
                value: [
                  if (showOnlyVerified)
                    {
                      "label": "Show only verified purchases",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  showOnlyVerified = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewsStats() {
    int totalReviews = reviewsData.length;
    double avgRating = reviewsData.fold(0.0, (sum, r) => sum + (r["rating"] as int)) / totalReviews;
    int verifiedReviews = reviewsData.where((r) => r["verified_purchase"] as bool).length;
    int pendingReviews = reviewsData.where((r) => r["status"] == "Under Review").length;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "$totalReviews",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Total Reviews",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: warningColor, size: 20),
                    SizedBox(width: spXs),
                    Text(
                      "${avgRating.toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: warningColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "Average Rating",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: spSm),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                Text(
                  "$verifiedReviews",
                  style: TextStyle(
                    fontSize: fsH4,
                    fontWeight: FontWeight.bold,
                    color: successColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "Verified",
                  style: TextStyle(
                    fontSize: 12,
                    color: disabledBoldColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewsList() {
    return Column(
      spacing: spSm,
      children: filteredReviews.map((review) {
        return Container(
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radiusMd),
            boxShadow: [shadowSm],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spSm,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusLg),
                      image: DecorationImage(
                        image: NetworkImage("${review["avatar"]}"),
                        fit: BoxFit.cover,
                      ),
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
                              "${review["customer"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            if (review["verified_purchase"] as bool) ...[
                              SizedBox(width: spXs),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: spXs, vertical: 2),
                                decoration: BoxDecoration(
                                  color: successColor.withAlpha(50),
                                  borderRadius: BorderRadius.circular(radiusXs),
                                ),
                                child: Text(
                                  "Verified",
                                  style: TextStyle(
                                    color: successColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        Text(
                          "${review["date"]}",
                          style: TextStyle(
                            color: disabledBoldColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                    decoration: BoxDecoration(
                      color: _getStatusColor(review["status"]).withAlpha(50),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Text(
                      "${review["status"]}",
                      style: TextStyle(
                        color: _getStatusColor(review["status"]),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radiusSm),
                      image: DecorationImage(
                        image: NetworkImage("${review["product_image"]}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: spSm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${review["product"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                              color: warningColor,
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                "${review["title"]}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fsH6,
                ),
              ),
              Text(
                "${review["review"]}",
                style: TextStyle(
                  color: disabledBoldColor,
                  fontSize: 13,
                ),
              ),
              if ((review["photos"] as List).isNotEmpty) ...[
                QHorizontalScroll(
                  children: (review["photos"] as List).map((photo) {
                    return Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(right: spSm),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radiusSm),
                        image: DecorationImage(
                          image: NetworkImage("$photo"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if ("${review["response"]}".isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(spSm),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spXs,
                    children: [
                      Text(
                        "Our Response:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "${review["response"]}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                      Text(
                        "Responded on ${review["response_date"]}",
                        style: TextStyle(
                          fontSize: 10,
                          color: disabledColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.thumb_up, size: 16, color: disabledBoldColor),
                      SizedBox(width: spXs),
                      Text(
                        "Helpful (${review["helpful_count"]})",
                        style: TextStyle(
                          color: disabledBoldColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  if (review["response"].toString().isEmpty) ...[
                    QButton(
                      label: "Respond",
                      size: bs.sm,
                      onPressed: () {
                        // Handle respond action
                      },
                    ),
                    SizedBox(width: spXs),
                  ],
                  QButton(
                    icon: Icons.more_vert,
                    size: bs.sm,
                    onPressed: () {
                      // Handle more actions
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          _buildRatingTrends(),
          _buildProductRatings(),
          _buildReviewMetrics(),
        ],
      ),
    );
  }

  Widget _buildRatingTrends() {
    Map<int, int> ratingCounts = {};
    for (var review in reviewsData) {
      int rating = review["rating"] as int;
      ratingCounts[rating] = (ratingCounts[rating] ?? 0) + 1;
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Rating Distribution",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...List.generate(5, (index) {
            int rating = 5 - index;
            int count = ratingCounts[rating] ?? 0;
            double percentage = count / reviewsData.length;
            
            return Row(
              children: [
                Text(
                  "$rating",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(width: spXs),
                Icon(Icons.star, color: warningColor, size: 16),
                SizedBox(width: spSm),
                Expanded(
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: disabledColor.withAlpha(50),
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
                  "$count (${(percentage * 100).toStringAsFixed(0)}%)",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProductRatings() {
    Map<String, List<int>> productRatings = {};
    for (var review in reviewsData) {
      String product = review["product"] as String;
      if (!productRatings.containsKey(product)) {
        productRatings[product] = [];
      }
      productRatings[product]!.add(review["rating"] as int);
    }

    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Product Ratings",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...productRatings.entries.map((entry) {
            double avgRating = entry.value.fold(0.0, (sum, rating) => sum + rating) / entry.value.length;
            return Row(
              children: [
                Expanded(
                  child: Text(
                    entry.key,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < avgRating.round() ? Icons.star : Icons.star_border,
                      color: warningColor,
                      size: 16,
                    );
                  }),
                ),
                SizedBox(width: spSm),
                Text(
                  "${avgRating.toStringAsFixed(1)} (${entry.value.length})",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReviewMetrics() {
    int withPhotos = reviewsData.where((r) => (r["photos"] as List).isNotEmpty).length;
    int withResponse = reviewsData.where((r) => r["response"].toString().isNotEmpty).length;
    
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spMd,
        children: [
          Text(
            "Review Metrics",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: infoColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$withPhotos",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                      Text(
                        "With Photos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(spMd),
                  decoration: BoxDecoration(
                    color: successColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$withResponse",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                      Text(
                        "Responded",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: disabledBoldColor,
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
    );
  }

  Widget _buildModerationTab() {
    List<Map<String, dynamic>> pendingReviews = reviewsData.where((r) => r["status"] == "Under Review").toList();
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(spMd),
      child: Column(
        spacing: spMd,
        children: [
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusMd),
              boxShadow: [shadowSm],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spMd,
              children: [
                Text(
                  "Pending Reviews (${pendingReviews.length})",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (pendingReviews.isEmpty) ...[
                  Container(
                    padding: EdgeInsets.all(spLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 64,
                          color: successColor,
                        ),
                        SizedBox(height: spSm),
                        Text(
                          "No pending reviews",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.w600,
                            color: disabledBoldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  ...pendingReviews.map((review) {
                    return Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        border: Border.all(color: disabledOutlineBorderColor),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spSm,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${review["customer"]} - ${review["product"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Row(
                                children: List.generate(review["rating"] as int, (index) {
                                  return Icon(Icons.star, color: warningColor, size: 16);
                                }),
                              ),
                            ],
                          ),
                          Text(
                            "${review["review"]}",
                            style: TextStyle(
                              fontSize: 13,
                              color: disabledBoldColor,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: QButton(
                                  label: "Approve",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Handle approve
                                  },
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: QButton(
                                  label: "Reject",
                                  size: bs.sm,
                                  onPressed: () {
                                    // Handle reject
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Published":
        return successColor;
      case "Under Review":
        return warningColor;
      case "Hidden":
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }
}
