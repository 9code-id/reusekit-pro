import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class TtaWriteReviewView extends StatefulWidget {
  const TtaWriteReviewView({super.key});

  @override
  State<TtaWriteReviewView> createState() => _TtaWriteReviewViewState();
}

class _TtaWriteReviewViewState extends State<TtaWriteReviewView> {
  int rating = 0;
  String reviewTitle = "";
  String reviewContent = "";
  String visitDate = "";
  String selectedCategory = "Restaurant";
  List<String> uploadedPhotos = [];
  bool isAnonymous = false;
  bool recommendToOthers = true;
  
  // Rating criteria
  Map<String, int> criteriaRatings = {
    "Service": 0,
    "Value for Money": 0,
    "Atmosphere": 0,
    "Cleanliness": 0,
  };

  List<Map<String, dynamic>> categoryItems = [
    {"label": "Restaurant", "value": "Restaurant"},
    {"label": "Hotel", "value": "Hotel"},
    {"label": "Attraction", "value": "Attraction"},
    {"label": "Transport", "value": "Transport"},
    {"label": "Shopping", "value": "Shopping"},
    {"label": "Entertainment", "value": "Entertainment"},
  ];

  List<Map<String, dynamic>> quickTags = [
    {"label": "Great Service", "selected": false},
    {"label": "Good Value", "selected": false},
    {"label": "Clean", "selected": false},
    {"label": "Friendly Staff", "selected": false},
    {"label": "Fast Service", "selected": false},
    {"label": "Authentic", "selected": false},
    {"label": "Tourist Friendly", "selected": false},
    {"label": "Instagram Worthy", "selected": false},
  ];

  List<Map<String, dynamic>> reviewTips = [
    {
      "title": "Be Specific",
      "description": "Include details about your experience to help other travelers",
      "icon": Icons.info
    },
    {
      "title": "Add Photos",
      "description": "Photos help others see what to expect",
      "icon": Icons.camera_alt
    },
    {
      "title": "Be Fair",
      "description": "Consider both positive and negative aspects",
      "icon": Icons.balance
    },
    {
      "title": "Be Respectful",
      "description": "Keep your review constructive and respectful",
      "icon": Icons.favorite
    },
  ];

  void _submitReview() {
    if (rating == 0) {
      se("Please provide an overall rating");
      return;
    }
    
    if (reviewTitle.trim().isEmpty) {
      se("Please enter a review title");
      return;
    }
    
    if (reviewContent.trim().isEmpty) {
      se("Please write your review");
      return;
    }

    showLoading();
    
    // Simulate review submission
    Future.delayed(Duration(seconds: 2), () {
      hideLoading();
      ss("Review submitted successfully!");
      // Navigate back or to review list
    });
  }

  void _toggleTag(int index) {
    setState(() {
      quickTags[index]["selected"] = !(quickTags[index]["selected"] as bool);
    });
  }

