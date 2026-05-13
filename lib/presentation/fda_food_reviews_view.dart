import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class FdaFoodReviewsView extends StatefulWidget {
  const FdaFoodReviewsView({super.key});

  @override
  State<FdaFoodReviewsView> createState() => _FdaFoodReviewsViewState();
}

class _FdaFoodReviewsViewState extends State<FdaFoodReviewsView> {
  String selectedSort = "newest";
  bool showPhotosOnly = false;
  
  Map<String, dynamic> foodItem = {
    "id": 1,
    "name": "Spaghetti Carbonara",
    "restaurant": "Bella Italia",
    "price": 18.99,
    "image": "https://placehold.co/400x300?text=Carbonara",
    "averageRating": 4.5,
    "totalReviews": 89,
    "ratingBreakdown": {
      "5": 45,
      "4": 32,
      "3": 8,
      "2": 3,
      "1": 1
    }
  };

  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "customerName": "Jennifer Wilson",
      "customerImage": "https://placehold.co/40x40?text=JW",
      "rating": 5.0,
      "date": "2024-06-15",
      "review": "Absolutely perfect! The pasta was cooked al dente and the sauce was creamy and rich. Exactly how carbonara should be made!",
      "helpful": 18,
      "images": [
        "https://placehold.co/300x200?text=Carbonara+1",
        "https://placehold.co/300x200?text=Carbonara+2"
      ],
      "orderSize": "Regular",
      "orderDate": "2024-06-14",
      "verified": true,
      "tags": ["Authentic", "Perfect Portion", "Fast Delivery"]
    },
    {
      "id": 2,
      "customerName": "Mark Thompson",
      "customerImage": "https://placehold.co/40x40?text=MT",
      "rating": 4.0,
      "date": "2024-06-13",
      "review": "Very good carbonara! Sauce was creamy and bacon was crispy. Only minor complaint is that it could use a bit more seasoning.",
      "helpful": 12,
      "images": [],
      "orderSize": "Large",
      "orderDate": "2024-06-13",
      "verified": true,
      "tags": ["Good Taste", "Large Portion"]
    },
    {
      "id": 3,
      "customerName": "Sofia Martinez",
      "customerImage": "https://placehold.co/40x40?text=SM",
      "rating": 5.0,
      "date": "2024-06-12",
      "review": "Best carbonara in town! The restaurant really knows Italian cuisine. Will definitely order again!",
      "helpful": 25,
      "images": [
        "https://placehold.co/300x200?text=Perfect+Dish"
      ],
      "orderSize": "Regular",
      "orderDate": "2024-06-12",
      "verified": true,
      "tags": ["Authentic", "Excellent", "Highly Recommended"]
    },
    {
      "id": 4,
      "customerName": "Robert Chen",
      "customerImage": "https://placehold.co/40x40?text=RC",
      "rating": 3.0,
      "date": "2024-06-11",
      "review": "It was okay. The pasta was a bit overcooked for my taste and the sauce was too thick. Not bad but not great either.",
      "helpful": 7,
      "images": [],
      "orderSize": "Regular",
      "orderDate": "2024-06-11",
      "verified": false,
      "tags": ["Average"]
    },
    {
      "id": 5,
      "customerName": "Emma Johnson",
      "customerImage": "https://placehold.co/40x40?text=EJ",
      "rating": 4.0,
      "date": "2024-06-10",
      "review": "Really enjoyed this dish! Fresh ingredients and good flavor. The portion size was perfect for lunch.",
      "helpful": 14,
      "images": [
        "https://placehold.co/300x200?text=Fresh+Pasta"
      ],
      "orderSize": "Small",
      "orderDate": "2024-06-10",
      "verified": true,
      "tags": ["Fresh", "Good Portion", "Tasty"]
    }
  ];

  List<Map<String, dynamic>> sortOptions = [
    {"label": "Newest First", "value": "newest"},
    {"label": "Oldest First", "value": "oldest"},
    {"label": "Highest Rated", "value": "highest"},
    {"label": "Most Helpful", "value": "helpful"}
  ];

  List<Map<String, dynamic>> get filteredReviews {
    List<Map<String, dynamic>> filtered = reviews;
    
    if (showPhotosOnly) {
      filtered = filtered.where((review) => (review["images"] as List).isNotEmpty).toList();
    }
    
    // Sort reviews
    switch (selectedSort) {
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

  Widget _buildFoodHeader() {
    return Container(
      padding: EdgeInsets.all(spMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: [shadowSm],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radiusMd),
              image: DecorationImage(
                image: NetworkImage("${foodItem["image"]}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: spMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${foodItem["name"]}",
                  style: TextStyle(
                    fontSize: fsH6,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spXs),
                Text(
                  "${foodItem["restaurant"]}",
                  style: TextStyle(
                    fontSize: 14,
                    color: disabledBoldColor,
                  ),
                ),
                SizedBox(height: spXs),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < (foodItem["averageRating"] as double).floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: warningColor,
                          size: 16,
                        );
                      }),
                    ),
                    SizedBox(width: spSm),
                    Text(
                      "${foodItem["averageRating"]} (${foodItem["totalReviews"]} reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spXs),
                Text(
                  "\$${(foodItem["price"] as double).toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBreakdown() {
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
            "Rating Breakdown",
            style: TextStyle(
              fontSize: fsH6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          SizedBox(height: spMd),
          Column(
            children: List.generate(5, (index) {
              int starCount = 5 - index;
              Map<String, dynamic> breakdown = foodItem["ratingBreakdown"];
              int count = breakdown["$starCount"] ?? 0;
              double percentage = count / (foodItem["totalReviews"] as int);
              
              return Padding(
                padding: EdgeInsets.only(bottom: spSm),
                child: Row(
                  children: [
                    Text(
                      "$starCount",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: spXs),
                    Icon(
                      Icons.star,
                      color: warningColor,
                      size: 14,
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
          Row(
            children: [
              Expanded(
                child: QDropdownField(
                  label: "Sort Reviews",
                  items: sortOptions,
                  value: selectedSort,
                  onChanged: (value, label) {
                    selectedSort = value;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(width: spMd),
              Column(
                children: [
                  Text(
                    "Photos Only",
                    style: TextStyle(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Switch(
                    value: showPhotosOnly,
                    onChanged: (value) {
                      showPhotosOnly = value;
                      setState(() {});
                    },
                  ),
                ],
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
                          "${review["date"]} • ${review["orderSize"]} size",
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
          if ((review["tags"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            Wrap(
              spacing: spXs,
              runSpacing: spXs,
              children: (review["tags"] as List).map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: spSm, vertical: spXs),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(radiusLg),
                  ),
                  child: Text(
                    "$tag",
                    style: TextStyle(
                      fontSize: 11,
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          if ((review["images"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: (review["images"] as List).map((image) {
                return Container(
                  width: 100,
                  height: 100,
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
                    "${review["helpful"]} found this helpful",
                    style: TextStyle(
                      fontSize: 12,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  QButton(
                    label: "Helpful",
                    size: bs.sm,
                    onPressed: () {
                      review["helpful"] = (review["helpful"] as int) + 1;
                      setState(() {});
                      ss("Thank you for your feedback!");
                    },
                  ),
                  SizedBox(width: spSm),
                  QButton(
                    label: "Reply",
                    size: bs.sm,
                    onPressed: () {
                      //navigateTo(FdaReplyReviewView())
                    },
                  ),
                ],
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
        title: Text("Food Reviews"),
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
            _buildFoodHeader(),
            SizedBox(height: spMd),
            _buildRatingBreakdown(),
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
                    //navigateTo(FdaWriteFoodReviewView())
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
