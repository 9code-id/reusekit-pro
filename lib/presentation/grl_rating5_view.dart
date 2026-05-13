import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class GrlRating5View extends StatefulWidget {
  @override
  State<GrlRating5View> createState() => _GrlRating5ViewState();
}

class _GrlRating5ViewState extends State<GrlRating5View> {
  int currentStep = 0;
  
  // Step 1: Overall Rating
  double overallRating = 0.0;
  
  // Step 2: Category Ratings
  Map<String, double> categoryRatings = {
    "quality": 0.0,
    "service": 0.0,
    "delivery": 0.0,
    "value": 0.0,
  };
  
  // Step 3: Detailed Feedback
  String reviewTitle = "";
  String reviewContent = "";
  List<String> selectedTags = [];
  
  // Step 4: Additional Info
  bool recommendToFriends = false;
  bool allowPublicReview = true;
  String improvements = "";

  List<Map<String, dynamic>> ratingSteps = [
    {
      "title": "Overall Rating",
      "subtitle": "How was your experience?",
      "icon": Icons.star_rate,
    },
    {
      "title": "Category Ratings",
      "subtitle": "Rate specific aspects",
      "icon": Icons.category,
    },
    {
      "title": "Write Review",
      "subtitle": "Share your thoughts",
      "icon": Icons.edit,
    },
    {
      "title": "Final Details",
      "subtitle": "Additional information",
      "icon": Icons.info,
    },
  ];

  List<String> reviewTags = [
    "Excellent Quality",
    "Fast Delivery",
    "Great Value",
    "Friendly Staff",
    "Easy to Use",
    "Reliable",
    "Professional",
    "Recommended",
    "Well Packaged",
    "As Described",
  ];

