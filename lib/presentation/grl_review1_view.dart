import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlReview1View extends StatefulWidget {
  @override
  State<GrlReview1View> createState() => _GrlReview1ViewState();
}

class _GrlReview1ViewState extends State<GrlReview1View> {
  int selectedRating = 0;
  String reviewTitle = "";
  String reviewContent = "";
  bool isAnonymous = false;
  bool recommendToFriends = false;
  List<String> selectedTags = [];
  
  List<String> availableTags = [
    "Excellent Service",
    "Great Value",
    "Fast Delivery",
    "Quality Product",
    "Friendly Staff",
    "Clean Environment",
    "Would Recommend",
    "Professional",
  ];
  
  List<Map<String, dynamic>> previousReviews = [
    {
      "id": 1,
      "product": "Wireless Headphones",
      "rating": 5,
      "date": DateTime.now().subtract(Duration(days: 5)),
      "title": "Amazing sound quality!",
      "content": "Best headphones I've ever owned. The bass is incredible.",
      "verified": true,
    },
    {
      "id": 2,
      "product": "Coffee Maker",
      "rating": 4,
      "date": DateTime.now().subtract(Duration(days: 12)),
      "title": "Good but could be better",
      "content": "Makes great coffee but takes a bit long to brew.",
      "verified": true,
    },
    {
      "id": 3,
      "product": "Running Shoes",
      "rating": 5,
      "date": DateTime.now().subtract(Duration(days: 20)),
      "title": "Perfect for daily runs",
      "content": "Comfortable and durable. Highly recommend for runners.",
      "verified": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Review"),
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
            // Product Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowMd],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(radiusLg),
                    child: Image.network(
                      "https://picsum.photos/80/80?random=1&keyword=product",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium Bluetooth Speaker",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "Model: BTS-2024 Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: disabledBoldColor,
                          ),
                        ),
                        SizedBox(height: spXs),
                        Text(
                          "\$199.99",
                          style: TextStyle(
                            fontSize: fsH6,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Rating Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rate this product",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) => GestureDetector(
                      onTap: () {
                        selectedRating = index + 1;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: spXs),
                        child: Icon(
                          selectedRating > index ? Icons.star : Icons.star_border,
                          size: 40,
                          color: selectedRating > index ? warningColor : disabledColor,
                        ),
                      ),
                    )),
                  ),
                  SizedBox(height: spSm),
                  if (selectedRating > 0)
                    Center(
                      child: Text(
                        _getRatingText(selectedRating),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: _getRatingColor(selectedRating),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Review Form
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Write your review",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  
                  QTextField(
                    label: "Review Title",
                    value: reviewTitle,
                    hint: "Give your review a title",
                    onChanged: (value) {
                      reviewTitle = value;
                      setState(() {});
                    },
                  ),
                  
                  SizedBox(height: spMd),
                  
                  QMemoField(
                    label: "Review Content",
                    value: reviewContent,
                    hint: "Share your experience with this product...",
                    onChanged: (value) {
                      reviewContent = value;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Tags Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add tags (optional)",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: spMd),
                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: availableTags.map((tag) => GestureDetector(
                      onTap: () {
                        if (selectedTags.contains(tag)) {
                          selectedTags.remove(tag);
                        } else {
                          selectedTags.add(tag);
                        }
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: spMd,
                          vertical: spSm,
                        ),
                        decoration: BoxDecoration(
                          color: selectedTags.contains(tag) ? primaryColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: selectedTags.contains(tag) ? primaryColor : disabledColor,
                          ),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: selectedTags.contains(tag) ? Colors.white : disabledBoldColor,
                          ),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Options
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Post as anonymous",
                              "value": true,
                              "checked": isAnonymous,
                            }
                          ],
                          value: [
                            if (isAnonymous)
                              {
                                "label": "Post as anonymous",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            isAnonymous = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Expanded(
                        child: QSwitch(
                          items: [
                            {
                              "label": "Recommend to friends",
                              "value": true,
                              "checked": recommendToFriends,
                            }
                          ],
                          value: [
                            if (recommendToFriends)
                              {
                                "label": "Recommend to friends",
                                "value": true,
                                "checked": true
                              }
                          ],
                          onChanged: (values, ids) {
                            recommendToFriends = values.isNotEmpty;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Review",
                size: bs.md,
                onPressed: selectedRating > 0 && reviewTitle.isNotEmpty && reviewContent.isNotEmpty
                    ? () {
                        ss("Review submitted successfully!");
                      }
                    : () {},
              ),
            ),
            
            SizedBox(height: spMd),
            
            // Previous Reviews
            Text(
              "Your Previous Reviews",
              style: TextStyle(
                fontSize: fsH6,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            SizedBox(height: spMd),
            
            ...previousReviews.map((review) => Container(
              margin: EdgeInsets.only(bottom: spMd),
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusLg),
                boxShadow: [shadowSm],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${review["product"]}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (review["verified"] as bool)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spSm,
                            vertical: spXs,
                          ),
                          decoration: BoxDecoration(
                            color: successColor,
                            borderRadius: BorderRadius.circular(radiusSm),
                          ),
                          child: Text(
                            "VERIFIED",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) => Icon(
                          index < (review["rating"] as int) ? Icons.star : Icons.star_border,
                          size: 16,
                          color: index < (review["rating"] as int) ? warningColor : disabledColor,
                        )),
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "${(review["date"] as DateTime).dMMMy}",
                        style: TextStyle(
                          fontSize: 12,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "${review["title"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: spXs),
                  Text(
                    "${review["content"]}",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Poor";
      case 2:
        return "Fair";
      case 3:
        return "Good";
      case 4:
        return "Very Good";
      case 5:
        return "Excellent";
      default:
        return "";
    }
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 1:
      case 2:
        return dangerColor;
      case 3:
        return warningColor;
      case 4:
      case 5:
        return successColor;
      default:
        return disabledColor;
    }
  }
}
