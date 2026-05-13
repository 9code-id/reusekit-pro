import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class BfaRateAppView extends StatefulWidget {
  const BfaRateAppView({super.key});

  @override
  State<BfaRateAppView> createState() => _BfaRateAppViewState();
}

class _BfaRateAppViewState extends State<BfaRateAppView> {
  int rating = 0;
  String feedback = "";
  bool hasRated = false;
  bool showFeedbackForm = false;

  List<Map<String, dynamic>> features = [
    {
      "name": "User Interface",
      "rating": 4.8,
      "description": "Clean and intuitive design"
    },
    {
      "name": "Performance",
      "rating": 4.6,
      "description": "Fast and responsive"
    },
    {
      "name": "Features",
      "rating": 4.9,
      "description": "Comprehensive functionality"
    },
    {
      "name": "Support",
      "rating": 4.7,
      "description": "Helpful customer service"
    },
  ];

  List<Map<String, dynamic>> reviews = [
    {
      "user": "Sarah M.",
      "rating": 5,
      "date": "2024-12-20",
      "comment": "Amazing app! Very user-friendly and packed with useful features.",
      "helpful": 24
    },
    {
      "user": "John D.",
      "rating": 4,
      "date": "2024-12-18",
      "comment": "Great app overall. Would love to see dark mode in future updates.",
      "helpful": 18
    },
    {
      "user": "Emily R.",
      "rating": 5,
      "date": "2024-12-15",
      "comment": "Excellent customer support and constant improvements. Highly recommended!",
      "helpful": 32
    },
    {
      "user": "Mike T.",
      "rating": 4,
      "date": "2024-12-12",
      "comment": "Very helpful app. The interface is clean and easy to navigate.",
      "helpful": 15
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Our App"),
        actions: [
          Icon(
            Icons.star,
            color: warningColor,
          ),
          SizedBox(width: spMd),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: spMd,
          children: [
            // App Info Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radiusMd),
                boxShadow: [shadowSm],
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.circular(radiusMd),
                    ),
                    child: Icon(
                      Icons.phone_android,
                      color: primaryColor,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Text(
                    "ReuseKit App",
                    style: TextStyle(
                      fontSize: fsH4,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Version 2.1.3",
                    style: TextStyle(
                      fontSize: 14,
                      color: disabledBoldColor,
                    ),
                  ),
                  SizedBox(height: spSm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: warningColor,
                            size: 20,
                          );
                        }),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "4.8",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: warningColor,
                        ),
                      ),
                      SizedBox(width: spXs),
                      Text(
                        "(2,847 reviews)",
                        style: TextStyle(
                          fontSize: 14,
                          color: disabledBoldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Rating Section
            if (!hasRated)
              Container(
                width: double.infinity,
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
                      "Rate Your Experience",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "How would you rate our app? Your feedback helps us improve!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: disabledBoldColor,
                      ),
                    ),

                    // Star Rating
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              rating = index + 1;
                              showFeedbackForm = rating <= 4;
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(spSm),
                              child: Icon(
                                index < rating ? Icons.star : Icons.star_border,
                                color: warningColor,
                                size: 40,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    if (rating > 0)
                      Center(
                        child: Text(
                          _getRatingText(rating),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _getRatingColor(rating),
                          ),
                        ),
                      ),

                    // Feedback Form (shows for ratings <= 4)
                    if (showFeedbackForm)
                      Column(
                        spacing: spSm,
                        children: [
                          QMemoField(
                            label: "What can we improve?",
                            value: feedback,
                            hint: "Please tell us how we can make the app better for you...",
                            onChanged: (value) {
                              feedback = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),

                    if (rating > 0)
                      Container(
                        width: double.infinity,
                        child: QButton(
                          label: rating >= 5 
                              ? "Rate on App Store" 
                              : "Submit Feedback",
                          icon: rating >= 5 ? Icons.store : Icons.send,
                          size: bs.md,
                          onPressed: () {
                            _handleRating();
                          },
                        ),
                      ),

                    if (rating > 0)
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            rating = 0;
                            showFeedbackForm = false;
                            setState(() {});
                          },
                          child: Text(
                            "Maybe later",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

            // Thank You Message (after rating)
            if (hasRated)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: successColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                  border: Border.all(color: successColor.withAlpha(40)),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: successColor,
                      size: 48,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Thank You!",
                      style: TextStyle(
                        fontSize: fsH4,
                        fontWeight: FontWeight.bold,
                        color: successColor,
                      ),
                    ),
                    Text(
                      "Your feedback helps us create better experiences for everyone.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: successColor,
                      ),
                    ),
                    SizedBox(height: spSm),
                    QButton(
                      label: "Share with Friends",
                      icon: Icons.share,
                      size: bs.sm,
                      onPressed: () {
                        // Handle sharing
                        si("Sharing app with friends...");
                      },
                    ),
                  ],
                ),
              ),

