import 'package:flutter/material.dart';
import 'package:reusekit/core.dart';

class HhaGuestFeedbackView extends StatefulWidget {
  const HhaGuestFeedbackView({super.key});

  @override
  State<HhaGuestFeedbackView> createState() => _HhaGuestFeedbackViewState();
}

class _HhaGuestFeedbackViewState extends State<HhaGuestFeedbackView> {
  final formKey = GlobalKey<FormState>();
  
  String selectedStay = "";
  int overallRating = 0;
  int roomRating = 0;
  int serviceRating = 0;
  int cleanlinessRating = 0;
  int amenitiesRating = 0;
  int valueRating = 0;
  
  String reviewTitle = "";
  String reviewText = "";
  String improvementSuggestions = "";
  
  bool wouldRecommend = false;
  bool returnGuest = false;
  
  List<String> selectedCategories = [];
  List<String> attachments = [];

  List<Map<String, dynamic>> stayOptions = [
    {
      "label": "Grand Hotel & Spa - Room A-205 (Dec 2024)",
      "value": "stay_1",
    },
    {
      "label": "Royal Palace Hotel - Room B-105 (Oct 2024)",
      "value": "stay_2",
    },
    {
      "label": "Ocean View Resort - Room C-301 (Aug 2024)",
      "value": "stay_3",
    },
    {
      "label": "Mountain Lodge - Room E-101 (Mar 2024)",
      "value": "stay_4",
    },
  ];

  List<String> feedbackCategories = [
    "Room Quality",
    "Staff Service",
    "Food & Dining",
    "Facilities",
    "Location",
    "Value for Money",
    "Cleanliness",
    "Amenities",
    "Check-in/Check-out",
    "Wi-Fi & Technology",
  ];

