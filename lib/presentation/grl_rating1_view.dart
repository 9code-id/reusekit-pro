import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRating1View extends StatefulWidget {
  @override
  State<GrlRating1View> createState() => _GrlRating1ViewState();
}

class _GrlRating1ViewState extends State<GrlRating1View> {
  double currentRating = 0.0;
  String reviewText = "";
  String selectedCategory = "service";
  bool isSubmitting = false;

  List<Map<String, dynamic>> ratingCategories = [
    {
      "id": "service",
      "label": "Service Quality",
      "icon": Icons.support_agent,
      "rating": 0.0,
    },
    {
      "id": "product",
      "label": "Product Quality",
      "icon": Icons.inventory,
      "rating": 0.0,
    },
    {
      "id": "delivery",
      "label": "Delivery Speed",
      "icon": Icons.local_shipping,
      "rating": 0.0,
    },
    {
      "id": "value",
      "label": "Value for Money",
      "icon": Icons.attach_money,
      "rating": 0.0,
    },
  ];

  List<Map<String, dynamic>> quickReviews = [
    {"text": "Great experience!", "rating": 5.0},
    {"text": "Good service overall", "rating": 4.0},
    {"text": "Average quality", "rating": 3.0},
    {"text": "Could be better", "rating": 2.0},
    {"text": "Not satisfied", "rating": 1.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Experience"),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Rating Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spLg),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withAlpha(180)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.star_rate,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "How was your experience?",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "Your feedback helps us improve",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          currentRating = index + 1.0;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            currentRating > index ? Icons.star : Icons.star_border,
                            size: 32,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    _getRatingText(currentRating),
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: spMd),

            // Category Ratings
            Text(
              "Rate by Category",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            ...ratingCategories.map((category) => Container(
              margin: EdgeInsets.only(bottom: spSm),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(spSm),
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusSm),
                    ),
                    child: Icon(
                      category["icon"] as IconData,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Text(
                      "${category["label"]}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          category["rating"] = index + 1.0;
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            (category["rating"] as double) > index ? Icons.star : Icons.star_border,
                            size: 20,
                            color: warningColor,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            )).toList(),

            SizedBox(height: spMd),

            // Quick Review Options
            Text(
              "Quick Reviews",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            Wrap(
              spacing: spSm,
              runSpacing: spSm,
              children: quickReviews.map((review) => GestureDetector(
                onTap: () {
                  reviewText = review["text"];
                  currentRating = review["rating"];
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: spMd,
                    vertical: spSm,
                  ),
                  decoration: BoxDecoration(
                    color: reviewText == review["text"] ? primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(radiusLg),
                    boxShadow: [shadowSm],
                    border: Border.all(
                      color: reviewText == review["text"] ? primaryColor : disabledOutlineBorderColor,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: List.generate((review["rating"] as double).toInt(), (index) {
                          return Icon(
                            Icons.star,
                            size: 12,
                            color: reviewText == review["text"] ? Colors.white : warningColor,
                          );
                        }),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "${review["text"]}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: reviewText == review["text"] ? Colors.white : primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),

            SizedBox(height: spMd),

            // Custom Review
            Text(
              "Write Your Review",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            SizedBox(height: spSm),

            QMemoField(
              label: "Share your detailed experience",
              value: reviewText,
              hint: "Tell us what you liked or how we can improve...",
              onChanged: (value) {
                reviewText = value;
                setState(() {});
              },
            ),

            SizedBox(height: spMd),

            // Rating Summary
            Container(
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: successColor.withAlpha(20),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: successColor.withAlpha(50)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.assessment,
                        color: successColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Rating Summary",
                        style: TextStyle(
                          fontSize: fsH6,
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Text(
                        "Overall Rating:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: spSm),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            currentRating > index ? Icons.star : Icons.star_border,
                            size: 16,
                            color: warningColor,
                          );
                        }),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${currentRating.toStringAsFixed(1)}/5.0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: successColor,
                        ),
                      ),
                    ],
                  ),
                  if (ratingCategories.any((c) => (c["rating"] as double) > 0)) ...[
                    SizedBox(height: spSm),
                    Text(
                      "Average Category Rating: ${_getAverageRating().toStringAsFixed(1)}/5.0",
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: spLg),

            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: isSubmitting ? "Submitting..." : "Submit Review",
                onPressed: currentRating > 0 ? _submitReview : null,
              ),
            ),

            SizedBox(height: spSm),

            Center(
              child: Text(
                "Your review will be published after verification",
                style: TextStyle(
                  fontSize: 12,
                  color: disabledBoldColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRatingText(double rating) {
    if (rating >= 5.0) return "Excellent!";
    if (rating >= 4.0) return "Great!";
    if (rating >= 3.0) return "Good";
    if (rating >= 2.0) return "Fair";
    if (rating >= 1.0) return "Poor";
    return "Rate your experience";
  }

  double _getAverageRating() {
    List<double> ratings = ratingCategories
        .map((c) => c["rating"] as double)
        .where((r) => r > 0)
        .toList();
    
    if (ratings.isEmpty) return 0.0;
    return ratings.reduce((a, b) => a + b) / ratings.length;
  }

  void _submitReview() async {
    isSubmitting = true;
    setState(() {});

    await Future.delayed(Duration(seconds: 2));

    isSubmitting = false;
    setState(() {});

    ss("Review submitted successfully!");
    
    // navigateTo(ThankYouView());
  }
}