  Widget _buildStarRating(int currentRating, Function(int) onRatingChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () => onRatingChanged(index + 1),
          child: Icon(
            index < currentRating ? Icons.star : Icons.star_border,
            color: warningColor,
            size: 32,
          ),
        );
      }),
    );
  }

  Widget _buildCriteriaRating(String criteria, int currentRating, Function(int) onRatingChanged) {
    return Row(
      children: [
        Expanded(
          child: Text(
            criteria,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Icon(
                index < currentRating ? Icons.star : Icons.star_border,
                color: warningColor,
                size: 20,
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Review"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spMd),
        child: Column(
          spacing: spMd,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Review Guidelines
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(spMd),
              decoration: BoxDecoration(
                color: infoColor.withAlpha(30),
                borderRadius: BorderRadius.circular(radiusLg),
                border: Border.all(color: infoColor.withAlpha(100)),
              ),
              child: Column(
                spacing: spSm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: infoColor,
                        size: 20,
                      ),
                      SizedBox(width: spSm),
                      Text(
                        "Review Guidelines",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: infoColor,
                        ),
                      ),
                    ],
                  ),
                  
                  Column(
                    spacing: spXs,
                    children: List.generate(reviewTips.length, (index) {
                      final tip = reviewTips[index];
                      
                      return Row(
                        spacing: spSm,
                        children: [
                          Icon(
                            tip["icon"] as IconData,
                            color: infoColor,
                            size: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: spXxs,
                              children: [
                                Text(
                                  "${tip["title"]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: infoColor,
                                  ),
                                ),
                                Text(
                                  "${tip["description"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: infoColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Review Form
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Review",
                    style: TextStyle(
                      fontSize: fsH6,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  // Category Selection
                  QDropdownField(
                    label: "Category",
                    items: categoryItems,
                    value: selectedCategory,
                    onChanged: (value, label) {
                      selectedCategory = value;
                      setState(() {});
                    },
                  ),

                  // Overall Rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: spSm,
                    children: [
                      Text(
                        "Overall Rating",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          _buildStarRating(rating, (newRating) {
                            setState(() {
                              rating = newRating;
                            });
                          }),
                          SizedBox(width: spSm),
                          if (rating > 0) ...[
                            Text(
                              rating == 1 ? "Poor" :
                              rating == 2 ? "Fair" :
                              rating == 3 ? "Good" :
                              rating == 4 ? "Very Good" : "Excellent",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: rating <= 2 ? dangerColor : 
                                       rating == 3 ? warningColor : successColor,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),

                  // Detailed Ratings
                  Text(
                    "Rate Different Aspects",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Column(
                    spacing: spSm,
                    children: criteriaRatings.keys.map((criteria) {
                      return _buildCriteriaRating(
                        criteria, 
                        criteriaRatings[criteria]!,
                        (newRating) {
                          setState(() {
                            criteriaRatings[criteria] = newRating;
                          });
                        }
                      );
                    }).toList(),
                  ),

                  // Review Title
                  QTextField(
                    label: "Review Title",
                    value: reviewTitle,
                    validator: Validator.required,
                    onChanged: (value) {
                      reviewTitle = value;
                      setState(() {});
                    },
                  ),

                  // Review Content
                  QMemoField(
                    label: "Write your review...",
                    value: reviewContent,
                    validator: Validator.required,
                    onChanged: (value) {
                      reviewContent = value;
                      setState(() {});
                    },
                  ),

                  // Visit Date
                  QDatePicker(
                    label: "Date of Visit",
                    value: visitDate.isNotEmpty ? DateTime.parse(visitDate) : DateTime.now(),
                    onChanged: (value) {
                      visitDate = value.toIso8601String().split('T')[0];
                      setState(() {});
                    },
                  ),

                  // Quick Tags
                  Text(
                    "Quick Tags (Optional)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),

                  Wrap(
                    spacing: spSm,
                    runSpacing: spSm,
                    children: List.generate(quickTags.length, (index) {
                      final tag = quickTags[index];
                      bool isSelected = tag["selected"] as bool;
                      
                      return GestureDetector(
                        onTap: () => _toggleTag(index),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: spMd,
                            vertical: spSm,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(radiusLg),
                            border: Border.all(
                              color: isSelected ? primaryColor : disabledColor,
                            ),
                          ),
                          child: Text(
                            "${tag["label"]}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : primaryColor,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  // Photo Upload
                  QMultiImagePicker(
                    label: "Add Photos (Optional)",
                    value: uploadedPhotos,
                    maxImages: 5,
                    onChanged: (value) {
                      uploadedPhotos = value;
                      setState(() {});
                    },
                  ),

                  // Additional Options
                  Column(
                    spacing: spSm,
                    children: [
                      QSwitch(
                        items: [
                          {
                            "label": "Post anonymously",
                            "value": true,
                            "checked": isAnonymous,
                          }
                        ],
                        value: isAnonymous ? [{"label": "Post anonymously", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          isAnonymous = values.isNotEmpty;
                          setState(() {});
                        },
                      ),

                      QSwitch(
                        items: [
                          {
                            "label": "I recommend this to other travelers",
                            "value": true,
                            "checked": recommendToOthers,
                          }
                        ],
                        value: recommendToOthers ? [{"label": "I recommend this to other travelers", "value": true, "checked": true}] : [],
                        onChanged: (values, ids) {
                          recommendToOthers = values.isNotEmpty;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Submit Button
            Container(
              width: double.infinity,
              child: QButton(
                label: "Submit Review",
                size: bs.md,
                onPressed: _submitReview,
              ),
            ),

            // Preview Section
            if (rating > 0 || reviewTitle.isNotEmpty || reviewContent.isNotEmpty) ...[
              Text(
                "Preview",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(color: disabledColor),
                ),
                child: Column(
                  spacing: spSm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: primaryColor.withAlpha(30),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: spSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: spXxs,
                            children: [
                              Text(
                                isAnonymous ? "Anonymous User" : "Your Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                              if (rating > 0) ...[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      index < rating ? Icons.star : Icons.star_border,
                                      color: warningColor,
                                      size: 16,
                                    );
                                  }),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),

                    if (reviewTitle.isNotEmpty) ...[
                      Text(
                        reviewTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],

                    if (reviewContent.isNotEmpty) ...[
                      Text(
                        reviewContent,
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                          height: 1.4,
                        ),
                      ),
                    ],

                    if (uploadedPhotos.isNotEmpty) ...[
                      Text(
                        "${uploadedPhotos.length} photo${uploadedPhotos.length > 1 ? 's' : ''} attached",
                        style: TextStyle(
                          fontSize: 12,
                          color: successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