            // Feature Ratings
            Container(
              width: double.infinity,
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
                    "Feature Ratings",
                    style: TextStyle(
                      fontSize: fsH5,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  ...features.map((feature) {
                    double featureRating = feature["rating"] as double;
                    int fullStars = featureRating.floor();
                    bool hasHalfStar = (featureRating - fullStars) >= 0.5;

                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${feature["name"]}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                "${featureRating}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: warningColor,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  IconData iconData;
                                  if (index < fullStars) {
                                    iconData = Icons.star;
                                  } else if (index == fullStars && hasHalfStar) {
                                    iconData = Icons.star_half;
                                  } else {
                                    iconData = Icons.star_border;
                                  }
                                  
                                  return Icon(
                                    iconData,
                                    color: warningColor,
                                    size: 16,
                                  );
                                }),
                              ),
                            ],
                          ),

                          Text(
                            "${feature["description"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: disabledBoldColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // User Reviews
            Container(
              width: double.infinity,
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
                  Row(
                    children: [
                      Text(
                        "Recent Reviews",
                        style: TextStyle(
                          fontSize: fsH5,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          // Handle view all reviews
                          // navigateTo(AllReviewsView)
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: 14,
                            color: infoColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ...reviews.map((review) {
                    int reviewRating = review["rating"] as int;
                    
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(spSm),
                      margin: EdgeInsets.only(bottom: spSm),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: spXs,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: primaryColor.withAlpha(20),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: primaryColor,
                                  size: 16,
                                ),
                              ),
                              SizedBox(width: spSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${review["user"]}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: List.generate(5, (index) {
                                            return Icon(
                                              index < reviewRating ? Icons.star : Icons.star_border,
                                              color: warningColor,
                                              size: 12,
                                            );
                                          }),
                                        ),
                                        SizedBox(width: spXs),
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

                          Text(
                            "${review["comment"]}",
                            style: TextStyle(
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: disabledBoldColor,
                                size: 14,
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
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Share and Connect
            Container(
              width: double.infinity,
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
                  Text(
                    "Share & Connect",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: QButton(
                          label: "Share App",
                          icon: Icons.share,
                          size: bs.sm,
                          onPressed: () {
                            // Handle share
                            si("Sharing app...");
                          },
                        ),
                      ),
                      SizedBox(width: spSm),
                      Expanded(
                        child: QButton(
                          label: "Follow Us",
                          icon: Icons.favorite,
                          size: bs.sm,
                          onPressed: () {
                            // Handle follow
                            si("Opening social media...");
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
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return "Very Disappointing";
      case 2:
        return "Could Be Better";
      case 3:
        return "It's Okay";
      case 4:
        return "Really Good!";
      case 5:
        return "Love It!";
      default:
        return "";
    }
  }

  Color _getRatingColor(int rating) {
    if (rating <= 2) return dangerColor;
    if (rating == 3) return warningColor;
    if (rating == 4) return infoColor;
    return successColor;
  }

  void _handleRating() {
    if (rating >= 5) {
      // Direct to app store
      si("Redirecting to App Store...");
    } else {
      // Submit feedback
      if (feedback.trim().isEmpty) {
        se("Please provide feedback to help us improve");
        return;
      }
      ss("Thank you for your feedback!");
    }
    
    hasRated = true;
    setState(() {});
  }
}
