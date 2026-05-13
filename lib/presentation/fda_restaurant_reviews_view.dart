import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaRestaurantReviewsView extends StatefulWidget {
  const FdaRestaurantReviewsView({super.key});

  @override
  State<FdaRestaurantReviewsView> createState() => _FdaRestaurantReviewsViewState();
}

class _FdaRestaurantReviewsViewState extends State<FdaRestaurantReviewsView> {
  String selectedFilter = "All";
  String sortBy = "newest";
  
  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "customerName": "Sarah Johnson",
      "customerImage": "https://placehold.co/40x40?text=SJ",
      "rating": 5.0,
      "date": "2024-06-14",
      "review": "Amazing food and excellent service! The pasta was perfectly cooked and the ambiance was wonderful. Definitely coming back!",
      "helpful": 24,
      "images": [
        "https://placehold.co/300x200?text=Food+1",
        "https://placehold.co/300x200?text=Food+2"
      ],
      "orderItems": ["Spaghetti Carbonara", "Caesar Salad"],
      "verified": true
    },
    {
      "id": 2,
      "customerName": "Mike Chen",
      "customerImage": "https://placehold.co/40x40?text=MC",
      "rating": 4.0,
      "date": "2024-06-13",
      "review": "Good food overall, but the delivery took longer than expected. The pizza was still warm though!",
      "helpful": 12,
      "images": [],
      "orderItems": ["Margherita Pizza", "Garlic Bread"],
      "verified": true
    },
    {
      "id": 3,
      "customerName": "Emily Davis",
      "customerImage": "https://placehold.co/40x40?text=ED",
      "rating": 3.0,
      "date": "2024-06-12",
      "review": "Average experience. Food was okay but nothing special. Customer service could be improved.",
      "helpful": 8,
      "images": [],
      "orderItems": ["Chicken Burger"],
      "verified": false
    },
    {
      "id": 4,
      "customerName": "David Wilson",
      "customerImage": "https://placehold.co/40x40?text=DW",
      "rating": 5.0,
      "date": "2024-06-11",
      "review": "Exceptional quality and taste! The chef really knows how to prepare authentic Italian cuisine. Highly recommended!",
      "helpful": 31,
      "images": [
        "https://placehold.co/300x200?text=Dish+1"
      ],
      "orderItems": ["Risotto Mushroom", "Tiramisu"],
      "verified": true
    },
    {
      "id": 5,
      "customerName": "Lisa Rodriguez",
      "customerImage": "https://placehold.co/40x40?text=LR",
      "rating": 2.0,
      "date": "2024-06-10",
      "review": "Disappointed with the quality. Food arrived cold and the portion size was smaller than expected for the price.",
      "helpful": 5,
      "images": [],
      "orderItems": ["Fish and Chips"],
      "verified": true
    }
  ];

  List<Map<String, dynamic>> filterOptions = [
    {"label": "All", "value": "All"},
    {"label": "5 Stars", "value": "5"},
    {"label": "4 Stars", "value": "4"},
    {"label": "3 Stars", "value": "3"},
    {"label": "2 Stars", "value": "2"},
    {"label": "1 Star", "value": "1"},
    {"label": "With Photos", "value": "photos"}
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Highest Rated", "value": "highest"},
    {"label": "Most Helpful", "value": "helpful"}
  ];

  Map<String, dynamic> restaurantStats = {
    "totalReviews": 247,
    "averageRating": 4.3,
    "ratingDistribution": {
      "5": 128,
      "4": 89,
      "3": 20,
      "2": 7,
      "1": 3
    }
  };

  List<Map<String, dynamic>> get filteredReviews {
    List<Map<String, dynamic>> filtered = reviews;
    
    if (selectedFilter != "All") {
      if (selectedFilter == "photos") {
        filtered = filtered.where((review) => (review["images"] as List).isNotEmpty).toList();
      } else {
        double filterRating = double.parse(selectedFilter);
        filtered = filtered.where((review) => (review["rating"] as double) == filterRating).toList();
      }
    }
    
    // Sort reviews
    switch (sortBy) {
      case "oldest":
        filtered.sort((a, b) => a["date"].compareTo(b["date"]));
        break;
      case "highest":
        filtered.sort((a, b) => (b["rating"] as double).compareTo(a["rating"] as double));
        break;
      case "helpful":
        filtered.sort((a, b) => (b["helpful"] as int).compareTo(a["helpful"] as int));
        break;
      default: // newest
        filtered.sort((a, b) => b["date"].compareTo(a["date"]));
    }
    
    return filtered;
  }

  Widget _buildRatingOverview() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${restaurantStats["averageRating"]}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (restaurantStats["averageRating"] as double).floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: warningColor,
                                size: 16,
                              );
                            }),
                          ),
                          SizedBox(height: spXs),
                          Text(
                            "${restaurantStats["totalReviews"]} reviews",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: spLg),
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    int starCount = 5 - index;
                    Map<String, dynamic> distribution = restaurantStats["ratingDistribution"];
                    int count = distribution["$starCount"] ?? 0;
                    double percentage = count / (restaurantStats["totalReviews"] as int);
                    
                    return Padding(
                      padding: EdgeInsets.only(bottom: spXs),
                      child: Row(
                        children: [
                          Text(
                            "$starCount",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                          SizedBox(width: spXs),
                          Icon(
                            Icons.star,
                            color: warningColor,
                            size: 12,
                          ),
                          SizedBox(width: spSm),
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
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersAndSort() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter Reviews",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spSm),
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
                  value: sortBy,
                  onChanged: (value, label) {
                    sortBy = value;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.only(bottom: spMd),
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${review["customerImage"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${review["customerName"]}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        if (review["verified"] == true) ...[
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
                              index < (review["rating"] as double).floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: warningColor,
                              size: 14,
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
              Icon(
                Icons.more_vert,
                color: disabledBoldColor,
                size: 20,
              ),
            ],
          ),
          SizedBox(height: spSm),
          Text(
            "${review["review"]}",
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              height: 1.5,
            ),
          ),
          if ((review["orderItems"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Container(
              padding: EdgeInsets.all(spSm),
              decoration: BoxDecoration(
                color: disabledColor,
                borderRadius: BorderRadius.circular(radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: disabledBoldColor,
                    size: 16,
                  ),
                  SizedBox(width: spXs),
                  Expanded(
                    child: Text(
                      "Ordered: ${(review["orderItems"] as List).join(", ")}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if ((review["images"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: (review["images"] as List).map((image) {
                return Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                    image: DecorationImage(
                      image: NetworkImage("$image"),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          SizedBox(height: spSm),
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: disabledBoldColor,
                    size: 16,
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
              Spacer(),
              QButton(
                label: "Helpful",
                size: bs.sm,
                onPressed: () {
                  review["helpful"] = (review["helpful"] as int) + 1;
                  setState(() {});
                  ss("Marked as helpful");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Reviews"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              ss("Reviews shared");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          children: [
            _buildRatingOverview(),
            SizedBox(height: spMd),
            _buildFiltersAndSort(),
            SizedBox(height: spMd),
            Row(
              children: [
                Text(
                  "${filteredReviews.length} Reviews",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                Spacer(),
                QButton(
                  label: "Write Review",
                  size: bs.sm,
                  onPressed: () {
                    //navigateTo(FdaWriteReviewView())
                  },
                ),
              ],
            ),
            SizedBox(height: spMd),
            ...filteredReviews.map((review) => _buildReviewCard(review)),
          ],
        ),
      ),
    );
  }
}