  void _submitFeedback() async {
    if (formKey.currentState!.validate()) {
      if (selectedStay.isEmpty) {
        se("Please select a stay to review");
        return;
      }
      
      if (overallRating == 0) {
        se("Please provide an overall rating");
        return;
      }

      showLoading();
      // Simulate API call
      await Future.delayed(Duration(seconds: 2));
      hideLoading();

      ss("Thank you for your feedback! Your review has been submitted.");
      
      // Reset form
      setState(() {
        selectedStay = "";
        overallRating = 0;
        roomRating = 0;
        serviceRating = 0;
        cleanlinessRating = 0;
        amenitiesRating = 0;
        valueRating = 0;
        reviewTitle = "";
        reviewText = "";
        improvementSuggestions = "";
        wouldRecommend = false;
        returnGuest = false;
        selectedCategories.clear();
        attachments.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Feedback"),
        actions: [
          TextButton(
            onPressed: () {
              // View previous feedback
            },
            child: Text(
              "My Reviews",
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(spMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spMd,
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.rate_review,
                      size: 40,
                      color: primaryColor,
                    ),
                    SizedBox(height: spSm),
                    Text(
                      "Share Your Experience",
                      style: TextStyle(
                        fontSize: fsH5,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: spXs),
                    Text(
                      "Your feedback helps us improve our service and helps other guests make informed decisions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Select Stay
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
                      "Select Your Stay",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QDropdownField(
                      label: "Choose a stay to review",
                      items: stayOptions,
                      value: selectedStay,
                      validator: Validator.required,
                      onChanged: (value, label) {
                        selectedStay = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Overall Rating
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
                      "Overall Rating",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            overallRating = index + 1;
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.all(spSm),
                            child: Icon(
                              index < overallRating ? Icons.star : Icons.star_border,
                              size: 40,
                              color: Colors.amber,
                            ),
                          ),
                        );
                      }),
                    ),
                    if (overallRating > 0)
                      Center(
                        child: Text(
                          _getRatingText(overallRating),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Detailed Ratings
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
                      "Detailed Ratings",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    _buildRatingRow("Room Quality", roomRating, (rating) {
                      roomRating = rating;
                      setState(() {});
                    }),
                    _buildRatingRow("Service Quality", serviceRating, (rating) {
                      serviceRating = rating;
                      setState(() {});
                    }),
                    _buildRatingRow("Cleanliness", cleanlinessRating, (rating) {
                      cleanlinessRating = rating;
                      setState(() {});
                    }),
                    _buildRatingRow("Amenities", amenitiesRating, (rating) {
                      amenitiesRating = rating;
                      setState(() {});
                    }),
                    _buildRatingRow("Value for Money", valueRating, (rating) {
                      valueRating = rating;
                      setState(() {});
                    }),
                  ],
                ),
              ),

              // Written Review
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
                      "Written Review",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QTextField(
                      label: "Review Title",
                      value: reviewTitle,
                      hint: "Give your review a catchy title",
                      validator: Validator.required,
                      onChanged: (value) {
                        reviewTitle = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Detailed Review",
                      value: reviewText,
                      hint: "Share your experience in detail. What did you like? What could be improved?",
                      validator: Validator.required,
                      onChanged: (value) {
                        reviewText = value;
                        setState(() {});
                      },
                    ),
                    QMemoField(
                      label: "Suggestions for Improvement",
                      value: improvementSuggestions,
                      hint: "How can we make your next stay even better?",
                      onChanged: (value) {
                        improvementSuggestions = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Feedback Categories
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
                      "Feedback Categories",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      "Select areas you'd like to comment on:",
                      style: TextStyle(
                        color: disabledBoldColor,
                      ),
                    ),
                    Wrap(
                      spacing: spSm,
                      runSpacing: spSm,
                      children: feedbackCategories.map((category) {
                        bool isSelected = selectedCategories.contains(category);
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              selectedCategories.remove(category);
                            } else {
                              selectedCategories.add(category);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: spMd, vertical: spSm),
                            decoration: BoxDecoration(
                              color: isSelected ? primaryColor.withAlpha(20) : Colors.grey.withAlpha(20),
                              borderRadius: BorderRadius.circular(radiusMd),
                              border: Border.all(
                                color: isSelected ? primaryColor : disabledOutlineBorderColor,
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? primaryColor : disabledBoldColor,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Photo Attachments
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
                      "Add Photos (Optional)",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QMultiImagePicker(
                      label: "Upload Photos",
                      value: attachments,
                      hint: "Add photos to support your review",
                      maxImages: 5,
                      onChanged: (value) {
                        attachments = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Additional Questions
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
                      "Additional Questions",
                      style: TextStyle(
                        fontSize: fsH6,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Would you recommend this hotel to friends and family?",
                          "value": true,
                          "checked": wouldRecommend,
                        }
                      ],
                      value: wouldRecommend ? [{"label": "Would you recommend this hotel to friends and family?", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        wouldRecommend = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                    QSwitch(
                      items: [
                        {
                          "label": "Would you stay at this hotel again?",
                          "value": true,
                          "checked": returnGuest,
                        }
                      ],
                      value: returnGuest ? [{"label": "Would you stay at this hotel again?", "value": true, "checked": true}] : [],
                      onChanged: (values, ids) {
                        returnGuest = values.isNotEmpty;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // Privacy Notice
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(spMd),
                decoration: BoxDecoration(
                  color: infoColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: spSm,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: infoColor, size: 20),
                        SizedBox(width: spSm),
                        Text(
                          "Review Privacy",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: infoColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Your review will be published publicly to help other guests. Personal information will not be shared. Reviews are moderated before publication.",
                      style: TextStyle(
                        fontSize: 12,
                        color: disabledBoldColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Submit Button
              Container(
                width: double.infinity,
                child: QButton(
                  label: "Submit Feedback",
                  size: bs.md,
                  onPressed: _submitFeedback,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow(String title, int rating, Function(int) onRatingChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: primaryColor,
            ),
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => onRatingChanged(index + 1),
              child: Container(
                padding: EdgeInsets.all(2),
                child: Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  size: 20,
                  color: Colors.amber,
                ),
              ),
            );
          }),
        ),
      ],
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
}