  Map<String, Map<String, dynamic>> categoryInfo = {
    "quality": {
      "title": "Product Quality",
      "icon": Icons.inventory,
      "color": successColor,
      "description": "Overall quality of the product",
    },
    "service": {
      "title": "Customer Service",
      "icon": Icons.support_agent,
      "color": primaryColor,
      "description": "Support and assistance received",
    },
    "delivery": {
      "title": "Delivery Experience",
      "icon": Icons.local_shipping,
      "color": infoColor,
      "description": "Speed and condition of delivery",
    },
    "value": {
      "title": "Value for Money",
      "icon": Icons.attach_money,
      "color": warningColor,
      "description": "Worth compared to price paid",
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate Your Experience"),
        actions: [
          if (currentStep > 0)
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                currentStep--;
                setState(() {});
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Column(
              children: [
                // Step Progress
                Row(
                  children: List.generate(ratingSteps.length, (index) {
                    bool isActive = index == currentStep;
                    bool isCompleted = index < currentStep;
                    
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: index < ratingSteps.length - 1 ? spSm : 0),
                        child: Column(
                          children: [
                            Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: isCompleted || isActive ? primaryColor : disabledColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(height: spSm),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isCompleted 
                                    ? successColor 
                                    : isActive 
                                        ? primaryColor 
                                        : disabledColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isCompleted 
                                    ? Icons.check 
                                    : ratingSteps[index]["icon"] as IconData,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                
                SizedBox(height: spMd),
                
                // Current Step Info
                Column(
                  children: [
                    Text(
                      "${ratingSteps[currentStep]["title"]}",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${ratingSteps[currentStep]["subtitle"]}",
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

          // Step Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(spMd),
              child: _buildStepContent(),
            ),
          ),

          // Navigation Buttons
          Container(
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [shadowSm],
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: QButton(
                      label: "Previous",
                      onPressed: () {
                        currentStep--;
                        setState(() {});
                      },
                    ),
                  ),
                if (currentStep > 0) SizedBox(width: spMd),
                Expanded(
                  child: QButton(
                    label: currentStep == ratingSteps.length - 1 ? "Submit Review" : "Next",
                    onPressed: _canProceed() ? _handleNext : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildOverallRatingStep();
      case 1:
        return _buildCategoryRatingStep();
      case 2:
        return _buildReviewStep();
      case 3:
        return _buildFinalStep();
      default:
        return Container();
    }
  }

  Widget _buildOverallRatingStep() {
    return Column(
      children: [
        // Main Rating Display
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
                size: 64,
                color: Colors.white,
              ),
              SizedBox(height: spMd),
              Text(
                "Rate Your Overall Experience",
                style: TextStyle(
                  fontSize: fsH5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: spSm),
              Text(
                "Your feedback helps us serve you better",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: spLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      overallRating = index + 1.0;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        overallRating > index ? Icons.star : Icons.star_border,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: spMd),
              Text(
                _getRatingText(overallRating),
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

        // Rating Explanation
        if (overallRating > 0) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: _getRatingColor(overallRating.toInt()).withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: _getRatingColor(overallRating.toInt()).withAlpha(50)),
            ),
            child: Column(
              children: [
                Icon(
                  _getRatingIcon(overallRating.toInt()),
                  color: _getRatingColor(overallRating.toInt()),
                  size: 32,
                ),
                SizedBox(height: spSm),
                Text(
                  _getRatingDescription(overallRating),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: _getRatingColor(overallRating.toInt()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCategoryRatingStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rate Each Category",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        SizedBox(height: spSm),
        
        Text(
          "Help us understand what aspects of your experience stood out",
          style: TextStyle(
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spMd),

        ...categoryInfo.entries.map((entry) {
          String key = entry.key;
          Map<String, dynamic> info = entry.value;
          double rating = categoryRatings[key] ?? 0.0;
          
          return Container(
            margin: EdgeInsets.only(bottom: spMd),
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radiusLg),
              boxShadow: [shadowSm],
              border: rating > 0 
                  ? Border.all(color: (info["color"] as Color).withAlpha(50))
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(spSm),
                      decoration: BoxDecoration(
                        color: (info["color"] as Color).withAlpha(20),
                        borderRadius: BorderRadius.circular(radiusSm),
                      ),
                      child: Icon(
                        info["icon"] as IconData,
                        color: info["color"] as Color,
                        size: 24,
                      ),
                    ),
                    SizedBox(width: spMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${info["title"]}",
                            style: TextStyle(
                              fontSize: fsH6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${info["description"]}",
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
                
                SizedBox(height: spMd),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        categoryRatings[key] = index + 1.0;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          rating > index ? Icons.star : Icons.star_border,
                          size: 24,
                          color: info["color"] as Color,
                        ),
                      ),
                    );
                  }),
                ),
                
                if (rating > 0) ...[
                  SizedBox(height: spSm),
                  Center(
                    child: Text(
                      "${rating.toStringAsFixed(1)} stars",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: info["color"] as Color,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Write Your Review",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: spMd),

        QTextField(
          label: "Review Title",
          value: reviewTitle,
          hint: "Summarize your experience in a few words",
          onChanged: (value) {
            reviewTitle = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        QMemoField(
          label: "Detailed Review",
          value: reviewContent,
          hint: "Share your detailed experience. What did you like? What could be improved?",
          onChanged: (value) {
            reviewContent = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        Text(
          "Add Tags (Optional)",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: spSm),

        Text(
          "Select tags that describe your experience",
          style: TextStyle(
            fontSize: 12,
            color: disabledBoldColor,
          ),
        ),

        SizedBox(height: spMd),

        Wrap(
          spacing: spSm,
          runSpacing: spSm,
          children: reviewTags.map((tag) {
            bool isSelected = selectedTags.contains(tag);
            return GestureDetector(
              onTap: () {
                if (isSelected) {
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
                  color: isSelected ? primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(radiusLg),
                  boxShadow: [shadowSm],
                  border: Border.all(
                    color: isSelected ? primaryColor : disabledOutlineBorderColor,
                  ),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : primaryColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        if (selectedTags.isNotEmpty) ...[
          SizedBox(height: spMd),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(spMd),
            decoration: BoxDecoration(
              color: primaryColor.withAlpha(20),
              borderRadius: BorderRadius.circular(radiusLg),
              border: Border.all(color: primaryColor.withAlpha(50)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Tags:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: spSm),
                Text(
                  selectedTags.join(", "),
                  style: TextStyle(
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFinalStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Final Details",
          style: TextStyle(
            fontSize: fsH6,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: spMd),

        // Recommendation Question
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
                "Would you recommend us to friends?",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        recommendToFriends = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: recommendToFriends ? successColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: recommendToFriends ? successColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: recommendToFriends ? Colors.white : successColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "Yes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: recommendToFriends ? Colors.white : successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: spMd),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        recommendToFriends = false;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(spMd),
                        decoration: BoxDecoration(
                          color: !recommendToFriends ? dangerColor : Colors.white,
                          borderRadius: BorderRadius.circular(radiusLg),
                          border: Border.all(
                            color: !recommendToFriends ? dangerColor : disabledOutlineBorderColor,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thumb_down,
                              color: !recommendToFriends ? Colors.white : dangerColor,
                            ),
                            SizedBox(width: spSm),
                            Text(
                              "No",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: !recommendToFriends ? Colors.white : dangerColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: spMd),

        // Public Review Permission
        Row(
          children: [
            Expanded(
              child: QSwitch(
                items: [
                  {
                    "label": "Allow public display of this review",
                    "value": true,
                    "checked": allowPublicReview,
                  }
                ],
                value: [
                  if (allowPublicReview)
                    {
                      "label": "Allow public display of this review",
                      "value": true,
                      "checked": true
                    }
                ],
                onChanged: (values, ids) {
                  allowPublicReview = values.isNotEmpty;
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        SizedBox(height: spMd),

        // Improvement Suggestions
        QMemoField(
          label: "Suggestions for Improvement (Optional)",
          value: improvements,
          hint: "What would make your experience even better?",
          onChanged: (value) {
            improvements = value;
            setState(() {});
          },
        ),

        SizedBox(height: spMd),

        // Review Summary
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(spMd),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(radiusLg),
            border: Border.all(color: primaryColor.withAlpha(50)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Review Summary",
                style: TextStyle(
                  fontSize: fsH6,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: spMd),
              Row(
                children: [
                  Text("Overall Rating: "),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        overallRating > index ? Icons.star : Icons.star_border,
                        size: 16,
                        color: warningColor,
                      );
                    }),
                  ),
                  SizedBox(width: spSm),
                  Text("${overallRating.toStringAsFixed(1)}/5.0"),
                ],
              ),
              SizedBox(height: spSm),
              Text("Categories: ${categoryRatings.values.where((r) => r > 0).length}/4 rated"),
              if (reviewTitle.isNotEmpty) ...[
                SizedBox(height: spSm),
                Text("Title: \"$reviewTitle\""),
              ],
              if (selectedTags.isNotEmpty) ...[
                SizedBox(height: spSm),
                Text("Tags: ${selectedTags.length} selected"),
              ],
            ],
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    switch (currentStep) {
      case 0:
        return overallRating > 0;
      case 1:
        return categoryRatings.values.any((rating) => rating > 0);
      case 2:
        return reviewTitle.isNotEmpty || reviewContent.isNotEmpty;
      case 3:
        return true; // Final step can always proceed
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < ratingSteps.length - 1) {
      currentStep++;
      setState(() {});
    } else {
      _submitReview();
    }
  }

  void _submitReview() async {
    showLoading();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    hideLoading();

    ss("Thank you for your detailed review! Your feedback helps us improve.");

    // Navigate to success page or back
    // navigateTo(ReviewSuccessView());
  }

  String _getRatingText(double rating) {
    if (rating >= 5.0) return "Excellent!";
    if (rating >= 4.0) return "Great!";
    if (rating >= 3.0) return "Good";
    if (rating >= 2.0) return "Fair";
    if (rating >= 1.0) return "Poor";
    return "Tap to rate";
  }

  String _getRatingDescription(double rating) {
    if (rating >= 5.0) return "Outstanding experience! Everything exceeded your expectations.";
    if (rating >= 4.0) return "Great experience! Most aspects met or exceeded expectations.";
    if (rating >= 3.0) return "Good experience overall with some areas for improvement.";
    if (rating >= 2.0) return "Fair experience with several issues that need attention.";
    if (rating >= 1.0) return "Poor experience with significant problems encountered.";
    return "";
  }

  Color _getRatingColor(int rating) {
    switch (rating) {
      case 5:
        return successColor;
      case 4:
        return primaryColor;
      case 3:
        return warningColor;
      case 2:
        return Colors.orange;
      case 1:
        return dangerColor;
      default:
        return disabledBoldColor;
    }
  }

  IconData _getRatingIcon(int rating) {
    switch (rating) {
      case 5:
        return Icons.sentiment_very_satisfied;
      case 4:
        return Icons.sentiment_satisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 2:
        return Icons.sentiment_dissatisfied;
      case 1:
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.help;
    }
  }
}
