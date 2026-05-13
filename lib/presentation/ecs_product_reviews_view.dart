import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class EcsProductReviewsView extends StatefulWidget {
  const EcsProductReviewsView({super.key});

  @override
  State<EcsProductReviewsView> createState() => _EcsProductReviewsViewState();
}

class _EcsProductReviewsViewState extends State<EcsProductReviewsView> {
  int selectedRatingFilter = 0; // 0 = All, 1-5 = specific stars
  String selectedSortBy = "newest";
  
  List<Map<String, dynamic>> reviews = [
    {
      "id": 1,
      "user_name": "Sarah Johnson",
      "user_avatar": "https://picsum.photos/50/50?random=1&keyword=person",
      "rating": 5,
      "date": "2024-06-10",
      "review": "Absolutely love this product! The quality is outstanding and delivery was super fast. Highly recommend!",
      "verified_purchase": true,
      "helpful_count": 12,
      "images": [
        "https://picsum.photos/100/100?random=10&keyword=review",
        "https://picsum.photos/100/100?random=11&keyword=review",
      ],
    },
    {
      "id": 2,
      "user_name": "Mike Chen",
      "user_avatar": "https://picsum.photos/50/50?random=2&keyword=person",
      "rating": 4,
      "date": "2024-06-08",
      "review": "Good product overall. The build quality is solid but the color was slightly different from the photos. Still satisfied with the purchase.",
      "verified_purchase": true,
      "helpful_count": 8,
      "images": [],
    },
    {
      "id": 3,
      "user_name": "Emma Davis",
      "user_avatar": "https://picsum.photos/50/50?random=3&keyword=person",
      "rating": 5,
      "date": "2024-06-05",
      "review": "Perfect! Exactly what I was looking for. Great value for money and excellent customer service.",
      "verified_purchase": true,
      "helpful_count": 15,
      "images": [
        "https://picsum.photos/100/100?random=12&keyword=review",
      ],
    },
    {
      "id": 4,
      "user_name": "Alex Wilson",
      "user_avatar": "https://picsum.photos/50/50?random=4&keyword=person",
      "rating": 3,
      "date": "2024-06-03",
      "review": "It's okay. Does the job but nothing special. Packaging could be better.",
      "verified_purchase": false,
      "helpful_count": 3,
      "images": [],
    },
    {
      "id": 5,
      "user_name": "Lisa Brown",
      "user_avatar": "https://picsum.photos/50/50?random=5&keyword=person",
      "rating": 4,
      "date": "2024-06-01",
      "review": "Really impressed with the quality. Minor issue with shipping but customer support resolved it quickly.",
      "verified_purchase": true,
      "helpful_count": 6,
      "images": [],
    },
  ];

  Map<String, dynamic> reviewStats = {
    "total_reviews": 156,
    "average_rating": 4.3,
    "rating_breakdown": {
      "5": 68,
      "4": 45,
      "3": 28,
      "2": 10,
      "1": 5,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews & Ratings"),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => _showSortOptions(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${(reviewStats["average_rating"] as double).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: fsH1,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < (reviewStats["average_rating"] as double).floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: warningColor,
                                size: 20,
                              );
                            }),
                          ),
                          Text(
                            "Based on ${reviewStats["total_reviews"]} reviews",
                            style: TextStyle(
                              fontSize: 12,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spMd),
                  
                  // Rating Breakdown
                  Column(
                    children: List.generate(5, (index) {
                      final stars = 5 - index;
                      final count = (reviewStats["rating_breakdown"]["$stars"] as int);
                      final percentage = count / (reviewStats["total_reviews"] as int);
                      
                      return Padding(
                        padding: EdgeInsets.only(bottom: spXs),
                        child: Row(
                          children: [
                            Text(
                              "$stars",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: percentage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: warningColor,
                                      borderRadius: BorderRadius.circular(4),
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
            ),
            
            SizedBox(height: spMd),
            
            // Filter Options
            Text(
              "Filter Reviews",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            QHorizontalScroll(
              children: [
                _buildFilterChip("All", selectedRatingFilter == 0, () {
                  selectedRatingFilter = 0;
                  setState(() {});
                }),
                SizedBox(width: spSm),
                ...List.generate(5, (index) {
                  final stars = 5 - index;
                  return Row(
                    children: [
                      _buildFilterChip(
                        "$stars ⭐",
                        selectedRatingFilter == stars,
                        () {
                          selectedRatingFilter = stars;
                          setState(() {});
                        },
                      ),
                      SizedBox(width: spSm),
                    ],
                  );
                }),
                _buildFilterChip("With Photos", false, () {}),
                SizedBox(width: spSm),
                _buildFilterChip("Verified", false, () {}),
              ],
            ),
            
            SizedBox(height: spMd),
            
            // Reviews List
            Text(
              "Customer Reviews",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: spSm),
            
            Column(
              children: reviews.map((review) => _buildReviewCard(review)).toList(),
            ),
            
            SizedBox(height: spMd),
            
            // Load More Button
            Center(
              child: QButton(
                label: "Load More Reviews",
                size: bs.md,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(spMd),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [shadowSm],
        ),
        child: QButton(
          label: "Write a Review",
          icon: Icons.edit,
          size: bs.md,
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: spSm,
          vertical: spXs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          border: Border.all(
            color: isSelected ? primaryColor : disabledOutlineBorderColor,
          ),
          borderRadius: BorderRadius.circular(radiusSm),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : disabledBoldColor,
          ),
        ),
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
          // User Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage("${review["user_avatar"]}"),
              ),
              SizedBox(width: spSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${review["user_name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (review["verified_purchase"] as bool) ...[
                          SizedBox(width: spXs),
                          Icon(
                            Icons.verified,
                            color: successColor,
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "${review["date"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              // Rating
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
            ],
          ),
          
          SizedBox(height: spSm),
          
          // Review Text
          Text(
            "${review["review"]}",
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
          
          // Review Images
          if ((review["images"] as List).isNotEmpty) ...[
            SizedBox(height: spSm),
            QHorizontalScroll(
              children: (review["images"] as List).map<Widget>((imageUrl) {
                return Container(
                  width: 80,
                  height: 80,
                  margin: EdgeInsets.only(right: spSm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radiusSm),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radiusSm),
                    child: Image.network(
                      "$imageUrl",
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          
          SizedBox(height: spSm),
          
          // Helpful Actions
          Row(
            children: [
              Text(
                "Helpful?",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
              SizedBox(width: spSm),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: 16,
                      color: disabledBoldColor,
                    ),
                    SizedBox(width: spXs),
                    Text(
                      "${review["helpful_count"]}",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: spMd),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.thumb_down,
                  size: 16,
                  color: disabledBoldColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(spMd),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sort Reviews By",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              
              ...[
                {"label": "Newest First", "value": "newest"},
                {"label": "Oldest First", "value": "oldest"},
                {"label": "Highest Rating", "value": "highest"},
                {"label": "Lowest Rating", "value": "lowest"},
                {"label": "Most Helpful", "value": "helpful"},
              ].map((option) {
                return ListTile(
                  title: Text("${option["label"]}"),
                  trailing: selectedSortBy == option["value"]
                      ? Icon(Icons.check, color: primaryColor)
                      : null,
                  onTap: () {
                    selectedSortBy = "${option["value"]}";
                    setState(() {});
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
